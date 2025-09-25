@echo off
echo ========================================
echo    COMPILANDO EXCEL UTILITY (SIMPLE)
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Borrando archivos anteriores...
if exist "bin" rd /s /q "bin"
if exist "obj" rd /s /q "obj"

echo.
echo Compilando aplicacion (sin paquetes externos)...
"C:\Users\juanr\dotnet\dotnet.exe" build --configuration Release --no-restore

if %errorlevel% neq 0 (
    echo.
    echo Intentando con restauracion minima...
    "C:\Users\juanr\dotnet\dotnet.exe" build --configuration Release
)

if %errorlevel% eq 0 (
    echo.
    echo ========================================
    echo    EXITO! Aplicacion compilada!
    echo ========================================
    echo.
    echo La aplicacion esta en:
    echo    bin\Release\net8.0-windows\
    echo.

    choice /C YN /M "Ejecutar aplicacion ahora"
    if errorlevel 2 goto end
    if errorlevel 1 goto run

    :run
    if exist "bin\Release\net8.0-windows\ExcelSpanUtility.exe" (
        start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
        echo Aplicacion iniciada!
    ) else (
        echo ERROR: No se encontro el ejecutable!
    )

    :end
) else (
    echo.
    echo ========================================
    echo    ERROR! No se pudo compilar
    echo ========================================
    echo.
    echo Intenta ejecutar ARREGLAR_DEPENDENCIAS.bat
)

pause