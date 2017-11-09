unit permission;

interface
uses
  System.Classes, demoMgr,
  hpdf_consts,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TPermissionDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function TPermissionDemo.StartDemo(AFileName: String): Boolean;
const
  text = 'User cannot print and copy this document.';
  owner_passwd = 'owner';
  user_passwd = '';
var
  pdf: THaruDocument;
  font: THaruFont;
  page: THaruPage;
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
      page.MoveTextPos((page.Width - tw) / 2, (page.Height - 20) / 2);
      page.ShowText(text);
      page.EndText;

      pdf.SetPassword(owner_passwd, user_passwd);
      pdf.SetPermission(HPDF_ENABLE_READ);
      pdf.SetEncryptionMode(HPDF_ENCRYPT_R3, 16);

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
    'Permissions',
    'User can not print and copy content of this document.',
    'General',
    'demos\permission.pdf',
    'demos\permission.png',
    TPermissionDemo);

end.
