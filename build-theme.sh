#!/bin/bash

# IdunWorks Theme Composition Script
# Composes site-specific theme without touching canonical idun-stack

set -e  # Exit on any error

SITE_NAME="idunworks"
SITE_ROOT=$(pwd)
CANONICAL_STACK="../idun-stack"
THEME_SOURCE="theme"
THEME_TARGET="idun-stack/idun-ui/src/lib/themes/${SITE_NAME}"

echo "🎨 Building ${SITE_NAME} theme..."

# Portable in-place sed: macOS requires an explicit (possibly empty) backup suffix;
# GNU sed on Linux does not accept the empty-string form 'sed -i ""'.
sed_inplace() {
    if sed --version >/dev/null 2>&1; then
        # GNU sed (Linux)
        sed -i "$@"
    else
        # BSD sed (macOS)
        sed -i '' "$@"
    fi
}

# Check if we're in the right directory
if [ ! -f ".env.${SITE_NAME}" ]; then
    echo "❌ Error: Must run from site root (should contain .env.${SITE_NAME})"
    exit 1
fi

# Check if canonical stack exists
if [ ! -d "$CANONICAL_STACK" ]; then
    echo "❌ Error: Canonical stack not found at $CANONICAL_STACK"
    exit 1
fi

# Check if theme source exists
if [ ! -d "$THEME_SOURCE" ]; then
    echo "❌ Error: Theme source not found at $THEME_SOURCE"
    exit 1
fi

# Clean existing composed theme
echo "🧹 Cleaning existing theme..."
rm -rf "$THEME_TARGET"
mkdir -p "$THEME_TARGET"

# Step 1: Copy all default theme files as base
echo "📂 Copying default theme as base..."
cp -r "$CANONICAL_STACK/idun-ui/src/lib/themes/default/"* "$THEME_TARGET/"

# Step 2: Override with site-specific components
echo "🔧 Applying component overrides..."
if [ -d "$THEME_SOURCE/components" ]; then
    for component in "$THEME_SOURCE/components/"*.svelte; do
        if [ -f "$component" ]; then
            component_name=$(basename "$component")
            echo "   → Overriding $component_name"
            cp "$component" "$THEME_TARGET/$component_name"
        fi
    done
fi

# Step 3: Add site-specific styles
echo "🎨 Adding custom styles..."
if [ -d "$THEME_SOURCE/styles" ]; then
    mkdir -p "$THEME_TARGET/styles"
    cp -r "$THEME_SOURCE/styles/"* "$THEME_TARGET/styles/"
fi

# Step 4: Copy assets
echo "🖼️  Copying assets..."
if [ -d "$THEME_SOURCE/assets" ] && [ "$(ls -A "$THEME_SOURCE/assets" 2>/dev/null)" ]; then
    mkdir -p "$THEME_TARGET/assets"
    cp -r "$THEME_SOURCE/assets/"* "$THEME_TARGET/assets/"
    echo "   → Assets copied"
else
    echo "   → No assets to copy"
fi

# Step 5: Create theme index file
echo "📝 Generating theme index..."
cat > "$THEME_TARGET/index.ts" << EOF
// Auto-generated theme index for $SITE_NAME
import Home from './Home.svelte';
import PagesList from './PagesList.svelte';
import PageView from './PageView.svelte';
import BlogList from './BlogList.svelte';

export const theme = { Home, PagesList, PageView, BlogList };
EOF

# Step 6: Update theme registry to include this theme
echo "🔗 Updating theme registry..."
REGISTRY_FILE="idun-stack/idun-ui/src/lib/theme/registry.ts"

# Create a backup
cp "$REGISTRY_FILE" "$REGISTRY_FILE.backup"

# Check if theme is already registered
if ! grep -q "import.*${SITE_NAME}Theme" "$REGISTRY_FILE"; then
    # Add import
    sed_inplace "/import.*blogTheme.*from/a\\
import { theme as ${SITE_NAME}Theme } from '../themes/${SITE_NAME}';" "$REGISTRY_FILE"
    
    # Add case to switch statement
    sed_inplace "/case 'blog':/a\\
    case '${SITE_NAME}':\\
      return ${SITE_NAME}Theme as unknown as Theme;" "$REGISTRY_FILE"
    
    echo "   → Added $SITE_NAME theme to registry"
else
    echo "   → Theme already registered"
fi

# Step 7: Update environment file
echo "⚙️  Updating environment configuration..."
ENV_FILE=".env.${SITE_NAME}"

# Add or update VITE_THEME setting
if grep -q "VITE_THEME=" "$ENV_FILE"; then
    sed_inplace "s/VITE_THEME=.*/VITE_THEME=${SITE_NAME}/" "$ENV_FILE"
    echo "   → Updated VITE_THEME=${SITE_NAME}"
else
    echo "" >> "$ENV_FILE"
    echo "# Theme configuration" >> "$ENV_FILE"
    echo "VITE_THEME=${SITE_NAME}" >> "$ENV_FILE"
    echo "   → Added VITE_THEME=${SITE_NAME}"
fi

# Step 8: Create CSS injection in app.html (if it doesn't exist)  
echo "🔗 Setting up CSS injection..."
APP_HTML="idun-stack/idun-ui/src/app.html"
if [ -f "$APP_HTML" ] && ! grep -q "site-theme.css" "$APP_HTML"; then
    # Add CSS link in head section (using printf to handle newlines properly)
    sed_inplace 's|</head>|    <link rel="stylesheet" href="/theme/site-theme.css" />\n</head>|' "$APP_HTML"
    echo "   → Added CSS injection to app.html"
fi

# Step 9: Generate combined CSS file
echo "🎨 Generating combined CSS..."
COMBINED_CSS="idun-stack/idun-ui/static/theme/site-theme.css"
mkdir -p "$(dirname "$COMBINED_CSS")"

cat > "$COMBINED_CSS" << EOF
/* Auto-generated theme CSS for $SITE_NAME */
/* Generated on $(date) */

EOF

# Append all custom CSS files
if [ -d "$THEME_SOURCE/styles" ]; then
    for css_file in "$THEME_SOURCE/styles/"*.css; do
        if [ -f "$css_file" ]; then
            echo "" >> "$COMBINED_CSS"
            echo "/* From $(basename "$css_file") */" >> "$COMBINED_CSS"
            cat "$css_file" >> "$COMBINED_CSS"
        fi
    done
fi

# Step 10: Summary
echo ""
echo "✅ Theme composition complete!"
echo "   📁 Theme: $THEME_TARGET"
echo "   🎨 Styles: $COMBINED_CSS"
echo "   ⚙️  Config: VITE_THEME=$SITE_NAME"
echo ""
echo "🚀 Ready to build! Run:"
echo "   docker compose --env-file .env.${SITE_NAME} up --build"
echo ""