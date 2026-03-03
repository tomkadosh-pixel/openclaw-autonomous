# 🤖 OpenClaw Autonomous Skills

This repository contains skills that make OpenClaw fully autonomous!

## What's Inside

```
openclaw-autonomous/
├── README.md                    # This file
├── skills/
│   └── autonomous/
│       ├── SKILL.md            # Skill definition
│       └── scripts/
│           └── setup.sh        # Installation script
```

## Quick Setup

1. **Clone this repo on your OpenClaw server:**
```bash
cd ~
git clone https://github.com/tomkadosh-pixel/openclaw-autonomous.git
cd openclaw-autonomous
```

2. **Run setup:**
```bash
chmod +x skills/autonomous/scripts/setup.sh
./skills/autonomous/scripts/setup.sh
```

3. **Enable web tools** in OpenClaw config:
```json
{
  "tools": {
    "web": {
      "search": { "enabled": true },
      "fetch": { "enabled": true }
    }
  }
}
```

## What Your Autonomous OpenClaw Can Do

### 🌐 Web Search (like Perplexity!)
- "Search for latest news about X"
- "What is the best way to do X?"
- Any question you have!

### 💻 Code Generation
- "Build me a React website"
- "Write a Python script for X"
- Any code you need!

### 📦 GitHub Integration
- Push code automatically
- Create new files
- Manage repositories

### 🚀 Build & Deploy
- Build projects
- Deploy to Vercel (optional)

## Example Commands

Once installed, you can ask your OpenClaw:
- "Search for the latest AI news"
- "Build me a todo app in React"
- "Find information about X and summarize it"

## Token

This repo uses a fine-grained GitHub token with access only to this repository.

## License

MIT
