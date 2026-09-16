#!/bin/bash

set -e

echo "🚀 Instalando MCPs do Claude..."

# Playwright
claude mcp add playwright -s user -- \
  npx -y @playwright/mcp@latest

# Firecrawl
if [ -z "$FIRECRAWL_API_KEY" ]; then
  echo "❌ FIRECRAWL_API_KEY não configurada."
  echo "Execute: export FIRECRAWL_API_KEY='sua_chave'"
  exit 1
fi

claude mcp add firecrawl -s user \
  --env FIRECRAWL_API_KEY="$FIRECRAWL_API_KEY" \
  -- npx -y firecrawl-mcp

# Go
if ! command -v go >/dev/null 2>&1; then
  echo "📦 Instalando Go..."
  brew install go
fi

# Glyph
echo "📦 Instalando Glyph..."
GOBIN=/usr/local/bin go install \
  github.com/benmyles/glyph@latest

claude mcp add glyph -s user -- \
  /usr/local/bin/glyph mcp

# Chrome DevTools
claude mcp add chrome-devtools -s user -- \
  npx -y chrome-devtools-mcp@latest

echo ""
echo "✅ MCPs instalados!"
echo ""

claude mcp list
