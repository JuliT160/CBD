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

  detalles = array[1..20] of detalle;
  resto = array[1..20] of vendidos;



procedure leer(var archivo: detalle; var dato: vendidos);
begin
  if not eof(archivo) then
    read(archivo, dato)
  else
    dato.codigo := 9999; //Valor alto de corte
end;

procedure minimo(var det: detalles; var min: vendidos; var r: resto);
var 
   posMin, i : integer;
begin
  min := r[1]; 
  posMin:= 1; 
  for i:= 2 to 17 do begin
    if (r[i].codigo < min.codigo) then begin
      min:= r[i];
      posMin:= i;
    end
    else if (r[i].codigo = min.codigo) and (r[i].numero < min.numero) then begin
      min:= r[i];
      posMin:= i;
    end;
  end;
  leer(det[posMin], r[posMin]);
end;

procedure actualizar(var det: detalles; var m: maestro; var sinStock: text);
var 
  regm: zapato;
  min: vendidos;
  i: integer;
  res: resto;
begin
  for i:= 1 to 20 do begin
    leer(det[i], res[i]);
  end;
  reset(m);
  minimo(det, min, res);
  while(min.codigo <> 9999) do
  begin

    while(min.codigo < regm.codigo) And (min.numero < regm.numero) do
    begin
      writeln('Calzado sin ventas: ', regm.codigo, ' Numero: ', regm.numero);
      read(m, regm);
    end;
    
    while(min.codigo = regm.codigo) and (min.numero = regm.numero) and (min.codigo <> 9999) do
    begin
      regm.stock:= regm.stock - min.cantidad;
      if regm.stock < regm.stock_min then
        writeln(sinStock, 'Codigo: ', regm.codigo, ' Numero: ', regm.numero);
      minimo(det, min, res);
    end;
    Seek(m, FilePos(m)-1);
    write(m, regm);
    end;
  Close(m);
  for i:= 1 to 20 do
    Close(det[i]);

end;



//Programa principal

var 
  m: maestro; 
  det: detalles;
  nombreArchi: string; 
  i: integer;
  sinStock: text;

begin
  assign(m, 'maestro.dat');
  assign(sinStock, 'calzadosinstock.txt');
  rewrite(sinStock);

  for i:= 1 to 20 do begin
    assign(det[i], 'detalle.dat');  //intToStr no funciona buscar otra forma
    reset(det[i]);
  end;
  actualizar(det, m, sinStock);
  close(sinStock);
end.