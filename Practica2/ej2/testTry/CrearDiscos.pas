Program CrearDiscos;

Type 
   disco = record
        codAutor: integer;
        nomAutor: string;
        nomDisco: string;
        genero: string;
        cantVendida: integer;
    end;

    arch = file of disco;

// Escribir un disco
Procedure escribirDisco(var d: disco);
Begin
    WriteLn('Ingrese el codigo del autor: ');
    ReadLn(d.codAutor);
    WriteLn('Ingrese el nombre del autor: ');
    ReadLn(d.nomAutor);
    WriteLn('Ingrese el nombre del disco: ');
    ReadLn(d.nomDisco);
    WriteLn('Ingrese el genero del disco: ');
    ReadLn(d.genero);
    WriteLn('Ingrese la cantidad vendida: ');
    ReadLn(d.cantVendida);
End;

var
    d: disco;
    archivo: arch;
    resp: char;

Begin
    WriteLn('Leer discos');
    WriteLn('-------------');

    // Crear archivo
    Assign(archivo, 'discos.dat');
    Rewrite(archivo);

    // Leer discos
    Repeat
        WriteLn('Ingrese los datos del disco: ');
        escribirDisco(d);
        Write(archivo, d);
        WriteLn('Desea ingresar otro disco? (s/n): ');
        ReadLn(resp);
    Until (resp = 'n');

    // Cerrar archivo
    Close(archivo);
    WriteLn('Archivo cerrado');
    WriteLn('Fin del programa');
End.
