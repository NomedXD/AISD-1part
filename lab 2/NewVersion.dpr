program NewVersion;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

type
  point = ^elem;
  elem = record
    data: Integer;
    next: point;
  end;

var
  allcases, k, amount, NumberOfKick: Integer;
  currentNess: point;
  ResOut: String;
  { allcases - количество, дл€ который провер€ем(1 to 64)
    k - текущий провер€емый номер(после удалени€ оп€ть единица)
    amount - оставшеес€ количество в ходе удалений
    NumberOfKick - вводимый номер удал€емого человека
    currentNess - текуща€ позицици€ указател€ в ходе удалений
    ResOut - выводима€ строка(всегда в конце присваеваем '' т к максимум 256 }

procedure MakeSpisok(var elempointer: point; n: Integer);
var
  i: Integer;
  first: point;
begin
  // —оздание первого элемента списка и присвоение его полю единицы
  New(elempointer);
  // ”казатель ставим на первый элемент
  first := elempointer;
  first^.data := 1;
  // ƒобавл€ем остальное количество элементов
  for i := 2 to n do
  begin
    New(elempointer^.next);
    elempointer := elempointer^.next;
    elempointer^.data := i;
  end;
  elempointer^.next := first;
  elempointer := first;
end;

procedure FindToDelete (var current, numberkick: Integer; var StrOut: String; var elempointer: point);
begin
  // ќтсчитываем нужное количество от единицы, чтобы удалить из круга
  while current < numberkick do
  begin
    // ≈сли следующие это тот, кого нужно выкинуть, то выписываем его номер
    // и передвигаемс€ на этот же номер, чтобы закончить цикл проверки
    if current + 1 = numberkick then
    begin
      StrOut := StrOut + IntToStr(elempointer^.next^.data) + ',';
      current := numberkick;
    end
    else
    // ¬ противном случае передвигаемс€ дальше по списку и увеличиваем номер
    // удал€емого, пока не достигнем нужного (current +1)
    begin
      inc(current);
      elempointer := elempointer^.next;
    end;
  end;
end;

// –азрываем св€зь между тикущим элементом и следующим,
// путем присваивани€ адреса 3-го элемента перворму через
// одно из полей удал€емого элемента
procedure DeleteElem(var elempointer: point);
begin
  elempointer^.next := elempointer^.next^.next;
end;

// Ёт  просто выпендрилась, но здесь € удал€ю последнюю зап€тую в конце р€д€
// которые циклом ставлю и вывожу последний оставшийс€ элемент списка, а после все очищаю
procedure ResOutput (var S: String; var elempointer: point);
begin
  writeln;
  S := ResOut + '| осталс€ человек с номером:' + IntToStr(elempointer^.data);
  writeln(S);
  S := '';
end;

begin
  write('¬веди номер удал€емого ');

  // ¬вод номера удал€емого и начало цикла дл€ всех случаев от 1 до 64
  readln(NumberOfKick);
  for allcases := 1 to 64 do
  begin
    // —оздаем список из к-ва человек от 1 до 64
    amount := allcases;
    MakeSpisok(currentNess, allcases);

    writeln;
    writeln('≈сли дано ', allcases, ' детей');
    write('”даленный р€д: ');

    // ѕока не останетс€ один человек
    while amount <> 1 do
    begin
      // ѕосле каждого удалени€ начинаем нумерацию с 1 и отсчитываем п€того
      // человека
      k := 1;
      FindToDelete(k, NumberOfKick, ResOut, currentNess);
      DeleteElem(currentNess);

      // ѕосле удаление сдвигаемс€ на место удаленного, чтобы начать считать
      // уже с него
      currentNess := currentNess^.next;

      // ”меньшеаем количество оставшихс€ в кругу
      dec(amount);
    end;
    ResOutput(ResOut,currentNess);

    // ќчистка пам€ти
    currentNess := nil;
  end;
  readln;

end.
