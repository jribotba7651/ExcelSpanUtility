@echo off
echo ========================================
echo    VERIFICANDO QUE SE GENERO
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Archivos en carpeta bin:
echo ------------------------
if exist "bin" (
    dir bin /s /b 2>nul
    echo.
) else (
    echo No existe carpeta bin
)

echo Archivos .exe encontrados:
echo --------------------------
for /r bin %%i in (*.exe) do (
    echo Encontrado: %%i
    echo Tamano: %%~zi bytes
    echo.
)

echo Archivos .dll encontrados:
echo --------------------------
for /r bin %%i in (*.dll) do (
    echo Encontrado: %%i
)

echo.
echo Verificando si se puede ejecutar...
if exist "bin\Debug\net8.0-windows\ExcelSpanUtility.exe" (
    echo ========================================
    echo    ENCONTRADO! bin\Debug\net8.0-windows\ExcelSpanUtility.exe
    echo ========================================
    echo.
    choice /C YN /M "Probar ejecutar ahora"
    if errorlevel 1 if not errorlevel 2 (
        start "" "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
    )
) else if exist "bin\Release\net8.0-windows\ExcelSpanUtility.exe" (
    echo ========================================
    echo    ENCONTRADO! bin\Release\net8.0-windows\ExcelSpanUtility.exe
    echo ========================================
    echo.
    choice /C YN /M "Probar ejecutar ahora"
    if errorlevel 1 if not errorlevel 2 (
        start "" "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
    )
) else (
    echo.
    echo NO se encontro ExcelSpanUtility.exe
    echo.
    echo La compilacion no termino correctamente.
    echo Intenta ejecutar COMPILAR_FINAL.bat de nuevo
)

pause