unit arc_demo;

interface
uses
  System.Classes, System.Types, demoMgr,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TArcDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation
uses
  grid;

function TArcDemo.StartDemo(AFileName: String): Boolean;
var
  page: THaruPage;
  currPos: TPointF;
  pdf: THaruDocument;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // add a new page
      page := pdf.Pages.Add;

      page.Height := 220;
      page.Width := 200;

      // draw grid to the page
      PrintGrid(pdf, page);

      {* draw pie chart
       *
       *   A: 45% Red
       *   B: 25% Blue
       *   C: 15% green
       *   D: other yellow
       *}

      // A
      page.RGBFill := THPDF_RGBColor.Create(1, 0, 0);
      page.MoveTo(100, 100);
      page.LineTo(100, 180);
      page.Arc(100, 100, 80, 0, 360 * 0.45);
      currPos := page.GetCurrentPos;
      page.LineTo(100, 100);
      page.Fill;

      // B
      page.RGBFill := THPDF_RGBColor.Create(0, 0, 1);
      page.MoveTo(100, 100);
      page.LineTo(currPos.X, currPos.Y);
      page.Arc(100, 100, 80, 360 * 0.45, 360 * 0.7);
      currPos := page.GetCurrentPos;
      page.LineTo(100, 100);
      page.Fill;

      // C
      page.RGBFill := THPDF_RGBColor.Create(0, 1, 0);
      page.MoveTo(100, 100);
      page.LineTo(currPos.X, currPos.Y);
      page.Arc(100, 100, 80, 360 * 0.7, 360 * 0.85);
      currPos := page.GetCurrentPos;
      page.LineTo(100, 100);
      page.Fill;

      // D
      page.RGBFill := THPDF_RGBColor.Create(1, 1, 0);
      page.MoveTo(100, 100);
      page.LineTo(currPos.X, currPos.Y);
      page.Arc(100, 100, 80, 360 * 0.85, 360);
      currPos := page.GetCurrentPos;
      page.LineTo(100, 100);
      page.Fill;

      // draw center circle
      page.GrayStroke := 0;
      page.GrayFill := 1;
      page.Circle(100, 100, 30);
      page.Fill;

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
    'Pie chart (multiple arc)',
    'Draws a pie chart.',
    'Graphics',
    'demos\arc_demo.pdf',
    'demos\arc_demo.png',
    TArcDemo);

end.
