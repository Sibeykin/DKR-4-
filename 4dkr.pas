program IntegrationVisualization;

uses GraphABC;

function f(x: Real): Real;
begin
  f := x * x * x - x * x - 2 * x + 11;
end;

function CalculateArea(a, b: Real; n: Integer): Real;
var
  h, sum: Real;
  i: Integer;
begin
  h := (b - a) / n; 
  sum := 0.5 * (f(a) + f(b)); 
  for i := 1 to n - 1 do
    sum := sum + f(a + i * h); 
  CalculateArea := sum * h;
end;

function CalculateError(a, b: Real; n: Integer): Real;
var
  h: Real;
begin
  h := (b - a) / n;
  CalculateError := (Power(h, 2) / 12) * (f(b) - f(a)); 
end;

procedure DrawGraph(a, b: Real; n: Integer);
var
  x, y: Real;
  i: Integer;
begin
  SetWindowSize(800, 600);
  ClearWindow(clWhite);

  Line(400, 0, 400, 600); // OY
  Line(0, 300, 800, 300); // OX

  TextOut(410, 290, 'Y');
  TextOut(780, 290, 'X');

  SetPenColor(clLightBlue);

  for i := 0 to n do
  begin
    x := a + (b - a) * i / n; 
    y := f(x); 

    if i = 0 then
      MoveTo(Round((x - a) * 400 / (b - a) + 400), Round(300 - y * 10)) // Первая точка
    else
      LineTo(Round((x - a) * 400 / (b - a) + 400), Round(300 - y * 10)); // Соединение точек
  end;
end;

procedure Menu();
var
  option: Integer;
  a, b: Real;
  n: Integer;
  area, error: Real;
begin
  repeat
    WriteLn('1. Вычислить площадь под кривой');
    WriteLn('2. Визуализировать кривую');
    WriteLn('3. Выход');
    Write('Выберите опцию (1, 2 или 3): ');
    ReadLn(option);

    case option of
      1: begin
           Write('Введите пределы интегрирования (a и b): ');
           ReadLn(a, b);
           Write('Введите количество трапеций: ');
           ReadLn(n);
           area := CalculateArea(a, b, n);
           error := CalculateError(a, b, n);
           WriteLn('Площадь под кривой: ', area:0:4);
           WriteLn('Оценка погрешности: ', Abs(error):0:4);
           ReadLn; 
         end;
      2: begin
           Write('Введите пределы интегрирования (a и b): ');
           ReadLn(a, b);
           Write('Введите количество точек: ');
           ReadLn(n);
           DrawGraph(a, b, n);
         end;
      3: WriteLn('Выход из программы...');
    else
      WriteLn('Неверный ввод. Попробуйте снова.');
    end;
  until option = 3;
end;

begin
  Menu();
end.