unit pdfa_demo;

interface
uses
  System.Classes, System.Types, System.SysUtils, demoMgr,
  harupdf.document,
  harupdf.page,
  harupdf.font,
  harupdf.image,
  hpdf,
  hpdf_consts,
  hpdf_types;

type
  TPDFADemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function TPDFADemo.StartDemo(AFileName: String): Boolean;
var
  pdf: THaruDocument;
  page: THaruPage;
  font_name: String;
  font: THaruFont;
  jpg_image: THaruImage;
  dt: TDateTime;
  icc: HPDF_OutputIntent;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      pdf.SetCompressionMode(HPDF_COMP_NONE);

      // set metadata
      pdf.Creator := 'THaruPDF - PDF/A Demo';
      pdf.Producer := 'THaruPDF - PDF/A Demo';
      dt := Now;
      pdf.SetCreationDate(dt);
      pdf.SetModificationDate(dt);

      // embed font
      font_name := pdf.Fonts.LoadTTFontFromFile('resources\Anonymous Pro.ttf', [foEmbedding]);
      font := pdf.Fonts.GetFont(font_name, 'WinAnsiEncoding');

      // add a new page
      page := pdf.Pages.Add;
      page.SetSize(HPDF_PAGE_SIZE_A4, HPDF_PAGE_PORTRAIT);

      page.BeginText;
      page.SetFontAndSize(font, 18);
      page.MoveTextPos(20, page.Height - 20);
      page.ShowText('This is a PDF/A file created with THaruPDF');
      page.EndText;

      // draw JPEG image, PDF/A doesn't support transparency
      jpg_image := pdf.LoadJpegImageFromFile('resources\apple.jpg');
      page.DrawImage(jpg_image, 20, page.Height - 400);

      // set PDF/A flag in document
      if not pdf.SetPDFAConformance(HPDF_PDFA_1B) then
        raise Exception.Create('Could not convert to PDF/A 1B.');

      // embed ICC profile
      icc := pdf.LoadIccProfileFromFile('resources\AdobeRGB1998.icc', 3);
      pdf.PDFA_AppendOutputIntents('DeviceRGB', icc);

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
    'PDF/A',
    'PDF/A is an ISO-standardized version of the Portable Document Format (PDF) specialized for use ' +
      'in the archiving and long-term preservation of electronic documents.',
    'General',
    'demos\pdfa_demo.pdf',
    'demos\pdfa_demo.png',
    TPDFADemo);

end.
