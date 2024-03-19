program ej5;
{Realizar un programa, con la declaración de tipos correspondientes que permita
crear un archivo de registros no ordenados con información de especies de flores
originarias de América. La información será suministrada mediante teclado. De
cada especie se registra: número de especie, altura máxima, nombre científico,
nombre vulgar, color y altura máxima que alcanza. La carga del archivo debe
finalizar cuando se reciba como nombre científico: ’zzz’.
Además se deberá contar con opciones del programa que posibiliten:
a) Reportar en pantalla la cantidad total de especies y la especie de menor y de
mayor altura a alcanzar.
b) Listar todo el contenido del archivo de a una especie por línea.
c) Modificar el nombre científico de la especie flores cargada como: Victoria
amazonia a: Victoria amazónica.
d) Añadir una o más especies al final del archivo con sus datos obtenidos por
teclado. La carga finaliza al recibir especie “zzz”.
e) Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”.
El archivo de texto se tiene que poder reutilizar.
f) ¿Qué cambiaría en la escritura del archivo de texto si no fuera necesario
utilizarlo?
}

type
    especie = record
        num: integer;
        altura: real;
        nombreCientifico: string;
        nombreVulgar: string;
        color: string;
    end;
    archivo = file of especie;


// Procesos de carga y modificación de archivo
// Procedimiento para leer una especie
procedure leerEspecie(var e:especie);
begin
    with e do begin
        write('Numero de especie: '); readln(num);
        if (num <> 0) then begin
            write('Altura maxima: '); readln(altura);
            write('Nombre cientifico: '); readln(nombreCientifico);
            write('Nombre vulgar: '); readln(nombreVulgar);
            write('Color: '); readln(color);
        end;
    end;
end;
// Procedimiento para cargar el archivo
procedure cargarArchivo(var a:archivo);
var
    e:especie;
begin
    assign(a, 'flores');
    rewrite(a);
    leerEspecie(e);
    while (e.nombreCientifico <> 'zzz') do begin
        write(a, e);
        leerEspecie(e);
    end;
    close(a);
end;

//c) Procedimiento para modificar el nombre cientifico de una especie (Victoria amazonia a Victoria amazonica)
Procedure modificarEspecie(Var a:archivo);
Var 
  e: especie;
Begin
  reset(a);
  While (Not eof(a)) Do
    Begin
      read(a, e);
      If (e.nombreCientifico = 'Victoria amazonia') Then
        e.nombreCientifico := 'Victoria amazónica';
      seek(a, filepos(a)-1);
      write(a, e);
    End;
  close(a);
End;


// a) Reportar en pantalla la cantidad total de especies y la especie de menor y de mayor altura a alcanzar. 
procedure minMaxAltura(var a:archivo);
var
    e:especie;
    min, max: real;
    total: integer;
begin
    reset(a);
    read(a, e);
    total := 0;
    min := e.altura;
    max := e.altura;
    while (not eof(a)) do begin
        total := total + 1;
        if (e.altura < min) then
            min := e.altura;
        if (e.altura > max) then
            max := e.altura;
        read(a, e);
    end;
    writeln('La cantidad total de especies es: ', total);
    writeln('La especie de menor altura es: ', min);
    writeln('La especie de mayor altura es: ', max);
    close(a);
end;

// b) Listar todo el contenido del archivo de a una especie por línea.
procedure listarArchivo(var a:archivo);
var
    e:especie;
begin
    reset(a);
    while (not eof(a)) do begin
        read(a, e);
        writeln('Numero de especie: ', e.num);
        writeln('Altura maxima: ', e.altura:0:2);
        writeln('Nombre cientifico: ', e.nombreCientifico);
        writeln('Nombre vulgar: ', e.nombreVulgar);
        writeln('Color: ', e.color);
    end;
    close(a);
end;

// d) Añadir una o más especies al final del archivo con sus datos obtenidos por teclado. La carga finaliza al recibir especie “zzz”.
procedure agregarEspecie(var a:archivo);
var
    e:especie;
begin
    reset(a);
    seek(a, filesize(a)-1);
    leerEspecie(e);
    while (e.nombreCientifico <> 'zzz') do begin
        write(a, e);
        leerEspecie(e);
    end;
    close(a);
end;

// e) Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”.
procedure exportarATexto(var a:archivo);
var
    e:especie;
    t:text;
begin
    reset(a);
    assign(t, 'flores.txt');
    rewrite(t);
    while (not eof(a)) do begin
        read(a, e);
        writeln(t, 'Numero de especie: ', e.num);
        writeln(t, 'Altura maxima: ', e.altura:0:2);
        writeln(t, 'Nombre cientifico: ', e.nombreCientifico);
        writeln(t, 'Nombre vulgar: ', e.nombreVulgar);
        writeln(t, 'Color: ', e.color);
    end;
end;



begin
    //cargarArchivo(a);
    //minMaxAltura(a);
    //listarArchivo(a);
    //modificarEspecie(a);
    //agregarEspecie(a);
    //exportarATexto(a);
    //close(a);
end.