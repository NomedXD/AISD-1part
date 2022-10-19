program Lab3V2;

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

Procedure make(Var list1: list; max1: Integer);
Var
  i, data2: Integer;
  cur: list;
Begin
  New(list1);

  cur := list1;

  For i := 0 to max1 do
  Begin
    New(cur^.next);
    cur := cur^.next;

    if cur^.data1 <> max1 - i then
      cur^.data1 := max1 - i;
    Write('Enter coef of x^', max1 - i, ' : ');
    Readln(data2);
    if data2 = 0 then
    begin
      cur^.data1 := 0;
      cur^.data2 := data2
    end
    else
      cur^.data2 := data2;

  End;
  cur^.next := nil;
  Writeln;
End;

Procedure print(Var first: list);
Var
  list1: list;
  fl: Boolean;
Begin
  list1 := first.next;

  write('Y = ');
  While list1 <> nil do
  Begin
    fl := true;

    if (list1.data1 = 0) and (list1.data2 = 0) then
    begin
      write('');
      fl := false;
    end
    else if (list1.data1 = 0) then
      write(list1^.data2)
    else
      write(list1^.data2, 'x^', list1^.data1);

    if (list1.next <> nil) and fl then
      Write(' + ');

    list1 := list1^.next;
  End;

End;

Function Equality(first, second: list): Boolean;
Var
  fl: Boolean;
  list1, list2: list;

Begin
  fl := true;
  Result := true;

  list1 := first.next;
  list2 := second.next;

  while (list1 <> nil) and (list2 <> nil) and fl do
  begin
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
    Writeln('Error. Can not to add this funtions');
    fl := false
  end;
  While (list3 <> nil) and (list1 <> nil) and (list2 <> nil) and fl do
  begin
    New(list3^.next);
    list3 := list3^.next;

    list3.data1 := max1;
    list3.data2 := list1.data2 + list2.data2;

    max1 := max1 - 1;
    list1 := list1.next;
    list2 := list2.next;
  end;
  list3.next := nil;
End;

Procedure Meaning(first: list; x: Integer);
Var
  list1: list;
Begin
  list1 := first^.next;
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
  Write('Enter max degree of function: ');
  Readln(max1);
  make(first, max1);
  Write('Enter max degree of function: ');
  Readln(max2);
  make(second, max2);
  Writeln('-------------------------------------');

  Writeln('first function look like');
  print(first);
  Writeln;
  Writeln('second function look like');
  print(second);
  Writeln;
  Writeln('-------------------------------------');

  If Equality(first, second) then
    Writeln('Functions are equal')
  else
    Writeln('Functions are NOT equal');
  Writeln('-------------------------------------');

  Add(third, first, second, max1, max2);
  Writeln('Result func of adding functions is ');
  print(third);
  Writeln;
  Writeln('-------------------------------------');

  Write('x to calculate = ');
  Readln(x);
  if x <> 0 then
  begin
    Writeln;
    Write('Choose func to calculate (1/2) : ');
    Readln(i);
    if i = 1 then
      Meaning(first, x)
    else if i = 2 then
      Meaning(second, x)
    else
      Write('Error. Incorrect input');
  end
  else
    Write('Sorry. Delphi can not calculate zero situation');
  Readln;

End.
