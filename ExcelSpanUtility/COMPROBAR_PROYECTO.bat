@echo off
echo ========================================
echo    COMPROBANDO ARCHIVOS DEL PROYECTO
echo ========================================
echo.

cd /d "C:\Users\juanr\ExcelSpanUtility"

echo Archivos principales del proyecto:
echo -----------------------------------
if exist "ExcelSpanUtility.csproj" (
    echo ✓ ExcelSpanUtility.csproj
) else (
    echo ✗ ExcelSpanUtility.csproj FALTA!
)

if exist "App.xaml" (
    echo ✓ App.xaml
) else (
    echo ✗ App.xaml FALTA!
)

if exist "App.xaml.cs" (
    echo ✓ App.xaml.cs
) else (
    echo ✗ App.xaml.cs FALTA!
)

if exist "MainWindow.xaml" (
    echo ✓ MainWindow.xaml
) else (
    echo ✗ MainWindow.xaml FALTA!
)

if exist "MainWindow.xaml.cs" (
    echo ✓ MainWindow.xaml.cs
) else (
    echo ✗ MainWindow.xaml.cs FALTA!
)

echo.
echo Archivos de servicios:
echo ----------------------
if exist "Services\ExcelWindowService.cs" (
    echo ✓ ExcelWindowService.cs
) else (
    echo ✗ ExcelWindowService.cs FALTA!
)

if exist "Services\MonitorService.cs" (
    echo ✓ MonitorService.cs
) else (
    echo ✗ MonitorService.cs FALTA!
)

echo.
echo Contenido del archivo .csproj:
echo -------------------------------
if exist "ExcelSpanUtility.csproj" (
    type "ExcelSpanUtility.csproj"
) else (
    echo ARCHIVO NO EXISTE!
)

echo.
echo Estado de dotnet:
echo -----------------
"C:\Users\juanr\dotnet\dotnet.exe" --info

echo.
echo ========================================
echo Presiona cualquier tecla para continuar...
pause >nul