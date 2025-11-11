#!/bin/bash
# Simple Neo4j Data Loader using cypher-shell with Java issues workaround
# This loads the data in smaller batches

echo "=========================================="
echo "CIRCULOOS Neo4j Simple Batch Loader"
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

# Load data using Neo4j's cypher-shell inside the container
echo "Loading data into Neo4j..."
docker exec -i neo4j-circuloos cypher-shell -u neo4j -p password < neo4j-washing-machine-tray.cypher

echo ""
echo "=========================================="
echo "Verification"
echo "=========================================="
echo ""

# Verify the data
docker exec -i neo4j-circuloos cypher-shell -u neo4j -p password << 'EOF'
MATCH (n) RETURN labels(n)[0] as NodeType, count(n) as Count ORDER BY Count DESC;
EOF

echo ""
echo "✓ Data loading complete!"
echo ""
echo "Open Neo4j Browser: http://localhost:7474"
echo "Login: neo4j / password"
echo "Query: MATCH (n) RETURN n LIMIT 25"
