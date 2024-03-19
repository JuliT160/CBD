program ej4;

{Crear un procedimiento que reciba como parámetro el archivo del punto 2, y
genere un archivo de texto con el contenido del mismo.}

procedure GenerarArchivoTexto(const archivo: string);
var
    archivoEntrada, archivoSalida: TextFile;
    linea: string;
begin
    // Abrir el archivo de entrada en modo lectura
    Assign(archivoEntrada, archivo);
    Reset(archivoEntrada);

    // Crear el archivo de salida en modo escritura
    Assign(archivoSalida, 'salida.txt');
    Rewrite(archivoSalida);

    // Leer cada línea del archivo de entrada y escribirla en el archivo de salida
    while not Eof(archivoEntrada) do
    begin
        ReadLn(archivoEntrada, linea);
        WriteLn(archivoSalida, linea);
    end;

    // Cerrar los archivos
    Close(archivoEntrada);
    Close(archivoSalida);
end;


var
    rutaArchivo: string;

begin
    // Leer la ruta del archivo desde la consola
    Write('Ingrese la ruta del archivo de entrada: ');
    ReadLn(rutaArchivo);

    // Generar el archivo de texto
    GenerarArchivoTexto(rutaArchivo);
end.
   