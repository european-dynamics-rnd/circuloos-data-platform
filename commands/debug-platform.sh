#!/bin/bash

# CIRCULOOS Data Platform Debug Log Generator
# Generates comprehensive diagnostic information for troubleshooting

# Color output for terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check for required commands
echo -e "${GREEN}=== CIRCULOOS Data Platform Debug Log Generator ===${NC}"
echo -e "${YELLOW}Checking required commands...${NC}\n"

REQUIRED_COMMANDS=("docker" "curl" "grep" "awk" "sed" "date" "hostname" "uname" "uptime" "du" "df" "wc")
OPTIONAL_COMMANDS=("netstat" "ss" "lsof" "nslookup" "ping" "systemctl" "journalctl")
MISSING_REQUIRED=()
MISSING_OPTIONAL=()

# Check required commands
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        MISSING_REQUIRED+=("$cmd")
        echo -e "${RED}✗ Missing required command: $cmd${NC}"
    fi
done

# Special check for docker compose (V2 plugin)
if ! docker compose version &> /dev/null; then
    MISSING_REQUIRED+=("docker compose")
    echo -e "${RED}✗ Missing required command: docker compose${NC}"
fi

# Check optional commands
for cmd in "${OPTIONAL_COMMANDS[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        MISSING_OPTIONAL+=("$cmd")
    fi
done

# Exit if required commands are missing
if [ ${#MISSING_REQUIRED[@]} -gt 0 ]; then
    echo -e "\n${RED}ERROR: Missing required commands: ${MISSING_REQUIRED[*]}${NC}"
    echo -e "${YELLOW}Please install missing commands and try again.${NC}"
    exit 1
fi

# Warn about optional commands
if [ ${#MISSING_OPTIONAL[@]} -gt 0 ]; then
    echo -e "\n${YELLOW}⚠ Optional commands not found: ${MISSING_OPTIONAL[*]}${NC}"
    echo -e "${YELLOW}  Some diagnostic features may be limited.${NC}"
fi

echo -e "\n${GREEN}All required commands are available!${NC}\n"

# Create logs directory if it doesn't exist
LOGS_DIR="./debug-logs"
mkdir -p "$LOGS_DIR"

# Generate timestamp for log file
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="$LOGS_DIR/debug_log_$TIMESTAMP.txt"

echo -e "${YELLOW}Collecting diagnostic information...${NC}"
echo -e "Log file: ${GREEN}$LOG_FILE${NC}\n"

# Start logging
{
    echo "========================================"
    echo "CIRCULOOS Data Platform Debug Log"
    echo "Generated: $(date)"
    echo "========================================"
    echo ""

    # System Information
    echo "========== SYSTEM INFORMATION =========="
    echo "Hostname: $(hostname)"
    echo "OS: $(uname -a)"
    echo "Uptime: $(uptime)"
    echo "Current User: $(whoami)"
    echo "Working Directory: $(pwd)"
    echo ""

    # Environment Variables (.env file)
    echo "========== ENVIRONMENT VARIABLES (.env) =========="
    if [ -f "../.env" ]; then
        cat ../.env 2>&1
    else
        echo ".env file not found in current directory"
    fi
    echo ""

    # Docker Version
    echo "========== DOCKER VERSION =========="
    docker --version 2>&1
    docker-compose --version 2>&1
    echo ""

    # Docker Service Status
    echo "========== DOCKER SERVICE STATUS =========="
    systemctl is-active docker 2>&1 || echo "systemctl not available"
    echo ""

    # Running Containers
    echo "========== DOCKER CONTAINERS (Running) =========="
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>&1
    echo ""

    # All Containers (including stopped)
    echo "========== DOCKER CONTAINERS (All) =========="
    docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>&1
    echo ""

    # Container Exit Codes and Status Details
    echo "========== CONTAINER EXIT CODES & STATUS =========="
    docker ps -a --format "table {{.Names}}\t{{.State}}\t{{.Status}}" 2>&1
    echo ""
    echo "Containers with non-zero exit codes:"
    docker ps -a --filter "status=exited" --format "{{.Names}}: Exit {{.Status}}" 2>&1 | grep -v "Exit 0" || echo "None found"
    echo ""

    # Docker Compose Status
    echo "========== DOCKER COMPOSE STATUS =========="
    docker-compose ps 2>&1
    echo ""

    # Container Resource Usage
    echo "========== CONTAINER RESOURCE USAGE =========="
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}" 2>&1
    echo ""

    # Port Usage
    echo "========== PORT USAGE (LISTENING) =========="
    sudo netstat -tulpn | grep LISTEN 2>&1 || ss -tulpn 2>&1
    echo ""

    # Critical Ports Check
    echo "========== CRITICAL PORTS CHECK =========="
    
    # Read ports from .env file if available
    PORTS_TO_CHECK=()
    if [ -f "../.env" ]; then
        # Extract port values from .env
        ORION_LD_PORT=$(grep -E '^ORION_LD_PORT=' ../.env | cut -d'=' -f2 | tr -d ' ')
        MONGO_DB_PORT=$(grep -E '^MONGO_DB_PORT=' ../.env | cut -d'=' -f2 | tr -d ' ')
        MINTAKA_PORT=$(grep -E '^MINTAKA_PORT=' ../.env | cut -d'=' -f2 | tr -d ' ')
        TIMESCALE_PORT=$(grep -E '^TIMESCALE_PORT=' ../.env | cut -d'=' -f2 | tr -d ' ')
        KEYCLOAK_TLS_PORT=$(grep -E '^KEYCLOAK_TLS_PORT=' ../.env | cut -d'=' -f2 | tr -d ' ')
        QUANTUMLEAP_PORT=$(grep -E '^QUANTUMLEAP_PORT=' ../.env | cut -d'=' -f2 | tr -d ' ')
        REDIS_PORT=$(grep -E '^REDIS_PORT=' ../.env | cut -d'=' -f2 | tr -d ' ')
        KONG_PORT=$(grep -E '^KONG_PORT=' ../.env | cut -d'=' -f2 | tr -d ' ')
        
        # Build port list with descriptions
        [ -n "$ORION_LD_PORT" ] && PORTS_TO_CHECK+=("$ORION_LD_PORT:Orion-LD")
        [ -n "$MONGO_DB_PORT" ] && PORTS_TO_CHECK+=("$MONGO_DB_PORT:MongoDB")
        [ -n "$MINTAKA_PORT" ] && PORTS_TO_CHECK+=("$MINTAKA_PORT:Mintaka")
        [ -n "$TIMESCALE_PORT" ] && PORTS_TO_CHECK+=("$TIMESCALE_PORT:TimescaleDB")
        [ -n "$KEYCLOAK_TLS_PORT" ] && PORTS_TO_CHECK+=("$KEYCLOAK_TLS_PORT:Keycloak")
        [ -n "$QUANTUMLEAP_PORT" ] && PORTS_TO_CHECK+=("$QUANTUMLEAP_PORT:QuantumLeap")
        [ -n "$REDIS_PORT" ] && PORTS_TO_CHECK+=("$REDIS_PORT:Redis")
        [ -n "$KONG_PORT" ] && PORTS_TO_CHECK+=("$KONG_PORT:Kong")
        
        # Add common Kong ports
        PORTS_TO_CHECK+=("8000:Kong-Proxy" "8001:Kong-Admin" "8082:Keycloak-HTTP")
    else
        # Fallback to default ports if .env not found
        PORTS_TO_CHECK=("8000:Kong-Proxy" "8001:Kong-Admin" "8082:Keycloak" "1026:Orion-LD" "8668:QuantumLeap" "5432:PostgreSQL" "27017:MongoDB")
    fi
    
    for port_info in "${PORTS_TO_CHECK[@]}"; do
        port=$(echo "$port_info" | cut -d':' -f1)
        service=$(echo "$port_info" | cut -d':' -f2)
        
        if sudo lsof -i :$port > /dev/null 2>&1; then
            echo "Port $port ($service): IN USE"
            sudo lsof -i :$port 2>&1 | head -3
        else
            echo "Port $port ($service): AVAILABLE"
        fi
    done
    echo ""

    # Docker Networks
    echo "========== DOCKER NETWORKS =========="
    docker network ls 2>&1
    echo ""

    # Default Network Inspection
    echo "========== DEFAULT NETWORK DETAILS =========="
    docker network inspect circuloos-data-platform_default 2>&1 || echo "Network not found"
    echo ""

    # Docker Volumes
    echo "========== DOCKER VOLUMES =========="
    docker volume ls 2>&1
    echo ""

    # Docker Disk Usage
    echo "========== DOCKER DISK USAGE =========="
    docker system df 2>&1
    echo ""

    # Recent Docker Events
    echo "========== RECENT DOCKER EVENTS (Last 50) =========="
    docker events --since 1h --until 0s 2>&1 | tail -50 || echo "No recent events or docker events not available"
    echo ""

    # System Disk Usage
    echo "========== SYSTEM DISK USAGE =========="
    df -h 2>&1
    echo ""

    # System Memory and Swap
    echo "========== SYSTEM MEMORY & SWAP =========="
    free -h 2>&1
    echo ""
    echo "OOM Killer activity (last 50 lines):"
    dmesg -T 2>&1 | grep -i "killed process" | tail -50 || echo "No OOM kills found or dmesg not accessible"
    echo ""

    # Kernel Messages Related to Docker
    echo "========== KERNEL MESSAGES (Docker/Container related) =========="
    dmesg -T 2>&1 | grep -i -E "docker|container|oom" | tail -30 || echo "No relevant kernel messages or dmesg not accessible"
    echo ""

    # System Limits
    echo "========== SYSTEM LIMITS (ulimit) =========="
    ulimit -a 2>&1
    echo ""

    # Docker Compose Configuration
    echo "========== DOCKER COMPOSE CONFIG =========="
    docker-compose config 2>&1
    echo ""

    # Service Versions (Orion)
    echo "========== ORION-LD VERSION =========="
    if [ -f "./getOrionVersion.sh" ]; then
        timeout 5 ./getOrionVersion.sh 2>&1 || echo "Timeout or error getting Orion version"
    else
        curl -s http://localhost:1026/version 2>&1 || echo "Cannot reach Orion"
    fi
    echo ""

    # Service Versions (Mintaka)
    echo "========== MINTAKA VERSION =========="
    if [ -f "./getMintakaVersion.sh" ]; then
        timeout 5 ./getMintakaVersion.sh 2>&1 || echo "Timeout or error getting Mintaka version"
    else
        curl -s http://localhost:8668/version 2>&1 || echo "Cannot reach Mintaka"
    fi
    echo ""

    # Kong Status
    echo "========== KONG GATEWAY STATUS =========="
    curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" http://localhost:8001/status 2>&1 || echo "Cannot reach Kong"
    curl -s http://localhost:8001/status 2>&1 | head -20
    echo ""

    # Keycloak Status
    echo "========== KEYCLOAK STATUS =========="
    curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" http://localhost:8082/health 2>&1 || echo "Cannot reach Keycloak"
    echo ""

    # Container Health Checks
    echo "========== CONTAINER HEALTH CHECKS =========="
    for container in $(docker ps -a --format "{{.Names}}" 2>&1); do
        health=$(docker inspect --format='{{.State.Health.Status}}' "$container" 2>&1)
        if [ "$health" != "<no value>" ] && [ -n "$health" ]; then
            echo "$container: $health"
        fi
    done
    echo ""

    # Inspect Failed/Stopped Containers
    echo "========== DETAILED INSPECTION OF FAILED/STOPPED CONTAINERS =========="
    for container in $(docker ps -a --filter "status=exited" --format "{{.Names}}" 2>&1); do
        echo "--- Inspecting: $container ---"
        docker inspect "$container" 2>&1 | grep -A 20 -E '"State"|"ExitCode"|"Error"|"Health"|"RestartCount"'
        echo ""
    done
    echo ""

    # Container Restart Counts
    echo "========== CONTAINER RESTART COUNTS =========="
    docker ps -a --format "table {{.Names}}\t{{.Status}}" 2>&1 | grep -i restart || echo "No restarting containers"
    echo ""

    # Container Logs (Last 100 lines, including stopped containers)
    echo "========== CONTAINER LOGS (Last 100 lines each, including stopped) =========="
    for container in $(docker ps -a --format "{{.Names}}" 2>&1); do
        echo ""
        echo "--- Logs for: $container ---"
        docker logs --tail=100 "$container" 2>&1
        echo ""
    done

    # Error Search in Recent Logs
    echo "========== ERROR SEARCH IN LOGS =========="
    docker-compose logs --tail=100 2>&1 | grep -i -E "error|exception|fail|fatal|panic" | head -50
    echo ""

    # Environment Variables (sanitized)
    echo "========== ENVIRONMENT VARIABLES (sanitized) =========="
    env | grep -i -E "docker|compose|kong|keycloak" | grep -v -i -E "password|secret|token|key" 2>&1
    echo ""

    # Network Connectivity Tests
    echo "========== NETWORK CONNECTIVITY =========="
    echo "Testing DNS resolution from host..."
    nslookup google.com 2>&1 | head -5
    echo ""
    echo "Testing internet connectivity from host..."
    ping -c 2 8.8.8.8 2>&1
    echo ""

    # DNS Resolution from Containers
    echo "========== DNS RESOLUTION FROM CONTAINERS =========="
    for container in $(docker ps --format "{{.Names}}" 2>&1 | head -3); do
        echo "Testing DNS in container: $container"
        docker exec "$container" nslookup google.com 2>&1 | head -5 || echo "DNS test failed or nslookup not available in container"
        echo ""
    done

    # Time Synchronization
    echo "========== TIME SYNCHRONIZATION =========="
    echo "Host time: $(date)"
    echo "Host timezone: $(timedatectl 2>&1 | grep 'Time zone' || echo $TZ)"
    if command -v timedatectl &> /dev/null; then
        timedatectl status 2>&1
    fi
    echo ""

    # Firewall Status
    echo "========== FIREWALL STATUS =========="
    if command -v ufw &> /dev/null; then
        sudo ufw status 2>&1
    elif command -v firewall-cmd &> /dev/null; then
        sudo firewall-cmd --state 2>&1
    else
        echo "No common firewall tool detected"
    fi
    echo ""

    # SELinux/AppArmor Status
    echo "========== SELINUX/APPARMOR STATUS =========="
    if command -v getenforce &> /dev/null; then
        echo "SELinux status: $(getenforce 2>&1)"
        sestatus 2>&1 | head -10
    elif command -v aa-status &> /dev/null; then
        echo "AppArmor status:"
        sudo aa-status 2>&1 | head -20
    else
        echo "Neither SELinux nor AppArmor detected"
    fi
    echo ""

    # Docker Daemon Logs
    echo "========== DOCKER DAEMON LOGS (Last 50 lines) =========="
    if command -v journalctl &> /dev/null; then
        sudo journalctl -u docker -n 50 --no-pager 2>&1
    else
        echo "journalctl not available, trying docker logs location..."
        tail -50 /var/log/docker.log 2>&1 || echo "Docker logs not accessible"
    fi
    echo ""

    # Recent System Errors
    echo "========== RECENT SYSTEM ERRORS (journalctl) =========="
    if command -v journalctl &> /dev/null; then
        sudo journalctl -p err -n 20 --no-pager 2>&1
    else
        echo "journalctl not available"
    fi
    echo ""

    echo "========================================"
    echo "Debug log generation completed"
    echo "Timestamp: $(date)"
    echo "========================================"

} > "$LOG_FILE" 2>&1

# Create a summary on console
echo -e "\n${GREEN}=== Debug Log Summary ===${NC}"
echo "Log saved to: $LOG_FILE"
echo ""
echo -e "${YELLOW}Quick Stats:${NC}"
echo "- Running containers: $(docker ps -q | wc -l)"
echo "- Total containers: $(docker ps -aq | wc -l)"
echo "- Docker images: $(docker images -q | wc -l)"
echo "- Docker networks: $(docker network ls -q | wc -l)"
echo "- Log file size: $(du -h "$LOG_FILE" | cut -f1)"
echo ""

# Check for critical issues
echo -e "${YELLOW}Checking for critical issues...${NC}"
ERROR_COUNT=$(docker-compose logs --tail=100 2>&1 | grep -i -E "error|exception|fail|fatal" | wc -l)
ERROR_COUNT=${ERROR_COUNT:-0}
if [ "$ERROR_COUNT" -gt 0 ] 2>/dev/null; then
    echo -e "${RED} Found $ERROR_COUNT error/exception mentions in recent logs${NC}"
else
    echo -e "${GREEN} No obvious errors in recent logs${NC}"
fi

# Check if all expected services are running
EXPECTED_SERVICES=("orion" "mintaka" "kong" "keycloak")
for service in "${EXPECTED_SERVICES[@]}"; do
    if docker ps | grep -q "$service"; then
        echo -e "${GREEN} $service is running${NC}"
    else
        echo -e "${RED} $service is NOT running${NC}"
    fi
done

echo ""
echo -e "${GREEN}Debug log generation complete!${NC}"
echo -e "Review the log file for detailed information: ${YELLOW}$LOG_FILE${NC}"
