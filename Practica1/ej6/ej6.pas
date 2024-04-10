program ej6;

{
Realizar un programa que permita:
a. Crear un archivo binario a partir de la información almacenada en un
archivo de texto. El nombre del archivo de texto es: “libros.txt”
b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
agregar un libro y modificar uno existente. Las búsquedas se realizan por
ISBN.
NOTA: La información en el archivo de texto consiste en: ISBN (nro de 13 dígitos),
título del libro, género, editorial y año de edición. Cada libro se almacena en tres líneas
en el archivo de texto. La primera línea contendrá la información de ISBN y título del
libro, la segunda línea almacenará el año de edición y la editorial y en la tercera línea el
género del libro. (Analice otras posibles formas de representar la información en el txt)
}

type
    tipoLibro = record
        ISBN: string[13];
        Titulo: string[50];
        Genero: string[20];
        Editorial: string[50];
        AnioEdicion: integer;
    end;

// Creo el archivo binario a partir del archivo de texto
procedure CrearArchivoBinario(var archivoTexto: Text; var archivoBinario: File);
var
    linea: string;
    libro: tipoLibro;
begin
    Reset(archivoTexto);
    Rewrite(archivoBinario);

    while not Eof(archivoTexto) do
    begin
        ReadLn(archivoTexto, linea);
        read(archivoTexto, libro.ISBN);
        ReadLn(archivoTexto, libro.Titulo);
        Read(archivoTexto, libro.AnioEdicion);
        Readln(archivoTexto, libro.Editorial);
        ReadLn(archivoTexto, libro.Genero);
        Write(archivoBinario, libro);
    end;

    Close(archivoTexto);
    Close(archivoBinario);
end;


// Agrego un libro al archivo binario
procedure AgregarLibro(var archivoBinario: File);
begin
    Seek(archivoBinario, FileSize(archivoBinario));
    
    WriteLn('Ingrese el ISBN del libro:');
    ReadLn(libro.ISBN);
    WriteLn('Ingrese el titulo del libro:');
    ReadLn(libro.Titulo);
    WriteLn('Ingrese el genero del libro:');
    ReadLn(libro.Genero);
    WriteLn('Ingrese la editorial del libro:');
    ReadLn(libro.Editorial);
    WriteLn('Ingrese el anio de edicion del libro:');
    ReadLn(libro.AnioEdicion);
    
    Write(archivoBinario, libro);
end;

// Modifico un libro en el archivo binario
procedure ModificarLibro(var archivoBinario: File);
var
    encontrado: Boolean;
begin
    WriteLn('Ingrese el ISBN del libro a modificar:');
    ReadLn(ISBNBusqueda);
    
    encontrado := False;
    
    while not Eof(archivoBinario) do
    begin
        Read(archivoBinario, libro);
        if libro.ISBN = ISBNBusqueda then
        begin
            encontrado := True;
            WriteLn('Ingrese el nuevo titulo del libro:');
            ReadLn(libro.Titulo);
            WriteLn('Ingrese el nuevo genero del libro:');
            ReadLn(libro.Genero);
            WriteLn('Ingrese la nueva editorial del libro:');
            ReadLn(libro.Editorial);
            WriteLn('Ingrese el nuevo anio de edición del libro:');
            ReadLn(libro.AnioEdicion);
            Seek(archivoBinario, FilePos(archivoBinario) - 1);
            Write(archivoBinario, libro);
            Break;
        end;
    end;
    
    if not encontrado then
        WriteLn('No se encontro un libro con el ISBN especificado.');
end;

begin
    Assign(archivoBinario, 'libros.dat');
    Reset(archivoBinario);
    
    //Programa basico de seleccion de opciones
    WriteLn('Seleccione una opcion:');
    WriteLn('a. Crear archivo binario a partir de archivo de texto.');
    WriteLn('b. Agregar un libro al archivo binario.');
    WriteLn('c. Modificar un libro en el archivo binario.');
    WriteLn('d. Salir. ');
    ReadLn(opcion);
    
    case opcion of
        'a': CrearArchivoBinario();
        'b': AgregarLibro(archivoBinario);
        'c': ModificarLibro(archivoBinario);
        'd': WriteLn('Saliendo...');
        else
            WriteLn('Opción no valida.');
    end;
    
    Close(archivoBinario);
end.
