program ej2;

var
    archivo: TextFile;
    nombreArchivo: string;
    votantes, minVotantes, maxVotantes: integer;

begin
    // Solicitar al usuario el nombre del archivo a procesar
    Write('Ingrese el nombre del archivo a procesar: ');
    Readln(nombreArchivo);

    // Abrir el archivo en modo lectura
    Assign(archivo, nombreArchivo);
    Reset(archivo);

    // Inicializar las variables de votantes, mínimos y máximos
    minVotantes := MaxInt;
    maxVotantes := -MaxInt;

    // Recorrer el archivo y mostrar el contenido en pantalla
    while not Eof(archivo) do
    begin
        Read(archivo, votantes);
        Writeln(votantes);

        // Actualizar los valores mínimos y máximos
        if votantes < minVotantes then
            minVotantes := votantes;
        if votantes > maxVotantes then
            maxVotantes := votantes;
    end;

    // Cerrar el archivo
    Close(archivo);

    // Mostrar los resultados
    Writeln('Cantidad minima de votantes: ', minVotantes);
    Writeln('Cantidad maxima de votantes: ', maxVotantes);

    // Esperar a que el usuario presione una tecla para finalizar
    Readln;
end.