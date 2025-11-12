#!/bin/bash

# ========================================
# Execute Production Update for Neo4j
# Produces 100 Siphon units and updates stock levels
# ========================================

# Neo4j connection details
NEO4J_URI="bolt://localhost:7687"
NEO4J_USER="neo4j"
NEO4J_PASSWORD="your_password"  # Update this with your actual password

echo "========================================="
echo "Starting Production Update..."
echo "========================================="

# Execute the production update Cypher script
docker exec -i neo4j-circuloos cypher-shell -u neo4j -p password  < neo4j-production-update.cypher

echo ""
echo "========================================="
echo "Production Update Complete!"
echo "========================================="
echo ""
echo "To verify the changes, you can run:"
echo "  ./verify_stock_levels.sh"
