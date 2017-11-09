unit grid;

interface
uses
  System.Classes, System.SysUtils,
  harupdf.document,
  harupdf.page,
  harupdf.font;

procedure PrintGrid(ADocument: THaruDocument; APage: THaruPage);

implementation

procedure PrintGrid(ADocument: THaruDocument; APage: THaruPage);
var
  width, height: Single;
  font: THaruFont;
  x, y: UInt32;
begin
  height := APage.Height;
  width := APage.Width;
  font := ADocument.Fonts.GetFont('Helvetica', '');

  APage.SetFontAndSize(font, 5);
  APage.GrayFill := 0.5;
  APage.GrayStroke := 0.8;

  // draw horizontal lines
  y := 0;
  while (y < height) do
  begin
    if (y mod 10 = 0) then
    begin
      APage.LineWidth := 0.5;
    end else
    begin
      if (APage.LineWidth <> 0.25) then
        APage.LineWidth := 0.25;
    end;

    APage.MoveTo(0, y);
    APage.LineTo(width, y);
    APage.Stroke;

    if (y mod 10 = 0) and (y > 0) then
    begin
      APage.GrayStroke := 0.5;

      APage.MoveTo(0, y);
      APage.LineTo(5, y);
      APage.Stroke;

      APage.GrayStroke := 0.8;
    end;

    y := y + 5;
  end;

  // draw vertical lines
  x := 0;
  while (x < width) do
  begin
    if (x mod 10 = 0) then
    begin
      APage.LineWidth := 0.5;
    end else
    begin
      if (APage.LineWidth <> 0.25) then
        APage.LineWidth := 0.25;
    end;

    APage.MoveTo(x, 0);
    APage.LineTo(x, height);
    APage.Stroke;

    if (x mod 50 = 0) and (x > 0) then
    begin
      APage.GrayStroke := 0.5;

      APage.MoveTo(x, 0);
      APage.LineTo(x, 5);
      APage.Stroke;

      APage.MoveTo(x, height);
      APage.LineTo(x, height - 5);
      APage.Stroke;

      APage.GrayStroke := 0.8;
    end;

    x := x + 5;
  end;

  // draw horizontal text
  y := 0;
  while (y < height) do
  begin
    if (y mod 10 = 0) and (y > 0) then
    begin
      APage.BeginText;
      APage.MoveTextPos(5, y - 2);
      APage.ShowText(IntToStr(y));
      APage.EndText;
    end;

    y := y + 5;
  end;

  // draw vertical text
  x := 0;
  while (x < width) do
  begin
    if (x mod 50 = 0) and (x > 0) then
    begin
      APage.BeginText;
      APage.MoveTextPos(x, 5);
      APage.ShowText(IntToStr(x));
      APage.EndText;

      APage.BeginText;
      APage.MoveTextPos(x, height - 10);
      APage.ShowText(IntToStr(x));
      APage.EndText;
    end;

    x := x + 5;
  end;

  APage.GrayFill := 0;
  APage.GrayStroke := 0;
end;

end.
