@echo off
echo =====================================
echo Excel Multi-Monitor Utility - Compiler
echo =====================================
echo.

REM Check if dotnet is installed
where dotnet >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] .NET SDK is not installed!
    echo.
    echo Please install .NET 8.0 SDK:
    echo 1. Go to: https://dotnet.microsoft.com/download/dotnet/8.0
    echo 2. Download ".NET 8.0 SDK" for Windows x64
    echo 3. Run the installer
    echo 4. Restart this script after installation
    echo.
    pause
    exit /b 1
)

echo [INFO] .NET SDK found. Starting compilation...
echo.

REM Navigate to project directory
cd /d "C:\Users\juanr\ExcelSpanUtility"

REM Clean previous builds
echo [1/4] Cleaning previous builds...
dotnet clean -v quiet >nul 2>nul

REM Restore packages
echo [2/4] Restoring NuGet packages...
dotnet restore
if %errorlevel% neq 0 (
    echo [ERROR] Failed to restore packages!
    pause
    exit /b 1
)

REM Build the project
echo [3/4] Building project...
dotnet build --configuration Release
if %errorlevel% neq 0 (
    echo [ERROR] Build failed!
    pause
    exit /b 1
)

echo [4/4] Build completed successfully!
echo.
echo =====================================
echo Output: bin\Release\net8.0-windows\
echo =====================================
echo.

REM Ask to run
set /p run="Do you want to run the application now? (y/n): "
if /i "%run%"=="y" (
    echo Starting Excel Multi-Monitor Utility...
    start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
)

pause