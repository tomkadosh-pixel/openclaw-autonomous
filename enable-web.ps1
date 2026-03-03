# OpenClaw Web Tools Enabler
# Run this on your OpenClaw Windows server

$configPath = "$env:USERPROFILE\.openclaw\openclaw.json"

# Read current config
$config = Get-Content $configPath -Raw | ConvertFrom-Json

# Add web tools
if (-not $config.tools) { $config | Add-Member -NotePropertyName "tools" -NotePropertyValue @{} }
if (-not $config.tools.web) { $config.tools | Add-Member -NotePropertyName "web" -NotePropertyValue @{} }
$config.tools.web = @{
    search = @{
        enabled = $true
        provider = "grok"
    }
    fetch = @{
        enabled = $true
    }
}

# Remove from deny list if exists
if ($config.tools.PSObject.Properties.Name -eq "deny") {
    $denyList = @($config.tools.deny)
    $config.tools.deny = $denyList | Where-Object { $_ -ne "web_search" -and $_ -ne "web_fetch" }
}

# Save
$config | ConvertTo-Json -Depth 10 | Set-Content $configPath

Write-Host "✅ Config updated! Restarting OpenClaw..." -ForegroundColor Green

# Restart
openclaw gateway restart
