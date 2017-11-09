unit page_boundary;

interface
uses
  System.Classes, System.Types, demoMgr,
  harupdf.document,
  harupdf.page,
  harupdf.font,
  harupdf.image,
  hpdf_consts,
  hpdf_types;

type
  TPageBoundaryDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function TPageBoundaryDemo.StartDemo(AFileName: String): Boolean;
var
  pdf: THaruDocument;
  page: THaruPage;
  font: THaruFont;
  headline_font: THaruFont;
  artwork_image: THaruImage;
  mediaBox, bleedBox,
  trimBox, artBox: TRectF;
  len: Integer;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      pdf.SetCompressionMode(HPDF_COMP_ALL);

      // add a new page
      page := pdf.Pages.Add;
      page.Width := 280;
      page.Height := 340;

      font := pdf.Fonts.GetFont('Helvetica');
      headline_font := pdf.Fonts.GetFont('Times-Bold');
      page.SetFontAndSize(font, 8);

      // HPDF_PAGE_MEDIABOX
      mediaBox := TRectF.Create(0, page.Height, page.Width, 0);
      page.SetBoundary(HPDF_PAGE_MEDIABOX, mediaBox);

      // printer's marks
      page.LineWidth := 3;
      page.RGBStroke := THPDF_RGBColor.Create(0, 0, 0);
      page.MoveTo(mediaBox.Left, mediaBox.Bottom + 50);
      page.LineTo(mediaBox.Right, mediaBox.Bottom + 50);
      page.Stroke;

      page.MoveTo(mediaBox.Left, mediaBox.Top - 50);
      page.LineTo(mediaBox.Right, mediaBox.Top - 50);
      page.Stroke;

      page.MoveTo(mediaBox.Left + 50, mediaBox.Bottom);
      page.LineTo(mediaBox.Left + 50, mediaBox.Top);
      page.Stroke;

      page.MoveTo(mediaBox.Right - 50, mediaBox.Bottom);
      page.LineTo(mediaBox.Right - 50, mediaBox.Top);
      page.Stroke;

      page.LineWidth := 0.8;
      page.SetDash([3.0, 7], 2);
      page.RGBStroke := THPDF_RGBColor.Create(0.7, 0, 0);
      page.Rectangle(mediaBox);
      page.Stroke;

      page.BeginText;
      page.TextOut(mediaBox.Left + 4, mediaBox.Bottom + 4, 'Media box');
      page.EndText;

      // HPDF_PAGE_CROPBOX, HPDF_PAGE_BLEEDBOX
      bleedBox := TRectF.Create(30, page.Height - 30, page.Width - 30, 30);
      page.SetBoundary(HPDF_PAGE_CROPBOX, bleedBox);
      page.SetBoundary(HPDF_PAGE_BLEEDBOX, bleedBox);

      page.RGBStroke := THPDF_RGBColor.Create(0, 0, 0.7);
      page.RGBFill := THPDF_RGBColor.Create(1, 1, 1);
      page.Rectangle(bleedBox);
      page.FillStroke;

      page.RGBFill := THPDF_RGBColor.Create(0.2, 0.6, 0.2);;
      page.Rectangle(bleedBox.Left, bleedBox.Bottom, bleedBox.Width, 200);
      page.Fill;

      page.RGBFill := THPDF_RGBColor.Create(0, 0, 0);
      page.BeginText;
      page.TextOut(bleedBox.Left + 4, bleedBox.Bottom + 4, 'Crop & bleed box');
      page.EndText;

      // HPDF_PAGE_TRIMBOX
      trimBox := TRectF.Create(42, page.Height - 42, page.Width - 42, 42);
      page.SetBoundary(HPDF_PAGE_TRIMBOX, trimBox);

      page.RGBStroke := THPDF_RGBColor.Create(0.1, 0.4, 0.75);
      page.Rectangle(trimBox);
      page.Stroke;

      page.RGBFill := THPDF_RGBColor.Create(0, 0, 0);
      page.BeginText;
      page.TextOut(trimBox.Left + 4, trimBox.Bottom + 4, 'Trim box');
      page.EndText;

      // HPDF_PAGE_ARTBOX
      artBox := TRectF.Create(65, trimBox.Top - 85, page.Width - 65, 65);
      page.SetBoundary(HPDF_PAGE_ARTBOX, artBox);

      page.RGBStroke := THPDF_RGBColor.Create(0.5, 0, 1);
      page.Rectangle(artBox);
      page.Stroke;

      page.RGBFill := THPDF_RGBColor.Create(0, 0, 0);
      page.BeginText;
      page.TextOut(artBox.Left + 4, artBox.Bottom + 4, 'Art box');
      page.EndText;

      // draw artwork image
      artwork_image := pdf.LoadPngImageFromFile('resources\world.png');
      page.DrawImage(artwork_image, artBox.Left + 15, artBox.Bottom + 15, artBox.Width - 30, artBox.Width - 30);

      // print headline
      page.SetFontAndSize(headline_font, 20);
      page.BeginText;
      page.TextRect(TRectF.Create(trimBox.Left, trimBox.Top, trimBox.Right, trimBox.Top - 60),
        HPDF_TALIGN_CENTER or HPDF_VALIGN_BOTTOM, 'This is a headline', len);
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
    'Page boundary',
    '',
    'Text',
    'demos\page_boundary.pdf',
    'demos\page_boundary.png',
    TPageBoundaryDemo);

end.
