$configPath = "$env:USERPROFILE\.openclaw\openclaw.json"
$json = Get-Content $configPath -Raw

# Fix the config - remove invalid web settings and add correct ones
$json = $json -replace '"provider":\s*"grok"', '"provider": "brave"'
$json = $json -replace '"search":\s*\{[^}]*"provider"', '"search": {"enabled": true, "provider": "brave"'
$json = $json -replace '"fetch":\s*\{[^}]*\}', '"fetch": {"enabled": true}'

# Remove duplicate web entries
$json = $json -replace '"web":\s*\{[^}]*"search"[^}]*\}[^}]*"web"', '"web": {"search": {"enabled": true, "provider": "brave"}, "fetch": {"enabled": true}}'

Set-Content -Path $configPath -Value $json -NoNewline

Write-Host "Fixed! Running doctor..." -ForegroundColor Green
openclaw doctor --non-interactive
