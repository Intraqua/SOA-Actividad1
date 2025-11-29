# Script tamanos.ps1
# Ejecuta lista_size.exe y analiza el fichero C:\tmp\lista_sz
# Devuelve: espacio total, fichero mas grande y fichero mas pequeño

Write-Host "Ejecutando lista_size.exe..." -ForegroundColor Cyan
Write-Host ""

# Ejecutar el programa lista_size.exe
$ejecutable = ".\lista_size.exe"

if (Test-Path $ejecutable) {
    & $ejecutable
    Write-Host "Programa ejecutado correctamente" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "Error: No se encuentra lista_size.exe en el directorio actual" -ForegroundColor Red
    exit 1
}

# Procesar el fichero generado
$ficheroEntrada = "C:\tmp\lista_sz"

if (-not (Test-Path $ficheroEntrada)) {
    Write-Host "Error: No se encuentra el fichero $ficheroEntrada" -ForegroundColor Red
    exit 1
}

Write-Host "Analizando ficheros..." -ForegroundColor Cyan
Write-Host ""

# Variables para calculos
$totalBytes = 0
$contador = 0
$ficheroMasGrande = ""
$tamanoMasGrande = 0
$ficheroMasPequeno = ""
$tamanoMasPequeno = [long]::MaxValue

# Leer el fichero linea por linea
foreach ($linea in Get-Content $ficheroEntrada) {
    $partes = $linea -split ' '
    
    if ($partes.Length -ge 2) {
        $nombreFichero = $partes[0]
        $tamanio = [long]$partes[1]
        
        # Excluir directorios (. y ..) del analisis
        if ($nombreFichero -ne "." -and $nombreFichero -ne "..") {
            # Acumular tamaño total
            $totalBytes += $tamanio
            $contador++
            
            # Buscar fichero mas grande
            if ($tamanio -gt $tamanoMasGrande) {
                $tamanoMasGrande = $tamanio
                $ficheroMasGrande = $nombreFichero
            }
            
            # Buscar fichero mas pequeño
            if ($tamanio -lt $tamanoMasPequeno) {
                $tamanoMasPequeno = $tamanio
                $ficheroMasPequeno = $nombreFichero
            }
        }
    }
}

# Mostrar resultados
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "RESULTADOS DEL ANALISIS" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Espacio ocupado por el directorio:" -ForegroundColor Green
Write-Host ("  - Total en bytes: {0:N0}" -f $totalBytes)
Write-Host ("  - Total en KB: {0:N2}" -f ($totalBytes / 1KB))
Write-Host ("  - Total en MB: {0:N2}" -f ($totalBytes / 1MB))
Write-Host ""
Write-Host "Fichero mas grande:" -ForegroundColor Green
Write-Host ("  - Nombre: {0}" -f $ficheroMasGrande)
Write-Host ("  - Tamaño: {0:N0} bytes ({1:N2} KB)" -f $tamanoMasGrande, ($tamanoMasGrande / 1KB))
Write-Host ""
Write-Host "Fichero mas pequeño:" -ForegroundColor Green
Write-Host ("  - Nombre: {0}" -f $ficheroMasPequeno)
Write-Host ("  - Tamaño: {0:N0} bytes ({1:N2} KB)" -f $tamanoMasPequeno, ($tamanoMasPequeno / 1KB))
Write-Host ""
Write-Host "Total de ficheros analizados: $contador" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan