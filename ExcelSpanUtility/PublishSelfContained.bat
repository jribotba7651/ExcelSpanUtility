@echo off
echo ====================================================
echo Creating Self-Contained Executable (No .NET needed)
echo ====================================================
echo.

REM Try to find dotnet executable
set DOTNET_EXE=dotnet
where dotnet >nul 2>nul
if %errorlevel% neq 0 (
    REM Try portable location
    if exist "C:\Users\juanr\dotnet-portable\dotnet.exe" (
        set DOTNET_EXE=C:\Users\juanr\dotnet-portable\dotnet.exe
    ) else (
        echo [ERROR] Cannot find dotnet.exe
        echo Please use CompileWithPortable.bat first
        pause
        exit /b 1
    )
)

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Publishing self-contained executable...
echo This will create a single .exe file that includes .NET
echo File size will be ~60-80MB but won't need .NET installed
echo.

"%DOTNET_EXE%" publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:EnableCompressionInSingleFile=true -o publish

if %errorlevel% eq 0 (
    echo.
    echo ====================================================
    echo SUCCESS! Self-contained executable created:
    echo    C:\Users\juanr\ExcelSpanUtility\publish\ExcelSpanUtility.exe
    echo.
    echo This file can run on any Windows 10/11 x64 computer
    echo without needing .NET installed!
    echo ====================================================
    echo.

    set /p copy="Copy to Desktop? (y/n): "
    if /i "%copy%"=="y" (
        copy "publish\ExcelSpanUtility.exe" "%USERPROFILE%\Desktop\ExcelSpanUtility.exe"
        echo Copied to Desktop!
    )
) else (
    echo [ERROR] Publishing failed!
)

pause