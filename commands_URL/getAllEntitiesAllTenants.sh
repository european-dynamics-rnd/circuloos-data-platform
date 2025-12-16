#!/bin/bash
#
# Script to get all entities from all tenants
# Usage: ./getAllEntitiesAllTenants.sh
#


# Change to the script directory
cd "$(dirname "$0")"

export $(cat ./partner_variables.txt | grep "#" -v)

echo "=========================================="
echo "Getting all tenants..."
echo "=========================================="

# Get all tenants and parse JSON, filter out postgres, circuloos, orion
TENANTS_JSON=$(./getTenantsViaKong.sh)
TENANTS=$(echo "$TENANTS_JSON" | jq -r '.tenants[]' | grep -v "^postgres$" | grep -v "^circuloos$" | grep -v "^orion$")

if [ -z "$TENANTS" ]; then
    echo "No tenants found!"
    exit 1
fi

echo "Found tenants:"
# Display tenants without orion_ prefix
for t in $TENANTS; do
    echo "  - ${t#orion_}"
done
echo ""

# Loop through each tenant and get entities
for TENANT in $TENANTS; do
    # Remove orion_ prefix for display
    DISPLAY_NAME="${TENANT#orion_}"
    
    echo "=========================================="
    echo "Tenant: $DISPLAY_NAME"
    echo "=========================================="
    
    # Get all entities for this tenant
    ENTITIES=$(./getAll_Ids_OrionViaKong.sh "$DISPLAY_NAME" 2>/dev/null || echo "")
    
    if [ -z "$ENTITIES" ]; then
        echo "  No entities found for tenant: $TENANT"
    else
        echo "  Entities:"
        echo "$ENTITIES" | while read -r entity; do
            echo "    - $entity"
        done
        
        # Count entities
        ENTITY_COUNT=$(echo "$ENTITIES" | wc -l)
        echo "  Total: $ENTITY_COUNT entities"
    fi
    
    echo ""
done

