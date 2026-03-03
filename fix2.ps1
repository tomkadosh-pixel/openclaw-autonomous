# Simple fix - just enable web search properly

$configPath = "$env:USERPROFILE\.openclaw\openclaw.json"
$json = Get-Content $configPath -Raw | ConvertFrom-Json

# Remove the invalid web section completely and add fresh
$json.PSObject.Properties.Remove('web')

# Add clean web section
$json.tools | Add-Member -NotePropertyName "web" -NotePropertyValue @{
    search = @{
        enabled = $true
        provider = "brave"
    }
    fetch = @{
        enabled = $true
    }
}

# Save
$json | ConvertTo-Json -Depth 10 | Set-Content $configPath

Write-Host "Fixed!" -ForegroundColor Green
Get-Content $configPath | Select-String "web"
