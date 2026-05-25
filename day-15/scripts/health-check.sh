#!/bin/bash

NAMESPACE="multi-service"
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Kubernetes Health Check${NC}"
echo "========================"
echo ""

# Check pods
echo -e "${YELLOW}Pod Status:${NC}"
kubectl get pods -n $NAMESPACE -o wide
echo ""

# Check deployments
echo -e "${YELLOW}Deployment Status:${NC}"
kubectl get deployments -n $NAMESPACE
echo ""

# Check services
echo -e "${YELLOW}Service Status:${NC}"
kubectl get svc -n $NAMESPACE
echo ""

# Check HPA
echo -e "${YELLOW}Autoscaling Status:${NC}"
kubectl get hpa -n $NAMESPACE
echo ""

# Check events
echo -e "${YELLOW}Recent Events:${NC}"
kubectl get events -n $NAMESPACE --sort-by='.lastTimestamp' | tail -10
echo ""

# Pod resource usage
echo -e "${YELLOW}Resource Usage:${NC}"
kubectl top pods -n $NAMESPACE 2>/dev/null || echo "Metrics not available (install metrics-server)"
