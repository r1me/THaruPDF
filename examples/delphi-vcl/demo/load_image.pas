unit load_image;

interface
uses
  System.Classes, demoMgr,
  hpdf_consts,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font,
  harupdf.destination,
  harupdf.image;

type
  TLoadImageDemo = class(TDemo)
  private
    procedure DrawJPGImage(ADocument: THaruDocument; AFileName: String; Ax, Ay: Single; AText: String);
    procedure DrawPNGImage(ADocument: THaruDocument; AFileName: String; Ax, Ay: Single; AText: String);
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

const
  RAW_IMAGE_DATA: array[0..127] of Byte = (
    $ff, $ff, $ff, $fe, $ff, $ff, $ff, $fc,
    $ff, $ff, $ff, $f8, $ff, $ff, $ff, $f0,
    $f3, $f3, $ff, $e0, $f3, $f3, $ff, $c0,
    $f3, $f3, $ff, $80, $f3, $33, $ff, $00,
    $f3, $33, $fe, $00, $f3, $33, $fc, $00,
    $f8, $07, $f8, $00, $f8, $07, $f0, $00,
    $fc, $cf, $e0, $00, $fc, $cf, $c0, $00,
    $ff, $ff, $80, $00, $ff, $ff, $00, $00,
    $ff, $fe, $00, $00, $ff, $fc, $00, $00,
    $ff, $f8, $0f, $e0, $ff, $f0, $0f, $e0,
    $ff, $e0, $0c, $30, $ff, $c0, $0c, $30,
    $ff, $80, $0f, $e0, $ff, $00, $0f, $e0,
    $fe, $00, $0c, $30, $fc, $00, $0c, $30,
    $f8, $00, $0f, $e0, $f0, $00, $0f, $e0,
    $e0, $00, $00, $00, $c0, $00, $00, $00,
    $80, $00, $00, $00, $00, $00, $00, $00
  );

procedure TLoadImageDemo.DrawJPGImage(ADocument: THaruDocument; AFileName: String; Ax, Ay: Single; AText: String);
var
  page: THaruPage;
  image: THaruImage;
begin
  page := ADocument.Pages.CurrentPage;
  image := ADocument.LoadJpegImageFromFile('resources\images\' + AFileName);

  // Draw image to the canvas
  page.DrawImage(image, Ax, Ay);

  // Print the text
  page.BeginText;
  page.TextLeading := 16;
  page.MoveTextPos(Ax, Ay);
  page.ShowTextNextLine(AFileName);
  page.ShowTextNextLine(AText);
  page.EndText;
end;

procedure TLoadImageDemo.DrawPNGImage(ADocument: THaruDocument; AFileName: String; Ax, Ay: Single; AText: String);
var
  page: THaruPage;
  image: THaruImage;
begin
  page := ADocument.Pages.CurrentPage;
  image := ADocument.LoadPngImageFromFile('resources\pngsuite\' + AFileName);

  // Draw image to the canvas
  page.DrawImage(image, Ax, Ay);

  // Print the text
  page.BeginText;
  page.TextLeading := 16;
  page.MoveTextPos(Ax, Ay);
  page.ShowTextNextLine(AFileName);
  page.ShowTextNextLine(AText);
  page.EndText;
end;

function TLoadImageDemo.StartDemo(AFileName: String): Boolean;
var
  pdf: THaruDocument;
  font: THaruFont;
  page: THaruPage;
  dst: THaruDestination;
  image: THaruImage;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      pdf.SetCompressionMode(HPDF_COMP_ALL);

      // create default-font
      font := pdf.Fonts.GetFont('Helvetica');

      // JPG images page
      page := pdf.Pages.Add;
      page.Width := 650;
      page.Height := 500;
      page.SetFontAndSize(font, 12);

      dst := page.Destinations.Add;
      dst.SetXYZ(0, page.Height, 1);
      pdf.SetOpenAction(dst);

      DrawJPGImage(pdf, 'rgb.jpg', 70, page.Height - 410, '24bit color image');
      DrawJPGImage(pdf, 'gray.jpg', 340, page.Height - 410, '8bit grayscale image');

      // PNG images page
      page := pdf.Pages.Add;
      page.Width := 550;
      page.Height := 590;
      page.SetFontAndSize(font, 12);

      DrawPNGImage(pdf, 'basn0g01.png', 100, page.Height - 120, '1bit grayscale.');
      DrawPNGImage(pdf, 'basn0g02.png', 200, page.Height - 120, '2bit grayscale.');
      DrawPNGImage(pdf, 'basn0g04.png', 300, page.Height - 120, '4bit grayscale.');
      DrawPNGImage(pdf, 'basn0g08.png', 400, page.Height - 120, '8bit grayscale.');

      DrawPNGImage(pdf, 'basn2c08.png', 100, page.Height - 220, '8bit color.');
      DrawPNGImage(pdf, 'basn2c16.png', 200, page.Height - 220, '16bit color.');

      DrawPNGImage(pdf, 'basn3p01.png', 100, page.Height - 320, '1bit pallet.');
      DrawPNGImage(pdf, 'basn3p02.png', 200, page.Height - 320, '2bit pallet.');
      DrawPNGImage(pdf, 'basn3p04.png', 300, page.Height - 320, '4bit pallet.');
      DrawPNGImage(pdf, 'basn3p08.png', 400, page.Height - 320, '8bit pallet.');

      DrawPNGImage(pdf, 'basn4a08.png', 100, page.Height - 420, '8bit alpha.');
      DrawPNGImage(pdf, 'basn4a16.png', 200, page.Height - 420, '16bit alpha.');

      DrawPNGImage(pdf, 'basn6a08.png', 100, page.Height - 520, '8bit alpha.');
      DrawPNGImage(pdf, 'basn6a16.png', 200, page.Height - 520, '16bit alpha.');

      // RAW images page
      page := pdf.Pages.Add;
      page.Width := 172;
      page.Height := 80;
      page.SetFontAndSize(font, 12);

      // load RGB raw-image file
      image := pdf.LoadRawImageFromFile('resources\rawimage\32_32_rgb.dat', 32, 32, HPDF_CS_DEVICE_RGB);
      page.DrawImage(image, 20, 20, 32, 32);

      // load GrayScale raw-image file
      image := pdf.LoadRawImageFromFile('resources\rawimage\32_32_gray.dat', 32, 32, HPDF_CS_DEVICE_GRAY);
      page.DrawImage(image, 70, 20, 32, 32);

      // load GrayScale raw-image (1bit) file from memory
      image := pdf.LoadRawImageFromMem(@RAW_IMAGE_DATA, 32, 32, HPDF_CS_DEVICE_GRAY, 1,
        SizeOf(RAW_IMAGE_DATA), True);
      page.DrawImage(image, 120, 20, 32, 32);

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
    'Load image from file',
    'Load JPEG/PNG and raw images from files and memory.',
    'Graphics',
    'demos\load_image.pdf',
    'demos\load_image.png',
    TLoadImageDemo);

end.
