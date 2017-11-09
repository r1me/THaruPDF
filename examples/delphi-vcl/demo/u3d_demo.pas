unit u3d_demo;

interface
uses
  System.Classes, System.Types, demoMgr,
  hpdf_consts,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font,
  harupdf.view3d,
  harupdf.image,
  harupdf.javascript;

type
  T3DDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function T3DDemo.StartDemo(AFileName: String): Boolean;
var
  pdf: THaruDocument;
  page: THaruPage;
  prc: THaruU3D;
  u3d: THaruU3D;
  js: THaruJavascript;
  defaultView, leftView: THaru3DView;
  measure: THaru3DMeasure;
  firstAnchor, textAnchor: THPDF_Point3D;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // load Product Representation Compact file
      prc := pdf.Load3DFromFile('resources\teapot.prc');
      // load Universal 3D file
      u3d := pdf.Load3DFromFile('resources\cube.u3d');
      try
        // add a new page (prc)
        page := pdf.Pages.Add;
        page.Width := 800;
        page.Height := 800;

        // add javascript
        js := THaruJavascript.CreateFromFile(pdf, 'resources\s2plot-prc.js');
        prc.AddOnInstantiate(js);

        // add default view
        defaultView := THaru3DView.Create3DView(prc, 'Default');
        defaultView.SetCamera(500, 450, 600, 0.5, 0.5, 0.5, 400, 0);
        defaultView.SetBackgroundColor(0.21, 0.15, 0.15);
        defaultView.SetLighting('Night');
        prc.Add3DView(defaultView);

        // add left perspective view
        leftView := THaru3DView.Create3DView(prc, 'Side');
        leftView.SetCamera(0, 600, 100, 0, 1, 0, 1000, 0);
        leftView.SetBackgroundColor(0.21, 0.15, 0.15);
        leftView.SetLighting('Night');
        prc.Add3DView(leftView);

        // create measurement
        // start anchor
        firstAnchor.x := 0;
        firstAnchor.y := 0;
        firstAnchor.z := -40;
        // end anchor (text)
        textAnchor.x := 0;
        textAnchor.y := 0;
        textAnchor.z := 340;
        measure := THaru3DMeasure.Create3DC3DMeasure(page, firstAnchor, textAnchor);
        try
          measure.SetName('height');
          measure.SetColor(THPDF_RGBColor.Create(1, 1, 0));
          measure.SetTextSize(24);
          measure.SetTextBoxSize(100, 50);
          measure.SetText('teapot height');
          leftView.Add3DMeasure(measure);
        finally
          measure.Free;
        end;

        // set default view
        prc.SetDefault3DView('Default');

        // create 3D annotation
        page.Annotations.Add3DAnnot(TRectF.Create(0, 800, 800, 0), True, False, prc, nil);

        // add a new page (u3d)
        page := pdf.Pages.Add;
        page.Width := 600;
        page.Height := 300;

        // create 3D annotation
        page.Annotations.Add3DAnnot(TRectF.Create(0, 300, 600, 0), True, True, u3d, nil);

        // save document to a file
        Result := pdf.SaveToFile(AFileName);
      finally
        prc.Free;
        u3d.Free;
      end;
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
    '3D: PRC & U3D',
    'Load PRC (Product Representation Compact) and U3D (Universal 3D) files and embeds them in ' +
      'separate pages. ' + #13#10 +
      'PRC page: Adds predefined camera views, measurement and start-up JavaScript. ' +
      'Press 1 or H to go back to default view, 2 for second view (left perspective).',
    'Graphics',
    'demos\3d_demo.pdf',
    'demos\3d_demo.png',
    T3DDemo);

end.
