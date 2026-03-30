# UniGetUI Full Stack Installation Script
# This script installs UniGetUI and its compatible package manager engines

$apps = @(
    # The Main Interface
    @{ Name = "UniGetUI";         ID = "MartiCliment.UniGetUI" },
    
    # Core Package Managers
    @{ Name = "Chocolatey";       ID = "Chocolatey.Chocolatey" },
    @{ Name = "Scoop";            ID = "ScoopInstaller.Scoop" },
    
    # Developer & Language Managers
    @{ Name = "Node.js (NPM)";    ID = "OpenJS.NodeJS" },
    @{ Name = "Python (Pip)";     ID = "Python.Python.3.12" },
    @{ Name = "vcpkg";            ID = "Microsoft.vcpkg" },
    @{ Name = ".NET SDK (Tools)"; ID = "Microsoft.DotNet.SDK.8" }
)

Write-Host "--- Preparing UniGetUI Environment ---" -ForegroundColor Cyan

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

Write-Host "--- Setup Complete. Please restart your terminal/PC to refresh PATH variables. ---" -ForegroundColor Cyan
