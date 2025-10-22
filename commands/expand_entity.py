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
from typing import Dict, Set, Any, Optional
import requests
from pathlib import Path


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
            "relatedEntities": related_entities
        }

        return result


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

        # Write output
        print(f"\nBuilding output JSON...", file=sys.stderr)
        with open(args.output, 'w') as f:
            if args.pretty:
                json.dump(result, f, indent=2, ensure_ascii=False)
            else:
                json.dump(result, f, indent=2, ensure_ascii=False)

        print(f"\n✓ Expansion complete!", file=sys.stderr)
        print(f"  Total entities fetched: {len(expander.all_entities)}", file=sys.stderr)
        print(f"  Output written to: {args.output}", file=sys.stderr)
        print(f"\nTo view: cat {args.output} | jq .", file=sys.stderr)

    except Exception as e:
        print(f"\n✗ Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
