# Washing Machine Tray - Entity Visualization

This directory contains the washing machine tray entity data and visualization tools.

## Generated Visualizations

### Static PNG Diagram

A static diagram showing all entities and their relationships with a legend. Good for documentation and reports.

### Interactive HTML Diagram
An interactive visualization with the following features:

#### Interactive Features:
- **Drag Nodes**: Click and drag any node to reposition it
- **Zoom**: Use mouse wheel to zoom in/out
- **Pan**: Click and drag the background to pan around
- **Navigation Buttons**: Use built-in navigation controls (bottom right)
- **Hover**: Hover over nodes and edges to see tooltips with details
- **Hierarchical Layout**: Nodes are organized in a top-down hierarchy (similar to PNG)
- **Legend**: Interactive legend in the top-right corner showing all entity types and relationships


#### Node Colors:
- **Red** (#FF6B6B) - ManufacturingMachine
- **Cyan** (#4ECDC4) - ManufacturingComponent
- **Light Green** (#95E1D3) - Material
- **Yellow** (#FFD93D) - Company
- **Purple** (#C49BFF) - Warehouse

#### Edge Colors (Relationships):
- **Red** (bold) - hasComponent
- **Cyan** - hasMaterial
- **Purple** (dashed) - warehouseLocation
- **Yellow** - producedBy
- **Light Green** (dotted) - supplier

## Generating Diagrams

### Prerequisites

```bash
# Install system graphviz (for PNG diagrams)
sudo apt install graphviz

# Install Python dependencies
pip install graphviz pyvis
```

### Usage

From the project root directory:

#### Generate Static PNG Diagram
```bash
python3 commands/expand_entity.py \
  urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001 \
  --diagram \
  --diagram-output circuloos-entities/plastic/washing-machine-tray/washing_machine_diagram
```

#### Generate Interactive HTML Diagram
```bash
python3 commands/expand_entity.py \
  urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001 \
  --interactive \
  --interactive-output circuloos-entities/plastic/washing-machine-tray/washing_machine_interactive.html
```

#### Generate Both Diagrams
```bash
python3 commands/expand_entity.py \
  urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001 \
  --diagram \
  --interactive \
  --diagram-output circuloos-entities/plastic/washing-machine-tray/washing_machine_diagram \
  --interactive-output circuloos-entities/plastic/washing-machine-tray/washing_machine_interactive.html
```

### Command Options

```
usage: expand_entity.py [-h] [--tenant TENANT] [--max-depth MAX_DEPTH]
                       [--output OUTPUT] [--host HOST] [--port PORT]
                       [--pretty] [--diagram] [--diagram-output DIAGRAM_OUTPUT]
                       [--interactive] [--interactive-output INTERACTIVE_OUTPUT]
                       entity_id

Options:
  --diagram, -d              Generate a PNG diagram of entity relationships
  --diagram-output PATH      Base path for diagram output (default: entity_diagram)
  --interactive, -i          Generate an interactive HTML diagram (drag, zoom, pan)
  --interactive-output PATH  Path for interactive HTML (default: entity_diagram_interactive.html)
  --max-depth N              Maximum recursion depth for relationships (default: 5)
  --tenant TENANT            NGSILD tenant (default: circuloos_demo)
```

## Entity Relationship Structure

The expand_entity.py script recursively follows these NGSI-LD Relationship types:

1. **hasComponent** - ManufacturingMachine → ManufacturingComponent (1:N)
2. **hasMaterial** - ManufacturingComponent → Material (N:1)
3. **warehouseLocation** - ManufacturingComponent → Warehouse (N:1)
4. **producedBy** - ManufacturingComponent → Company (N:1)
5. **supplier** - Material → Company (N:M)

## Example: Opening Interactive Diagram

```bash
# Generate the interactive diagram
python3 commands/expand_entity.py \
  urn:ngsi-ld:ManufacturingMachine:washingMachineTray:001 \
  --interactive

# Open in browser
xdg-open washing_machine_interactive.html
# or on macOS:
# open washing_machine_interactive.html
# or on Windows:
# start washing_machine_interactive.html
```
