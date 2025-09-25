# 📦 Configuración Sin Permisos de Admin

Ya que no tienes permisos de administrador, aquí están las opciones:

## 🎯 Opción Más Fácil: Descargar .NET Portable

### Pasos:

1. **Descarga el ZIP de .NET 8.0 (NO el instalador)**
   - Ve a: https://dotnet.microsoft.com/download/dotnet/8.0
   - Busca: **"All .NET 8.0 downloads"**
   - En la sección **"SDK 8.0"**, busca **"Binaries"**
   - Descarga: **Windows x64** (archivo .zip de ~200MB)
   - Nombre del archivo: `dotnet-sdk-8.0.xxx-win-x64.zip`

2. **Extrae el ZIP**
   ```
   Crea carpeta: C:\Users\juanr\dotnet-portable
   Extrae todo el ZIP ahí
   Verifica que exista: C:\Users\juanr\dotnet-portable\dotnet.exe
   ```

3. **Compila el proyecto**
   ```
   Doble click en: CompileWithPortable.bat
   ```

## 🚀 Scripts Disponibles

### `CompileWithPortable.bat`
- Usa .NET portable sin instalación
- No requiere permisos de admin
- Busca automáticamente en `C:\Users\juanr\dotnet-portable`

### `PublishSelfContained.bat`
- Crea un único archivo .exe (~70MB)
- Incluye .NET dentro del ejecutable
- El .exe resultante funciona en cualquier PC sin .NET

## 💡 Si No Puedes Descargar .NET

### Opción A: Pide a alguien con admin que ejecute:
```cmd
cd C:\Users\juanr\ExcelSpanUtility
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true
```
Esto creará un archivo único en `publish\ExcelSpanUtility.exe` que puedes copiar a cualquier PC.

### Opción B: Usa una PC con .NET ya instalado
- Compila ahí y copia el ejecutable autocontenido

## 🔧 Verificar si funciona

1. Abre Excel con un archivo
2. Ejecuta `ExcelSpanUtility.exe`
3. Click en "Refresh"
4. Si ve las ventanas de Excel, ¡funciona!

## ⚠️ Notas Importantes

- El .NET portable NO se instala, solo se extrae
- Puedes llevar la carpeta `dotnet-portable` en un USB
- El ejecutable autocontenido es grande (~70MB) pero portable
- No modifica el registro ni requiere instalación