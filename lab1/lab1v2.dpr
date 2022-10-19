program lab1v2;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

type
  link = ^List; // ������ �� ������� ���������������� ������

  // ������-������� ���������������� ������
  List = record
    number: string;
    left: link;
    right: link;
  end;

  link2 = ^List2; // ������ �� ������� ����������������� ������

  // ������-������� ����������������� ������
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

  { ��������� ������� ������ ����� �������
    � ��������������� ������ � ��������� ���� ���
    ���������� ������ }
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

{ ��������� ������� ������ ����� ������� ����������������� ������
  � ��������� ���� �������� ��� �������� ��������� ���������������� ������
  ��� ����������� ������ ���� ��������� � �������� �������.
  ���������:����� ���� ����� ��������� ��� �������� � �����, �����
  ��� ��������� � ������� ��������, ����� ���� �� ����� �������� }
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

// ����� ������ �� ��������� ������� � ��������������� ������
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

{ ������ ���������������� ������ ����� ������� � ������������ �� ��� ������
  ����������������� ������ }
procedure addingelemtolist2(Start: link);
begin
  while (Start <> nil) do
  begin

    addelementlist2(Start^.number);
    Start := Start^.left;
  end;
end;

// ����� ��������� �� ����������������� ������
procedure vivod(beg2newLProc: link2);
begin
  while (beg2newLProc <> nil) do
  begin
    writeln(beg2newLProc^.number);
    beg2newLProc := beg2newLProc^.right;
  end;

end;

// ������� ��������� ����������������� ������ � ������ ��� ����������
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

// ���������� �������
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

// ������� ��������������� ��������� � ����� ������ � ������� ����������� ���
// ����������� ������ �� �����
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
    writeln('������ ����� �������? (1-���� ��,0-���� ���)');
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
    writeln('���� ����������� ������ � ������� �����������');
    vivod(beg3newL);
  except
  end;

  try
    writeln;
    writeln('��� ���� ������ � �������� ������� �����: ');
    vivod(beg2newL);
  except
  end;
  readln;

end.
