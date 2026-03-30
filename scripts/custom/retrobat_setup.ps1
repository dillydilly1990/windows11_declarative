# --- Configuration ---
$repoUrl = "https://github.com/RetroBat/RetroBat.git"
$destination = "$HOME\Desktop\RetroBat-Source"

# --- Script Logic ---

# 1. Check if Git is installed
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Git is not installed or not in your PATH." -ForegroundColor Red
    Write-Host "Please install Git from https://git-scm.com/ and try again."
    exit
}

# 2. Create the destination directory if it doesn't exist
if (!(Test-Path -Path $destination)) {
    Write-Host "Creating directory: $destination" -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $destination | Out-Null
} else {
    Write-Host "Destination folder already exists. Attempting to clone inside..." -ForegroundColor Yellow
}

# 3. Clone the repository
Write-Host "Cloning RetroBat from $repoUrl..." -ForegroundColor Green
git clone $repoUrl $destination

# 4. Success Message
if ($LASTEXITCODE -eq 0) {
    Write-Host "`nSuccess! RetroBat has been cloned to: $destination" -ForegroundColor Green
} else {
    Write-Host "`nAn error occurred during the cloning process." -ForegroundColor Red
}
