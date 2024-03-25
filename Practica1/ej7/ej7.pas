program ej7;
{Realizar un programa con opciones para:
a. Crear un archivo de registros no ordenados con la información
correspondiente a los alumnos de la facultad de ingeniería y cargarlo con
datos obtenidos a partir de un archivo de texto denominado “alumnos.txt”.
Los registros deben contener DNI, legajo, nombre y apellido, dirección, año
que cursa y fecha de nacimiento (longInt).
b. Listar en pantalla toda la información de los alumnos cuyos nombres
comiencen con un carácter proporcionado por el usuario.
c. Listar en un archivo de texto denominado “alumnosAEgresar.txt” todos los
registros del archivo de alumnos que cursen 5º año.
d. Añadir uno o más alumnos al final del archivo con sus datos obtenidos por
teclado.
e. Modificar el año que cursa un alumno dado. Las búsquedas son por legajo
del alumno}

type 
    alumno = record
        dni: Integer;
        legajo: string[7];
        nombre: String[20];
        apellido: String[20];
        direccion: String[20];
        anioCursa: Integer;
        fechaNac: LongInt;
    end;

    archAlu = file of alumno;

//Creo el archivo binario a partir del archivo de texto
procedure CrearArchivoBinario();
Var
    linea: String;
Begin
  Assign(archTxt, 'alumnos.txt');
  Assign(archBin, 'alumnos.dat');
  Reset(archTxt);
  Rewrite(archBin);


  While Not Eof(archTxt) Do
    Begin
      ReadLn(archTxt, alumno.dni);
      ReadLn(archTxt, alumno.legajo);
      ReadLn(archTxt, alumno.nombre);
      ReadLn(archTxt, alumno.apellido);
      ReadLn(archTxt, alumno.direccion);
      ReadLn(archTxt, alumno.anioCursa);
      ReadLn(archTxt, alumno.fechaNac);
      Write(archBin, alumno);
    End;

  Close(archivoTexto);
  Close(archivoBinario);
End;

//Listar en pantalla toda la información de los alumnos cuyos nombres comiencen con un carácter proporcionado por el usuario.
procedure ListarAlumnosPorNombre(caracter: char);
var
    alumno: alumno;
    archBin: archAlu;
begin
    Assign(archBin, 'alumnos.dat');
    Reset(archBin);
    while not eof(archBin) do
    begin
        read(archBin, alumno);
        if alumno.nombre[1] = caracter then
        begin
            writeln('DNI: ', alumno.dni);
            writeln('Legajo: ', alumno.legajo);
            writeln('Nombre: ', alumno.nombre);
            writeln('Apellido: ', alumno.apellido);
            writeln('Direccion: ', alumno.direccion);
            writeln('Año que cursa: ', alumno.anioCursa);
            writeln('Fecha de nacimiento: ', alumno.fechaNac);
        end;
    end;
    Close(archBin);
end;

//Listar en un archivo de texto denominado “alumnosAEgresar.txt” todos los registros del archivo de alumnos que cursen 5º año.
procedure ListarAlumnosAEgresar();
var
    alumno: alumno;
    archBin: archAlu;
    archTxt: Text;
begin
    Assign(archBin, 'alumnos.dat');
    Reset(archBin);
    Assign(archTxt, 'alumnosAEgresar.txt');
    Rewrite(archTxt);
    while not eof(archBin) do
    begin
        read(archBin, alumno);
        if alumno.anioCursa = 5 then
        begin
            writeln(archTxt, 'DNI: ', alumno.dni);
            writeln(archTxt, 'Legajo: ', alumno.legajo);
            writeln(archTxt, 'Nombre: ', alumno.nombre);
            writeln(archTxt, 'Apellido: ', alumno.apellido);
            writeln(archTxt, 'Direccion: ', alumno.direccion);
            writeln(archTxt, 'Año que cursa: ', alumno.anioCursa);
            writeln(archTxt, 'Fecha de nacimiento: ', alumno.fechaNac);
        end;
    end;
    Close(archBin);
    Close(archTxt);
end;

//Añadir uno o más alumnos al final del archivo con sus datos obtenidos por teclado.
procedure AgregarAlumno();
var
    alumno: alumno;
    archBin: archAlu;
begin
    Assign(archBin, 'alumnos.dat');
    Reset(archBin);
    seek(archBin, filesize(archBin));
    writeln('Ingrese el DNI del alumno: ');
    readln(alumno.dni);
    writeln('Ingrese el legajo del alumno: ');
    readln(alumno.legajo);
    writeln('Ingrese el nombre del alumno: ');
    readln(alumno.nombre);
    writeln('Ingrese el apellido del alumno: ');
    readln(alumno.apellido);
    writeln('Ingrese la direccion del alumno: ');
    readln(alumno.direccion);
    writeln('Ingrese el año que cursa el alumno: ');
    readln(alumno.anioCursa);
    writeln('Ingrese la fecha de nacimiento del alumno: ');
    readln(alumno.fechaNac);
    write(archBin, alumno);
    Close(archBin);
end;

//Modificar el año que cursa un alumno dado. Las búsquedas son por legajo del alumno
procedure ModificarAnioCursa(legajo: string; anio: integer);
var
    alumno: alumno;
    archBin: archAlu;
begin
    Assign(archBin, 'alumnos.dat');
    Reset(archBin);
    while not eof(archBin) do
    begin
        read(archBin, alumno);
        if alumno.legajo = legajo then
        begin
            alumno.anioCursa := anio;
            seek(archBin, filepos(archBin) - 1);
            write(archBin, alumno);
        end;
    end;
    Close(archBin);
end;

//pp
begin
  
end.

//Esta sin terminar pero es igual al anterior