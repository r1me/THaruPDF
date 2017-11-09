unit blend_mode;

interface
uses
  System.Classes, demoMgr,
  hpdf,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TBlendModeDemo = class(TDemo)
  private
    procedure DrawCircles(APage: THaruPage; ADescription: String; Ax, Ay: Single);
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

procedure TBlendModeDemo.DrawCircles(APage: THaruPage; ADescription: String; Ax, Ay: Single);
begin
  APage.LineWidth := 1.0;
  APage.RGBStroke := THPDF_RGBColor.Create(0.0, 0.0, 0.0);
  APage.RGBFill := THPDF_RGBColor.Create(1.0, 0.0, 0.0);
  APage.Circle(Ax + 40, Ay + 40, 40);
  APage.ClosePathFillStroke;
  APage.RGBFill := THPDF_RGBColor.Create(0.0, 1.0, 0.0);
  APage.Circle(Ax + 100, Ay + 40, 40);
  APage.ClosePathFillStroke;
  APage.RGBFill := THPDF_RGBColor.Create(0.0, 0.0, 1.0);
  APage.Circle(Ax + 70, Ay + 74.64, 40);
  APage.ClosePathFillStroke;

  APage.RGBFill := THPDF_RGBColor.Create(0.0, 0.0, 0.0);
  APage.BeginText;
  APage.TextOut(Ax, Ay + 130, ADescription);
  APage.EndText;
end;

function TBlendModeDemo.StartDemo(AFileName: String): Boolean;
const
  PAGE_WIDTH = 600.0;
  PAGE_HEIGHT = 900.0;
var
  pdf: THaruDocument;
  page: THaruPage;
  hfont: THaruFont;
  gstate: HPDF_ExtGState;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      hfont := pdf.Fonts.GetFont('Helvetica-Bold');

      // add a new page
      page := pdf.Pages.Add;

      page.SetFontAndSize(hfont, 10);

      page.Height := PAGE_HEIGHT;
      page.Width := PAGE_WIDTH;

      // normal
      page.GSave;
      DrawCircles(page, 'normal', 40.0, PAGE_HEIGHT - 170);
      page.GRestore;

      // transparency (0.8)
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetAlphaFill(gstate, 0.8);
      pdf.ExtGStateSetAlphaStroke(gstate, 0.8);
      page.SetExtGState(gstate);
      DrawCircles(page, 'alpha fill = 0.8', 230.0, PAGE_HEIGHT - 170);
      page.GRestore;

      // transparency (0.4)
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetAlphaFill(gstate, 0.4);
      page.SetExtGState(gstate);
      DrawCircles(page, 'alpha fill = 0.4', 420.0, PAGE_HEIGHT - 170);
      page.GRestore;

      // blend-mode=HPDF_BM_MULTIPLY
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_MULTIPLY);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_MULTIPLY', 40.0, PAGE_HEIGHT - 340);
      page.GRestore;

      // blend-mode=HPDF_BM_SCREEN
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_SCREEN);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_SCREEN', 230.0, PAGE_HEIGHT - 340);
      page.GRestore;

      // blend-mode=HPDF_BM_OVERLAY
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_OVERLAY);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_OVERLAY', 420.0, PAGE_HEIGHT - 340);
      page.GRestore;

      // blend-mode=HPDF_BM_DARKEN
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_DARKEN);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_DARKEN', 40.0, PAGE_HEIGHT - 510);
      page.GRestore;

      // blend-mode=HPDF_BM_LIGHTEN
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_LIGHTEN);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_LIGHTEN', 230.0, PAGE_HEIGHT - 510);
      page.GRestore;

      // blend-mode=HPDF_BM_COLOR_DODGE
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_COLOR_DODGE);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_COLOR_DODGE', 420.0, PAGE_HEIGHT - 510);
      page.GRestore;


      // blend-mode=HPDF_BM_COLOR_BUM
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_COLOR_BUM);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_COLOR_BUM', 40.0, PAGE_HEIGHT - 680);
      page.GRestore;

      // blend-mode=HPDF_BM_HARD_LIGHT
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_HARD_LIGHT);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_HARD_LIGHT', 230.0, PAGE_HEIGHT - 680);
      page.GRestore;

      // blend-mode=HPDF_BM_SOFT_LIGHT
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_SOFT_LIGHT);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_SOFT_LIGHT', 420.0, PAGE_HEIGHT - 680);
      page.GRestore;

      // blend-mode=HPDF_BM_DIFFERENCE
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_DIFFERENCE);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_DIFFERENCE', 40.0, PAGE_HEIGHT - 850);
      page.GRestore;


      // blend-mode=HPDF_BM_EXCLUSHON
      page.GSave;
      gstate := pdf.CreateExtGState;
      pdf.ExtGStateSetBlendMode(gstate, HPDF_BM_EXCLUSHON);
      page.SetExtGState(gstate);
      DrawCircles(page, 'HPDF_BM_EXCLUSHON', 230.0, PAGE_HEIGHT - 850);
      page.GRestore;


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
    'Blend mode',
    'Blend mode controls how new content is painted and allows the new pixels to be effected by what has already been drawn.',
    'Graphics',
    'demos\blend_mode.pdf',
    'demos\blend_mode.png',
    TBlendModeDemo);

end.
