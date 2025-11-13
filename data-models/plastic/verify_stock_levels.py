#!/usr/bin/env python3
"""
Verify Stock Levels in Neo4j
Displays current stock levels for all components and materials
"""

import sys
from pathlib import Path
from neo4j_config import Neo4jConnection


def main():
    print("=" * 50)
    print("Checking Current Stock Levels...")
    print("=" * 50)
    print()
    
    # Connect to Neo4j
    with Neo4jConnection() as conn:
        # Execute the verification query
        cypher_file = Path(__file__).parent / "verify_stock_levels.cypher"
        
        try:
            with open(cypher_file, 'r') as f:
                query = f.read()
            
            results = conn.execute_query(query)
            
            # Display results in a formatted table
            if results:
                print(f"{'Title':<35} | {'Component':<20} | {'Stock Level':<15} | {'Unit':<10}")
                print("-" * 90)
                
                for record in results:
                    title = record.get('Title', '')
                    component = record.get('ComponentName', '')
                    stock = record.get('CurrentStockLevel', 0)
                    unit = record.get('Unit', '')
                    
                    # Handle None values
                    title = str(title) if title is not None else ''
                    component = str(component) if component is not None else ''
                    stock = str(stock) if stock is not None else '0'
                    unit = str(unit) if unit is not None else ''
                    
                    print(f"{title:<35} | {component:<20} | {stock:<15} | {unit:<10}")
            else:
                print("No data found. Have you loaded the initial data?")
                print("Run: python load_neo4j_simple_siphon.py")
        
        except FileNotFoundError:
            print(f"✗ Error: File not found: {cypher_file}")
            sys.exit(1)
        except Exception as e:
            print(f"✗ Error verifying stock levels: {e}")
            sys.exit(1)
    
    print()
    print("=" * 50)
    print("Verification Complete!")
    print("=" * 50)


if __name__ == "__main__":
    main()
