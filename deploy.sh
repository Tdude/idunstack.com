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

# Enforce SSH host key verification — never silently accept unknown hosts.
# If you see a host-key error, add the server to ~/.ssh/known_hosts first:
#   ssh-keyscan -H ${SERVER} >> ~/.ssh/known_hosts
SSH_OPTS="-o StrictHostKeyChecking=yes -o BatchMode=yes"

# Update submodule
git submodule update --remote --merge

# Build locally (optional, can build on server)
# docker compose build

# Sync to server.
# Excludes:
#   .git          — version-control internals
#   node_modules  — must be installed on server, not transferred
#   .env.local    — local-machine dev overrides must never reach the server
echo "📦 Syncing files to server...or something. Worried yet?"
rsync -avz -e "ssh ${SSH_OPTS}" \
    --exclude '.git' \
    --exclude 'node_modules' \
    --exclude '.env.local' \
    --exclude '.env.local.*' \
    ./ ${SERVER}:${SERVER_PATH}/

# Deploy on server
echo "🔄 Deploying on server...Now is the time for Shit Hit Fan. Or not."
ssh ${SSH_OPTS} ${SERVER} "cd ${SERVER_PATH} && git submodule update --init --recursive && make prod"

echo "✅ Deployment complete. Cross your fingers! 🤞"
