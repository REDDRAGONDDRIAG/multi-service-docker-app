#!/bin/bash

set -e

echo "🚀 Starting Advanced Kubernetes Deployment..."
echo "=============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

NAMESPACE="multi-service"
KUBECTL_CONTEXT=$(kubectl config current-context)

echo -e "${YELLOW}Deployment Context: $KUBECTL_CONTEXT${NC}"
echo -e "${YELLOW}Namespace: $NAMESPACE${NC}"
echo ""

# Function to apply resources
apply_resource() {
    local file=$1
    local name=$2
    
    if [ -f "$file" ]; then
        echo -e "${YELLOW}Applying $name...${NC}"
        kubectl apply -f "$file"
        echo -e "${GREEN}✓ $name applied${NC}"
    else
        echo -e "${RED}✗ $name not found: $file${NC}"
    fi
    echo ""
}

# Create namespace
echo -e "${YELLOW}Creating namespace...${NC}"
kubectl apply -f kubernetes/namespace.yaml
echo -e "${GREEN}✓ Namespace ready${NC}"
echo ""

# Wait for namespace
sleep 2

# Apply configurations
apply_resource "kubernetes/configmap.yaml" "ConfigMaps"
apply_resource "kubernetes/secret.yaml" "Secrets"

# Apply RBAC
apply_resource "kubernetes/rbac.yaml" "RBAC"

# Apply deployments
apply_resource "kubernetes/services.yaml" "Services"
apply_resource "kubernetes/monitoring.yaml" "Monitoring (Prometheus + Grafana)"
apply_resource "kubernetes/frontend-deployment.yaml" "Frontend Deployment"
apply_resource "kubernetes/backend-deployment.yaml" "Backend Deployment"
apply_resource "kubernetes/worker-deployment.yaml" "Worker Deployment"

# Apply scaling
apply_resource "kubernetes/hpa.yaml" "Horizontal Pod Autoscaler"

# Apply policies
apply_resource "kubernetes/pdb.yaml" "Pod Disruption Budgets"
apply_resource "kubernetes/networkpolicy.yaml" "Network Policies"

# Apply ingress
apply_resource "kubernetes/ingress.yaml" "Ingress"

echo -e "${GREEN}=============================================="
echo "✓ Deployment completed successfully!"
echo "=============================================${NC}"
echo ""

# Check status
echo -e "${YELLOW}Checking deployment status...${NC}"
kubectl get deployment -n $NAMESPACE
echo ""
kubectl get pods -n $NAMESPACE
echo ""

echo -e "${YELLOW}Services:${NC}"
kubectl get svc -n $NAMESPACE
echo ""

echo -e "${GREEN}Deployment Summary:${NC}"
echo "Frontend Replicas: $(kubectl get deployment frontend -n $NAMESPACE -o jsonpath='{.spec.replicas}')"
echo "Backend Replicas: $(kubectl get deployment backend -n $NAMESPACE -o jsonpath='{.spec.replicas}')"
echo "Worker Replicas: $(kubectl get deployment worker -n $NAMESPACE -o jsonpath='{.spec.replicas}')"
