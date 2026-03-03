# OpenClaw Autonomous Skill

This skill enables autonomous web search and code generation capabilities.

## What It Does

When enabled, the agent can:
1. **Search the web** - Find any information online
2. **Fetch web content** - Read pages and extract data  
3. **Write code** - Generate code in any language
4. **Push to GitHub** - Save and manage code

## Installation

```bash
# On your OpenClaw server
cd ~
git clone https://github.com/tomkadosh-pixel/openclaw-autonomous.git
cd openclaw-autonomous

# Copy skill
mkdir -p ~/.openclaw/skills/autonomous
cp -r skills/autonomous/* ~/.openclaw/skills/autonomous/

# Enable web tools (edit ~/.openclaw/openclaw.json)
```

## Config Update

Add to your OpenClaw config:
```json
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
```

## Usage Examples

- "Search for X" → Searches web, returns summary
- "Build a website" → Writes code, pushes to GitHub
- "Find info about X" → Fetches relevant pages
