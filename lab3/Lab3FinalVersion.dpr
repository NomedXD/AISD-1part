program Lab3FinalVersion;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

Type
  list = ^elem;

  elem = Record
    data1, data2: Integer;
    next: list;
  End;

Var
  first, second, third: list;
  i, max1, max2, data1, data2, x: Integer;
  Result: Real;
  Equal: Boolean;

{ Процедура создания списка. В качестве параметров извлекаем ссылки на
  первые элементы каждого списка(всего 2+1), а также максимальная степень
  многочлена }
Procedure make(Var list1: list; max1: Integer);
Var
  i, data2: Integer;
  cur: list;
Begin
  // Заголовок
  New(list1);
  // Ссылка на заголовок для работы внутри процедуры
  cur := list1;
  // заполняем каждый элемент списка данными(коэффициент при x)
  For i := 0 to max1 do
  Begin
    New(cur^.next);
    cur := cur^.next;

    if cur^.data1 <> max1 - i then
      cur^.data1 := max1 - i;
    Write('Введите коэффициент при x^', max1 - i, ' : ');
    Readln(data2);
    // если коэффициент равен 0, то, "убираем" из списка этот элемент
    if data2 = 0 then
    begin
      cur^.data1 := 0;
      cur^.data2 := data2
    end
    else
      cur^.data2 := data2;

  End;
  // на всякий случай пишем nil(т к внутри подпрограммы эта ссылка изначально
  // будет хранить неопределенное значение)
  cur^.next := nil;
  Writeln;
End;

// Вывод списка
Procedure print(Var first: list);
Var
  list1: list;
  fl: Boolean;
Begin
  // Переход с заголовка на первый элемент
  list1 := first.next;

  write('Y(Многочлен) = ');
  // Выводим, пока не достигли "нулевой" ссылки
  While list1 <> nil do
  Begin
    fl := true;
    // Если оба нуля, то не выводим этот элемент
    if (list1.data1 = 0) and (list1.data2 = 0) then
    begin
      write('');
      fl := false;
    end
    // Если степень 0 - то просто число
    else if (list1.data1 = 0) then
      write(list1^.data2)
    else
      // Обычный вывод
      write(list1^.data2, 'x^', list1^.data1);

    if (list1.next <> nil) and fl then
      Write(' + ');

    list1 := list1^.next;
  End;

End;

{ Функция проверяет на равенство 2 многочлена. Два многочлена являются равными,
  если равны как коэффициенты при x, так и степени соответствующих x. В качестве
  параметров передаются(параметры занчения) ссылки на заголовки двух списков }
Function Equality(first, second: list): Boolean;
Var
  fl: Boolean;
  list1, list2: list;

Begin
  // Чтобы раньше выйти из цикла вводим флаг
  fl := true;
  Result := true;

  list1 := first.next;
  list2 := second.next;
  // Сама проверка
  while (list1 <> nil) and (list2 <> nil) and fl do
  begin
    // Сравнение обоих полей
    if (list1^.data1 = list2^.data1) and (list1.data2 = list2.data2) then
    begin
      list1 := list1^.next;
      list2 := list2^.next;
    end
    else
    begin
      fl := false;
      Result := false;
    end;
  end;

End;

{ Процедура складывает 2 многочлена. В качестве параметров передаются(параметры
 переменные) ссылки на заголовки 2 списков(многочленов), а также сохраняется
 ссылка на новый многочлен-сумму через третий параметр ссылку. Также передается
 Максимальная степень обоих многочленов для проверки возможности сложение}
Procedure Add(Var third, first, second: list; max1, max2: Integer);
Var
  list1, list2, list3: list;
  fl: Boolean;

Begin
  fl := true;
  New(list3);
  list1 := first.next;
  list2 := second.next;
  third := list3;
  if max1 <> max2 then
  begin
    Writeln('Упс. Такие многочлены нельзя сложить. Внимательно посмотри на степени :)');
    fl := false
  end;
  // Если степени равны, то nil будет достигнут в обоих списках в одинаковый момент
  While (list3 <> nil) and (list1 <> nil) and (list2 <> nil) and fl do
  begin
    // Создание элемента под новый многочлен
    New(list3^.next);
    list3 := list3^.next;
    // Заполнение полей нового многочлена(степень+сумма коэффициентов)
    list3.data1 := max1;
    list3.data2 := list1.data2 + list2.data2;
    // Уменьшим коэффициент(текущую степень) на 1, чтобы сложить следующую степень
    max1 := max1 - 1;
    // Перейдем на следующие элементы в списках(следующий коэффициент и x)
    list1 := list1.next;
    list2 := list2.next;
  end;
  list3.next := nil;
End;

// Подсчет значение многочлена при определенном x
Procedure Meaning(first: list; x: Integer);
Var
  list1: list;
Begin
  list1 := first^.next;
  { Данный подсчет представляет собой проход по всем элементам и подстановку x
    в выражение вида data2(k)*x^data1(степень) и суммирование этого в переменной}
  while list1 <> nil do
  begin
    if list1.data1 <> 0 then
      Result := Result + (Exp(ln(x) * list1^.data1) * list1^.data2)
    else
      Result := Result + (1 * list1^.data2);

    list1 := list1^.next;
  end;
  Writeln('Result = ', Result:0:2);
end;

Begin
  Write('Введите максимальную степень одного из многочленов: ');
  Readln(max1);
  make(first, max1);
  Write('Введите максимальную степень одного из многочленов: ');
  Readln(max2);
  make(second, max2);
  Writeln('');

  Writeln('Первый многочлен выглядит так:');
  print(first);
  Writeln;
  Writeln('Второй многочлен выглядит так:');
  print(second);
  Writeln;
  Writeln('');

  If Equality(first, second) then
    Writeln('Многочлены эквивалентны')
  else
    Writeln('Многочлены не эквивалентны');
  Writeln('');

  Add(third, first, second, max1, max2);
  Writeln('Сумма двух многочленов равна: ');
  print(third);
  Writeln;
  Writeln('');

  Writeln('Введите x, чтобы посчитать значение одного из многочленов');
  Readln(x);
  if x <> 0 then
  begin
    Writeln;
    Write('Выберите, какой многочлен посчитать(1 или 2): ');
    Readln(i);
    if i = 1 then
      Meaning(first, x)
    else if i = 2 then
      Meaning(second, x)
    else
      Write('Ошибка, неверный ввод :)');
  end
  else
    Write('Нельзя посчитать с 0');
  Readln;

End.
