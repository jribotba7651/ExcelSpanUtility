@echo off
echo ========================================
echo    FORZANDO COMPILACION COMPLETA
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo LIMPIEZA TOTAL...
if exist "bin" rd /s /q "bin"
if exist "obj" rd /s /q "obj"

echo.
echo COMPILANDO SIN RESTORE...
"C:\Users\juanr\dotnet\dotnet.exe" build --configuration Debug --no-restore --force
echo Resultado: %errorlevel%

if %errorlevel% neq 0 (
    echo.
    echo Compilacion fallo, intentando con restore...
    "C:\Users\juanr\dotnet\dotnet.exe" build --configuration Debug
    echo Resultado con restore: %errorlevel%
)

echo.
echo VERIFICANDO RESULTADO...
if exist "bin\Debug\net8.0-windows\ExcelSpanUtility.exe" (
    echo.
    echo ===== EXITO! =====
    echo Ejecutable creado correctamente!
    dir "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
    echo.

    set /p run="Ejecutar ahora? (s/n): "
    if /i "%run%"=="s" (
        start "" "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
    )
) else (
    echo.
    echo ===== FALLO =====
    echo No se creo el ejecutable
    echo.
    echo Contenido de bin:
    if exist "bin" (
        dir bin /s /b
    ) else (
        echo No existe carpeta bin
    )

    echo.
    echo Intentando compilacion modo Release...
    "C:\Users\juanr\dotnet\dotnet.exe" build --configuration Release

    if exist "bin\Release\net8.0-windows\ExcelSpanUtility.exe" (
        echo EXITO en Release!
        dir "bin\Release\net8.0-windows\ExcelSpanUtility.exe"
    ) else (
        echo Fallo tambien en Release

        echo.
        echo === DIAGNOSTICO ===
        echo Verificando archivos del proyecto...
        if exist "MainWindow.xaml" echo MainWindow.xaml: OK
        if exist "App.xaml" echo App.xaml: OK
        if exist "ExcelSpanUtility.csproj" echo ExcelSpanUtility.csproj: OK

        echo.
        echo Ultimo intento con verbose...
        "C:\Users\juanr\dotnet\dotnet.exe" build --verbosity normal
    )
)

echo.
echo Presiona cualquier tecla para continuar...
pause >nul