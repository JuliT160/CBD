{Se necesita contabilizar los CD vendidos por una discográfica. Para ello se dispone de
un archivo con la siguiente información: código de autor, nombre del autor, nombre
disco, género y la cantidad vendida de ese CD. Realizar un programa que muestre un
listado como el que se detalla a continuación. Dicho listado debe ser mostrado en
pantalla y además listado en un archivo de texto. En el archivo de texto se debe listar
nombre del disco, nombre del autor y cantidad vendida. El archivo origen está
ordenado por código de autor, género y nombre disco.

Autor: _____
Género: ----------
Nombre Disco: ---------- cantidad vendida: ------------
Nombre Disco: ---------- cantidad vendida: ------------
Total Género:
Género:----------
Nombre Disco: ---------- cantidad vendida: ------------
.......
Total Autor:
Total Discográfica:
}

program ej2;

type
    disco = record
        codAutor: integer;
        nomAutor: string;
        nomDisco: string;
        genero: string;
        cantVendida: integer;
    end;

    archivoDat = file of disco;
    archivoTxt = text;

procedure leer(var datos: archivoDat; var reg: disco);
begin
    if not eof(datos) then
        read(datos, reg)
    else
        reg.codAutor := 9999;
end;
var
    datos: archivoDat;
    dato: disco;
    totalAutor, totalDisco, totalGenero: integer;
    nomAutor, genero, nomDisco: string;
    txt: archivoTxt;
begin
    assign(datos, 'discos.dat');
    reset(datos);
    assign(txt, 'discos.txt');
    rewrite(txt);

    leer(datos, dato);
    while dato.codAutor <> 9999 do
    begin
        totalAutor := 0;
        totalDisco := 0;
        totalGenero := 0;
        nomAutor := dato.nomAutor;
        writeln('Autor: ', nomAutor);
        while (dato.codAutor <> 9999) and (nomAutor = dato.nomAutor) do
        begin
            totalAutor := totalAutor + dato.cantVendida;
            totalGenero := 0;
            genero := dato.genero;
            writeln('Genero: ', genero);
            while (dato.codAutor <> 9999) and (nomAutor = dato.nomAutor) and (genero = dato.genero) do
            begin
                totalGenero := totalGenero + dato.cantVendida;
                totalDisco := 0;
                nomDisco := dato.nomDisco;
                writeln('Nombre Disco: ', nomDisco, ' cantidad vendida: ', dato.cantVendida);
                while (dato.codAutor <> 9999) and (nomAutor = dato.nomAutor) and (genero = dato.genero) and (nomDisco = dato.nomDisco) do
                begin
                    totalDisco := totalDisco + dato.cantVendida;
                    leer(datos, dato);
                end;
                writeln('Total Disco: ', totalDisco);
            end;
            writeln('Total Genero: ', totalGenero);
        end;
        writeln('Total Autor: ', totalAutor);
    end;
    writeln('Total Discografica: ', totalDisco);
    close(txt);
    close(datos);

end. 
