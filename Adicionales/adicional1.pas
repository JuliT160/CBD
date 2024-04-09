{Se desea manejar un archivo con información de profesionales de una clínica. Se sabe que el archivo utiliza la técnica de lista
invertida para aprovechamiento de espacio. Es decir las bajas se realizan apilando registros borrados y las altas reutilizando
registros borrados. El registro en la posición 0 del archivo se usa como cabecera de la pila de registros borrados.}
program adicional1;

type
  profesional = record
    dni: integer;
    nombre: string;
    apellido: string;
    sueldo: real;
  end;

  tArchivo = file of profesional;

procedure Crear(var archivo: tArchivo; var info: text);
var
  p: profesional;
begin
    Reset(info);
    Rewrite(archivo);
    p.dni := 0;
    Write(archivo, p);
    while not eof(info) do begin
        Readln(info, p.dni, p.nombre, p.sueldo);
        ReadLn(info, p.apellido);
        Write(archivo, p);
    end;
    Close(archivo);
    Close(info);
end;

procedure Agregar(var arch: tArchivo; p: profesional);
var
  aux, cabecera: profesional;

begin
    Reset(arch);
    Read(arch, cabecera);
    if (cabecera.dni <> 0 ) then 
    begin
        Seek(arch, - cabecera.dni); //no tengo idea porque el menos
        Read(arch, aux);
        Seek(arch, 0);
        write(arch, aux);
        Seek(arch, - cabecera.dni);
    end
    else
        Seek(arch, FileSize(arch));
    Write(arch, p);
    Close(arch);
end;

procedure Eliminar(var arch: tArchivo; dni: integer; var bajas: text);
var
  p, cabecera: profesional;

begin
    Reset(arch);
    Reset(bajas);
    Read(arch, p);
    Read(arch, cabecera); //qsy si va esto no lei bien

    while (not eof(arch)) and (p.dni <> dni) do
        Read(arch, p);
    if (p.dni = dni) then
    begin
        Seek(arch, FilePos(arch) - 1);
        Write(arch, cabecera);
        cabecera.dni := FilePos(arch) * (-1);
        Seek(arch, 0);
        Write(arch, cabecera);
        WriteLn(bajas, p.dni, p.nombre, p.sueldo);
        WriteLn(bajas, p.apellido);
    end
    else
        WriteLn('No se encontro el profesional');
    Close(arch);
    Close(bajas);
end;

begin
  
end.