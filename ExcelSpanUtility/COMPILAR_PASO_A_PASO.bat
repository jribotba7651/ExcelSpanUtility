@echo off
echo ========================================
echo    COMPILACION PASO A PASO
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Verificando dotnet...
"C:\Users\juanr\dotnet\dotnet.exe" --version
echo Version de dotnet: OK
echo.

echo Limpiando archivos anteriores...
if exist "bin" (
    echo Borrando carpeta bin...
    rd /s /q "bin"
)
if exist "obj" (
    echo Borrando carpeta obj...
    rd /s /q "obj"
)
echo Limpieza: OK
echo.

echo Restaurando dependencias...
echo (Esto puede tardar 30 segundos)
"C:\Users\juanr\dotnet\dotnet.exe" restore

if %errorlevel% eq 0 (
    echo Restore: OK
    echo.

    echo Compilando proyecto...
    echo (Esto puede tardar 10 segundos)
    "C:\Users\juanr\dotnet\dotnet.exe" build

    if %errorlevel% eq 0 (
        echo Build: OK
        echo.

        echo Verificando si se creo el ejecutable...
        if exist "bin\Debug\net8.0-windows\ExcelSpanUtility.exe" (
            echo.
            echo ========================================
            echo    EXITO! APLICACION COMPILADA!
            echo ========================================
            echo.
            echo Ubicacion: bin\Debug\net8.0-windows\ExcelSpanUtility.exe

            echo.
            set /p respuesta="Ejecutar aplicacion ahora? (s/n): "
            if /i "%respuesta%"=="s" (
                echo Abriendo aplicacion...
                start "" "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
            )
        ) else (
            echo.
            echo ERROR: No se encontro el ejecutable
            echo Mostrando contenido de bin...
            dir bin /s /b 2>nul
        )
    ) else (
        echo.
        echo ERROR en BUILD
        echo Mostrando ultimas lineas del error...
    )
) else (
    echo.
    echo ERROR en RESTORE
    echo Verifica tu conexion a internet
)

echo.
echo Presiona Enter para cerrar...
pause >nul