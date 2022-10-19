program FinalVersion;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

type
  link = ^List;

  List = record
    number: string;
    name:string;
    right: link;
  end;

var
  beg1L,End2L: link;
  k, i: integer;
  N: integer;
  Mas: array of integer;
  vvodstr:string;

procedure addelementlist1(var first,last: link);
var
  add: link;
begin
  new(add);

  add^.right := nil;
  writeln('������� ����� ��������,������� ����� ��������');
  repeat
    readln(add^.number);
    if (length(add^.number) <> 7) then
    begin
      writeln('�� ����� �������� ����� ��������, ������� ������');
    end;

  until (length(add^.number) = 7);
  writeln('������� ������� ��������');
  readln(add^.name);
  if (first = nil) then
  begin
    first := add;
    last := add;
  end
  else
  begin
    last^.right := add;
    last := add;

  end;

end;


procedure vivod(FirstLink: link);
begin
  while (FirstLink <> nil) do
  begin
    writeln('����� ��������: ',FirstLink^.number,' �������: ',FirstLink^.name);
    FirstLink := FirstLink^.right;
  end;

end;



procedure sort(kol: integer; first1LProc: link);
var
  i, j: integer;
  ref: link;
  temp1,temp2: string;
begin
  ref := first1LProc;
  for i := 1 to kol - 1 do
  begin
    for j := 1 to kol - i do
    begin
      if first1LProc^.name > first1LProc^.right^.name
      then
      begin
        temp1 := first1LProc^.name;
        temp2 := first1LProc^.number;
        first1LProc^.number := first1LProc^.right^.number;
        first1LProc^.name := first1LProc^.right^.name;
        first1LProc^.right^.name := temp1;
        first1LProc^.right^.number := temp2;
      end;
      first1LProc := first1LProc^.right;
    end;
    first1LProc := ref;
  end;
end;

procedure FindPoName(first:link;sName:string);
var
  curr:link;
  check:boolean;
begin
  check:=true;
  curr:=first;
  while (curr<>nil) do
  begin
    if curr^.Name = sName then
    begin
      writeln('�� ������ ������� ������(-�) ������: ',Curr^.Number);
      curr := curr^.right;
      check:=false;
    end
    else
    begin
      curr := curr^.right;
    end;

  end;
  if check = true then
  begin
    writeln('�� ������ ������� �� ���� ������� �������');
  end;

end;

procedure FindPoNumber(first:link;sNumber:string);
var
  curr:link;
  check:boolean;
begin
  check:=true;
  curr:=first;
  while (curr<>nil) do
  begin
    if curr^.number = sNumber then
    begin
      writeln('�� ������� ������ ������(-�) �������: ',Curr^.Name);
      curr := curr^.right;
      check:=false;
    end
    else
    begin
      curr := curr^.right;
    end;

  end;
  if check = true then
  begin
    writeln('�� ������� ������ �� ������� �������');
  end;

end;

begin
  N := 0;
  repeat
    writeln('������ ����� �������? (1-���� ��,0-���� ���)');
    readln(k);
    if k = 1 then
    begin
      addelementlist1(beg1L,end2L);
      inc(N);
    end;

  until k = 0;

  writeln('���� ������������� �������� ������ ');
  sort(N, beg1L);
  vivod(Beg1L);
  writeln;

  repeat
    writeln('����� ������� �� ������ ��������? (1-���� ��,0-���� ���)');
    readln(k);
    if k =1  then
    begin
      writeln('�� ������ ������ �����?');
      readln(vvodstr);
      FindPoNumber(beg1L,vvodstr);
    end;
  until k=0 ;

  repeat
    writeln('����� ������ �� ����� �� �������? (1-���� ��,0-���� ���)');
    readln(k);
    if k=1 then
    begin
      writeln('�� ����� ������� �����?');
      readln(vvodstr);
      FindPoName(beg1L,vvodstr);
    end;
  until k=0 ;

  readln;

end.