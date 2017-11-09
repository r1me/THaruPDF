unit line_demo;

interface
uses
  System.Classes, demoMgr,
  hpdf_consts,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TLineDemo = class(TDemo)
  private
    procedure DrawLine(APage: THaruPage; Ax, Ay: Single; ALabel: String);
    procedure DrawLine2(APage: THaruPage; Ax, Ay: Single; ALabel: String);
    procedure DrawRect(APage: THaruPage; Ax, Ay: Single; ALabel: String);
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

procedure TLineDemo.DrawLine(APage: THaruPage; Ax, Ay: Single; ALabel: String);
begin
  APage.BeginText;
  APage.MoveTextPos(Ax, Ay - 10);
  APage.ShowText(ALabel);
  APage.EndText;

  APage.MoveTo(Ax, Ay - 15);
  APage.LineTo(Ax + 220, Ay - 15);
  APage.Stroke;
end;

procedure TLineDemo.DrawLine2(APage: THaruPage; Ax, Ay: Single; ALabel: String);
begin
  APage.BeginText;
  APage.MoveTextPos(Ax, Ay);
  APage.ShowText(ALabel);
  APage.EndText;

  APage.MoveTo(Ax + 30, Ay - 25);
  APage.LineTo(Ax + 160, Ay - 25);
  APage.Stroke;
end;

procedure TLineDemo.DrawRect(APage: THaruPage; Ax, Ay: Single; ALabel: String);
begin
  APage.BeginText;
  APage.MoveTextPos(Ax, Ay - 10);
  APage.ShowText(ALabel);
  APage.EndText;

  APage.Rectangle(Ax, Ay - 40, 220, 25);
end;

function TLineDemo.StartDemo(AFileName: String): Boolean;
const
  page_title = 'Line Example';
const
  DASH_MODE1: array[0..0] of Single = (3.0);
  DASH_MODE2: array[0..1] of Single = (3.0, 7.0);
  DASH_MODE3: array[0..3] of Single = (8.0, 7.0, 2.0, 7.0);
var
  pdf: THaruDocument;
  font: THaruFont;
  page: THaruPage;
  x, y: Double;
  x1, y1: Double;
  x2, y2: Double;
  x3, y3: Double;
  tw: Single;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      pdf.SetCompressionMode(HPDF_COMP_ALL);

      // create default-font
      font := pdf.Fonts.GetFont('Helvetica');

      // add a new page
      page := pdf.Pages.Add;

      // print the lines of the page
      page.LineWidth := 1;
      page.Rectangle(50, 50, page.Width - 100, page.Height - 110);
      page.Stroke;

      // print the title of the page (with positioning center)
      page.SetFontAndSize(font, 24);
      tw := page.TextWidth(page_title);
      page.BeginText;
      page.MoveTextPos((page.Width - tw) / 2, page.Height - 50);
      page.ShowText(page_title);
      page.EndText;

      page.SetFontAndSize(font, 10);

      // draw various widths of lines
      page.LineWidth := 0;
      DrawLine(page, 60, 770, 'line width = 0');

      page.LineWidth := 1;
      DrawLine(page, 60, 740, 'line width = 1.0');

      page.LineWidth := 2;
      DrawLine(page, 60, 710, 'line width = 2.0');

      // line dash pattern
      page.LineWidth := 1.0;

      page.SetDash(DASH_MODE1, 1);
      DrawLine(page, 60, 680, 'dash_ptn=[3], phase=1 -- 2 on, 3 off, 3 on...');

      page.SetDash(DASH_MODE2, 2);
      DrawLine(page, 60, 650, 'dash_ptn=[7, 3], phase=2 -- 5 on 3 off, 7 on...');

      page.SetDash(DASH_MODE3, 0);
      DrawLine(page, 60, 620, 'dash_ptn=[8, 7, 2, 7], phase=0');

      page.SetDash([], 0);

      page.LineWidth := 30;
      page.RGBStroke := THPDF_RGBColor.Create(0, 0.5, 0);

      // line Cap Style
      page.LineCap := HPDF_BUTT_END;
      DrawLine2(page, 60, 570, 'PDF_BUTT_END');

      page.LineCap := HPDF_ROUND_END;
      DrawLine2(page, 60, 505, 'PDF_ROUND_END');

      page.LineCap := HPDF_PROJECTING_SQUARE_END;
      DrawLine2(page, 60, 440, 'PDF_PROJECTING_SQUARE_END');

      // line Join Style
      page.LineWidth := 30;
      page.RGBStroke := THPDF_RGBColor.Create(0, 0, 0.5);

      page.LineJoin := HPDF_MITER_JOIN;
      page.MoveTo(120, 300);
      page.LineTo(160, 340);
      page.LineTo(200, 300);
      page.Stroke;

      page.BeginText;
      page.MoveTextPos(60, 360);
      page.ShowText('PDF_MITER_JOIN');
      page.EndText;

      page.LineJoin := HPDF_ROUND_JOIN;
      page.MoveTo(120, 195);
      page.LineTo(160, 235);
      page.LineTo(200, 195);
      page.Stroke;

      page.BeginText;
      page.MoveTextPos(60, 255);
      page.ShowText('PDF_ROUND_JOIN');
      page.EndText;

      page.LineJoin := HPDF_BEVEL_JOIN;
      page.MoveTo(120, 90);
      page.LineTo(160, 130);
      page.LineTo(200, 90);
      page.Stroke;

      page.BeginText;
      page.MoveTextPos(60, 150);
      page.ShowText('PDF_BEVEL_JOIN');
      page.EndText;

      // draw Rectangle
      page.LineWidth := 2;
      page.RGBStroke := THPDF_RGBColor.Create(0, 0, 0);
      page.RGBFill := THPDF_RGBColor.Create(0.75, 0, 0);

      DrawRect(page, 300, 770, 'Stroke');
      page.Stroke;

      DrawRect(page, 300, 720, 'Fill');
      page.Fill;

      DrawRect(page, 300, 670, 'Fill then Stroke');
      page.FillStroke;

      // clip Rect
      page.GSave; // Save the current graphic state
      DrawRect(page, 300, 620, 'Clip Rectangle');
      page.Clip;
      page.Stroke;
      page.SetFontAndSize(font, 13);

      page.BeginText;
      page.MoveTextPos(290, 600);
      page.TextLeading := 12;
      page.ShowText('Clip Clip Clip Clip Clip Clip Clip Clip Clip');
      page.ShowTextNextLine('Clip Clip Clip Clip Clip Clip Clip Clip Clip');
      page.ShowTextNextLine('Clip Clip Clip Clip Clip Clip Clip Clip Clip');
      page.EndText;
      page.GRestore;

      // curve Example(CurveTo2)
      x := 330;
      y := 440;
      x1 := 430;
      y1 := 530;
      x2 := 480;
      y2 := 470;
      x3 := 480;
      y3 := 90;

      page.RGBFill := THPDF_RGBColor.Create(0, 0, 0);

      page.BeginText;
      page.MoveTextPos(300, 540);
      page.ShowText('CurveTo2(x1, y1, x2, y2)');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(x + 5, y - 5);
      page.ShowText('Current point');
      page.MoveTextPos(x1 - x, y1 - y);
      page.ShowText('(x1, y1)');
      page.MoveTextPos(x2 - x1, y2 - y1);
      page.ShowText('(x2, y2)');
      page.EndText;

      page.SetDash(DASH_MODE1, 0);

      page.LineWidth := 0.5;
      page.MoveTo(x1, y1);
      page.LineTo(x2, y2);
      page.Stroke;

      page.SetDash([], 0);

      page.LineWidth := 1.5;
      page.MoveTo(x, y);
      page.CurveTo2(x1, y1, x2, y2);
      page.Stroke;

      // curve Example(CurveTo3)
      y := y - 150;
      y1 := y1 - 150;
      y2 := y2 - 150;

      page.BeginText;
      page.MoveTextPos(300, 390);
      page.ShowText('CurveTo3(x1, y1, x2, y2)');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(x + 5, y - 5);
      page.ShowText('Current point');
      page.MoveTextPos(x1 - x, y1 - y);
      page.ShowText('(x1, y1)');
      page.MoveTextPos(x2 - x1, y2 - y1);
      page.ShowText('(x2, y2)');
      page.EndText;

      page.SetDash(DASH_MODE1, 0);

      page.LineWidth := 0.5;
      page.MoveTo(x, y);
      page.LineTo(x1, y1);
      page.Stroke;

      page.SetDash([], 0);

      page.LineWidth := 1.5;
      page.MoveTo(x, y);
      page.CurveTo3(x1, y1, x2, y2);
      page.Stroke;

      // curve Example(CurveTo)
      y := y - 150;
      y1 := y1 - 160;
      y2 := y2 - 130;
      x2 := x2 + 10;

      page.BeginText;
      page.MoveTextPos(300, 240);
      page.ShowText('CurveTo(x1, y1, x2, y2, x3, y3)');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(x + 5, y - 5);
      page.ShowText('Current point');
      page.MoveTextPos(x1 - x, y1 - y);
      page.ShowText('(x1, y1)');
      page.MoveTextPos(x2 - x1, y2 - y1);
      page.ShowText('(x2, y2)');
      page.MoveTextPos(x3 - x2, y3 - y2);
      page.ShowText('(x3, y3)');
      page.EndText;

      page.SetDash(DASH_MODE1, 0);

      page.LineWidth := 0.5;
      page.MoveTo(x, y);
      page.LineTo(x1, y1);
      page.Stroke;
      page.MoveTo(x2, y2);
      page.LineTo(x3, y3);
      page.Stroke;

      page.SetDash([], 0);

      page.LineWidth := 1.5;
      page.MoveTo(x, y);
      page.CurveTo(x1, y1, x2, y2, x3, y3);
      page.Stroke;

      // save the document to a file
      Result := pdf.SaveToFile(AFileName);
    finally
      // clean up
      pdf.Free;
    end;
  except
    on e: EHaruPDFException do
    begin
      if Assigned(DemoManager.OnHaruException) then
        DemoManager.OnHaruException(Self, e);
    end;
  end;
end;

initialization
  DemoManager.AddDemo(
    'Lines',
    'Draw lines and bézier curves of different width, end shape and join style. Shows how to limit (clip) drawing area within rectangle.',
    'Graphics',
    'demos\line_demo.pdf',
    'demos\line_demo.png',
    TLineDemo);

end.
