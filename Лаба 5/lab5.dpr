program lab5;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

var
  Stack: array of char;
  InputStr: string;
  len, index,k: integer;
  StackPr,OtnPr:integer;


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
  Writeln('¬ведите ваше выражение: ');
  Readln(InputStr);
  len := length(InputStr);
  Setlength(Stack, len);
  index := len-1;
  k:=1;
  Stack[index]:=InputStr[k];
  k:=2;
  index:=index-1;
  while k<>length(InputStr) do
  begin
    GetPriority(InputStr[k],StackPr,OtnPr);

  end;


end.
