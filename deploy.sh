#!/bin/bash
set -e

SITE="idunworks"
SERVER="hostup-vps"
SERVER_PATH="/opt/idunworks.com"

echo "🚀 Deploying ${SITE}.com"
echo "   Server: ${SERVER}"
echo "   Path: ${SERVER_PATH}"
echo ""
read -p "Continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "❌ Deployment cancelled"
    exit 1
fi

# Update submodule
git submodule update --remote --merge

# Build locally (optional, can build on server)
# docker compose build

# Sync to server
echo "📦 Syncing files to server...or something. Worried yet?"
rsync -avz --exclude '.git' --exclude 'node_modules' \
    ./ ${SERVER}:${SERVER_PATH}/

# Deploy on server
echo "🔄 Deploying on server...Now is the time for Shit Hit Fan. Or not."
ssh ${SERVER} "cd ${SERVER_PATH} && git submodule update --init --recursive && make prod"

echo "✅ Deployment complete. Cross your fingers! 🤞"
