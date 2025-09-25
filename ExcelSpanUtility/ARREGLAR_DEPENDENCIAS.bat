@echo off
echo ========================================
echo    ARREGLANDO DEPENDENCIAS
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Limpiando cache de NuGet...
"C:\Users\juanr\dotnet\dotnet.exe" nuget locals all --clear

echo.
echo Borrando carpetas antiguas...
if exist "bin" rd /s /q "bin"
if exist "obj" rd /s /q "obj"

echo.
echo Restaurando paquetes NuGet (esto puede tardar)...
"C:\Users\juanr\dotnet\dotnet.exe" restore --force

if %errorlevel% eq 0 (
    echo.
    echo ========================================
    echo    DEPENDENCIAS ARREGLADAS!
    echo ========================================
    echo.
    echo Ahora compilando proyecto...
    "C:\Users\juanr\dotnet\dotnet.exe" build --configuration Release

    if %errorlevel% eq 0 (
        echo.
        echo TODO LISTO! La aplicacion se compilo correctamente!
        echo.
        echo Presiona Y para ejecutar
        echo Presiona N para salir
        echo.

        choice /C YN /M "Ejecutar aplicacion"
        if errorlevel 2 goto end
        if errorlevel 1 goto run

        :run
        start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"

        :end
    ) else (
        echo.
        echo ERROR al compilar!
    )
) else (
    echo.
    echo ERROR al descargar dependencias!
    echo.
    echo Verifica tu conexion a internet
)

pause