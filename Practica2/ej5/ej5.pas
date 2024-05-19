{$codepage utf8}
program ej5;

type
    str50 = string[50];

    regPoblacion = record
        partido: str50;
        localidad: str50;
        barrio: str50;
        cantidadNinos: integer;
        cantidadAdultos: integer;
    end;

    archPoblacion = file of regPoblacion;

procedure procesarArchivo(var archivo: archPoblacion);
var
    reg: regPoblacion;
    partidoActual, localidadActual: str50;
    totalNinosPartido, totalAdultosPartido: integer;
    totalNinosLocalidad, totalAdultosLocalidad: integer;

begin
    reset(archivo);
    if not eof(archivo) then
    begin
        read(archivo, reg);
        partidoActual := reg.partido;
        localidadActual := reg.localidad;
        totalNinosPartido := 0;
        totalAdultosPartido := 0;

        while not eof(archivo) do
        begin
            totalNinosLocalidad := 0;
            totalAdultosLocalidad := 0;
            while (not eof(archivo)) and (reg.partido = partidoActual) and (reg.localidad = localidadActual) do
            begin
                totalNinosLocalidad := totalNinosLocalidad + reg.cantidadNinos;
                totalAdultosLocalidad := totalAdultosLocalidad + reg.cantidadAdultos;
                read(archivo, reg);
            end;

            writeln('Localidad: ', localidadActual);
            writeln('Cantidad niños: ', totalNinosLocalidad, '  Cantidad adultos: ', totalAdultosLocalidad);
            writeln('Total niños ', localidadActual, ': ', totalNinosLocalidad, '   Total adultos ', localidadActual, ': ', totalAdultosLocalidad);
            writeln;

            totalNinosPartido := totalNinosPartido + totalNinosLocalidad;
            totalAdultosPartido := totalAdultosPartido + totalAdultosLocalidad;

            if (not eof(archivo)) and (reg.partido = partidoActual) then
            begin
                localidadActual := reg.localidad;
            end
            else if not eof(archivo) then
            begin
                writeln('TOTAL NIÑOS PARTIDO: ', totalNinosPartido, '  TOTAL ADULTOS PARTIDO: ', totalAdultosPartido);
                writeln;
                partidoActual := reg.partido;
                localidadActual := reg.localidad;
                totalNinosPartido := 0;
                totalAdultosPartido := 0;
            end;
        end;

        // Para el último partido y localidad
        writeln('Localidad: ', localidadActual);
        writeln('Cantidad niños: ', totalNinosLocalidad, '    Cantidad adultos: ', totalAdultosLocalidad);
        writeln('Total niños ', localidadActual, ': ', totalNinosLocalidad, '  Total adultos ', localidadActual, ': ', totalAdultosLocalidad);
        writeln;
        writeln('TOTAL NIÑOS PARTIDO: ', totalNinosPartido, '  TOTAL ADULTOS PARTIDO: ', totalAdultosPartido);
    end;
    close(archivo);
end;

// Programa principal
var
    archivo: archPoblacion;
    ruta: string;
begin
    ruta := 'municipios.dat'; // Reemplaza con la ruta correcta del archivo
    assign(archivo, ruta);
    procesarArchivo(archivo);
end.
