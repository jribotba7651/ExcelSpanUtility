@echo off
echo ================================================
echo Excel Multi-Monitor Utility - Portable Compiler
echo    (No Admin Rights Required)
echo ================================================
echo.

set PORTABLE_DOTNET=C:\Users\juanr\dotnet-portable\dotnet.exe
set LOCAL_DOTNET=%USERPROFILE%\dotnet-portable\dotnet.exe

REM Check for portable dotnet in user folder
if exist "%PORTABLE_DOTNET%" (
    set DOTNET_EXE=%PORTABLE_DOTNET%
    echo [OK] Found portable .NET at: %PORTABLE_DOTNET%
) else if exist "%LOCAL_DOTNET%" (
    set DOTNET_EXE=%LOCAL_DOTNET%
    echo [OK] Found portable .NET at: %LOCAL_DOTNET%
) else (
    echo [ERROR] Portable .NET SDK not found!
    echo.
    echo Please download .NET 8.0 SDK portable version:
    echo.
    echo 1. Go to: https://dotnet.microsoft.com/download/dotnet/8.0
    echo 2. Download "Binaries" x64 ZIP file (NOT the installer)
    echo 3. Extract to: C:\Users\juanr\dotnet-portable\
    echo 4. Run this script again
    echo.
    echo The ZIP file should be named like:
    echo    dotnet-sdk-8.0.xxx-win-x64.zip
    echo.
    pause
    exit /b 1
)

echo.
cd /d "C:\Users\juanr\ExcelSpanUtility"

REM Clean
echo [1/4] Cleaning previous builds...
"%DOTNET_EXE%" clean -v quiet >nul 2>nul

REM Restore
echo [2/4] Restoring NuGet packages...
"%DOTNET_EXE%" restore
if %errorlevel% neq 0 (
    echo [ERROR] Failed to restore packages!
    pause
    exit /b 1
)

REM Build
echo [3/4] Building project...
"%DOTNET_EXE%" build --configuration Release
if %errorlevel% neq 0 (
    echo [ERROR] Build failed!
    pause
    exit /b 1
)

echo [4/4] Build completed!
echo.
echo ================================================
echo SUCCESS! Application built at:
echo    bin\Release\net8.0-windows\ExcelSpanUtility.exe
echo ================================================
echo.

set /p run="Run the application now? (y/n): "
if /i "%run%"=="y" (
    echo Starting Excel Multi-Monitor Utility...
    start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
)

pause