#!/usr/bin/env python3
"""
FIWARE Orion-LD Entity Expansion Script

This script fetches an entity from Orion-LD and recursively follows all
Relationship properties to fetch related entities, compiling them into
a comprehensive JSON output.
"""

import argparse
import json
import os
import sys
from datetime import datetime
from typing import Dict, Set, Any, Optional, List, Tuple
import requests
from pathlib import Path

try:
    import graphviz
    GRAPHVIZ_AVAILABLE = True
except ImportError:
    GRAPHVIZ_AVAILABLE = False

try:
    from pyvis.network import Network
    PYVIS_AVAILABLE = True
except ImportError:
    PYVIS_AVAILABLE = False


class OrionLDExpander:
    """Expands FIWARE Orion-LD entities by recursively fetching relationships."""

    def __init__(self, host: str, port: int, tenant: str, max_depth: int = 5):
        """
        Initialize the expander.

        Args:
            host: Orion-LD host
            port: Orion-LD port
            tenant: NGSILD tenant name
            max_depth: Maximum recursion depth for relationships
        """
        self.base_url = f"http://{host}:{port}/ngsi-ld/v1/entities"
        self.tenant = tenant
        self.max_depth = max_depth
        self.visited_entities: Set[str] = set()
        self.all_entities: Dict[str, Dict[str, Any]] = {}
        self.headers = {
            'Accept': 'application/ld+json',
            'NGSILD-Tenant': tenant
        }

    def fetch_entity(self, entity_id: str, depth: int = 0) -> Optional[Dict[str, Any]]:
        """
        Fetch an entity from Orion-LD.

        Args:
            entity_id: The entity ID to fetch
            depth: Current recursion depth

        Returns:
            The entity JSON or None if not found
        """
        # Check if already visited
        if entity_id in self.visited_entities:
            print(f"  {'  ' * depth}Already visited: {entity_id}", file=sys.stderr)
            return None

        # Check depth limit
        if depth > self.max_depth:
            print(f"  {'  ' * depth}Max depth reached for: {entity_id}", file=sys.stderr)
            return None

        # Mark as visited
        self.visited_entities.add(entity_id)

        # Fetch entity
        url = f"{self.base_url}/{entity_id}"
        print(f"  {'  ' * depth}Fetching: {entity_id} (depth: {depth})", file=sys.stderr)

        try:
            response = requests.get(url, headers=self.headers, timeout=10)

            if response.status_code == 404:
                print(f"  {'  ' * depth}Warning: Entity not found: {entity_id}", file=sys.stderr)
                return None

            response.raise_for_status()
            entity_json = response.json()

            # Store entity
            self.all_entities[entity_id] = entity_json

            # Extract and follow relationships
            relationships = self._extract_relationships(entity_json)

            if relationships:
                print(f"  {'  ' * depth}Found {len(relationships)} relationship(s)", file=sys.stderr)

                for rel_id in relationships:
                    print(f"  {'  ' * depth}Following relationship -> {rel_id}", file=sys.stderr)
                    self.fetch_entity(rel_id, depth + 1)

            return entity_json

        except requests.exceptions.RequestException as e:
            print(f"  {'  ' * depth}Error fetching {entity_id}: {e}", file=sys.stderr)
            return None

    def _extract_relationships(self, entity: Dict[str, Any]) -> Set[str]:
        """
        Extract all relationship object IDs from an entity.

        Args:
            entity: The entity JSON

        Returns:
            Set of entity IDs referenced in relationships
        """
        relationships = set()

        def find_relationships(obj):
            """Recursively find all Relationship type objects."""
            if isinstance(obj, dict):
                # Check if this is a Relationship
                if obj.get('type') == 'Relationship' and 'object' in obj:
                    rel_object = obj['object']

                    # Handle both single values and arrays
                    if isinstance(rel_object, list):
                        relationships.update(rel_object)
                    elif isinstance(rel_object, str):
                        relationships.add(rel_object)

                # Recurse into nested objects
                for value in obj.values():
                    find_relationships(value)
            elif isinstance(obj, list):
                # Recurse into list items
                for item in obj:
                    find_relationships(item)

        find_relationships(entity)
        return relationships

    def _get_property_value(self, entity: Dict[str, Any], *property_names: str) -> Any:
        """
        Get a property value from an entity, trying multiple possible keys.

        Args:
            entity: The entity to search
            property_names: List of possible property names to try

        Returns:
            The property value or None if not found
        """
        for prop_name in property_names:
            prop = entity.get(prop_name)
            if prop and isinstance(prop, dict) and prop.get('type') == 'Property':
                return prop
        return None

    def _calculate_material_weights(self) -> Dict[str, Any]:
        """
        Calculate the weight of materials for each component.

        Returns:
            Dictionary containing material weight calculations at the material level (not composition)
        """
        calculations = []
        material_totals = {}

        for entity_id, entity in self.all_entities.items():
            # Only process components with hasMaterial relationship
            if entity.get('type') != 'ManufacturingComponent':
                continue

            has_material = entity.get('hasMaterial')
            if not has_material or has_material.get('type') != 'Relationship':
                continue

            material_id = has_material.get('object')
            if not material_id:
                continue

            # Get component weight (try multiple property names)
            weight_prop = self._get_property_value(
                entity,
                'weight',
                'https://smartdatamodels.org/dataModel.Energy/weight',
                'https://smartdatamodels.org/weight'
            )

            if not weight_prop:
                continue

            component_weight = weight_prop.get('value')
            weight_unit = weight_prop.get('unitCode', 'KGM')

            # Get component name (try multiple property names)
            name_prop = self._get_property_value(
                entity,
                'name',
                'https://smartdatamodels.org/name'
            )
            component_name = name_prop.get('value') if name_prop else entity_id

            # Get material name if entity exists
            material_name = material_id
            if material_id in self.all_entities:
                material_entity = self.all_entities[material_id]
                material_name_prop = self._get_property_value(
                    material_entity,
                    'name',
                    'https://smartdatamodels.org/name'
                )
                if material_name_prop:
                    material_name = material_name_prop.get('value', material_id)

            calculations.append({
                "componentId": entity_id,
                "componentName": component_name,
                "componentWeight": {
                    "value": component_weight,
                    "unitCode": weight_unit
                },
                "materialId": material_id,
                "materialName": material_name,
                "materialWeight": {
                    "value": component_weight,
                    "unitCode": weight_unit
                }
            })

            # Aggregate totals by material
            if material_id not in material_totals:
                material_totals[material_id] = {
                    "materialName": material_name,
                    "totalWeight": 0,
                    "unitCode": weight_unit,
                    "components": []
                }

            material_totals[material_id]['totalWeight'] += component_weight
            material_totals[material_id]['components'].append({
                "componentId": entity_id,
                "componentName": component_name,
                "weight": component_weight
            })

        # Round total weights
        for material_id in material_totals:
            material_totals[material_id]['totalWeight'] = round(
                material_totals[material_id]['totalWeight'], 6
            )

        return {
            "componentBreakdown": calculations,
            "materialTotals": material_totals
        }

    def _generate_ngsi_ld_material_totals(self, root_entity_id: str, material_totals: Dict[str, Any]) -> Dict[str, Any]:
        """
        Generate NGSI-LD formatted entity for material totals.

        Args:
            root_entity_id: The root entity ID this calculation is for
            material_totals: The material totals dictionary

        Returns:
            NGSI-LD formatted entity
        """
        return {
            # "id": root_entity_id,
            # "@context": "http://circuloos-ld-context/circuloos-context.jsonld",
            # "type": self.all_entities.get(root_entity_id, {}).get('type', 'Entity'),
            "materialTotals": {
                "type": "Property",
                "value": material_totals
            }
        }

    def _generate_material_totals_attrs(self, material_totals: Dict[str, Any]) -> Dict[str, Any]:
        """
        Generate attributes-only format for materialTotals (for PATCH operations).

        Args:
            material_totals: The material totals dictionary

        Returns:
            Attributes object (without entity metadata) for use with appendAttributesOrion.sh
        """
        return {
            "materialTotals": {
                "type": "Property",
                "value": material_totals
            }
        }

    def expand(self, entity_id: str) -> Dict[str, Any]:
        """
        Expand an entity by fetching it and all related entities.

        Args:
            entity_id: The root entity ID to expand

        Returns:
            Dictionary containing the expanded entity data
        """
        print(f"\nStarting entity expansion for: {entity_id}", file=sys.stderr)
        print(f"Tenant: {self.tenant}", file=sys.stderr)
        print(f"Max depth: {self.max_depth}", file=sys.stderr)
        print(f"Base URL: {self.base_url}\n", file=sys.stderr)

        # Fetch the main entity and all related entities
        main_entity = self.fetch_entity(entity_id, 0)

        if not main_entity:
            raise ValueError(f"Could not fetch main entity: {entity_id}")

        # Build the result
        related_entities = [
            entity for eid, entity in self.all_entities.items()
            if eid != entity_id
        ]

        # Calculate material weights
        material_weights = self._calculate_material_weights()

        result = {
            "@context": "https://uri.etsi.org/ngsi-ld/v1/ngsi-ld-core-context.jsonld",
            "expandedEntity": {
                "id": entity_id,
                "tenant": self.tenant,
                "expandedAt": datetime.utcnow().isoformat() + "Z",
                "totalEntities": len(self.all_entities),
                "maxDepth": self.max_depth
            },
            "mainEntity": main_entity,
            "relatedEntities": related_entities,
            "materialWeightCalculations": material_weights
        }

        return result

    def generate_diagram(self, output_path: str = "entity_diagram") -> Optional[str]:
        """
        Generate a visual diagram of the entity relationships.

        Args:
            output_path: Base path for the output file (without extension)

        Returns:
            Path to the generated PNG file, or None if graphviz is not available
        """
        if not GRAPHVIZ_AVAILABLE:
            print("\nWarning: graphviz package not available. Install with: pip install graphviz", file=sys.stderr)
            print("Also ensure graphviz system package is installed: sudo apt install graphviz", file=sys.stderr)
            return None

        print(f"\nGenerating entity relationship diagram...", file=sys.stderr)

        # Create a directed graph
        dot = graphviz.Digraph(comment='Entity Relationships', format='png')
        dot.attr(rankdir='TB', bgcolor='white')
        dot.attr('node', shape='box', style='rounded,filled', fontname='Arial', fontsize='10')
        dot.attr('edge', fontname='Arial', fontsize='9')

        # Track entity types for styling
        entity_types = {}
        relationships: List[Tuple[str, str, str, str]] = []  # (from_id, to_id, rel_name, rel_type)

        # First pass: collect all entities and their types
        for entity_id, entity in self.all_entities.items():
            entity_type = entity.get('type', 'Unknown')
            entity_types[entity_id] = entity_type

            # Extract relationships for second pass
            for key, value in entity.items():
                if isinstance(value, dict) and value.get('type') == 'Relationship':
                    rel_object = value.get('object')
                    if isinstance(rel_object, list):
                        for obj_id in rel_object:
                            relationships.append((entity_id, obj_id, key, entity_type))
                    elif isinstance(rel_object, str):
                        relationships.append((entity_id, rel_object, key, entity_type))

        # Define color scheme for different entity types
        type_colors = {
            'ManufacturingMachine': '#FF6B6B',
            'ManufacturingComponent': '#4ECDC4',
            'Material': '#95E1D3',
            'Company': '#FFD93D',
            'Warehouse': '#C49BFF',
            'Default': '#E8E8E8'
        }

        # Create a mapping of entity IDs to safe node names
        node_names = {}
        for i, entity_id in enumerate(self.all_entities.keys()):
            node_names[entity_id] = f"node_{i}"

        # Add nodes with styling based on entity type
        for entity_id, entity in self.all_entities.items():
            entity_type = entity.get('type', 'Unknown')

            # Create a shorter label
            short_id = entity_id.split(':')[-1] if ':' in entity_id else entity_id

            # Try to get name property
            name = None
            for key in ['name', 'https://smartdatamodels.org/name']:
                if key in entity:
                    name_prop = entity[key]
                    if isinstance(name_prop, dict) and 'value' in name_prop:
                        name = name_prop['value']
                        break

            if name:
                label = f"{name}\\n({entity_type})\\n{short_id}"
            else:
                label = f"{entity_type}\\n{short_id}"

            color = type_colors.get(entity_type, type_colors['Default'])
            # Use safe node name instead of entity_id
            dot.node(node_names[entity_id], label, fillcolor=color, fontcolor='#333333')

        # Add edges for relationships
        relationship_styles = {
            'hasComponent': {'color': '#FF6B6B', 'style': 'bold', 'penwidth': '2'},
            'hasMaterial': {'color': '#4ECDC4', 'style': 'solid', 'penwidth': '1.5'},
            'warehouseLocation': {'color': '#C49BFF', 'style': 'dashed', 'penwidth': '1.5'},
            'producedBy': {'color': '#FFD93D', 'style': 'solid', 'penwidth': '1.5'},
            'supplier': {'color': '#95E1D3', 'style': 'dotted', 'penwidth': '1.5'},
        }

        for from_id, to_id, rel_name, entity_type in relationships:
            if to_id in self.all_entities:  # Only draw edges to entities we fetched
                style = relationship_styles.get(rel_name, {'color': '#999999', 'style': 'solid', 'penwidth': '1'})
                # Use safe node names
                dot.edge(node_names[from_id], node_names[to_id], label=rel_name, **style)

        # Add legend
        with dot.subgraph(name='cluster_legend') as legend:
            legend.attr(label='Entity Types', fontsize='12', style='filled', color='lightgrey')
            for i, (entity_type, color) in enumerate(type_colors.items()):
                if entity_type != 'Default':
                    legend.node(f'legend_{i}', entity_type, fillcolor=color, fontcolor='#333333')

        try:
            # Render the diagram
            output_file = dot.render(output_path, cleanup=True)
            print(f"✓ Diagram generated: {output_file}", file=sys.stderr)
            return output_file
        except Exception as e:
            print(f"Error generating diagram: {e}", file=sys.stderr)
            return None

    def generate_interactive_diagram(self, output_path: str = "entity_diagram_interactive.html") -> Optional[str]:
        """
        Generate an interactive HTML diagram of the entity relationships.
        Users can drag nodes, zoom in/out, and pan around.

        Args:
            output_path: Path for the output HTML file

        Returns:
            Path to the generated HTML file, or None if pyvis is not available
        """
        if not PYVIS_AVAILABLE:
            print("\nWarning: pyvis package not available. Install with: pip install pyvis", file=sys.stderr)
            return None

        print(f"\nGenerating interactive entity relationship diagram...", file=sys.stderr)

        # Create network with physics enabled for interactive movement
        net = Network(
            height="900px",
            width="100%",
            bgcolor="#ffffff",
            font_color="#333333",
            directed=True
        )

        # Configure hierarchical layout to match PNG structure
        net.set_options("""
        {
          "layout": {
            "hierarchical": {
              "enabled": true,
              "direction": "UD",
              "sortMethod": "directed",
              "nodeSpacing": 150,
              "levelSeparation": 200,
              "treeSpacing": 200,
              "blockShifting": true,
              "edgeMinimization": true,
              "parentCentralization": true
            }
          },
          "physics": {
            "enabled": false,
            "hierarchicalRepulsion": {
              "centralGravity": 0.0,
              "springLength": 200,
              "springConstant": 0.01,
              "nodeDistance": 150,
              "damping": 0.09
            }
          },
          "interaction": {
            "hover": true,
            "dragNodes": true,
            "dragView": true,
            "zoomView": true,
            "navigationButtons": true,
            "keyboard": {
              "enabled": true
            },
            "tooltipDelay": 100
          },
          "nodes": {
            "font": {
              "size": 14,
              "face": "Arial"
            },
            "borderWidth": 2,
            "shadow": {
              "enabled": true,
              "color": "rgba(0,0,0,0.2)",
              "size": 5,
              "x": 2,
              "y": 2
            }
          },
          "edges": {
            "font": {
              "size": 11,
              "align": "middle",
              "strokeWidth": 0,
              "background": "white"
            },
            "arrows": {
              "to": {
                "enabled": true,
                "scaleFactor": 0.6
              }
            },
            "smooth": {
              "enabled": true,
              "type": "cubicBezier",
              "forceDirection": "vertical",
              "roundness": 0.4
            },
            "shadow": {
              "enabled": true,
              "color": "rgba(0,0,0,0.1)",
              "size": 3,
              "x": 1,
              "y": 1
            }
          }
        }
        """)

        # Define color scheme for different entity types
        type_colors = {
            'ManufacturingMachine': '#FF6B6B',
            'ManufacturingComponent': '#4ECDC4',
            'Material': '#95E1D3',
            'Company': '#FFD93D',
            'Warehouse': '#C49BFF',
            'Default': '#E8E8E8'
        }

        # Add nodes
        for entity_id, entity in self.all_entities.items():
            entity_type = entity.get('type', 'Unknown')

            # Create a shorter label
            short_id = entity_id.split(':')[-1] if ':' in entity_id else entity_id

            # Try to get name property
            name = None
            for key in ['name', 'https://smartdatamodels.org/name']:
                if key in entity:
                    name_prop = entity[key]
                    if isinstance(name_prop, dict) and 'value' in name_prop:
                        name = name_prop['value']
                        break

            # Build node label and title (tooltip)
            # Use plain text with newlines for Firefox compatibility
            if name:
                label = f"{name}"
                title = f"{name}\nType: {entity_type}\nID: {short_id}"
            else:
                label = f"{entity_type}"
                title = f"Type: {entity_type}\nID: {short_id}"

            # Get color for entity type
            color = type_colors.get(entity_type, type_colors['Default'])

            # Determine node size based on entity type
            size = 25
            if entity_type == 'ManufacturingMachine':
                size = 40  # Main entity is larger
            elif entity_type == 'ManufacturingComponent':
                size = 30

            # Add node to network
            net.add_node(
                entity_id,
                label=label,
                title=title,
                color=color,
                size=size,
                shape='dot'
            )

        # Add edges for relationships
        relationship_colors = {
            'hasComponent': '#FF6B6B',
            'hasMaterial': '#4ECDC4',
            'warehouseLocation': '#C49BFF',
            'producedBy': '#FFD93D',
            'supplier': '#95E1D3',
        }

        relationship_widths = {
            'hasComponent': 3,
            'hasMaterial': 2,
            'warehouseLocation': 2,
            'producedBy': 2,
            'supplier': 1.5,
        }

        # Extract and add edges
        for entity_id, entity in self.all_entities.items():
            for key, value in entity.items():
                if isinstance(value, dict) and value.get('type') == 'Relationship':
                    rel_object = value.get('object')
                    rel_objects = []

                    if isinstance(rel_object, list):
                        rel_objects = rel_object
                    elif isinstance(rel_object, str):
                        rel_objects = [rel_object]

                    for target_id in rel_objects:
                        if target_id in self.all_entities:
                            color = relationship_colors.get(key, '#999999')
                            width = relationship_widths.get(key, 1)

                            net.add_edge(
                                entity_id,
                                target_id,
                                title=key,
                                label=key,
                                color=color,
                                width=width
                            )

        try:
            # Save the network to HTML file
            net.save_graph(output_path)

            # Add custom legend to the HTML
            self._add_legend_to_html(output_path, type_colors, relationship_colors)

            print(f"✓ Interactive diagram generated: {output_path}", file=sys.stderr)
            print(f"  Open in browser to interact: drag nodes, zoom, pan", file=sys.stderr)
            return output_path
        except Exception as e:
            print(f"Error generating interactive diagram: {e}", file=sys.stderr)
            return None

    def _add_legend_to_html(self, html_path: str, type_colors: dict, relationship_colors: dict):
        """
        Add a legend to the generated HTML file.

        Args:
            html_path: Path to the HTML file
            type_colors: Dictionary of entity type colors
            relationship_colors: Dictionary of relationship colors
        """
        # Read the HTML file
        with open(html_path, 'r') as f:
            html_content = f.read()

        # Create legend HTML
        legend_html = """
        <div id="legend" style="position: absolute; top: 10px; right: 10px; background: white;
                                border: 2px solid #ccc; border-radius: 8px; padding: 15px;
                                box-shadow: 0 2px 10px rgba(0,0,0,0.1); font-family: Arial;
                                max-width: 250px; z-index: 1000;">
            <h3 style="margin: 0 0 10px 0; font-size: 16px; border-bottom: 2px solid #333;
                       padding-bottom: 8px;">Entity Types</h3>
            <div style="margin-bottom: 15px;">
"""

        # Add entity types
        for entity_type, color in type_colors.items():
            if entity_type != 'Default':
                legend_html += f"""
                <div style="display: flex; align-items: center; margin: 6px 0;">
                    <div style="width: 20px; height: 20px; background-color: {color};
                                border-radius: 50%; border: 2px solid #333; margin-right: 10px;
                                box-shadow: 0 1px 3px rgba(0,0,0,0.2);"></div>
                    <span style="font-size: 13px; color: #333;">{entity_type}</span>
                </div>
"""

        legend_html += """
            </div>
            <h3 style="margin: 10px 0 10px 0; font-size: 16px; border-bottom: 2px solid #333;
                       padding-bottom: 8px;">Relationships</h3>
            <div>
"""

        # Add relationship types
        relationship_names = {
            'hasComponent': 'Has Component',
            'hasMaterial': 'Has Material',
            'warehouseLocation': 'Warehouse Location',
            'producedBy': 'Produced By',
            'supplier': 'Supplier',
        }

        for rel_key, rel_name in relationship_names.items():
            if rel_key in relationship_colors:
                color = relationship_colors[rel_key]
                legend_html += f"""
                <div style="display: flex; align-items: center; margin: 6px 0;">
                    <div style="width: 30px; height: 3px; background-color: {color};
                                margin-right: 10px; position: relative;">
                        <div style="position: absolute; right: -2px; top: -3px; width: 0;
                                    height: 0; border-left: 6px solid {color};
                                    border-top: 4px solid transparent;
                                    border-bottom: 4px solid transparent;"></div>
                    </div>
                    <span style="font-size: 12px; color: #555;">{rel_name}</span>
                </div>
"""

        legend_html += """
            </div>
            <div style="margin-top: 15px; padding-top: 10px; border-top: 1px solid #ddd;
                        font-size: 11px; color: #666;">
                <strong>Tip:</strong> Drag nodes to rearrange, scroll to zoom, drag background to pan.
            </div>
        </div>
"""

        # Insert legend before closing body tag
        html_content = html_content.replace('</body>', legend_html + '</body>')

        # Write back to file
        with open(html_path, 'w') as f:
            f.write(html_content)


def load_env_file(env_path: Path) -> Dict[str, str]:
    """
    Load environment variables from a .env file.

    Args:
        env_path: Path to the .env file

    Returns:
        Dictionary of environment variables
    """
    env_vars = {}
    if env_path.exists():
        with open(env_path, 'r') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#') and '=' in line:
                    key, value = line.split('=', 1)
                    env_vars[key] = value
    return env_vars


def main():
    """Main entry point for the script."""
    parser = argparse.ArgumentParser(
        description='Expand FIWARE Orion-LD entities by recursively fetching relationships',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Basic usage
  %(prog)s urn:ngsi-ld:Building:001

  # Custom tenant
  %(prog)s urn:ngsi-ld:Building:001 --tenant my_tenant

  # Custom depth and output file
  %(prog)s urn:ngsi-ld:Building:001 --max-depth 10 --output building_full.json

  # Specify host and port
  %(prog)s urn:ngsi-ld:Building:001 --host localhost --port 1026

  # Generate static PNG diagram
  %(prog)s urn:ngsi-ld:Building:001 --diagram --diagram-output building_diagram

  # Generate interactive HTML diagram (drag nodes, zoom, pan)
  %(prog)s urn:ngsi-ld:Building:001 --interactive --interactive-output building.html

  # Generate both diagram types
  %(prog)s urn:ngsi-ld:Building:001 --diagram --interactive

  # Output only material weight calculations
  %(prog)s urn:ngsi-ld:Building:001 --materials-only --output materials.json

  # Generate NGSI-LD entity with materialTotals (ready to upload to Orion-LD)
  %(prog)s urn:ngsi-ld:Building:001 --ngsi-ld-materials --output material_totals_entity.json
        """
    )

    parser.add_argument('entity_id', help='The ID of the entity to expand')
    parser.add_argument('--tenant', default='circuloos_demo',
                       help='The NGSILD tenant (default: circuloos_demo)')
    parser.add_argument('--max-depth', type=int, default=5,
                       help='Maximum recursion depth (default: 5)')
    parser.add_argument('--output', '-o', default='expanded.json',
                       help='Output file name (default: expanded.json)')
    parser.add_argument('--host', help='Orion-LD host (default: from .env)')
    parser.add_argument('--port', type=int, help='Orion-LD port (default: from .env)')
    parser.add_argument('--pretty', action='store_true',
                       help='Pretty print the JSON output')
    parser.add_argument('--diagram', '-d', action='store_true',
                       help='Generate a PNG diagram of entity relationships')
    parser.add_argument('--diagram-output', default='entity_diagram',
                       help='Base path for diagram output (default: entity_diagram)')
    parser.add_argument('--interactive', '-i', action='store_true',
                       help='Generate an interactive HTML diagram (with drag, zoom, pan)')
    parser.add_argument('--interactive-output', default='entity_diagram_interactive.html',
                       help='Path for interactive HTML diagram (default: entity_diagram_interactive.html)')
    parser.add_argument('--materials-only', '-m', action='store_true',
                       help='Output only material weight calculations (excludes mainEntity and relatedEntities)')
    parser.add_argument('--ngsi-ld-materials', action='store_true',
                       help='Generate NGSI-LD formatted entity with materialTotals property (ready for Orion-LD upload)')

    args = parser.parse_args()

    # Load .env file
    script_dir = Path(__file__).parent
    env_file = script_dir.parent / '.env'
    env_vars = load_env_file(env_file)

    # Get configuration
    host = args.host or env_vars.get('HOST', 'localhost')
    port = args.port or int(env_vars.get('ORION_LD_PORT', '1026'))

    try:
        # Create expander and expand entity
        expander = OrionLDExpander(
            host=host,
            port=port,
            tenant=args.tenant,
            max_depth=args.max_depth
        )

        result = expander.expand(args.entity_id)

        # Prepare output based on flags
        if args.ngsi_ld_materials:
            # Generate NGSI-LD formatted entity with materialTotals
            material_calcs = result.get('materialWeightCalculations', {})
            material_totals = material_calcs.get('materialTotals', {})
            output_data = expander._generate_ngsi_ld_material_totals(args.entity_id, material_totals)
        elif args.materials_only:
            # Output only material calculations (not NGSI-LD formatted)
            output_data = result.get('materialWeightCalculations', {})
        else:
            # Full expansion output
            output_data = result

        # Write output
        print(f"\nBuilding output JSON...", file=sys.stderr)
        with open(args.output, 'w') as f:
            if args.pretty:
                json.dump(output_data, f, indent=2, ensure_ascii=False)
            else:
                json.dump(output_data, f, indent=2, ensure_ascii=False)

        print(f"\n✓ Expansion complete!", file=sys.stderr)
        print(f"  Total entities fetched: {len(expander.all_entities)}", file=sys.stderr)
        if args.ngsi_ld_materials:
            print(f"  NGSI-LD material totals entity written to: {args.output}", file=sys.stderr)
            print(f"  Ready to upload to Orion-LD!", file=sys.stderr)
        elif args.materials_only:
            print(f"  Material calculations written to: {args.output}", file=sys.stderr)
        else:
            print(f"  Output written to: {args.output}", file=sys.stderr)
        print(f"\nTo view: cat {args.output} | jq .", file=sys.stderr)

        # Generate diagram if requested
        if args.diagram:
            diagram_path = expander.generate_diagram(args.diagram_output)
            if diagram_path:
                print(f"  Diagram written to: {diagram_path}", file=sys.stderr)

        # Generate interactive diagram if requested
        if args.interactive:
            interactive_path = expander.generate_interactive_diagram(args.interactive_output)
            if interactive_path:
                print(f"  Interactive diagram written to: {interactive_path}", file=sys.stderr)

    except Exception as e:
        print(f"\n✗ Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
