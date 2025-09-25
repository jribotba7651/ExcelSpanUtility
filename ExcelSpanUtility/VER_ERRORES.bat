@echo off
echo ========================================
echo    COMPILACION CON ERRORES VISIBLES
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo PASO 1: Verificando dotnet...
"C:\Users\juanr\dotnet\dotnet.exe" --version
if %errorlevel% neq 0 (
    echo ERROR: dotnet no funciona!
    pause
    exit /b 1
)

echo.
echo PASO 2: Limpiando...
if exist "bin" rd /s /q "bin"
if exist "obj" rd /s /q "obj"
echo Limpieza completada.

echo.
echo PASO 3: Verificando archivos del proyecto...
if not exist "ExcelSpanUtility.csproj" (
    echo ERROR: No existe ExcelSpanUtility.csproj
    pause
    exit /b 1
)
if not exist "MainWindow.xaml" (
    echo ERROR: No existe MainWindow.xaml
    pause
    exit /b 1
)
echo Archivos del proyecto OK.

echo.
echo PASO 4: Restaurando (presiona cualquier tecla para continuar)...
pause
"C:\Users\juanr\dotnet\dotnet.exe" restore --verbosity detailed
echo.
echo Codigo de salida de restore: %errorlevel%

echo.
echo PASO 5: Compilando (presiona cualquier tecla para continuar)...
pause
"C:\Users\juanr\dotnet\dotnet.exe" build --verbosity detailed
echo.
echo Codigo de salida de build: %errorlevel%

echo.
echo PASO 6: Verificando resultado...
if exist "bin\Debug\net8.0-windows\ExcelSpanUtility.exe" (
    echo SUCCESS! Ejecutable creado!
    dir "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
) else (
    echo FALLO: No se creo el ejecutable
    echo.
    echo Verificando que existe en bin...
    if exist "bin" (
        dir bin /s
    ) else (
        echo No existe carpeta bin
    )
)

echo.
echo ========================================
echo Presiona cualquier tecla para salir...
pause