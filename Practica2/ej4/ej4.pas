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
//Uses sysutils; //comentado porque sino llora el vsc pero para que funcione hay que descomentarlo

const
    cant_cines = 2;

type
    str50 = string[50];

    regDetalle = record
        codigo: integer;
        nombre: str50;
        genero: str50;
        director: str50;
        duracion: integer;
        fecha: str50;
        asistentes: integer;
    end;

    regMaestro = record
        codigo: integer;
        nombre: str50;
        genero: str50;
        director: str50;
        duracion: integer;
        totalAsistentes: integer;
    end;

    archMaestro = file of regMaestro;
    archDetalle = file of regDetalle;
    arrDetalles = array[1..cant_cines] of archDetalle;
    arrRegDetalles = array[1..cant_cines] of regDetalle;


procedure leerDetalle(var archivo: archDetalle; var registro: regDetalle);
begin
    if not eof(archivo) then
        read(archivo, registro)
    else
        registro.codigo := 9999; // valor muy alto para marcar fin de archivo
end;

procedure encontrarMinimo(var detalles: arrDetalles; var registros: arrRegDetalles; var min: regDetalle; var minIndex: integer);
var
    i: integer;
begin
    min.codigo := 9999;
    for i := 1 to cant_cines do
    begin
        if (registros[i].codigo < min.codigo) then
        begin
            min := registros[i];
            minIndex := i;
        end;
    end;
end;

procedure generarMaestro(var maestro: archMaestro; var detalles: arrDetalles; ruta: string);
var
    rMaestro: regMaestro;
    rDetalle: arrRegDetalles;
    minDetalle: regDetalle;
    i, minIndex: integer;
    detalleNombre: string;
begin
    // Asignar y abrir el archivo maestro para escritura
    Assign(maestro, ruta + 'maestro.dat');
    Rewrite(maestro);

    // Asignar y abrir los archivos de detalles
    for i := 1 to cant_cines do
    begin
        detalleNombre := ruta + 'detalle' + IntToStr(i) + '.dat';
        Assign(detalles[i], detalleNombre);
        Reset(detalles[i]);
        leerDetalle(detalles[i], rDetalle[i]);
    end;

    // Proceso de consolidación de detalles en maestro
    encontrarMinimo(detalles, rDetalle, minDetalle, minIndex);
    while minDetalle.codigo <> 9999 do
    begin
        rMaestro.codigo := minDetalle.codigo;
        rMaestro.nombre := minDetalle.nombre;
        rMaestro.genero := minDetalle.genero;
        rMaestro.director := minDetalle.director;
        rMaestro.duracion := minDetalle.duracion;
        rMaestro.totalAsistentes := 0;

        while (minDetalle.codigo <> 9999) and (rMaestro.codigo = minDetalle.codigo) do
        begin
            rMaestro.totalAsistentes := rMaestro.totalAsistentes + minDetalle.asistentes;
            leerDetalle(detalles[minIndex], rDetalle[minIndex]);
            encontrarMinimo(detalles, rDetalle, minDetalle, minIndex);
        end;

        write(maestro, rMaestro);
    end;

    // Cerrar todos los archivos
    for i := 1 to cant_cines do
    begin
        Close(detalles[i]);
    end;
    Close(maestro);
end;

var
    maestro: archMaestro;
    detalles: arrDetalles;
    ruta: string;
begin
    ruta := ''; // completar con la ruta de los archivos
    generarMaestro(maestro, detalles, ruta);
    writeln('Archivo maestro generado con éxito.');
end.
