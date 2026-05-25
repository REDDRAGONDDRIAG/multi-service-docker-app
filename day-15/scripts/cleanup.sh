#!/bin/bash

set -e

NAMESPACE="multi-service"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${RED}=============================================="
echo "🗑️  CLEANUP - Removing all resources..."
echo "=============================================${NC}"
echo ""

read -p "Are you sure you want to delete namespace '$NAMESPACE'? (yes/no): " confirm

if [ "$confirm" = "yes" ]; then
    echo -e "${YELLOW}Deleting namespace and all resources...${NC}"
    kubectl delete namespace $NAMESPACE --ignore-not-found=true
    
    echo -e "${YELLOW}Waiting for cleanup...${NC}"
    sleep 5
    
    echo -e "${GREEN}✓ Cleanup completed!${NC}"
else
    echo -e "${YELLOW}Cleanup cancelled.${NC}"
fi
