unit text_circle;

interface
uses
  System.Classes, System.Types, demoMgr,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TTextCircleDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function TTextCircleDemo.StartDemo(AFileName: String): Boolean;
var
  pdf: THaruDocument;
  page: THaruPage;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // add a new page
      page := pdf.Pages.Add;
      page.Width := 320;
      page.Height := 340;

      page.GrayStroke := 0;
      page.LineWidth := 0.5;

      // big circle
      page.Circle(160, 170, 145);
      page.Circle(160, 170, 113);
      page.Stroke;

      page.SetFontAndSize(pdf.Fonts.GetFont('Courier-Bold'), 30);
      page.BeginText;
      page.TextOutCircle(160, 170, 122, 0, 'Text on a circular path, start angle set to 0. ');
      page.EndText;

      // inner text
      page.SetFontAndSize(pdf.Fonts.GetFont('Courier'), 12);
      page.BeginText;
      page.TextOutCircle(160, 170, 66, 180, 'Text on a circular path, start angle set to 180. ');
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
    'Text on circular path',
    'Example usage of TextOutCircle function.',
    'Text',
    'demos\text_circle.pdf',
    'demos\text_circle.png',
    TTextCircleDemo);

end.
