{Una cadena de cines de renombre desea administrar la asistencia del público a las
diferentes películas que se exhiben actualmente. Para ello cada cine genera
semanalmente un archivo indicando: código de película, nombre de la película, género,
director, duración, fecha y cantidad de asistentes a la función. Se sabe que la cadena
tiene 20 cines. Escriba las declaraciones necesarias y un procedimiento que reciba los
20 archivos y un String indicando la ruta del archivo maestro y genere el archivo
maestro de la semana a partir de los 20 detalles (cada película deberá aparecer una
vez en el maestro con los datos propios de la película y el total de asistentes que tuvo
durante la semana). Todos los archivos detalles vienen ordenados por código de
película. Tenga en cuenta que en cada detalle la misma película aparecerá tantas
veces como funciones haya dentro de esa semana
Usar conceptos de algoritmica clasica}

program ej4;

Uses sysutils;

const
    cant_cines = 2;

type

    regDetalle = record
        codigo: integer;
        nombre: string;
        genero: string;
        director: string;
        duracion: integer;
        fecha: string;
        asistentes: integer;
    end;

    regMaestro = record
        codigo: integer;
        nombre: string;
        genero: string;
        director: string;
        duracion: integer;
        asistentes: integer;
    end;

    archMaestro = file of regMaestro;
    archDetalle = file of regDetalle;

var 
    maestro: archMaestro;
    detalle: archDetalle;
    rMaestro: regMaestro;
    rDetalle: regDetalle;
    i: integer;
    ruta: string; //??
    nombre: string;

begin
    assign(maestro, 'maestro'); 
    reset(maestro);
    read(maestro, rMaestro);

    for i:= 1 to cant_cines do
    begin
      //primero codigo adicional para leer los detalles
        nombre := IntToStr(i);
        Assign(detalle, nombre);  // supongo que los detalles estan nombrados por el numero de cine
        reset(detalle);
        read(detalle, rDetalle);
        while not eof(detalle) do
        begin
          while(rMaestro.codigo <> rDetalle.codigo) do
            begin
                read(maestro, rMaestro);
            end;
            rMaestro.asistentes := rMaestro.asistentes + rDetalle.asistentes;
            read(detalle, rDetalle);
            seek(maestro, filepos(maestro)-1);
            write(maestro, rMaestro);
        end;
        close(detalle);
    end;
    close(maestro);
    writeln('Archivo maestro generado con exito');
end.

//modificarlo despues. 