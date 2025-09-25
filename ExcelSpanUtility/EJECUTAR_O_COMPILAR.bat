@echo off
echo ========================================
echo    EXCEL MULTI-MONITOR UTILITY
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

if exist "bin\Release\net8.0-windows\ExcelSpanUtility.exe" (
    echo Aplicacion encontrada! Ejecutando...
    start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
) else if exist "bin\Debug\net8.0-windows\ExcelSpanUtility.exe" (
    echo Aplicacion encontrada (Debug)! Ejecutando...
    start "" "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
) else (
    echo La aplicacion no esta compilada.
    echo.
    echo Compilando ahora...
    echo.

    "C:\Users\juanr\dotnet\dotnet.exe" restore
    "C:\Users\juanr\dotnet\dotnet.exe" build

    if exist "bin\Debug\net8.0-windows\ExcelSpanUtility.exe" (
        echo.
        echo Compilacion exitosa! Ejecutando...
        start "" "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
    ) else (
        echo.
        echo ERROR: No se pudo compilar
        echo Intenta ejecutar COMPILAR_FINAL.bat
        pause
    )
)