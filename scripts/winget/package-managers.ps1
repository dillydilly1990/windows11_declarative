# --- Configuration ---
$apps = @(
    # The Main Interface & Version Control
    @{ Name = "UniGetUI";         ID = "MartiCliment.UniGetUI" },
    @{ Name = "Git";              ID = "Git.Git" },
    
    # Core Package Managers
    @{ Name = "Chocolatey";       ID = "Chocolatey.Chocolatey" },
    
    # Developer & Language Managers
    @{ Name = "Node.js (NPM)";    ID = "OpenJS.NodeJS" },
    @{ Name = "Python (Pip)";     ID = "Python.Python.3.12" },
    @{ Name = "vcpkg";            ID = "Microsoft.vcpkg" },
    @{ Name = ".NET SDK (Tools)"; ID = "Microsoft.DotNet.SDK.8" }
)

Write-Host "--- Preparing UniGetUI Environment ---" -ForegroundColor Cyan

# 1. Install Scoop (Requires special handling)
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Scoop..." -ForegroundColor Yellow
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    if ($LASTEXITCODE -eq 0) { Write-Host ">> Scoop installed successfully!" -ForegroundColor Green }
} else {
    Write-Host ">> Scoop is already installed." -ForegroundColor Green
}

# 2. Install WinGet-based apps
foreach ($app in $apps) {
    Write-Host "Processing $($app.Name)..." -ForegroundColor Yellow
    
    # Check if already installed
    $check = winget list --id $($app.ID) --exact 2>$null
    
    if ($check -match $($app.ID)) {
        Write-Host ">> $($app.Name) is already installed." -ForegroundColor Green
    } else {
        Write-Host ">> Installing $($app.Name) silently..." -ForegroundColor White
        winget install --id $($app.ID) --source winget --silent --accept-package-agreements --accept-source-agreements
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ">> Success!" -ForegroundColor Green
        }
    }
}

Write-Host "`n--- Setup Complete ---" -ForegroundColor Cyan
Write-Host "IMPORTANT: Please RESTART your terminal or PC to refresh PATH variables." -ForegroundColor Red
