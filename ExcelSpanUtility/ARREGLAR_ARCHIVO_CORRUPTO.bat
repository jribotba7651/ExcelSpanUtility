@echo off
echo ========================================
echo    ARREGLANDO ARCHIVO CORRUPTO
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Verificando archivo problematico...
if exist "UI\SettingsWindow.xaml" (
    echo Encontrado UI\SettingsWindow.xaml
    echo Contenido actual:
    type "UI\SettingsWindow.xaml"
    echo.
    echo Eliminando archivo corrupto...
    del "UI\SettingsWindow.xaml"
    echo Archivo eliminado.
) else (
    echo No existe UI\SettingsWindow.xaml
)

if exist "UI\SettingsWindow.xaml.cs" (
    echo Eliminando archivo .cs correspondiente...
    del "UI\SettingsWindow.xaml.cs"
    echo Archivo .cs eliminado.
)

echo.
echo Limpiando carpetas de compilacion...
if exist "bin" rd /s /q "bin"
if exist "obj" rd /s /q "obj"

echo.
echo Intentando compilacion...
"C:\Users\juanr\dotnet\dotnet.exe" build

if %errorlevel% eq 0 (
    echo.
    echo ========================================
    echo    EXITO! Problema solucionado!
    echo ========================================
    echo.

    if exist "bin\Debug\net8.0-windows\ExcelSpanUtility.exe" (
        echo Ejecutable creado en: bin\Debug\net8.0-windows\ExcelSpanUtility.exe
        echo.
        set /p run="Ejecutar aplicacion? (s/n): "
        if /i "%run%"=="s" (
            start "" "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
        )
    ) else (
        echo Verificando otras ubicaciones...
        dir bin /s /b *.exe 2>nul
    )
) else (
    echo.
    echo Aun hay errores. Mostrando errores detallados...
    "C:\Users\juanr\dotnet\dotnet.exe" build --verbosity normal
)

echo.
echo Presiona cualquier tecla para continuar...
pause >nul