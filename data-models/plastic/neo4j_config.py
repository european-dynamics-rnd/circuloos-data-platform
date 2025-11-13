#!/usr/bin/env python3
"""
Neo4j Connection Configuration
Shared configuration for all Neo4j scripts
"""

import docker
from neo4j import GraphDatabase
import sys


# Configuration
NEO4J_CONTAINER_NAME = "neo4j-circuloos"
NEO4J_URI = "bolt://localhost:7687"
NEO4J_USER = "neo4j"
NEO4J_PASSWORD = "password"


class Neo4jConnection:
    """Neo4j database connection manager"""
    
    def __init__(self, uri=NEO4J_URI, user=NEO4J_USER, password=NEO4J_PASSWORD):
        """Initialize Neo4j connection"""
        self.uri = uri
        self.user = user
        self.password = password
        self.driver = None
    
    def __enter__(self):
        """Context manager entry"""
        try:
            self.driver = GraphDatabase.driver(self.uri, auth=(self.user, self.password))
            # Test connection
            self.driver.verify_connectivity()
            return self
        except Exception as e:
            print(f"✗ Failed to connect to Neo4j: {e}")
            print(f"  URI: {self.uri}")
            print(f"  User: {self.user}")
            print("\nMake sure Neo4j container is running:")
            print(f"  docker start {NEO4J_CONTAINER_NAME}")
            sys.exit(1)
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit"""
        if self.driver:
            self.driver.close()
    
    def execute_query(self, query, parameters=None):
        """Execute a Cypher query and return results"""
        with self.driver.session() as session:
            result = session.run(query, parameters or {})
            return [record.data() for record in result]
    
    def execute_write(self, query, parameters=None):
        """Execute a write query"""
        with self.driver.session() as session:
            result = session.run(query, parameters or {})
            return result.consume()
    
    def execute_file(self, filepath):
        """Execute a Cypher file"""
        with open(filepath, 'r') as f:
            content = f.read()
        
        # Neo4j driver doesn't handle multi-statement files well
        # Execute the entire file as one batch using session.run
        results = []
        with self.driver.session() as session:
            try:
                # Try to execute the whole file at once
                result = session.run(content)
                # Consume the result
                summary = result.consume()
                
                # Get counters if available
                if summary.counters:
                    counters = {
                        'nodes_created': summary.counters.nodes_created,
                        'relationships_created': summary.counters.relationships_created,
                        'properties_set': summary.counters.properties_set
                    }
                    results.append(counters)
                
                return results
            except Exception as e:
                # If single execution fails, try splitting by CREATE statements
                # This is more compatible with complex Cypher files
                print(f"Note: Using line-by-line execution for compatibility")
                
                lines = content.split('\n')
                current_statement = []
                
                for line in lines:
                    stripped = line.strip()
                    
                    # Skip comments and empty lines
                    if not stripped or stripped.startswith('//'):
                        continue
                    
                    current_statement.append(line)
                    
                    # Execute when we hit a semicolon at end of line
                    if stripped.endswith(';'):
                        stmt = '\n'.join(current_statement)
                        try:
                            result = session.run(stmt)
                            result.consume()
                        except Exception as stmt_error:
                            # Skip errors for comments or formatting issues
                            if "unexpected end of input" not in str(stmt_error).lower():
                                print(f"Warning executing statement: {stmt_error}")
                        current_statement = []
                
                # Execute any remaining statement
                if current_statement:
                    stmt = '\n'.join(current_statement)
                    if stmt.strip():
                        try:
                            result = session.run(stmt)
                            result.consume()
                        except Exception as stmt_error:
                            print(f"Warning executing final statement: {stmt_error}")
                
                return results


def check_docker_container(container_name=NEO4J_CONTAINER_NAME):
    """Check if Docker container is running"""
    try:
        # Try different Docker connection methods
        client = None
        try:
            client = docker.DockerClient(base_url='unix://var/run/docker.sock')
        except Exception:
            try:
                client = docker.from_env()
            except Exception:
                # Fall back to subprocess method
                import subprocess
                result = subprocess.run(
                    ["docker", "ps", "--filter", f"name={container_name}", "--format", "{{.Status}}"],
                    capture_output=True,
                    text=True,
                    timeout=5
                )
                if result.returncode == 0 and "Up" in result.stdout:
                    return True, f"✓ Neo4j container '{container_name}' is running"
                elif result.returncode == 0:
                    return False, f"✗ Neo4j container '{container_name}' is not running"
                else:
                    return False, f"✗ Docker not accessible"
        
        if client:
            # Get container
            try:
                container = client.containers.get(container_name)
                
                if container.status == 'running':
                    return True, f"✓ Neo4j container '{container_name}' is running"
                else:
                    return False, f"✗ Neo4j container '{container_name}' exists but is not running (status: {container.status})"
            
            except docker.errors.NotFound:
                return False, f"✗ Neo4j container '{container_name}' not found"
            finally:
                client.close()
    
    except docker.errors.DockerException as e:
        return False, f"✗ Docker error: {e}"
    
    except Exception as e:
        return False, f"✗ Error checking Docker: {e}"


def start_docker_container(container_name=NEO4J_CONTAINER_NAME):
    """Start a Docker container"""
    try:
        # Try Docker SDK first
        try:
            client = docker.DockerClient(base_url='unix://var/run/docker.sock')
        except Exception:
            try:
                client = docker.from_env()
            except Exception:
                # Fall back to subprocess method
                import subprocess
                print(f"Starting container '{container_name}' using Docker CLI...")
                result = subprocess.run(
                    ["docker", "start", container_name],
                    capture_output=True,
                    text=True,
                    timeout=30
                )
                if result.returncode == 0:
                    print(f"✓ Container started")
                    return True
                else:
                    print(f"✗ Failed to start container: {result.stderr}")
                    return False
        
        if client:
            container = client.containers.get(container_name)
            
            if container.status != 'running':
                print(f"Starting container '{container_name}'...")
                container.start()
                print(f"✓ Container started")
                client.close()
                return True
            
            client.close()
            return True
    
    except docker.errors.NotFound:
        print(f"✗ Container '{container_name}' not found")
        return False
    
    except Exception as e:
        print(f"✗ Error starting container: {e}")
        return False


def get_container_logs(container_name=NEO4J_CONTAINER_NAME, tail=50):
    """Get Docker container logs"""
    try:
        # Try Docker SDK first
        try:
            client = docker.DockerClient(base_url='unix://var/run/docker.sock')
        except Exception:
            try:
                client = docker.from_env()
            except Exception:
                # Fall back to subprocess method
                import subprocess
                result = subprocess.run(
                    ["docker", "logs", "--tail", str(tail), container_name],
                    capture_output=True,
                    text=True,
                    timeout=10
                )
                if result.returncode == 0:
                    return result.stdout
                else:
                    return f"Error getting logs: {result.stderr}"
        
        if client:
            container = client.containers.get(container_name)
            logs = container.logs(tail=tail).decode('utf-8')
            client.close()
            return logs
    
    except Exception as e:
        return f"Error getting logs: {e}"


if __name__ == "__main__":
    # Test connection
    print("Testing Neo4j connection...")
    print()
    
    # Check Docker container
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
    
    # Test Neo4j connection
    with Neo4jConnection() as conn:
        print("✓ Connected to Neo4j successfully!")
        
        # Test query
        result = conn.execute_query("RETURN 1 as test")
        print(f"✓ Test query successful: {result}")
