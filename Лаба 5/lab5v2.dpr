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

// ������������ ����� �������� �������������� ���
// ��������� ���������� �������
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
  Writeln('������� ���� ���������: ');
  Readln(InputStr);

  // ������������� ����� ������������� ������� ������ ����� ����� ���������
  len := length(InputStr);
  Setlength(Stack, len);

  // �������� ������ �� ������ ��������� ������ � �����
  // � ������ �� ��������� ������ ������� �� ���� = ����� ������-1
  index := len - 1;
  // ������ ������� ������
  k := 1;
  // ���������� ������ ������ � ���� ��������
  Stack[index] := InputStr[k];
  // �������� ��������� ������ ������
  // � �������� ������ �����
  k := 2;
  index := index - 1;

  // ������� ���������
  Letters:=['A'..'Z','a'..'z'];
  Characters:=['+','-','*','/','^'];

  // ���� ��� ������� �� ������� �������� ������
  while k <> length(InputStr)+1 do
  begin
    // ���� ���������� �������� � "����������" �������
    GetPriority(InputStr[k], StackPrIn, OtnPrIn);
    GetPriority(Stack[index + 1], StackPrSt, OtnPrSt);
    // ���� �������� ��� ����� ������...
    if InputStr[k] <> ')' then
    begin
      // ���� �������� ��� ��������� ���� ���������
      // ��� �� ��������� � ������ �����, �� �������� ������� ������ �����
      if (OtnPrIn > StackPrSt) or (index+1=length(Stack)) then
      begin
        Stack[index] := InputStr[k];
        // �������� ������ ����� �� ��������� �����
        index := index - 1;
        // �������� ��������� ������ �� ���� �������
        k := k + 1;
      end
      else
      begin
          // ���� �������� �����. ���� � �� �� �������� ����� �����, ��...
          while (OtnPrIn <= StackPrSt) and (index+1<>length(Stack)) do
          begin
            // ���������� ������� ������� ����� � ��������� ������
            outputStr := outputStr + Stack[index + 1];
            // �������� ������ ����� ���� ��� �������� ���������� �������� �����
            index := index + 1;
            { ���� ��������� ���������� �������� �����. ���������:
              ��� ��� ����������� � ������� ����� ������ �� ����� �����
              �� ������� ���� ��, ��� � ���������� ������ ���������
              ��������� � �������� ��������� ����� ���������� ������
              �� �������������� ����� ������, ��� ��� �� ��������� ��������
              ����� ����������� ����� �� ����� � �������� �����������
              ����� ������������� :))))) }
            GetPriority(Stack[index + 1], StackPrSt, OtnPrSt);
          end;
          // ���������� ������� �� ��������� ���������� �����
          Stack[index]:=InputStr[k];
          // �������� ��� ������� ��� ������
          index:=index-1;
          k := k + 1;

      end;
    end
    else
    begin
      // ���� ��� �� ������� ����������� ������. �� ����������� ���������� �����
      while Stack[index+1]<>'(' do
      begin
        outputStr := outputStr + Stack[index + 1];
        index := index + 1;
      end;
      if Stack[index+1]='(' then
      begin
        // � ����� �� �������� ����������� ������ �� ������ ����������� ������
        // ��� ����� ��� ����� ������������
        index := index + 1;
      end;
      k:=k+1;
    end;

  end;
  // ���� �������� ��� �������� � �����, ����������� ��
  if index+1<>length(Stack) then
  begin
    while index+1<>length(Stack) do
    begin
      outPutStr:= outPutStr+Stack[index+1];
      // �� �������� ��� ������
      index:=index+1;
    end;

  end;
  Writeln('���� �������� �������� ������: ');
  writeln(outputStr);

  // ������� ���� ������������� ���������
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
  // ��������������� ��������� � �����
  { ���������: ��������� ���� ���������� ��������� �� ����� ������, ��� ���
    ��� ����� ���� �������� ��� aaa**, ��� � ����� ������ ����� ����� ������ }
  if k=1 then
  begin
    Writeln('���� ��������� �������� ���������� ����������, ��� ���� ����� � ���� �������� �������� ������: ');
    writeln(k);
  end
  else
  begin
    Writeln('���� ��������� �������� ����������, ��� ��� ���� �������� �������� ������ �����: ');
    writeln(k);
  end;

  readln;
end.
