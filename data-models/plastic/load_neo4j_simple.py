#!/usr/bin/env python3
"""
Simple Neo4j Data Loader using native driver
Loads washing machine tray data
"""

import sys
from pathlib import Path
from neo4j_config import Neo4jConnection, check_docker_container, start_docker_container


def main():
    print("=" * 50)
    print("CIRCULOOS Neo4j Simple Batch Loader")
    print("=" * 50)
    print()
    
    # Check Docker container
    print("Checking Neo4j connection...")
    running, message = check_docker_container()
    print(message)
    
    if not running:
        print("\nAttempting to start container...")
        if start_docker_container():
            import time
            print("Waiting 5 seconds for Neo4j to initialize...")
            time.sleep(5)
        else:
            sys.exit(1)
    
    print()
    
    # Connect to Neo4j and load data
    with Neo4jConnection() as conn:
        # Clear existing data
        print("Clearing existing data...")
        conn.execute_write("MATCH (n) DETACH DELETE n")
        print("✓ Database cleared\n")
        
        # Load data
        print("Loading data into Neo4j...")
        cypher_file = Path(__file__).parent / "neo4j-washing-machine-tray.cypher"
        
        try:
            conn.execute_file(cypher_file)
            print("✓ Data loaded\n")
        except Exception as e:
            print(f"✗ Error loading data: {e}")
            sys.exit(1)
        
        print("=" * 50)
        print("Verification")
        print("=" * 50)
        print()
        
        # Verify the data
        nodes = conn.execute_query(
            "MATCH (n) RETURN labels(n)[0] as NodeType, count(n) as Count ORDER BY Count DESC"
        )
        for node in nodes:
            print(f"  {node['NodeType']}: {node['Count']}")
    
    print()
    print("✓ Data loading complete!")
    print()
    print("Open Neo4j Browser: http://localhost:7474")
    print("Login: neo4j / password")
    print("Query: MATCH (n) RETURN n LIMIT 25")


if __name__ == "__main__":
    main()
