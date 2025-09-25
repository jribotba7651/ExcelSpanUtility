@echo off
echo ========================================
echo    RESETEANDO A VERSION SIMPLE
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Eliminando archivos problematicos...
if exist "UI" rd /s /q "UI"
if exist "bin" rd /s /q "bin"
if exist "obj" rd /s /q "obj"

echo.
echo Copiando version simple del proyecto...

echo Creando ExcelSpanUtility.csproj simple...
(
echo ^<Project Sdk="Microsoft.NET.Sdk"^>
echo.
echo   ^<PropertyGroup^>
echo     ^<OutputType^>WinExe^</OutputType^>
echo     ^<TargetFramework^>net8.0-windows^</TargetFramework^>
echo     ^<UseWPF^>true^</UseWPF^>
echo     ^<UseWindowsForms^>true^</UseWindowsForms^>
echo   ^</PropertyGroup^>
echo.
echo ^</Project^>
) > ExcelSpanUtility.csproj

echo.
echo Probando compilacion...
"C:\Users\juanr\dotnet\dotnet.exe" build

if %errorlevel% eq 0 (
    echo.
    echo ========================================
    echo    EXITO! Version simple compilada!
    echo ========================================
    echo.

    if exist "bin\Debug\net8.0-windows\ExcelSpanUtility.exe" (
        echo Ejecutable creado: bin\Debug\net8.0-windows\ExcelSpanUtility.exe
        echo.
        set /p run="Probar ejecutar? (s/n): "
        if /i "%run%"=="s" (
            start "" "bin\Debug\net8.0-windows\ExcelSpanUtility.exe"
        )
    )
) else (
    echo.
    echo Aun hay errores...
    echo Mostrando detalles:
    "C:\Users\juanr\dotnet\dotnet.exe" build --verbosity normal
)

echo.
echo Presiona cualquier tecla para continuar...
pause >nul