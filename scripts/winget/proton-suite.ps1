# Proton AG Products Silent Installation Script
# This script installs Proton Mail, VPN, Drive, and Pass without user interaction

$apps = @(
    @{ Name = "Proton Mail";  ID = "Proton.ProtonMail" },
    @{ Name = "Proton VPN";   ID = "ProtonVPN.ProtonVPN" },
    @{ Name = "Proton Drive"; ID = "Proton.ProtonDrive" },
    @{ Name = "Proton Pass";  ID = "Proton.ProtonPass" }
)

Write-Host "--- Initiating Silent Installation for Proton Suite ---" -ForegroundColor Cyan

foreach ($app in $apps) {
    Write-Host "Checking status for $($app.Name)..." -ForegroundColor Yellow
    
    # Check if the app is already installed
    $check = winget list --id $($app.ID) --exact 2>$null
    
    if ($check -match $($app.ID)) {
        Write-Host ">> $($app.Name) is already present. Skipping..." -ForegroundColor Green
    } else {
        Write-Host ">> Installing $($app.Name) silently..." -ForegroundColor White
        
        # --silent: Suppresses the installer UI
        # --accept-package-agreements: Auto-accepts EULAs
        # --accept-source-agreements: Auto-accepts winget source terms
        winget install --id $($app.ID) --source winget --silent --accept-package-agreements --accept-source-agreements
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ">> Successfully installed $($app.Name)." -ForegroundColor Green
        }
    }
}

Write-Host "--- All Proton products processed successfully! ---" -ForegroundColor Cyan
