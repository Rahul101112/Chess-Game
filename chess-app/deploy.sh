#!/bin/bash

################################################################################
# Chess Application Automated Deployment Script
# This script builds and deploys the entire chess application in one go
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHESS_APP_DIR="$PROJECT_ROOT/chess-app"
BACKEND_DIR="$CHESS_APP_DIR/backend"
BUILD_DIR="$CHESS_APP_DIR/build"

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}Chess Application Deployment${NC}"
echo -e "${BLUE}================================${NC}"

# Step 1: Checkout/Update
echo -e "\n${YELLOW}Step 1: Preparing environment...${NC}"
if [ ! -d "$CHESS_APP_DIR" ]; then
    echo "Chess app directory not found!"
    exit 1
fi

cd "$CHESS_APP_DIR"

# Step 2: Build Backend
echo -e "\n${YELLOW}Step 2: Building Java Backend...${NC}"
cd "$BACKEND_DIR"
mvn clean package -DskipTests
echo -e "${GREEN}✓ Backend build complete${NC}"

# Step 3: Build Frontend
echo -e "\n${YELLOW}Step 3: Building Frontend...${NC}"
cd "$CHESS_APP_DIR"
npm install
npm run build
echo -e "${GREEN}✓ Frontend build complete${NC}"

# Step 4: Build Docker Image
echo -e "\n${YELLOW}Step 4: Building Docker Image...${NC}"
docker build -t chess-app-backend:latest "$BACKEND_DIR"
echo -e "${GREEN}✓ Docker image built${NC}"

# Step 5: Stop existing containers
echo -e "\n${YELLOW}Step 5: Stopping existing containers...${NC}"
docker-compose down || true
echo -e "${GREEN}✓ Containers stopped${NC}"

# Step 6: Start new containers
echo -e "\n${YELLOW}Step 6: Starting application...${NC}"
docker-compose up -d
echo -e "${GREEN}✓ Containers started${NC}"

# Step 7: Wait for services
echo -e "\n${YELLOW}Step 7: Waiting for services to be ready...${NC}"
sleep 5

# Step 8: Health checks
echo -e "\n${YELLOW}Step 8: Performing health checks...${NC}"
max_attempts=30
attempt=1

echo "Checking backend..."
while [ $attempt -le $max_attempts ]; do
    if curl -s http://localhost:8080/api/health > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Backend is healthy!${NC}"
        break
    fi
    echo "  Attempt $attempt/$max_attempts..."
    sleep 2
    attempt=$((attempt + 1))
done

echo "Checking frontend..."
if curl -s http://localhost:3000 > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Frontend is accessible!${NC}"
else
    echo -e "${YELLOW}⚠ Frontend not yet accessible (may still be starting)${NC}"
fi

# Step 9: Display status
echo -e "\n${YELLOW}Step 9: Final Status Check${NC}"
docker-compose ps

# Summary
echo -e "\n${BLUE}================================${NC}"
echo -e "${GREEN}✓ DEPLOYMENT COMPLETE!${NC}"
echo -e "${BLUE}================================${NC}"
echo -e "\n${GREEN}Chess Application is now RUNNING!${NC}\n"
echo "Access Points:"
echo -e "  Frontend:   ${BLUE}http://localhost:3000${NC}"
echo -e "  Backend:    ${BLUE}http://localhost:8080${NC}"
echo -e "  API Health: ${BLUE}http://localhost:8080/api/health${NC}"
echo ""
echo "Useful Commands:"
echo "  View logs:       docker-compose logs -f"
echo "  Stop service:    docker-compose down"
echo "  Restart service: docker-compose restart"
echo "  Backend logs:    docker logs chess-backend"
echo "  Frontend logs:   docker logs chess-frontend"
echo ""
echo -e "${GREEN}Happy playing!${NC}\n"
