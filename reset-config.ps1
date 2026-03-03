# Complete reset and fix for OpenClaw

$configPath = "$env:USERPROFILE\.openclaw\openclaw.json"

# Read current broken config
$content = Get-Content $configPath -Raw -ErrorAction SilentlyContinue

if ($content) {
    # Backup first
    $backupPath = "$configPath.backup"
    $content | Set-Content $backupPath
    Write-Host "Backed up to $backupPath" -ForegroundColor Yellow
}

# Create minimal working config
$newConfig = @{
    meta = @{
        lastTouchedVersion = "2026.2.15"
    }
    tools = @{
        web = @{
            search = @{
                enabled = $true
                provider = "brave"
            }
            fetch = @{
                enabled = $true
            }
        }
        deny = @()
    }
    messages = @{
        ackReactionScope = "group-mentions"
    }
    commands = @{
        native = "auto"
        nativeSkills = "auto"
    }
    gateway = @{
        port = 18789
        mode = "local"
        bind = "loopback"
    }
}

# Save
$newConfig | ConvertTo-Json -Depth 10 | Set-Content $configPath

Write-Host "✅ Config reset! Now run: openclaw reset" -ForegroundColor Green
