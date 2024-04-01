program ej1;
{
El área de recursos humanos de un ministerio administra el personal del mismo
distribuido en 10 direcciones generales.
Entre otras funciones, recibe periódicamente un archivo detalle de cada una de las
direcciones conteniendo información de las licencias solicitadas por el personal.
Cada archivo detalle contiene información que indica: código de empleado, la fecha y
la cantidad de días de licencia solicitadas. El archivo maestro tiene información de
cada empleado: código de empleado, nombre y apellido, fecha de nacimiento,
dirección, cantidad de hijos, teléfono, cantidad de días que le corresponden de
vacaciones en ese periodo. Tanto el maestro como los detalles están ordenados por
código de empleado. Escriba el programa principal con la declaración de tipos
necesaria y realice un proceso que reciba los detalles y actualice el archivo maestro
con la información proveniente de los archivos detalles. Se debe actualizar la cantidad
de días que le restan de vacaciones. Si el empleado tiene menos días de los que
solicita deberá informarse en un archivo de texto indicando: código de empleado,
nombre y apellido, cantidad de días que tiene y cantidad de días que solicita
}

type
    empleado = record
        codigo: integer;
        nombre: string;
        apellido: string;
        fechaNacimiento: string;
        direccion: string;
        hijos: integer;
        telefono: string;
        diasVacaciones: integer;
    end;

    licencia = record
        codigo: integer;
        fecha: string;
        dias: integer;
    end;

    detalle = file of licencia;
    maestro = file of empleado;

procedure leer(var archivo: detalle; var dato: licencia);
begin
    if not eof(archivo) then
        read(archivo, dato);
end;

procedure leer(var archivo: maestro; var dato: empleado);
begin
    if not eof(archivo) then
        read(archivo, dato);
end;

procedure actualizarMaestro(var maestro: maestro; var detalle: detalle);
var
    regMaestro: empleado;
    regDetalle: licencia;
    diasRestantes: integer;
    texto: Text;
begin
    reset(maestro);
    reset(detalle);
    leer(maestro, regMaestro);
    leer(detalle, regDetalle);
    while (not eof(maestro)) and (not eof(detalle)) do
    begin
        if (regMaestro.codigo = regDetalle.codigo) then 
        begin
            diasRestantes := regMaestro.diasVacaciones - regDetalle.dias;
            if (diasRestantes >= 0) then
            begin
                regMaestro.diasVacaciones := diasRestantes;
                seek(maestro, filepos(maestro) - 1); // Actualizar el registro del maestro 
                write(maestro, regMaestro);
            end
            else
            begin  // Informar en un archivo de texto el empleado que no tiene suficientes dias de vacaciones
                assign(texto, 'licencias.txt');
                rewrite(texto);
                writeln(texto, 'Codigo de empleado: ', regMaestro.codigo);
                writeln(texto, 'Nombre y apellido: ', regMaestro.nombre, ' ', regMaestro.apellido);
                writeln(texto, 'Cantidad de dias que tiene: ', regMaestro.diasVacaciones);
                writeln(texto, 'Cantidad de dias que solicita: ', regDetalle.dias);
                close(texto);
            end;
            leer(maestro, regMaestro);
            leer(detalle, regDetalle);
        end
        else
        begin
            if (regMaestro.codigo < regDetalle.codigo) then
                leer(maestro, regMaestro)
            else
                leer(detalle, regDetalle);
        end;
    end;
    close(maestro);
    close(detalle);
end;

var
    maestro: maestro;
    detalle: detalle;

begin
    assign(maestro, 'maestro.dat');
    assign(detalle, 'detalle.dat');
    actualizarMaestro(maestro, detalle);

end.