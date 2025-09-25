@echo off
echo ========================================
echo    COMPILANDO EXCEL UTILITY
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Limpiando archivos anteriores...
if exist "bin" rd /s /q "bin"
if exist "obj" rd /s /q "obj"
"C:\Users\juanr\dotnet\dotnet.exe" clean -v quiet >nul 2>nul

echo Descargando componentes necesarios...
"C:\Users\juanr\dotnet\dotnet.exe" restore

echo Compilando aplicacion...
"C:\Users\juanr\dotnet\dotnet.exe" build --configuration Release

if %errorlevel% eq 0 (
    echo.
    echo ========================================
    echo    LISTO! Compilacion exitosa!
    echo ========================================
    echo.
    echo La aplicacion esta en:
    echo    bin\Release\net8.0-windows\
    echo.
    echo Presiona Y para ejecutar la aplicacion
    echo Presiona N para salir
    echo.

    choice /C YN /M "Ejecutar aplicacion ahora"
    if errorlevel 2 goto end
    if errorlevel 1 goto run

    :run
    start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
    echo.
    echo Aplicacion iniciada!

    :end
) else (
    echo.
    echo ========================================
    echo    ERROR! No se pudo compilar
    echo ========================================
    echo.
    echo Posibles soluciones:
    echo 1. Verifica que tienes internet
    echo 2. Intenta ejecutar este archivo de nuevo
    echo.
)

pause