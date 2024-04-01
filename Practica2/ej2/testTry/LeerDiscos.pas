Program LeerDiscos;

Type 
    disco = Record
        codAutor: integer;
        nombreAutor: string;
        nombreDisco: string;
        genero: string;
        cantidadVendida: integer;
    End;

Var 
    archivoDiscosTxt: Text;
    archivoDiscosDat: file Of disco;
    discoLeido: disco;
    i: integer;

Begin
    Assign(archivoDiscosTxt, 'discos.txt');
    Reset(archivoDiscosTxt);

    Assign(archivoDiscosDat, 'discos.dat');
    Rewrite(archivoDiscosDat);

    //While Not Eof(archivoDiscosTxt) Do
    for i:= 1 to 100 do
        Begin
            Readln(archivoDiscosTxt, discoLeido.codAutor, discoLeido.nombreAutor, discoLeido.nombreDisco, discoLeido.genero, discoLeido.cantidadVendida);
            Write(archivoDiscosDat, discoLeido);
        End;

    Close(archivoDiscosTxt); // Close the text file
    Close(archivoDiscosDat); // Close the binary file

    writeln('Archivo .dat generado exitosamente.');
End.
