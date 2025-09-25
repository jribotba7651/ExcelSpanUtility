# Build.ps1
param(
    [string]$Configuration = "Release",
    [string]$Platform = "x64"
)

Write-Host "Building Excel Span Utility..." -ForegroundColor Green
Write-Host "Configuration: $Configuration" -ForegroundColor Yellow

# Clean previous builds
Write-Host "Cleaning..." -ForegroundColor Yellow
dotnet clean --configuration $Configuration --verbosity minimal

# Restore packages
Write-Host "Restoring packages..." -ForegroundColor Yellow
dotnet restore --verbosity minimal

# Build
Write-Host "Building..." -ForegroundColor Yellow
dotnet build --configuration $Configuration --no-restore --verbosity minimal

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build completed successfully!" -ForegroundColor Green
} else {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}