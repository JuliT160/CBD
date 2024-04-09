{Una zapatería cuenta con 20 locales de ventas. Cada local de ventas envía un listado
con los calzados vendidos indicando: código de calzado, número y cantidad vendida
del mismo.
El archivo maestro almacena la información de cada uno de los calzados que se
venden, para ello se registra el código de calzado, número, descripción, precio unitario,
color, el stock de cada producto y el stock mínimo.
Escriba el programa principal con la declaración de tipos necesaria y realice un
proceso que reciba los 20 detalles y actualice el archivo maestro con la información
proveniente de los archivos detalle. Tanto el maestro como los detalles se encuentran
ordenados por el código de calzado y el número.
Además, se deberá informar qué calzados no tuvieron ventas y cuáles quedaron por
debajo del stock mínimo. Los calzados sin ventas se informan por pantalla, mientras
que los calzados que quedaron por debajo del stock mínimo se deben informar en un
archivo de texto llamado calzadosinstock.txt.
Nota: tenga en cuenta que no se realizan ventas si no se posee stock.}

//Hay que usar de la algoritmica clasica el ejemplo Un maestro y N detalles
program ej3;

type
  zapato = record
    codigo: integer;
    numero: integer;
    descripcion: string;
    precio: real;
    color: string;
    stock: integer;
    stock_min: integer;
  end;

  vendidos = record
    codigo: integer;
    numero: integer;
    cantidad: integer;
  end;

  maestro = file of zapato;
  detalle = file of vendidos;

procedure leer(var archivo: detalle; var dato: vendidos);
begin
  if not eof(archivo) then
    read(archivo, dato)
  else
    dato.codigo := 9999; //Valor alto de corte
end;

procedure minimo(var r1, r2, r3, r4, r5, r6, r7, r8, r9)

begin
  
end.