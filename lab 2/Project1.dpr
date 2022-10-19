program Project1;

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
  m, k, amount, gout: Integer;
  A, B: point;
  Res: String;

// ������ ������ ������ ��������. ����� ���� ��������� �� ������ �������
// �� ��� ������ ���������, ���� ��� ����� ��� � �� ����� ��������� ���
// ����� ������ ��������, � � ����� ���� ������ ������� �� �������
// ��������� ������� �� �����. ������� ��������� ���� �� ���� ������,
// ����� �������� ������ ����� � ���������� ��������, � �� �������
procedure MakeSpisok(var eleppointer: point; n: Integer);
var
  i: Integer;
  first: point;
begin
  // �������� ������� �������� ������ � ���������� ��� ���� �������
  New(eleppointer);
  // ��������� ������ �� ������ �������
  first := eleppointer;
  first^.data := 1;
  //
  for i := 2 to n do
  begin
    New(eleppointer^.next);
    eleppointer := eleppointer^.next;
    eleppointer^.data := i;
  end;
  eleppointer^.next := first;
  eleppointer := first;
end;

// ����� ������ �� � ���� ���� ���� ������. ����� ��������� �� � ����� ������,
// ���� ������� �� ������ ���, �� ��������. �� ������� ����� �� �������, � ���������
// � � �� ������� ������ ��������� ����� ����������. ������� ���� ������� ���� 1 ��� ��
// �� � ������ ���������� ���������� ������ ���������� ��������, � ������� �����
// ������ �� ����� ����������, ���� ����������. ���� ��� ���� �� ���, �� ������
// ����������� ������� � ��������� �� ����� ������� ������
procedure FindToDelete (var i, x: Integer; var S: String; var curr: point);
begin
  while i < x do
  begin
    if i + 1 = x then
    begin
      S := S + IntToStr(curr^.next^.data) + ',';
      i := x;
    end
    else
    begin
      inc(i);
      curr := curr^.next;
    end;
  end;
end;

// ��������� �� ������. ��������� ����������� ����� ���� ������� ��������� �� ���������
// � ��������� �� ����-����
procedure DeleteElem(var curr: point);
begin
  curr^.next := curr^.next^.next;
end;

// ��  ������ ������������, �� ����� � ������ ��������� ������� � ����� ����
// ������� ������ ������ � ������ ��������� ���������� ������� ������, � ����� ��� ������
procedure ResOutput (var S: String; var curr: point);
begin
  Delete(S, Length(S), 1);
  S := Res + '| Left:' + IntToStr(curr^.data);
  writeln(S);
  S := '';
end;

begin
  write('Enter the number which goes out ');

  // �� ������ ��� ��� ���� ��� 64 ��������� ������� ����, ��� ��� � ���� ������������
  // � ������ ����� ���������
  readln(gout);
  for m := 1 to 64 do
  begin
    // ������� ��� ����� �� ���� �� � �������
    amount := m;
    MakeSpisok(A, m);
    writeln;
    writeln('If there are ', m, ' children');
    write('The row: ');

    // ����������� �� �����, � ��������� ���� �� ����� �������, �� ��� ��� ����� �
    // �� �����, ��� ��� ��������� ����� ������� ������������
    while amount <> 1 do
    begin
      k := 1;
      FindToDelete(k, gout, Res, A);
      DeleteElem(A);

      // �� ��� ���� ����� ������� ���� � �� ��������� ���������� ���� ������ ������
      // �� ���������� � ������ ������
      A := A^.next;

      // � � ������� �� ������ ��� �������� ����
      dec(amount);
    end;
    ResOutput(Res,A);

    // �� � � ����� ��� ������� ����������, � ����� ������ ���� ������� � � �
    // ��� ���� ������� ������� �� ��� ��� �� ��� ��� �� �����, ������� � �������
    // ���� ���
    A := nil;
  end;
  readln;

end.
