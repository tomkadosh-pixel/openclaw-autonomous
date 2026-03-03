#!/bin/bash
# Setup script for Autonomous Skill on OpenClaw

echo "🤖 Setting up Autonomous Skill for OpenClaw"
echo ""

# Get the skill directory
SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
OPENCLAW_DIR="${OPENCLAW_DIR:-/root/.openclaw}"

echo "Skill directory: $SKILL_DIR"
echo "OpenClaw directory: $OPENCLAW_DIR"
echo ""

# Copy skill to OpenClaw
echo "📦 Copying skill to OpenClaw..."
mkdir -p "$OPENCLAW_DIR/skills/autonomous"
cp -r "$SKILL_DIR"/* "$OPENCLAW_DIR/skills/autonomous/"

echo ""
echo "✅ Skill installed!"
echo ""
echo "Next steps:"
echo "1. Make sure web search and fetch are enabled in config"
echo "2. The skill will be available for the agent"
echo ""
echo "To enable web tools, add to config:"
echo '{"tools": {"web": {"search": {"enabled": true}, "fetch": {"enabled": true}}}}'
