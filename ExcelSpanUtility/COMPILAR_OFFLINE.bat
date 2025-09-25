@echo off
echo ========================================
echo    COMPILACION OFFLINE TOTAL
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Limpieza completa...
if exist "bin" rd /s /q "bin"
if exist "obj" rd /s /q "obj"
if exist "%USERPROFILE%\.nuget\packages" (
    echo Limpiando cache NuGet local...
    rd /s /q "%USERPROFILE%\.nuget\packages" 2>nul
)

echo.
echo Compilando en modo offline...
"C:\Users\juanr\dotnet\dotnet.exe" build --configuration Release --no-restore --no-dependencies /p:RestorePackages=false /p:RestoreNoCache=true

if %errorlevel% neq 0 (
    echo.
    echo Segundo intento sin flags...
    "C:\Users\juanr\dotnet\dotnet.exe" build -c Release
)

if exist "bin\Release\net8.0-windows\ExcelSpanUtility.exe" (
    echo.
    echo ========================================
    echo    EXITO! Aplicacion compilada!
    echo ========================================
    echo.

    choice /C YN /M "Abrir aplicacion"
    if errorlevel 1 if not errorlevel 2 (
        start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
    )
) else (
    echo.
    echo ERROR: No se genero el ejecutable
    echo.
    echo Posible solucion:
    echo 1. Verifica que dotnet.exe este en C:\Users\juanr\dotnet\
    echo 2. Intenta reiniciar la computadora
)

pause