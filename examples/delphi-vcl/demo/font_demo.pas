unit font_demo;

interface
uses
  System.Classes, demoMgr,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TFontDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

const
  font_list: array[0..13] of String = (
    'Courier',
    'Courier-Bold',
    'Courier-Oblique',
    'Courier-BoldOblique',
    'Helvetica',
    'Helvetica-Bold',
    'Helvetica-Oblique',
    'Helvetica-BoldOblique',
    'Times-Roman',
    'Times-Bold',
    'Times-Italic',
    'Times-BoldItalic',
    'Symbol',
    'ZapfDingbats'
  );

function TFontDemo.StartDemo(AFileName: String): Boolean;
const
  page_title = 'Font Demo';
  samp_text = 'abcdefgABCDEFG12345!#$%&+-@?';
var
  page: THaruPage;
  def_font: THaruFont;
  font: THaruFont;
  pdf: THaruDocument;
  tw: Single;
  width, height: Single;
  i: Integer;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // add a new page
      page := pdf.Pages.Add;

      height := page.Height;
      width := page.Width;

      // print the lines of the page
      page.LineWidth := 1;
      page.Rectangle(50, 50, width - 100, height - 110);
      page.Stroke;

      // print the title of the page (with positioning center)
      def_font := pdf.Fonts.GetFont('Helvetica');
      page.SetFontAndSize(def_font, 24);

      tw := page.TextWidth(page_title);
      page.BeginText;
      page.TextOut((width - tw) / 2, height - 50, page_title);
      page.EndText;

      // output subtitle
      page.BeginText;
      page.SetFontAndSize(def_font, 16);
      page.TextOut(60, height - 80, '<Standard Type1 fonts samples>');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(60, height - 105);

      for i := Low(font_list) to High(font_list) do
      begin
        font := pdf.Fonts.GetFont(font_list[i]);

        // print a label of text
        page.SetFontAndSize(def_font, 9);
        page.ShowText(font_list[i]);
        page.MoveTextPos(0, -18);

        // print a sample text
        page.SetFontAndSize(font, 20);
        page.ShowText(samp_text);
        page.MoveTextPos(0, -20);
      end;

      page.EndText;

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
    'Standard fonts',
    'Shows the base 14 fonts, that should be available in most PDF readers.',
    'Text',
    'demos\font_demo.pdf',
    'demos\font_demo.png',
    TFontDemo);

end.
