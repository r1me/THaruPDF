unit bookmark_demo;

interface
uses
  System.Classes, System.SysUtils, System.Generics.Collections, demoMgr,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font,
  harupdf.destination,
  harupdf.outline;

type
  TBookmarkDemo = class(TDemo)
  private
    procedure PrintPage(APage: THaruPage; APageNum: Integer);
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

procedure TBookmarkDemo.PrintPage(APage: THaruPage; APageNum: Integer);
begin
  APage.Width := 800;
  APage.Height := 800;

  APage.BeginText;
  APage.MoveTextPos(30, 740);
  APage.ShowText(Format('Page:%d', [APageNum]));
  APage.EndText;
end;

function TBookmarkDemo.StartDemo(AFileName: String): Boolean;
var
  pdf: THaruDocument;
  font: THaruFont;
  page: array[0..2] of THaruPage;
  dst: THaruDestination;
  i: Integer;
  root: THaruOutline;
  outlines: TObjectList<THaruOutline>;
  tw: Single;
  left: Single;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // create default-font
      font := pdf.Fonts.GetFont('Helvetica');

      // set page mode to use outlines
      pdf.PageMode := HPDF_PAGE_MODE_USE_OUTLINE;

      // add 3 pages to the document
      for i := Low(page) to High(page) do
      begin
        page[i] := pdf.Pages.Add;
        page[i].SetFontAndSize(font, 30);
        PrintPage(page[i], i+1);
      end;

      page[2].BeginText;
      tw := page[2].TextWidth('last page middle');
      left := (page[2].Width - tw) / 2;
      page[2].TextOut(left, 400, 'last page middle');
      page[2].EndText;

      // create outline root
      root := pdf.Outlines.Add('OutlineRoot', nil);
      root.SetOpened(True);

      outlines := TObjectList<THaruOutline>.Create;
      try
        outlines.Add(pdf.Outlines.Add('page1', root));
        outlines.Add(pdf.Outlines.Add('page2', root));

        // create outline with text which is ISO8859-2 encoded
        outlines.Add(pdf.Outlines.Add('', root,
          pdf.Encoder.GetEncoder('ISO8859-2'), PAnsiChar('ISO8859-2 text ±ê¶æñó³¿¼')));
        outlines.Add(pdf.Outlines.Add('last page middle, zoom 1.5', root));

        // create destination objects on each pages and link it to outline items
        for i := Low(page) to High(page) do
        begin
          dst := page[i].Destinations.Add;
          dst.SetXYZ(0, page[i].Height, 1);
          outlines[i].SetDestination(dst);
        end;

        dst := page[2].Destinations.Add;
        dst.SetXYZ(left / 2, 400 + page[2].FontSize, 1.5);
        outlines[3].SetDestination(dst);

        // save the document to a file
        Result := pdf.SaveToFile(AFileName);
      finally
        outlines.Free;
        root.Free;
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
    'Bookmarks',
    'Each bookmark goes to a different view or page in the document.',
    'Navigation',
    'demos\bookmark_demo.pdf',
    'demos\bookmark_demo.png',
    TBookmarkDemo);

end.
