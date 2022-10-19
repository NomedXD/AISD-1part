program lab1v2v1;

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
  N:integer;
  Mas:array of integer;

procedure addelementlist1;
var
  add: link;
begin
  new(add);
  add^.left := nil;
  add^.right := nil;
  writeln('������� ����� ��������,������� ����� ��������');
  repeat
    readln(add^.number);
    if (length(add^.number) <> 3) and (length(add^.number) <> 7) then
    begin
      writeln('�� ����� �������� ����� ��������, ������� ������');
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
  first: link;
begin
  first := beg2L;
  while first^.right <> nil do
  begin
    first := first^.right;
  end;
  lastlink1 := first;
end;

procedure vivod1(lastlink1: link);
begin
  while (lastlink1 <> nil) do
  begin

    addelementlist2(lastlink1^.number);
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

procedure AddToArray(first:link;  var N:integer);
begin
  while first<>nil do
  begin
    if (length(first^.number)=7) then
    begin
      SetLength(Mas,N+1);
      Mas[n]:=strtoint( first^.number);
      N:=N+1;

    end;
    first:=first^.right;

  end;
end;

procedure SortArray(Arr:array of integer);
var
  i,j:integer;
  min,swap:integer;
begin
  for i := 0 to N-1 do
    begin
      min:=i;
      for j := i+1 to N do
      begin
        if Arr[j]<Arr[min] then
        begin
          min:=j;
        end;
      end;
      swap:=Arr[min];
      Arr[min]:=Arr[i];
      Arr[i]:=swap;
    end;
end;

procedure outputMas(Arr:array of integer);
var
  i:integer;
begin
  writeln('���� ������ � ��������������� �������(�� �����������)');
  for i := 0 to N do
  begin
    writeln(Arr[i]);
  end;
end;

begin

  repeat
    writeln('������ ����� �������? (1-���� ��,0-���� ���)');
    readln(k);
    if k = 1 then
    begin
      addelementlist1;
    end;
  until k = 0;
  findlastlink(lastlink);
  vivod1(lastlink);



  N:=0;
  AddToArray(beg2L,N);

 { SortArray(Mas);
  outputMas(Mas); }

  writeln('���� ������: ');
  try
    vivod(beg2newL);
  except
  end;
  readln;


end.
