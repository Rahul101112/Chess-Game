#!/bin/bash

################################################################################
# Master Chess Application Deployment Script (Root Level)
# Automatically finds and deploys chess-app
################################################################################

echo ""
echo "============================================================================"
echo "                    CHESS APPLICATION DEPLOYMENT"
echo "============================================================================"
echo ""

# Find chess-app directory
if [ -d "chess-app" ]; then
    CHESS_APP_DIR="chess-app"
    echo "Found chess-app directory"
elif [ -d "$(dirname "${BASH_SOURCE[0]}")/chess-app" ]; then
    CHESS_APP_DIR="$(dirname "${BASH_SOURCE[0]}")/chess-app"
    echo "Found chess-app at root"
else
    echo "Error: chess-app directory not found!"
    echo "Please run this script from the project root directory"
    exit 1
fi

echo ""
echo "Starting deployment..."
echo ""

# Change to chess-app directory and run deployment
cd "$CHESS_APP_DIR"
bash deploy.sh

exit $?
