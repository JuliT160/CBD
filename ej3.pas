program ej3;


var
    DinosaurName: string;
    DinosaurFile: TextFile;

begin
    Assign(DinosaurFile, 'dinosaurio.txt');
    Rewrite(DinosaurFile);

    repeat
        Write('Ingresa un nombre de dinosaurio (o "zzz" para finalizar): ');
        Readln(DinosaurName);

        if DinosaurName <> 'zzz' then
            Writeln(DinosaurFile, DinosaurName);
    until DinosaurName = 'zzz';

    Close(DinosaurFile);

    WriteLn('Archivo "dinosaurio.txt" creado con exito.');
end.