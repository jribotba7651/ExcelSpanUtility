@echo off
echo ========================================
echo    EJECUTANDO EXCEL UTILITY
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

if exist "bin\Release\net8.0-windows\ExcelSpanUtility.exe" (
    echo Iniciando aplicacion...
    start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
) else (
    echo La aplicacion no esta compilada!
    echo.
    echo Primero ejecuta COMPILAR.bat
    echo.
    pause
)