# Autonomous Agent Skill

This skill gives OpenClaw autonomous capabilities to:
- Search the web (like Perplexity)
- Write code and push to GitHub
- Build and deploy projects
- Run tasks independently

## Installation

Copy this skill folder to your OpenClaw's skills directory:
```
/path/to/openclaw/skills/autonomous/
```

## Tools Enabled

- **Web Search**: Search the internet for information
- **Web Fetch**: Extract content from websites  
- **GitHub**: Push code, create repos, manage projects

## Usage

Once installed, the agent can:
1. Search for information autonomously
2. Write code and push to your GitHub repo
3. Fetch web content
4. Build and deploy projects

## Configuration

Set these environment variables or add to TOOLS.md:
- `GITHUB_TOKEN`: Your GitHub token (we have one!)
- `VERCEL_TOKEN`: Optional - for deployments
