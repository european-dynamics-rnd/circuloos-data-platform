#!/bin/bash
# Simple Neo4j Data Loader for siphon Example
# Loads just one component (siphon) with its relationships

echo "=========================================="
echo "CIRCULOOS Neo4j Simple siphon Example Loader"
echo "=========================================="
echo ""

# Check if Neo4j is running
echo "Checking Neo4j connection..."
if ! docker ps | grep -q neo4j; then
    echo "✗ Neo4j container is not running"
    echo "Start it with: docker start neo4j-circuloos"
    exit 1
fi

echo "✓ Neo4j is running"
echo ""

# Clear existing data
echo "Clearing existing data..."
docker exec -i neo4j-circuloos cypher-shell -u neo4j -p password << 'EOF'
MATCH (n) DETACH DELETE n;
EOF
echo "✓ Database cleared"
echo ""

# Load data
echo "Loading siphon component data into Neo4j..."
docker exec -i neo4j-circuloos cypher-shell -u neo4j -p password < neo4j-simple-siphon.cypher

echo ""
echo "=========================================="
echo "Verification"
echo "=========================================="
echo ""

# Verify nodes
echo "Nodes created:"
docker exec -i neo4j-circuloos cypher-shell -u neo4j -p password << 'EOF'
MATCH (n) RETURN labels(n)[0] as NodeType, count(n) as Count ORDER BY Count DESC;
EOF

echo ""
echo "Relationships created:"
docker exec -i neo4j-circuloos cypher-shell -u neo4j -p password << 'EOF'
MATCH ()-[r]->() RETURN type(r) as RelationType, count(r) as Count ORDER BY Count DESC;
EOF

echo ""
echo "=========================================="
echo "✓ Simple siphon example loaded successfully!"
echo "=========================================="
echo ""
echo "Open Neo4j Browser: http://localhost:7474"
echo "Login: neo4j / password"
echo ""
echo "Try these queries:"
echo "  1. View all: MATCH (n) RETURN n"
echo "  2. View flow: MATCH path = (s:Company)-[*]-(c:ManufacturingComponent) RETURN path"
echo "  3. Count nodes: MATCH (n) RETURN labels(n)[0] as Type, count(n) as Count"
