# 🚀 Usar .NET Portable (Sin permisos de Admin)

## Opción 1: Descargar .NET SDK Portable (Recomendado)

### Paso 1: Descargar .NET SDK Portable
1. Ve a: https://dotnet.microsoft.com/download/dotnet/8.0
2. Busca la sección **"All .NET 8.0 downloads"**
3. Descarga **"Binaries"** → **"x64"** (archivo .zip, NO el instalador)
   - Archivo: `dotnet-sdk-8.0.xxx-win-x64.zip` (~200MB)

### Paso 2: Extraer .NET Portable
1. Crea una carpeta: `C:\Users\juanr\dotnet-portable`
2. Extrae el archivo ZIP en esa carpeta
3. Deberías ver `dotnet.exe` en `C:\Users\juanr\dotnet-portable\`

### Paso 3: Compilar con .NET Portable
Usa el archivo `CompileWithPortable.bat` que está en la carpeta del proyecto

---

## Opción 2: Descargar Binarios Pre-compilados

Si no puedes compilar, necesitarás que alguien con acceso admin compile la aplicación como "self-contained".

### Para que alguien te compile la aplicación:
Pídeles que ejecuten este comando:
```cmd
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true
```

Esto generará un único archivo .exe (~60-80MB) que incluye todo .NET y no requiere instalación.

---

## Opción 3: Usar Visual Studio Code Portable

1. Descarga VS Code Portable (no requiere admin)
2. Instala la extensión C# Dev Kit
3. Abre el proyecto y usa la terminal integrada

---

## Si ya descargaste los binarios de .NET:

El archivo `CompileWithPortable.bat` automáticamente:
- Detectará si tienes .NET portable en `C:\Users\juanr\dotnet-portable`
- Compilará usando esa versión
- No requiere permisos de administrador