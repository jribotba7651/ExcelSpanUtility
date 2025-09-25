@echo off
echo ========================================
echo    COMPILANDO - INTENTO FINAL
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Paso 1: Limpiando todo...
if exist "bin" rd /s /q "bin"
if exist "obj" rd /s /q "obj"

echo.
echo Paso 2: Restaurando (necesario una vez)...
"C:\Users\juanr\dotnet\dotnet.exe" restore

if %errorlevel% eq 0 (
    echo.
    echo Paso 3: Compilando...
    "C:\Users\juanr\dotnet\dotnet.exe" build --configuration Release

    if %errorlevel% eq 0 (
        echo.
        echo ========================================
        echo    COMPILACION EXITOSA!
        echo ========================================
        echo.

        if exist "bin\Release\net8.0-windows\ExcelSpanUtility.exe" (
            echo Aplicacion lista en: bin\Release\net8.0-windows\ExcelSpanUtility.exe
            echo.
            choice /C YN /M "Ejecutar ahora"
            if errorlevel 1 if not errorlevel 2 (
                start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
            )
        ) else if exist "bin\Debug\net8.0-windows\ExcelSpanUtility.exe" (
            echo Aplicacion lista en: bin\Debug\net8.0-windows\ExcelSpanUtility.exe
            echo.
            choice /C YN /M "Ejecutar ahora"
            if errorlevel 1 if not errorlevel 2 (
                start "" "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
            )
        ) else (
            echo.
            echo Verificando otras ubicaciones...
            dir /s /b bin\*.exe 2>nul
        )
    ) else (
        echo.
        echo ERROR en la compilacion!
        echo Intentando modo Debug...
        "C:\Users\juanr\dotnet\dotnet.exe" build
    )
) else (
    echo.
    echo ERROR: No se pudo restaurar!
    echo Verifica tu conexion a internet
)

echo.
pause