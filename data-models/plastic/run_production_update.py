#!/usr/bin/env python3
"""
Execute Production Update for Neo4j
Produces 100 Siphon units and updates stock levels
"""

import sys
from pathlib import Path
from neo4j_config import Neo4jConnection


def main():
    print("=" * 50)
    print("Starting Production Update...")
    print("=" * 50)
    print()
    
    # Connect to Neo4j
    with Neo4jConnection() as conn:
        # Execute the production update Cypher script
        cypher_file = Path(__file__).parent / "neo4j-production-update.cypher"
        
        try:
            with open(cypher_file, 'r') as f:
                query = f.read()
            
            results = conn.execute_query(query)
            
            # Display production summary
            if results:
                print("Production Summary:")
                print("-" * 50)
                
                for record in results:
                    for key, value in record.items():
                        # Format section headers
                        if key.startswith('==='):
                            print(f"\n{value}")
                        else:
                            # Format numeric values
                            if isinstance(value, float):
                                print(f"  {key}: {value:.4f}")
                            else:
                                print(f"  {key}: {value}")
            else:
                print("✓ Production update completed (no summary returned)")
        
        except FileNotFoundError:
            print(f"✗ Error: File not found: {cypher_file}")
            sys.exit(1)
        except Exception as e:
            print(f"✗ Error running production update: {e}")
            import traceback
            traceback.print_exc()
            sys.exit(1)
    
    print()
    print("=" * 50)
    print("Production Update Complete!")
    print("=" * 50)
    print()
    print("To verify the changes, you can run:")
    print("  python verify_stock_levels.py")
    print("  or")
    print("  ./verify_stock_levels.py")


if __name__ == "__main__":
    main()
