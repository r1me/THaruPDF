unit text_demo;

interface
uses
  System.Classes, System.SysUtils, System.Math, demoMgr,
  hpdf_consts,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TTextDemo = class(TDemo)
  private
    procedure ShowStripePattern(APage: THaruPage; Ax, Ay: Single);
    procedure ShowDescription(APage: THaruPage; Ax, Ay: Single; AText: String);
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

procedure TTextDemo.ShowStripePattern(APage: THaruPage; Ax, Ay: Single);
var
  iy: Integer;
begin
  iy := 0;
  while (iy < 50) do
  begin
    APage.RGBStroke := THPDF_RGBColor.Create(0, 0, 0.5);
    APage.LineWidth := 1;
    APage.MoveTo(Ax, Ay + iy);
    APage.LineTo(Ax + APage.TextWidth('ABCabc123'), Ay + iy);
    APage.Stroke;
    iy := iy + 3;
  end;

  APage.LineWidth := 2.5;
end;

procedure TTextDemo.ShowDescription(APage: THaruPage; Ax, Ay: Single; AText: String);
var
  fsize: Single;
  font: THaruFont;
  c: THPDF_RGBColor;
begin
  fsize := APage.FontSize;
  font := APage.Font;
  c := APage.RGBFill;

  APage.BeginText;
  APage.RGBFill := THPDF_RGBColor.Create(0, 0, 0);
  APage.TextRenderingMode := HPDF_FILL;
  APage.SetFontAndSize(font, 10);
  APage.TextOut(Ax, Ay - 12, AText);
  APage.EndText;

  APage.SetFontAndSize(font, fsize);
  APage.RGBFill := c;
end;

function TTextDemo.StartDemo(AFileName: String): Boolean;
const
  samp_text = 'abcdefgABCDEFG123!#$%&+-@?';
  samp_text2 = 'The quick brown fox jumps over the lazy dog.';
var
  pdf: THaruDocument;
  font: THaruFont;
  page: THaruPage;
  fsize: Single;
  i: Integer;
  len: Integer;
  angle1: Single;
  angle2: Single;
  rad1: Single;
  rad2: Single;
  ypos: Single;
  r, g, b: Single;
  buf: String;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // set compression mode
      pdf.SetCompressionMode(HPDF_COMP_ALL);

      // create default font
      font := pdf.Fonts.GetFont('Helvetica');

      // add a new page
      page := pdf.Pages.Add;

      page.BeginText;
      page.MoveTextPos(60, page.Height - 60);

      // font size
      fsize := 8;
      while (fsize < 60) do
      begin
        // set style and size of font
        page.SetFontAndSize(font, fsize);

        // set the position of the text
        page.MoveTextPos(0, -5 - fsize);

        // measure the number of characters which included in the page
        len := page.MeasureText(samp_text, page.Width - 120, []);

        page.ShowText(Copy(samp_text, 1, len));

        // print the description
        page.MoveTextPos(0, -10);
        page.SetFontAndSize(font, 8);
        page.ShowText(Format('Fontsize=%.0f', [fsize]));

        fsize := fsize * 1.5;
      end;

      // font color
      page.SetFontAndSize(font, 8);
      page.MoveTextPos(0, -30);
      page.ShowText('Font color');

      page.SetFontAndSize(font, 18);
      page.MoveTextPos(0, -20);
      len := Length(samp_text);
      for i := 1 to len do
      begin
        r := i / len;
        g := 1 - (i / len);
        buf := samp_text[i];

        page.RGBFill := THPDF_RGBColor.Create(r, g, 0);
        page.ShowText(buf);
      end;
      page.MoveTextPos(0, -25);

      for i := 1 to len do
      begin
        r := i / len;
        b := 1 - (i / len);
        buf := samp_text[i];

        page.RGBFill := THPDF_RGBColor.Create(r, 0, b);
        page.ShowText(buf);
      end;
      page.MoveTextPos(0, -25);

      for i := 1 to len do
      begin
        b := i / len;
        g := 1 - (i / len);
        buf := samp_text[i];

        page.RGBFill := THPDF_RGBColor.Create(0, g, b);
        page.ShowText(buf);
      end;
      page.MoveTextPos(0, -25);

      page.EndText;

      ypos := 450;

      // font rendering mode
      page.SetFontAndSize(font, 32);
      page.RGBFill := THPDF_RGBColor.Create(0.5, 0.5, 0);
      page.LineWidth := 1.5;

      // PDF_FILL
      ShowDescription(page, 60, ypos, 'RenderingMode=PDF_FILL');
      page.TextRenderingMode := HPDF_FILL;
      page.BeginText;
      page.TextOut(60, ypos, 'ABCabc123');
      page.EndText;

      // PDF_STROKE
      ShowDescription(page, 60, ypos - 50, 'RenderingMode=PDF_STROKE');
      page.TextRenderingMode := HPDF_STROKE;
      page.BeginText;
      page.TextOut(60, ypos - 50, 'ABCabc123');
      page.EndText;

      // PDF_FILL_THEN_STROKE
      ShowDescription(page, 60, ypos - 100, 'RenderingMode=PDF_FILL_THEN_STROKE');
      page.TextRenderingMode := HPDF_FILL_THEN_STROKE;
      page.BeginText;
      page.TextOut(60, ypos - 100, 'ABCabc123');
      page.EndText;

      // PDF_FILL_CLIPPING
      ShowDescription(page, 60, ypos - 150, 'RenderingMode=PDF_FILL_CLIPPING');
      page.GSave;
      page.TextRenderingMode := HPDF_FILL_CLIPPING;
      page.BeginText;
      page.TextOut(60, ypos - 150, 'ABCabc123');
      page.EndText;
      ShowStripePattern(page, 60, ypos - 150);
      page.GRestore;

      // PDF_STROKE_CLIPPING
      ShowDescription(page, 60, ypos - 200, 'RenderingMode=PDF_STROKE_CLIPPING');
      page.GSave;
      page.TextRenderingMode := HPDF_STROKE_CLIPPING;
      page.BeginText;
      page.TextOut(60, ypos - 200, 'ABCabc123');
      page.EndText;
      ShowStripePattern(page, 60, ypos - 200);
      page.GRestore;

      // PDF_FILL_STROKE_CLIPPING
      ShowDescription(page, 60, ypos - 250, 'RenderingMode=PDF_FILL_STROKE_CLIPPING');
      page.GSave;
      page.TextRenderingMode := HPDF_FILL_STROKE_CLIPPING;
      page.BeginText;
      page.TextOut(60, ypos - 250, 'ABCabc123');
      page.EndText;
      ShowStripePattern(page, 60, ypos - 250);
      page.GRestore;

      // reset text attributes
      page.TextRenderingMode := HPDF_FILL;
      page.RGBFill := THPDF_RGBColor.Create(0, 0, 0);
      page.SetFontAndSize(font, 30);

      // rotating text
      angle1 := 30;  // A rotation of 30 degrees
      rad1 := angle1 / 180 * Pi; // Calcurate the radian value

      ShowDescription(page, 320, ypos - 60, 'Rotating text');
      page.BeginText;
      page.TextMatrix := THPDF_TransMatrix.Create(cos(rad1), sin(rad1), -sin(rad1), cos(rad1),
        330, ypos - 60);
      page.ShowText('ABCabc123');
      page.EndText;

      // skewing text
      ShowDescription(page, 320, ypos - 120, 'Skewing text');
      page.BeginText;

      angle1 := 10;
      angle2 := 20;
      rad1 := angle1 / 180 * Pi;
      rad2 := angle2 / 180 * Pi;

      page.TextMatrix := THPDF_TransMatrix.Create(1, tan(rad1), tan(rad2), 1, 320, ypos - 120);
      page.ShowText('ABCabc123');
      page.EndText;

      // scaling text (X direction)
      ShowDescription(page, 320, ypos - 175, 'Scaling text (X direction)');
      page.BeginText;
      page.TextMatrix := THPDF_TransMatrix.Create(1.5, 0, 0, 1, 320, ypos - 175);
      page.ShowText('ABCabc12');
      page.EndText;

      // scaling text (Y direction)
      ShowDescription(page, 320, ypos - 250, 'Scaling text (Y direction)');
      page.BeginText;
      page.TextMatrix := THPDF_TransMatrix.Create(1, 0, 0, 2, 320, ypos - 250);
      page.ShowText('ABCabc123');
      page.EndText;

      // char spacing, word spacing
      ShowDescription(page, 60, 140, 'char-spacing 0');
      ShowDescription(page, 60, 100, 'char-spacing 1.5');
      ShowDescription(page, 60, 60, 'char-spacing 1.5, word-spacing 2.5');

      page.SetFontAndSize(font, 20);
      page.RGBFill := THPDF_RGBColor.Create(0.1, 0.3, 0.1);

      // char-spacing 0
      page.BeginText;
      page.TextOut(60, 140, samp_text2);
      page.EndText;

      // char-spacing 1.5
      page.CharSpace := 1.5;

      page.BeginText;
      page.TextOut(60, 100, samp_text2);
      page.EndText;

      // char-spacing 1.5, word-spacing 2.5
      page.WordSpace := 2.5;

      page.BeginText;
      page.TextOut(60, 60, samp_text2);
      page.EndText;

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
    'Font style',
      'Prints text with various font size, color, character and word spacing, shows different rendering modes. ' +
      'Applies transformation matrix to rotate, skew and scale the text.',
    'Text',
    'demos\text_demo.pdf',
    'demos\text_demo.png',
    TTextDemo);

end.
