#!/bin/bash

# ========================================
# Verify Stock Levels in Neo4j
# ========================================

# Neo4j connection details
NEO4J_URI="bolt://localhost:7687"
NEO4J_USER="neo4j"
NEO4J_PASSWORD="your_password"  # Update this with your actual password

echo "========================================="
echo "Checking Current Stock Levels..."
echo "========================================="

# Execute the verification Cypher script
docker exec -i neo4j-circuloos cypher-shell -u neo4j -p password  < verify_stock_levels.cypher

echo ""
echo "========================================="
echo "Verification Complete!"
echo "========================================="
