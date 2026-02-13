#!/bin/bash
# Seed script for idunworks.com
# Usage: ./seed/seed.sh [base_url] [auth_url]
# Default: localhost with standard ports

BASE_URL="${1:-http://localhost:8051/api/v1}"
AUTH_URL="${2:-http://localhost:8053}"
EMAIL="${SEED_EMAIL:-admin@idunworks.com}"
PASSWORD="${SEED_PASSWORD:-ChangeMe_123}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🌱 Seeding idunworks.com..."
echo "   API: $BASE_URL"
echo "   Auth: $AUTH_URL"

# Get token
TOKEN=$(curl -s -X POST "$AUTH_URL/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=$EMAIL&password=$PASSWORD" | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token',''))")

if [ -z "$TOKEN" ]; then
  echo "❌ Failed to authenticate"
  exit 1
fi
echo "✅ Authenticated"

# Seed pages (home first as update, rest as create)
for page in home about showcase contact idun; do
  FILE="$SCRIPT_DIR/pages/$page.json"
  if [ ! -f "$FILE" ]; then
    echo "⏭️  Skipping $page (no file)"
    continue
  fi

  # Try create first, if slug exists it'll fail — that's fine
  RESULT=$(curl -s -X POST "$BASE_URL/pages/" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d @"$FILE")

  TITLE=$(echo "$RESULT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('title', d.get('detail', 'error')))" 2>/dev/null)
  echo "📄 $page → $TITLE"
done

echo ""
echo "🎉 Seeding complete!"
