#!/bin/bash
# 🤖 OpenClaw Autonomous Installation Script
# Run this on your OpenClaw server

set -e

echo "🤖 Installing Autonomous Skills for OpenClaw..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${YELLOW}Step 1: Cloning skills repository...${NC}"
cd ~
git clone https://github.com/tomkadosh-pixel/openclaw-autonomous.git openclaw-autonomous
cd openclaw-autonomous

echo ""
echo -e "${YELLOW}Step 2: Copying skills to OpenClaw...${NC}"
mkdir -p ~/.openclaw/skills/autonomous
cp -r skills/autonomous/* ~/.openclaw/skills/autonomous/
echo -e "${GREEN}✓ Skills copied!${NC}"

echo ""
echo -e "${YELLOW}Step 3: Updating OpenClaw config...${NC}"

# Check if config file exists
if [ ! -f ~/.openclaw/openclaw.json ]; then
    echo "Error: OpenClaw config not found at ~/.openclaw/openclaw.json"
    echo "Make sure OpenClaw is installed first!"
    exit 1
fi

# Create a temporary file with the new config
cat > /tmp/autonomous_config.json << 'EOF'
{
  "tools": {
    "web": {
      "search": {
        "enabled": true,
        "provider": "grok"
      },
      "fetch": {
        "enabled": true
      }
    }
  }
}
EOF

# Use Python to merge the configs
python3 << 'PYTHON'
import json
import sys

# Read existing config
try:
    with open('/root/.openclaw/openclaw.json', 'r') as f:
        config = json.load(f)
except:
    print("Error: Could not read config file")
    sys.exit(1)

# Add/update tools config
if 'tools' not in config:
    config['tools'] = {}

config['tools']['web'] = {
    "search": {
        "enabled": True,
        "provider": "grok"
    },
    "fetch": {
        "enabled": True
    }
}

# Remove from deny list if present
if 'deny' in config.get('tools', {}):
    deny_list = config['tools']['deny']
    if 'web_search' in deny_list:
        deny_list.remove('web_search')
    if 'web_fetch' in deny_list:
        deny_list.remove('web_fetch')

# Write back
with open('/root/.openclaw/openclaw.json', 'w') as f:
    json.dump(config, f, indent=2)

print("Config updated successfully!")
PYTHON

echo -e "${GREEN}✓ Config updated!${NC}"

echo ""
echo -e "${YELLOW}Step 4: Restarting OpenClaw...${NC}"
openclaw restart || echo "Note: Run 'openclaw restart' manually if needed"

echo ""
echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo "Your OpenClaw can now:"
echo "  🌐 Search the web (like Perplexity)"
echo "  💻 Write code and push to GitHub"
echo "  🌐 Fetch web content"
echo ""
echo "Try asking: 'Search for X' or 'Build me a website'"
