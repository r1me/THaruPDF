unit ttfont_demo;

interface
uses
  System.Classes, demoMgr,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TTTFFontDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function TTTFFontDemo.StartDemo(AFileName: String): Boolean;
const
  SAMP_TXT = 'The quick brown fox jumps over the lazy dog.';
var
  pdf: THaruDocument;
  title_font: THaruFont;
  detail_font_name: String;
  detail_font: THaruFont;
  page: THaruPage;
  page_height, page_width: Single;
  pw: Single;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // add a new page
      page := pdf.Pages.Add;

      detail_font_name := pdf.Fonts.LoadTTFontFromFile('resources\Anonymous Pro.ttf', [foEmbedding]);
      detail_font := pdf.Fonts.GetFont(detail_font_name);

      title_font := pdf.Fonts.GetFont('Helvetica');
      page.SetFontAndSize(title_font, 10);

      page.BeginText;

      // move the position of the text to top of the page
      page.MoveTextPos(10, 190);
      page.ShowText(detail_font_name + ' (Embedded Subset)');

      page.SetFontAndSize(detail_font, 15);
      page.MoveTextPos(10, -20);
      page.ShowText('abcdefghijklmnopqrstuvwxyz');
      page.MoveTextPos(0, -20);
      page.ShowText('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
      page.MoveTextPos(0, -20);
      page.ShowText('1234567890');
      page.MoveTextPos(0, -20);

      page.SetFontAndSize(detail_font, 10);
      page.ShowText(SAMP_TXT);
      page.MoveTextPos(0, -18);

      page.SetFontAndSize(detail_font, 16);
      page.ShowText(SAMP_TXT);
      page.MoveTextPos(0, -27);

      page.SetFontAndSize(detail_font, 23);
      page.ShowText(SAMP_TXT);
      page.MoveTextPos(0, -36);

      page.SetFontAndSize(detail_font, 30);
      page.ShowText(SAMP_TXT);
      page.MoveTextPos(0, -36);

      pw := page.TextWidth(SAMP_TXT);
      page_height := 210;
      page_width := pw + 40;

      page.Width := page_width;
      page.Height := page_height;

      // finish to print text
      page.EndText;

      page.LineWidth := 0.5;
      page.MoveTo(10, page_height - 25);
      page.LineTo(page_width - 10, page_height - 25);
      page.Stroke;
      page.MoveTo(10, page_height - 85);
      page.LineTo(page_width - 10, page_height - 85);
      page.Stroke;

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
    'Embed TTF font',
    'Embeds a TTF font into a document.',
    'Text',
    'demos\ttfont_demo.pdf',
    'demos\ttfont_demo.png',
    TTTFFontDemo);

end.
