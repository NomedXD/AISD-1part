program FinalVersion11;

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
  beg2L, end2L: link;
  k, i: integer;
  N: integer;
  Mas: array of integer;
  beg2newL, end2newL: link2;

  { ��������� ������� ������ ����� �������
    � ��������������� ������ � ��������� ���� ���
    ���������� ������ }
procedure addelementlist1(var first, last: link);
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

// ����� ��������� �� ����������������� ������
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
  curr, temp1,temp2: link2;
begin
  for j := 1 to kol - 1 do
  begin
    curr := first2LProc;
    while curr^.right<>nil do

    begin
      if curr^.number > curr^.right^.number then
      begin
        temp1 := curr^.right;
        curr^.right^.right:=curr;
        curr^.right:=temp1^.right;
      end;
      curr := curr^.right;
    end;
  end;
end;

begin
  N := 0;
  repeat
    writeln('������ ����� �������? (1-���� ��,0-���� ���)');
    readln(k);
    if k = 1 then
    begin
      addelementlist1(beg2L, end2L);
    end;
  until k = 0;
  vivod(end2L);
  writeln;
  addelementlist2(beg2L, beg2newL, end2newL, N);
  vivod2(beg2newL);
  writeln;
  // �� ���� �������� �� ���
  sort(N,beg2newL);
  vivod2(beg2newL);

  sleep(20000000);

end.