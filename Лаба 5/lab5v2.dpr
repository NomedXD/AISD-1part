program lab5v2;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;


var
  Stack: array of char;
  InputStr: string;
  len, index, k, i: integer;
  StackPrIn, OtnPrIn, StackPrSt, OtnPrSt: integer;
  outputStr: string;
  Letters: set of Char;
  Characters: set of Char;

// Осуществляем поиск значения относительного или
// стекового приоритета символа
procedure GetPriority(s: char; var StackPriotiry, OtnPriotiry: integer);
var
  StackPriotiryProc, OtnPriotiryProc: integer;
begin
  case s of
    '+', '-':
      begin
        StackPriotiryProc := 2;
        OtnPriotiryProc := 1;
      end;
    '*', '/':
      begin
        StackPriotiryProc := 4;
        OtnPriotiryProc := 3;
      end;
    '^':
      begin
        StackPriotiryProc := 5;
        OtnPriotiryProc := 6;
      end;
    'A' .. 'Z', 'a' .. 'z':
      begin
        StackPriotiryProc := 8;
        OtnPriotiryProc := 7;
      end;
    '(':
      begin
        StackPriotiryProc := 0;
        OtnPriotiryProc := 9;
      end;
    ')':
      begin
        StackPriotiryProc := -1;
        OtnPriotiryProc := 0;
      end;
  end;
  StackPriotiry := StackPriotiryProc;
  OtnPriotiry := OtnPriotiryProc;

end;

begin
  outputStr := '';
  Writeln('Введите ваше выражение: ');
  Readln(InputStr);

  // Устанавливаем длину динамического массива равной длине всего выражения
  len := length(InputStr);
  Setlength(Stack, len);

  // Сдвигаем индекс на первое свободное местов в стеке
  // А именно на последний индекс массива то есть = длина строки-1
  index := len - 1;
  // индекс символа строки
  k := 1;
  // записываем первый символ в стек отдельно
  Stack[index] := InputStr[k];
  // сдвигаем строковый индекс вправо
  // и стековый индекс влево
  k := 2;
  index := index - 1;

  // создаем множества
  Letters:=['A'..'Z','a'..'z'];
  Characters:=['+','-','*','/','^'];

  // Цикл для прохода по каждому элементу строки
  while k <> length(InputStr)+1 do
  begin
    // Ищем приоритеты входного и "последнего" символа
    GetPriority(InputStr[k], StackPrIn, OtnPrIn);
    GetPriority(Stack[index + 1], StackPrSt, OtnPrSt);
    // Если попалось все кроме скобки...
    if InputStr[k] <> ')' then
    begin
      // Если входящий отн приоритет выше стекового
      // или мы находимся в начале стека, то помещаем элемент наверх стека
      if (OtnPrIn > StackPrSt) or (index+1=length(Stack)) then
      begin
        Stack[index] := InputStr[k];
        // Сдвигаем индекс стека на свободное место
        index := index - 1;
        // Сдвигаем строковый индекс на след элемент
        k := k + 1;
      end
      else
      begin
          // Если входящий приор. ниже и мы не достигли конца стека, то...
          while (OtnPrIn <= StackPrSt) and (index+1<>length(Stack)) do
          begin
            // Записываем верхний элемент стека в выводимую строку
            outputStr := outputStr + Stack[index + 1];
            // Сдвигаем индекс стека вниз для проверки следующего элемента стека
            index := index + 1;
            { Ищем приоритет следующего элемента стека. Замечание:
              Так как выполняется в условии цикла защита от конца стека
              то неважно даже то, что в результате работы следующей
              процедуры в выходные параметры могут записаться данные
              из неопределенной части памяти, так как на следующей итерации
              будет осуществлен выход из цикла и значения приоритетов
              будут переприсвоены :))))) }
            GetPriority(Stack[index + 1], StackPrSt, OtnPrSt);
          end;
          // Записываем элемент на найденное подходящее место
          Stack[index]:=InputStr[k];
          // Сдвигаем все индексы как обычно
          index:=index-1;
          k := k + 1;

      end;
    end
    else
    begin
      // Если все же найдена закрывающая скобка. то выталкиваем содержимое стека
      while Stack[index+1]<>'(' do
      begin
        outputStr := outputStr + Stack[index + 1];
        index := index + 1;
      end;
      if Stack[index+1]='(' then
      begin
        // А также не забываем переместить индекс на индекс открывающей скобки
        // как будто это место освободилось
        index := index + 1;
      end;
      k:=k+1;
    end;

  end;
  // Если остались еще элементы в стеке, выталкиваем их
  if index+1<>length(Stack) then
  begin
    while index+1<>length(Stack) do
    begin
      outPutStr:= outPutStr+Stack[index+1];
      // Не забываем про индекс
      index:=index+1;
    end;

  end;
  Writeln('Ваша обратная польская запись: ');
  writeln(outputStr);

  // Считаем ранг получившегося выражения
  k:=0;
  for I := 1 to length(outputStr) do
  begin
    if outputStr[i] in Letters then
    begin
      k:=k+1;
    end;
    if outputStr[i] in Characters then
    begin
      k:=k-1;
    end;

  end;
  // Соответствующие сообщения о ранге
  { Замечание: Проверять ранг начального выражения не имеет смысла, так как
    оно может быть записано как aaa**, что с точки зрения ранга будет верным }
  if k=1 then
  begin
    Writeln('Ваше выражение является правильным изначально, его ранг равен и ранг обратной польской записи: ');
    writeln(k);
  end
  else
  begin
    Writeln('Ваше выражение неверное изначально, так как ранг обратной польской записи равен: ');
    writeln(k);
  end;

  readln;
end.
