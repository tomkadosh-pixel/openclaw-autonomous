# Autonomous Agent Skill

This skill enables OpenClaw to operate autonomously with web search, code generation, and GitHub integration.

## Capabilities

- **Web Search**: Search the internet for any information (like Perplexity)
- **Web Fetch**: Extract and read content from any website
- **Code Generation**: Write code in any language
- **GitHub Integration**: Push code, create files, manage repositories

## Usage

When user asks for information or to build something:

1. **Search**: Use web search to find current information
2. **Fetch**: Extract content from relevant websites
3. **Code**: Write code based on findings
4. **GitHub**: Push code to repositories

## GitHub Configuration

The agent has access to:
- Repository: tomkadosh-pixel/openclaw-autonomous
- Token: Uses provided GitHub token

To push code:
```
git add .
git commit -m "description"
git push
```

Or use GitHub API:
```
POST https://api.github.com/repos/{owner}/{repo}/contents/{path}
```

## Examples

- "Search for latest news about X" → Search web, return summary
- "Build me a website" → Write code, push to GitHub
- "What is X?" → Search web, provide answer with sources
