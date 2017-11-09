unit encryption;

interface
uses
  System.Classes, demoMgr,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TEncryptionDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function TEncryptionDemo.StartDemo(AFileName: String): Boolean;
const
  text = 'This is an encrypted document example.';
  owner_passwd = 'owner';
  user_passwd = 'user';
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

      page.SetSize(HPDF_PAGE_SIZE_B5, HPDF_PAGE_LANDSCAPE);

      page.BeginText;
      page.SetFontAndSize(font, 20);
      tw := page.TextWidth(text);
      page.MoveTextPos((page.Width - tw) / 2, (page.Height  - 20) / 2);
      page.ShowText(text);
      page.EndText;

      pdf.SetPassword(owner_passwd, user_passwd);

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
    'Password',
    'An encrypt document example. Owner password: "owner", user password: "user".',
    'General',
    'demos\encryption.pdf',
    'demos\encryption.png',
    TEncryptionDemo);

end.
