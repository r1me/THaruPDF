unit image_demo;

interface
uses
  System.Classes, System.SysUtils, System.Math, demoMgr,
  hpdf_consts,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font,
  harupdf.destination,
  harupdf.image;

type
  TImageDemo = class(TDemo)
  private
    procedure ShowDescription(APage: THaruPage; Ax, Ay: Single; AText: String);
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

procedure TImageDemo.ShowDescription(APage: THaruPage; Ax, Ay: Single; AText: String);
var
  buf: String;
begin
  APage.MoveTo(Ax, Ay - 10);
  APage.LineTo(Ax, Ay + 10);
  APage.MoveTo(Ax - 10, Ay);
  APage.LineTo(Ax + 10, Ay);
  APage.Stroke;

  APage.SetFontAndSize(APage.Font, 8);
  APage.RGBFill := THPDF_RGBColor.Create(0, 0, 0);

  APage.BeginText;
  buf := Format('(x=%d,y=%d)', [Round(Ax), Round(Ay)]);
  APage.MoveTextPos(Ax - APage.TextWidth(buf) - 5, Ay - 10);
  APage.ShowText(buf);
  APage.EndText;

  APage.BeginText;
  APage.MoveTextPos(Ax - 20, Ay - 25);
  APage.ShowText(AText);
  APage.EndText;
end;

function TImageDemo.StartDemo(AFileName: String): Boolean;
var
  pdf: THaruDocument;
  font: THaruFont;
  page: THaruPage;
  dst: THaruDestination;
  image: THaruImage;
  image1: THaruImage;
  image2: THaruImage;
  image3: THaruImage;

  x, y: Single;
  angle: Single;
  angle1: Single;
  angle2: Single;
  rad: Single;
  rad1: Single;
  rad2: Single;

  iw, ih: Single;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      pdf.SetCompressionMode(HPDF_COMP_ALL);

      // create default-font
      font := pdf.Fonts.GetFont('Helvetica');

      // add a new page
      page := pdf.Pages.Add;

      page.Width := 550;
      page.Height := 500;

      dst := page.Destinations.Add;
      dst.SetXYZ(0, page.Height, 1);
      pdf.SetOpenAction(dst);

      page.BeginText;
      page.SetFontAndSize(font, 20);
      page.MoveTextPos(220, page.Height - 70);
      page.ShowText('ImageDemo');
      page.EndText;

      // load image file
      image := pdf.LoadPngImageFromFile('resources\pngsuite\basn3p02.png');

      // image1 is masked by image2
      image1 := pdf.LoadPngImageFromFile('resources\pngsuite\basn3p02.png');

      // image2 is a mask image
      image2 := pdf.LoadPngImageFromFile('resources\pngsuite\basn0g01.png');

      // image3 is a RGB-color image. we use this image for color-mask demo
      image3 := pdf.LoadPngImageFromFile('resources\pngsuite\maskimage.png');

      iw := image.Width;
      ih := image.Height;

      page.LineWidth := 0.5;

      x := 100;
      y := page.Height - 150;

      // draw image to the canvas. (normal-mode with actual size.)
      page.DrawImage(image, x, y, iw, ih);
      ShowDescription(page, x, y, 'Actual Size');

      x := x + 150;

      // scaling image (X direction)
      page.DrawImage(image, x, y, iw * 1.5, ih);
      ShowDescription(page, x, y, 'Scalling image (X direction)');

      x := x + 150;

      // scaling image (Y direction)
      page.DrawImage(image, x, y, iw, ih * 1.5);
      ShowDescription(page, x, y, 'Scalling image (Y direction)');

      x := 100;
      y := y - 120;

      // Skewing image
      angle1 := 10;
      angle2 := 20;
      rad1 := angle1 / 180 * 3.141592;
      rad2 := angle2 / 180 * 3.141592;

      page.GSave;

      page.Concat(iw, tan(rad1) * iw, tan(rad2) * ih, ih, x, y);

      page.ExecuteXObject(image.ImageHandle);
      page.GRestore;

      ShowDescription(page, x, y, 'Skewing image');

      x := x + 150;

      // rotating image
      angle := 30;  // rotation of 30 degrees
      rad := angle / 180 * 3.141592; // Calcurate the radian value

      page.GSave;

      page.Concat(iw * cos(rad),
                  iw * sin(rad),
                  ih * -sin(rad),
                  ih * cos(rad),
                  x, y);

      page.ExecuteXObject(image.ImageHandle);
      page.GRestore;

      ShowDescription(page, x, y, 'Rotating image');

      x := x + 150;

      // draw masked image

      // set image2 to the mask image of image1
      image1.SetMaskImage(image2);

      page.RGBFill := THPDF_RGBColor.Create(0, 0, 0);
      page.BeginText;
      page.MoveTextPos(x - 6, y + 14);
      page.ShowText('MASKMASK');
      page.EndText;

      page.DrawImage(image1, x - 3, y - 3, iw + 6, ih + 6);

      ShowDescription(page, x, y, 'masked image');

      x := 100;
      y := y - 120;

      // color mask
      page.RGBFill := THPDF_RGBColor.Create(0, 0, 0);
      page.BeginText;
      page.MoveTextPos(x - 6, y + 14);
      page.ShowText('MASKMASK');
      page.EndText;

      image3.SetColorMask(0, 255, 0, 0, 0, 255);
      page.DrawImage(image3, x, y, iw, ih);

      ShowDescription(page, x, y, 'Color Mask');

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
    'Image transformation',
    'Image drawing and transformation: scale, skew, rotate, apply color and image masks.',
    'Graphics',
    'demos\image_demo.pdf',
    'demos\image_demo.png',
    TImageDemo);

end.
