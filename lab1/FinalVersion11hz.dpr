program FinalVersion11hz;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

type
  link = ^List; // Ссылка на элемент двунаправленного списка

  // Запись-элемент двунаправленного списка
  List = record
    number: string;
    left: link;
    right: link;
  end;

  link2 = ^List2; // Ссылка на элемент однонаправленного списка

  // Запись-элемент однонаправленного списка
  List2 = record
    number: string;
    right: link2;
  end;

var
  beg2L, end2L: link;
  k, i: integer;
  N: integer;
  Mas: array of integer;
  beg2newL, end2newL: link2;

  { Процедура создает каждый новый элемент
    в двунаправленном списке и добавляет туда все
    подходящие номера }
procedure addelementlist1(var first, last: link);
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
  if (first = nil) then
  begin
    first := add;
    last := add;
  end
  else
  begin
    last^.right := add;
    add^.left := last;
    last := add;

  end;

end;

procedure addelementlist2(first: link; var first2LProc, last2LProc: link2;
  var count: integer);
var
  add: link2;
begin
  while first <> nil do
  begin
    if length(first^.number) = 7 then
    begin
      new(add);
      add^.right := nil;
      if (first2LProc = nil) then
      begin
        first2LProc := add;
        last2LProc := add;
        add^.number := first^.number;
      end
      else
      begin
        last2LProc^.right := add;
        last2LProc := add;
        add^.number := first^.number;
      end;
      count := count + 1;
    end;
    first := first^.right;
  end;
end;

// Вывод элементов из однонаправленного списка
procedure vivod(LastLProc: link);
begin
  while (LastLProc <> nil) do
  begin
    writeln(LastLProc^.number);
    LastLProc := LastLProc^.left;
  end;

end;

procedure vivod2(firstLProc: link2);
begin
  while (firstLProc <> nil) do
  begin
    writeln(firstLProc^.number);
    firstLProc := firstLProc^.right;
  end;

end;

procedure sort(kol: integer; first2LProc: link2);
var
  i, j: integer;
  ref: link2;
  temp: string;
begin
  ref := first2LProc;
  for i := 1 to kol - 1 do
  begin
    for j := 1 to kol - i do
    begin
      if StrToInt(first2LProc^.number) > StrToInt(first2LProc^.right^.number)
      then
      begin
        temp := first2LProc^.number;
        first2LProc^.number := first2LProc^.right^.number;
        first2LProc^.right^.number := temp;
      end;
      first2LProc := first2LProc^.right;
    end;
    first2LProc := ref;
  end;
end;

begin
  N := 0;
  repeat
    writeln('Ввести новый элемент? (1-если да,0-если нет)');
    readln(k);
    if k = 1 then
    begin
      addelementlist1(beg2L, end2L);
    end;
  until k = 0;
  writeln('Ваши элементы в обратном порядке ');
  vivod(end2L);
  writeln;
  addelementlist2(beg2L, beg2newL, end2newL, N);

  sort(N, beg2newL);
  writeln('Семизначные номера в порядке возрастания');
  vivod2(beg2newL);

  sleep(20000000);

end.
