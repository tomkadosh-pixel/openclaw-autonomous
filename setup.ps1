# OpenClaw Complete Setup Script
# Run this on your Windows server

$ErrorActionPreference = "Stop"

Write-Host "🤖 OpenClaw Setup Script" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan

# Ask for API Key if not provided
$apiKey = $env:OPENAI_API_KEY
if (-not $apiKey) {
    Write-Host ""
    Write-Host "Enter your OpenAI API Key:" -ForegroundColor Yellow
    $apiKey = Read-Host "sk-..."
}

if ($apiKey -match "^sk-") {
    Write-Host "✅ API Key received!" -ForegroundColor Green
} else {
    Write-Host "❌ Invalid API Key format. Should start with sk-" -ForegroundColor Red
    exit 1
}

# 1. Delete old broken config
$configPath = "$env:USERPROFILE\.openclaw\openclaw.json"
if (Test-Path $configPath) {
    Write-Host "🗑️  Deleting old config..." -ForegroundColor Yellow
    Remove-Item $configPath -Force
}

# 2. Create new clean config
Write-Host "📝 Creating new config..." -ForegroundColor Yellow

$config = @{
    meta = @{
        lastTouchedVersion = "2026.2.15"
        lastTouchedAt = (Get-Date -Format "o")
    }
    auth = @{
        profiles = @{
            "openai:default" = @{
                provider = "openai"
                mode = "api_key"
            }
        }
    }
    models = @{
        mode = "merge"
        providers = @{
            openai = @{
                baseUrl = "https://api.openai.com/v1"
                apiKey = $apiKey
                api = "openai"
                models = @(
                    @{
                        id = "gpt-4o"
                        name = "GPT-4o"
                    }
                )
            }
        }
    }
    agents = @{
        defaults = @{
            model = @{
                primary = "openai/gpt-4o"
            }
            workspace = "$env:USERPROFILE\.openclaw\workspace"
            heartbeat = @{
                every = "30m"
            }
        }
        list = @(
            @{
                id = "main"
                default = $true
                subagents = @{
                    allowAgents = @("*")
                }
            }
        )
    }
    tools = @{
        deny = @()
        web = @{
            search = @{
                enabled = $true
                provider = "brave"
            }
            fetch = @{
                enabled = $true
            }
        }
    }
    messages = @{
        ackReactionScope = "group-mentions"
    }
    commands = @{
        native = "auto"
        nativeSkills = "auto"
    }
    channels = @{
        telegram = @{
            enabled = $true
            dmPolicy = "pairing"
            botToken = "8486408223:AAGJ1sB3dof_rNlbInjfIHCwuxbowqa__c4"
            groupPolicy = "allowlist"
            streamMode = "partial"
        }
    }
    gateway = @{
        port = 18789
        mode = "local"
        bind = "loopback"
        reload = @{
            mode = "hot"
            debounceMs = 300
        }
    }
}

# 3. Save config
$config | ConvertTo-Json -Depth 10 | Set-Content $configPath -NoNewline

Write-Host "✅ Config saved!" -ForegroundColor Green
Write-Host ""
Write-Host "🔄 Restarting OpenClaw..." -ForegroundColor Yellow

# 4. Restart
openclaw gateway restart

Write-Host ""
Write-Host "✅ DONE!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Go to Telegram and send /start to @tomask86bot" -ForegroundColor White
Write-Host "2. Tell me the pairing code!" -ForegroundColor White
