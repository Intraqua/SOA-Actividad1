#include <windows.h>
#include <stdio.h>

int main(void)
{
    WIN32_FIND_DATA datos;
    HANDLE hBusqueda;
    HANDLE hFichero;
    DWORD dwBytesEscritos;
    char buffer[512];
    DWORD tamanoArchivo;

    // Crear el directorio si no existe
    CreateDirectory("C:\\tmp", NULL);

    // Abrir el fichero de salida
    hFichero = CreateFile(
        "C:\\tmp\\lista_sz",
        GENERIC_WRITE,
        0,
        NULL,
        CREATE_ALWAYS,
        FILE_ATTRIBUTE_NORMAL,
        NULL
    );

	// Control de errores para crear el archivo
    if (hFichero == INVALID_HANDLE_VALUE)
    {
        fprintf(stderr, "Error al crear el fichero de salida\n");
        return 1;
    }

    // Buscar el primer fichero en el directorio actual
    hBusqueda = FindFirstFile("*.*", &datos);

	// Control de errores al buscar archivos
    if (hBusqueda == INVALID_HANDLE_VALUE)
    {
        fprintf(stderr, "Error al buscar ficheros\n");
        CloseHandle(hFichero);
        return 1;
    }

    // Recorrer todos los ficheros
    do
    {
        tamanoArchivo = datos.nFileSizeLow;
        
        // Formatear la linea con el nombre y tamaño
        sprintf(buffer, "%s %lu\n", datos.cFileName, tamanoArchivo);

        // Escribir en el fichero
		// Control de errores para escribir el archivo
        if (!WriteFile(hFichero, buffer, strlen(buffer), &dwBytesEscritos, NULL))
        {
            fprintf(stderr, "Error al escribir en el fichero\n");
            FindClose(hBusqueda);
            CloseHandle(hFichero);
            return 1;
        }

    } while (FindNextFile(hBusqueda, &datos));

    // Cerrar los manejadores
    FindClose(hBusqueda);
    CloseHandle(hFichero);

    return 0;
}