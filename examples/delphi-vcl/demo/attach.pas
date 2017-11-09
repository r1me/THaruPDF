unit attach;

interface
uses
  System.Classes, demoMgr,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TAttachDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function TAttachDemo.StartDemo(AFileName: String): Boolean;
const
  text = 'This PDF should have an attachment named attach.pas';
var
  page: THaruPage;
  font: THaruFont;
  pdf: THaruDocument;
  tw: Single;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // create default-font
      font := pdf.Fonts.GetFont('Helvetica');

      // add a new page
      page := pdf.Pages.Add;

      page.SetSize(HPDF_PAGE_SIZE_LETTER, HPDF_PAGE_PORTRAIT);

      page.BeginText;
      page.SetFontAndSize(font, 20);
      tw := page.TextWidth(text);
      page.MoveTextPos((page.Width - tw) / 2, (page.Height  - 20) / 2);
      page.ShowText(text);
      page.EndText;

      // attach a file to the document
      pdf.AttachFile('resources\attach.pas');

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
    'File attachment',
    'Attach a file to PDF document.',
    'General',
    'demos\attach.pdf',
    'demos\attach.png',
    TAttachDemo);

end.
