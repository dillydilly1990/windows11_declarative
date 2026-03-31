# Set the download location to a folder named "SwitchEmulators" on your Desktop
$destination = "$HOME\Desktop\SwitchEmulators"
if (!(Test-Path $destination)) { New-Item -ItemType Directory -Path $destination }

# Function to get the latest GitHub release download link
function Get-GithubLink {
    param ( [string]$repo )
    $url = "https://api.github.com/repos/$repo/releases/latest"
    $release = Invoke-RestMethod -Uri $url
    # Filter for Windows zip or 7z files
    return $release.assets | Where-Object { $_.name -like "*win*" -and ($_.name -like "*.zip" -or $_.name -like "*.7z") } | Select-Object -First 1 -ExpandProperty browser_download_url
}

# 1. Ryujinx (The current gold standard for accuracy/compatibility)
Write-Host "Fetching Ryujinx..." -ForegroundColor Cyan
$ryuLink = Get-GithubLink "Ryujinx/Ryujinx"
Invoke-WebRequest -Uri $ryuLink -OutFile "$destination\Ryujinx.zip"

# 2. Sudachi (A popular continuation of the Yuzu codebase)
Write-Host "Fetching Sudachi..." -ForegroundColor Cyan
$sudachiLink = Get-GithubLink "sudachi-emu/sudachi"
Invoke-WebRequest -Uri $sudachiLink -OutFile "$destination\Sudachi.zip"

# 3. Suyu (Another Yuzu-based fork)
Write-Host "Fetching Suyu..." -ForegroundColor Cyan
$suyuLink = Get-GithubLink "suyu-emu/suyu"
Invoke-WebRequest -Uri $suyuLink -OutFile "$destination\Suyu.zip"

Write-Host "`nDownloads complete! Check your desktop: $destination" -ForegroundColor Green
Explore $destination
