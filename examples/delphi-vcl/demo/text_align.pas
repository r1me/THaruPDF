unit text_align;

interface
uses
  System.Classes, System.Types, demoMgr,
  hpdf_consts,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TTextAlignDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function TTextAlignDemo.StartDemo(AFileName: String): Boolean;
const
  SAMP_TXT = 'The quick brown fox jumps over the lazy dog.';
var
  pdf: THaruDocument;
  font: THaruFont;
  page: THaruPage;
  len: Integer;
  rect: TRectF;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // add a new page
      page := pdf.Pages.Add;
      page.SetSize(HPDF_PAGE_SIZE_A5, HPDF_PAGE_PORTRAIT);

      page.LineWidth := 0.5;

      font := pdf.Fonts.GetFont('Helvetica');
      page.TextLeading := 20;

      // HPDF_TALIGN_LEFT
      rect.Left := 25;
      rect.Top := 560;
      rect.Right := 200;
      rect.Bottom := rect.Top - 50;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_TALIGN_LEFT');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_TALIGN_LEFT, SAMP_TXT, len);
      page.EndText;

      // HPDF_TALIGN_RIGHT
      rect.Left := 220;
      rect.Right := 395;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;

      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_TALIGN_RIGHT');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_TALIGN_RIGHT, SAMP_TXT, len);
      page.EndText;

      // HPDF_TALIGN_CENTER
      rect.Left := 25;
      rect.Top := 480;
      rect.Right := 200;
      rect.Bottom := rect.Top - 50;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_TALIGN_CENTER');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_TALIGN_CENTER, SAMP_TXT, len);
      page.EndText;

      // HPDF_TALIGN_JUSTIFY
      rect.Left := 220;
      rect.Right := 395;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_TALIGN_JUSTIFY');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_TALIGN_JUSTIFY, SAMP_TXT, len);
      page.EndText;

      // HPDF_TALIGN_STRETCH
      rect.Left := 25;
      rect.Top := 400;
      rect.Right := 200;
      rect.Bottom := rect.Top - 50;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_TALIGN_STRETCH');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_TALIGN_STRETCH, SAMP_TXT, len);
      page.EndText;

      // HPDF_VALIGN_TOP
      rect.Left := 25;
      rect.Top := 320;
      rect.Right := 200;
      rect.Bottom := rect.Top - 50;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_VALIGN_TOP');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_VALIGN_TOP, SAMP_TXT, len);
      page.EndText;

      // HPDF_VALIGN_CENTER
      rect.Left := 220;
      rect.Right := 395;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_VALIGN_CENTER');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_VALIGN_CENTER, SAMP_TXT, len);
      page.EndText;

      // HPDF_VALIGN_BOTTOM
      rect.Left := 25;
      rect.Top := 240;
      rect.Right := 200;
      rect.Bottom := rect.Top - 50;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_VALIGN_BOTTOM');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_VALIGN_BOTTOM, SAMP_TXT, len);
      page.EndText;

      // HPDF_VALIGN_JUSTIFY_ALL
      rect.Left := 220;
      rect.Right := 395;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_VALIGN_JUSTIFY_ALL');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_VALIGN_JUSTIFY_ALL, SAMP_TXT, len);
      page.EndText;

      // HPDF_VALIGN_CENTER or HPDF_TALIGN_CENTER
      rect.Left := 25;
      rect.Top := 160;
      rect.Right := 200;
      rect.Bottom := rect.Top - 50;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 14, 'HPDF_VALIGN_CENTER or');
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_TALIGN_CENTER');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_VALIGN_CENTER or HPDF_TALIGN_CENTER, SAMP_TXT, len);
      page.EndText;

      // HPDF_VALIGN_CENTER or HPDF_TALIGN_JUSTIFY
      rect.Left := 220;
      rect.Right := 395;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 14, 'HPDF_VALIGN_CENTER or');
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_TALIGN_JUSTIFY');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_VALIGN_CENTER or HPDF_TALIGN_JUSTIFY, SAMP_TXT, len);
      page.EndText;

      // HPDF_VALIGN_STRETCH_ALL or HPDF_TALIGN_STRETCH_ALL
      rect.Left := 25;
      rect.Top := 80;
      rect.Right := 200;
      rect.Bottom := rect.Top - 50;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 14, 'HPDF_VALIGN_STRETCH_ALL or');
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_TALIGN_STRETCH_ALL');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_VALIGN_STRETCH_ALL or HPDF_TALIGN_STRETCH_ALL, SAMP_TXT, len);
      page.EndText;

      // HPDF_VALIGN_BOTTOM or HPDF_TALIGN_RIGHT
      rect.Left := 220;
      rect.Right := 395;

      page.Rectangle(rect);
      page.Stroke;

      page.BeginText;
      page.SetFontAndSize(font, 10);
      page.TextOut(rect.Left, rect.Top + 14, 'HPDF_VALIGN_BOTTOM or');
      page.TextOut(rect.Left, rect.Top + 3, 'HPDF_TALIGN_RIGHT');
      page.SetFontAndSize(font, 13);
      page.TextRect(rect, HPDF_VALIGN_BOTTOM or HPDF_TALIGN_RIGHT, SAMP_TXT, len);
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
    'Text alignment',
    'Prints text in a rectangle, with horizontal, vertical and mixed text alignment.',
    'Text',
    'demos\text_align.pdf',
    'demos\text_align.png',
    TTextAlignDemo);

end.
