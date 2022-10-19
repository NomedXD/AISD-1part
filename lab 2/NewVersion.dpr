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
  { allcases - ����������, ��� ������� ���������(1 to 64)
    k - ������� ����������� �����(����� �������� ����� �������)
    amount - ���������� ���������� � ���� ��������
    NumberOfKick - �������� ����� ���������� ��������
    currentNess - ������� ��������� ��������� � ���� ��������
    ResOut - ��������� ������(������ � ����� ����������� '' � � �������� 256 }

procedure MakeSpisok(var elempointer: point; n: Integer);
var
  i: Integer;
  first: point;
begin
  // �������� ������� �������� ������ � ���������� ��� ���� �������
  New(elempointer);
  // ��������� ������ �� ������ �������
  first := elempointer;
  first^.data := 1;
  // ��������� ��������� ���������� ���������
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
  // ����������� ������ ���������� �� �������, ����� ������� �� �����
  while current < numberkick do
  begin
    // ���� ��������� ��� ���, ���� ����� ��������, �� ���������� ��� �����
    // � ������������� �� ���� �� �����, ����� ��������� ���� ��������
    if current + 1 = numberkick then
    begin
      StrOut := StrOut + IntToStr(elempointer^.next^.data) + ',';
      current := numberkick;
    end
    else
    // � ��������� ������ ������������� ������ �� ������ � ����������� �����
    // ����������, ���� �� ��������� ������� (current +1)
    begin
      inc(current);
      elempointer := elempointer^.next;
    end;
  end;
end;

// ��������� ����� ����� ������� ��������� � ���������,
// ����� ������������ ������ 3-�� �������� �������� �����
// ���� �� ����� ���������� ��������
procedure DeleteElem(var elempointer: point);
begin
  elempointer^.next := elempointer^.next^.next;
end;

// ��  ������ ������������, �� ����� � ������ ��������� ������� � ����� ����
// ������� ������ ������ � ������ ��������� ���������� ������� ������, � ����� ��� ������
procedure ResOutput (var S: String; var elempointer: point);
begin
  writeln;
  S := ResOut + '| ������� ������� � �������:' + IntToStr(elempointer^.data);
  writeln(S);
  S := '';
end;

begin
  write('����� ����� ���������� ');

  // ���� ������ ���������� � ������ ����� ��� ���� ������� �� 1 �� 64
  readln(NumberOfKick);
  for allcases := 1 to 64 do
  begin
    // ������� ������ �� �-�� ������� �� 1 �� 64
    amount := allcases;
    MakeSpisok(currentNess, allcases);

    writeln;
    writeln('���� ���� ', allcases, ' �����');
    write('��������� ���: ');

    // ���� �� ��������� ���� �������
    while amount <> 1 do
    begin
      // ����� ������� �������� �������� ��������� � 1 � ����������� ������
      // ��������
      k := 1;
      FindToDelete(k, NumberOfKick, ResOut, currentNess);
      DeleteElem(currentNess);

      // ����� �������� ���������� �� ����� ����������, ����� ������ �������
      // ��� � ����
      currentNess := currentNess^.next;

      // ���������� ���������� ���������� � �����
      dec(amount);
    end;
    ResOutput(ResOut,currentNess);

    // ������� ������
    currentNess := nil;
  end;
  readln;

end.
