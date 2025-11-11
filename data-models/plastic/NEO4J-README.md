# CIRCULOOS Plastic Manufacturing - Neo4j Graph Database

## Installation

### Prerequisites

1. **Neo4j Database** (4.4+ or 5.x)
   ```bash
   # Using Docker
   docker run -d \
     --name neo4j-circuloos \
     -p 7474:7474 -p 7687:7687 \
     -e NEO4J_AUTH=neo4j/password \
     neo4j:latest
   ```

### Load Data

#### Option 1: Using Neo4j Browser (RECOMMENDED - No Java issues)

1. Open Neo4j Browser: http://localhost:7474
2. Login with credentials (default: neo4j/password)
3. Open the `neo4j-washing-machine-tray.cypher` file in a text editor
4. Copy sections and paste into Neo4j Browser
5. Execute each section one by one (the script is divided into 16 sections)
6. Verify with the verification queries at the end

**Tips for Neo4j Browser:**
- The browser may timeout on large scripts
- Execute sections 1-16 separately for best results
- Each section is clearly marked with comments
- Watch for any error messages after each execution
