program lab1;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

type
  link = ^List;

  List = record
    number: string;
    left: link;
    right: link;
  end;

var
  beg2L, beg2newL, lastlink: link;
  k: integer;

procedure addelementlist1;
var
  add: link;
begin
  new(add);
  add^.left := nil;
  add^.right := nil;
  writeln('Введите номер телефона,который нужно добавить');
  repeat
    readln(add^.number);
    if (length(add^.number) <> 3) and (length(add^.number) <> 7) then
    begin
      writeln('Вы ввели неверный номер телефона, введите верный');
    end;

  until (length(add^.number) = 3) or (length(add^.number) = 7);
  if (beg2L = nil) then
  begin
    beg2L := add;
  end
  else
  begin
    add^.right := beg2L;
    beg2L^.left := add;
    beg2L := add;
  end;

end;

procedure addelementlist2(const str: string);
var
  add: link;
begin
  new(add);
  if (beg2newL = nil) then
  begin
    beg2newL := add;
    add^.number := str;
  end
  else
  begin
    add^.right := beg2newL;
    beg2newL := add;
    add^.number := str;
  end;
end;

procedure findlastlink(var lastlink1: link);
var
  last: link;
begin
  last := beg2L;
  while last^.right <> nil do
  begin
    last := last^.right;
  end;
  lastlink1 := last;
end;

procedure poisk(lastlink1: link);
begin
  while (lastlink1 <> nil) do
  begin
    if length(lastlink1^.number) = 7 then
    begin
      addelementlist2(lastlink1^.number);
    end;
    lastlink1 := lastlink1^.left;
  end;
end;

procedure vivod(beg2newLProc: link);
begin
  while (beg2newLProc <> nil) do
  begin
    writeln(beg2newLProc^.number);
    beg2newLProc := beg2newLProc^.right;
  end;

end;

begin

  repeat
    writeln('Ввести новый элемент? (1-если да,0-если нет)');
    readln(k);
    if k = 1 then
    begin
      addelementlist1;
    end;
  until k = 0;
  findlastlink(lastlink);
  poisk(lastlink);
  writeln('Ваши номера: ');
  try
    vivod(beg2newL);
  except
  end;
  readln;

end.
