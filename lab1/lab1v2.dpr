program lab1v2;

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
  beg2L, lastlink: link;
  k, i: integer;
  N: integer;
  Mas: array of integer;
  beg2newL, beg3newL: link2;

  { Процедура создает каждый новый элемент
    в двунаправленном списке и добавляет туда все
    подходящие номера }
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

{ Процедура создает каждый новый элемент однонаправленного списка
  и добавляет туда элементы при обратном прочтении двунаправленного списка
  для дальнейшего вывода всех элементов в обратном порядке.
  Замечание:можно было сразу добавлять все элементы в конец, тогда
  при прочтении с заднего элемента, можно было бы сразу выводить }
procedure addelementlist2(const str: string);
var
  add: link2;
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

// Поиск ссылки на последний элемент в двунаправленном списке
procedure findlastlink(var lastlink1: link);
var
  first: link;
begin
  first := beg2L;
  while first^.right <> nil do
  begin
    first := first^.right;
  end;
  lastlink1 := first;
end;

{ Чтение двунаправленного списка задом наперед и формирование на его основе
  однонаправленного списка }
procedure addingelemtolist2(Start: link);
begin
  while (Start <> nil) do
  begin

    addelementlist2(Start^.number);
    Start := Start^.left;
  end;
end;

// Вывод элементов из однонаправленного списка
procedure vivod(beg2newLProc: link2);
begin
  while (beg2newLProc <> nil) do
  begin
    writeln(beg2newLProc^.number);
    beg2newLProc := beg2newLProc^.right;
  end;

end;

// Перенос элементов однонаправленного списка в массив для сортировки
procedure AddToArray(first: link; var N: integer);
begin
  while first <> nil do
  begin
    if (length(first^.number) = 7) then
    begin
      SetLength(Mas, N + 1);
      Mas[N] := strtoint(first^.number);
      N := N + 1;

    end;
    first := first^.right;

  end;

end;

// Сортировка массива
procedure Sort(var Arr: array of integer);
var
  i, j, min, swap: integer;
begin
  swap := 0;
  min := 0;
  for i := 0 to N - 2 do
  begin
    min := i;
    for j := i + 1 to N - 1 do
    begin
      if Arr[j] < Arr[min] then
      begin
        min := j;
      end;
    end;
    swap := Arr[i];
    Arr[i] := Arr[min];
    Arr[min] := swap;
  end;

end;

// Перенос отсортированных элементов в новый список в порядке возрастания для
// дальнейшего вывода на экран
procedure AddElementFromArr(const str: string);
var
  add: link2;
begin
  new(add);
  if (beg3newL = nil) then
  begin
    beg3newL := add;
    add^.number := str;
  end
  else
  begin
    add^.right := beg3newL;
    beg3newL := add;
    add^.number := str;
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
  addingelemtolist2(lastlink);

  N := 0;
  AddToArray(beg2L, N);
  Sort(Mas);
  for i := N - 1 downto 0 do
  begin
    AddElementFromArr(inttostr(Mas[i]));
  end;

  try
    writeln;
    writeln('Ваши семизначные номера в порядке возрастания');
    vivod(beg3newL);
  except
  end;

  try
    writeln;
    writeln('Все Ваши номера в обратном порядке ввода: ');
    vivod(beg2newL);
  except
  end;
  readln;

end.
