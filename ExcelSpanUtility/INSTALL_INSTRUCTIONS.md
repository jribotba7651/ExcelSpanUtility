# 🚀 Instrucciones de Instalación y Compilación

## Paso 1: Instalar .NET 8.0 SDK

### Opción A: Descarga directa
1. Ve a: https://dotnet.microsoft.com/download/dotnet/8.0
2. Descarga **".NET 8.0 SDK"** (no Runtime) para Windows x64
3. Ejecuta el instalador
4. Reinicia tu computadora (recomendado)

### Opción B: Usando winget (si tienes Windows 11/10 actualizado)
```cmd
winget install Microsoft.DotNet.SDK.8
```

## Paso 2: Compilar el Proyecto

### Método 1: Usar el archivo BAT (Más fácil)
1. Doble clic en `CompileAndRun.bat`
2. Sigue las instrucciones en pantalla
3. Cuando pregunte si quieres ejecutar, escribe `y` y presiona Enter

### Método 2: Usar PowerShell
1. Abre PowerShell como Administrador
2. Ejecuta:
```powershell
cd C:\Users\juanr\ExcelSpanUtility
.\Build.ps1
```

### Método 3: Línea de comandos manual
1. Abre CMD o PowerShell
2. Ejecuta estos comandos:
```cmd
cd C:\Users\juanr\ExcelSpanUtility
dotnet restore
dotnet build --configuration Release
```

## Paso 3: Ejecutar la Aplicación

### Opción 1: Desde el explorador de Windows
1. Navega a: `C:\Users\juanr\ExcelSpanUtility\bin\Release\net8.0-windows\`
2. Doble clic en `ExcelSpanUtility.exe`

### Opción 2: Desde línea de comandos
```cmd
cd C:\Users\juanr\ExcelSpanUtility
dotnet run
```

## 🧪 Para Probar la Aplicación

1. **Abre Excel** con al menos un archivo
2. **Ejecuta la aplicación** ExcelSpanUtility
3. **Haz clic en "Refresh"** para ver las ventanas de Excel
4. **Selecciona una ventana** de la lista superior
5. **Selecciona monitores** de la lista inferior (puedes seleccionar varios con Ctrl+Click)
6. **Haz clic en "Span Selected Monitors"**

## ❌ Solución de Problemas

### Error: "dotnet is not recognized"
- Instala .NET 8.0 SDK siguiendo el Paso 1
- Después de instalar, cierra y vuelve a abrir la terminal

### Error: "Could not find project"
- Asegúrate de estar en el directorio correcto: `C:\Users\juanr\ExcelSpanUtility`

### Error al compilar
- Ejecuta primero: `dotnet restore`
- Si persiste, elimina las carpetas `bin` y `obj` y vuelve a compilar

### La aplicación no detecta Excel
- Asegúrate de que Excel esté abierto con al menos un archivo
- Ejecuta la aplicación como Administrador (clic derecho > Ejecutar como administrador)

## 📝 Notas Adicionales

- La aplicación requiere Windows 10 o superior
- Necesitas tener al menos 2 monitores conectados para usar la función de span
- Excel debe estar instalado (cualquier versión de Office 2013 o superior)