# Programación en Windows: Tamaño de Ficheros

**Actividad de Sistemas Operativos Avanzados**

## Descripción

Este proyecto implementa una solución completa para listar y analizar el tamaño de ficheros en un directorio de Windows, combinando programación en C con la API de Windows y automatización mediante PowerShell.

La actividad está dividida en dos fases:
- **Fase 1**: Programa en C que lista ficheros y sus tamaños
- **Fase 2**: Script PowerShell que analiza los resultados

## Objetivos

- Utilizar llamadas al sistema de la API de Windows para manipulación de ficheros
- Implementar control de errores robusto en C
- Automatizar tareas del sistema con PowerShell
- Procesar y analizar datos de ficheros
- Integrar múltiples tecnologías en una solución completa

## Estructura del Proyecto

```
.
├── lista_size.c                          # Programa en C (Fase 1)
├── tamanos.ps1                            # Script PowerShell (Fase 2)
└── README.md                              # Este archivo
```

## Tecnologías Utilizadas

- **Lenguaje C**: Programación de sistemas con la API de Windows
- **PowerShell**: Automatización y procesamiento de datos
- **API de Windows**: FindFirstFile, FindNextFile, CreateFile, WriteFile

## Fase 1: Programa en C (lista_size.c)

### Funcionalidad

El programa `lista_size.c` realiza las siguientes operaciones:

1. Crea el directorio `C:\tmp` si no existe
2. Abre/crea el fichero `C:\tmp\lista_sz`
3. Lista todos los ficheros del directorio actual
4. Escribe en el fichero el nombre y tamaño de cada archivo
5. Implementa control de errores completo

### Llamadas al Sistema Utilizadas

- `CreateDirectory()` - Creación de directorios
- `CreateFile()` - Apertura/creación de ficheros
- `FindFirstFile()` - Inicio de búsqueda de ficheros
- `FindNextFile()` - Continuación de búsqueda
- `WriteFile()` - Escritura en ficheros
- `CloseHandle()` / `FindClose()` - Liberación de recursos

### Compilación

```bash
# Usando Visual Studio (recomendado)
cl lista_size.c

# Usando MinGW/GCC
gcc lista_size.c -o lista_size.exe
```

### Ejecución

```bash
lista_size.exe
```

### Salida Generada

El programa genera el fichero `C:\tmp\lista_sz` con el siguiente formato:

```
. 0
.. 0
lista_size.c 1629
lista_size.exe 115712
lista_size.obj 3421
```

## Fase 2: Script PowerShell (tamanos.ps1)

### Funcionalidad

El script `tamanos.ps1` realiza las siguientes operaciones:

1. Ejecuta automáticamente `lista_size.exe`
2. Lee y procesa el fichero `C:\tmp\lista_sz`
3. Calcula estadísticas del directorio:
   - Espacio total ocupado (bytes, KB, MB)
   - Fichero más grande
   - Fichero más pequeño
4. Muestra resultados formateados en pantalla

### Comandos de PowerShell Utilizados

- `Test-Path` - Verificación de existencia de ficheros
- `Get-Content` - Lectura de ficheros
- `Write-Host` - Salida formateada con colores
- `-split` - División de cadenas
- Operadores de comparación: `-gt`, `-lt`, `-ne`

### Configuración Inicial (solo primera vez)

```powershell
# Abrir PowerShell como Administrador y ejecutar:
Set-ExecutionPolicy RemoteSigned
```

### Ejecución

```powershell
# Navegar al directorio del script
cd C:\ruta\del\proyecto

# Ejecutar el script
.\tamanos.ps1
```

### Salida del Script

```
Ejecutando lista_size.exe...

Programa ejecutado correctamente

Analizando ficheros...

==========================================
RESULTADOS DEL ANALISIS
==========================================

Espacio ocupado por el directorio:
  - Total en bytes: 120.901
  - Total en KB: 118,07
  - Total en MB: 0,12

Fichero mas grande:
  - Nombre: lista_size.exe
  - Tamaño: 115.712 bytes (113,00 KB)

Fichero mas pequeño:
  - Nombre: lista_size.c
  - Tamaño: 1.629 bytes (1,59 KB)

Total de ficheros analizados: 3
==========================================
```

## Guía Rápida de Uso

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/lista-size-windows.git
cd lista-size-windows
```

### 2. Compilar el programa C

```bash
# Abrir "Developer Command Prompt for Visual Studio"
cl lista_size.c
```

### 3. Ejecutar el script PowerShell

```powershell
.\tamanos.ps1
```

## Requisitos del Sistema

- **Sistema Operativo**: Windows 7/8/10/11
- **Compilador C**: 
  - Visual Studio (con compilador CL)
  - O MinGW/GCC para Windows
- **PowerShell**: Versión 5.1 o superior (incluido por defecto en Windows)

## Control de Errores Implementado

### En el programa C:

1. Verificación de creación de fichero de salida
2. Verificación de búsqueda de ficheros
3. Verificación de escritura en fichero
4. Liberación de recursos en caso de error

### En el script PowerShell:

1. Verificación de existencia de `lista_size.exe`
2. Verificación de existencia de fichero de entrada
3. Validación de formato de datos
4. Mensajes de error descriptivos

## Detalles Técnicos

### Formato del Fichero de Salida

Cada línea del fichero `C:\tmp\lista_sz` contiene:
- Nombre del fichero o directorio
- Un espacio
- Tamaño en bytes

### Exclusiones en el Análisis

El script PowerShell excluye del análisis:
- Directorio actual (`.`)
- Directorio padre (`..`)

Esto asegura que solo se procesen ficheros reales.

## Documentación Adicional

- **Actividad_Lista_Size_Completa.docx**: Documento completo con explicaciones detalladas, código comentado y respuestas a preguntas teóricas
- **INSTRUCCIONES.txt**: Guía paso a paso para compilar y ejecutar

## Solución de Problemas

### Error: "No se reconoce 'cl' como comando"
**Solución**: Usar "Developer Command Prompt for Visual Studio" en lugar del CMD normal

### Error: "No se puede ejecutar script PowerShell"
**Solución**: Ejecutar `Set-ExecutionPolicy RemoteSigned` como administrador

### Error: "tamanos.ps1 no se reconoce como comando"
**Solución**: Usar `.\tamanos.ps1` (con punto y barra invertida)

### Error: "Caracteres extraños en la salida de PowerShell"
**Solución**: Guardar el script con PowerShell ISE usando codificación UTF-8 con BOM

## Autor

David Valbuena Segura - Actividad 1 de Sistemas Operativos Avanzados

## Licencia

Este proyecto es material académico para la asignatura de Sistemas Operativos Avanzados.

## Referencias

- [Documentación oficial de la API de Windows](https://docs.microsoft.com/en-us/windows/win32/)
- [Documentación de PowerShell](https://docs.microsoft.com/en-us/powershell/)
- Material del curso: Temas 1-6, 9-10

---

**Nota**: Este proyecto demuestra el uso integrado de programación en C con la API de Windows y automatización con PowerShell para tareas de administración del sistema.