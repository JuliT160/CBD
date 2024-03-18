program ej1;

type
    TMaterial = record
        Nombre: string[50];
    end;

var
    Archivo: file of TMaterial;
    Material: TMaterial;
    NombreArchivo: string;

begin
    Write('Ingrese el nombre del archivo: ');
    Readln(NombreArchivo);

    Assign(Archivo, NombreArchivo);
    Rewrite(Archivo);

    repeat
        Write('Ingrese el nombre del material (o "cemento" para finalizar): ');
        Readln(Material.Nombre);

        Write(Archivo, Material);
    until Material.Nombre = 'cemento';

    Close(Archivo);
end.