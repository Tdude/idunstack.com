#!/bin/bash

# IdunWorks Theme Management Helper Script

SITE_NAME="idunworks"
THEME_TARGET="idun-stack/idun-ui/src/lib/themes/${SITE_NAME}"

case "$1" in
    "build")
        echo "🎨 Building theme..."
        ./build-theme.sh
        ;;
    "clean")
        echo "🧹 Cleaning composed theme..."
        rm -rf "$THEME_TARGET"
        rm -f "idun-stack/idun-ui/static/theme/site-theme.css"
        # Restore registry backup if it exists
        if [ -f "idun-stack/idun-ui/src/lib/theme/registry.ts.backup" ]; then
            cp "idun-stack/idun-ui/src/lib/theme/registry.ts.backup" "idun-stack/idun-ui/src/lib/theme/registry.ts"
        fi
        echo "   → Cleaned up composed theme files"
        ;;
    "dev")
        echo "🚀 Starting development server..."
        ./build-theme.sh
        docker compose --env-file .env.${SITE_NAME} up -d
        echo "   → Server running at http://localhost:5216"
        ;;
    "rebuild")
        echo "🔄 Rebuilding theme and containers..."
        ./build-theme.sh
        docker compose --env-file .env.${SITE_NAME} up --build -d
        ;;
    "logs")
        echo "📋 Showing logs..."
        docker compose logs -f idun-ui
        ;;
    "status")
        echo "📊 Theme Status:"
        echo "   Site: $SITE_NAME"
        if [ -d "$THEME_TARGET" ]; then
            echo "   Theme: ✅ Composed"
            echo "   Files: $(ls -1 "$THEME_TARGET" | wc -l | xargs)"
        else
            echo "   Theme: ❌ Not composed"
        fi
        if grep -q "VITE_THEME=$SITE_NAME" ".env.$SITE_NAME"; then
            echo "   Config: ✅ Set to $SITE_NAME"
        else
            echo "   Config: ❌ Not configured"
        fi
        echo "   Docker: $(docker compose ps idun-ui --format '{{.Status}}')"
        ;;
    *)
        echo "IdunWorks Theme Helper"
        echo ""
        echo "Usage: $0 {build|clean|dev|rebuild|logs|status}"
        echo ""
        echo "Commands:"
        echo "  build   - Compose theme from source files"
        echo "  clean   - Remove composed theme files"
        echo "  dev     - Build theme and start development server"
        echo "  rebuild - Build theme and restart containers"
        echo "  logs    - Show container logs"
        echo "  status  - Show theme and container status"
        echo ""
        echo "Example workflow:"
        echo "  $0 build   # Compose theme"
        echo "  $0 dev     # Start development"
        echo "  $0 logs    # Check logs"
        ;;
esac