unit slide_show_demo;

interface
uses
  System.Classes, System.SysUtils, System.Types, demoMgr,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font,
  harupdf.destination,
  harupdf.annotation,
  harupdf.outline;

type
  TSlideShowDemo = class(TDemo)
  private
    procedure PrintPage(APage: THaruPage; ACaption: String; AFont: THaruFont;
      AStyle: THPDF_TransitionStyle; APrevPage, ANextPage: THaruPage);
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

procedure TSlideShowDemo.PrintPage(APage: THaruPage; ACaption: String; AFont: THaruFont;
  AStyle: THPDF_TransitionStyle; APrevPage, ANextPage: THaruPage);
var
  r, g, b: Single;
  rect: TRectF;
  dst: THaruDestination;
  annot: THaruAnnotation;
begin
  r := Random(High(Word)) / High(Word);
  g := Random(High(Word)) / High(Word);
  b := Random(High(Word)) / High(Word);

  APage.Width := 800;
  APage.Height := 600;

  APage.RGBFill := THPDF_RGBColor.Create(r, g, b);

  APage.Rectangle(0, 0, 800, 600);
  APage.Fill;

  APage.RGBFill := THPDF_RGBColor.Create(1.0 - r, 1.0 - g, 1.0 - b);

  APage.SetFontAndSize(AFont, 30);

  APage.BeginText;
  APage.TextMatrix := THPDF_TransMatrix.Create(0.8, 0, 0, 1.0, 0, 0);
  APage.TextOut(50, 530, ACaption);

  APage.TextMatrix := THPDF_TransMatrix.Create(1.0, 0, 0, 1.0, 0, 0);
  APage.SetFontAndSize(AFont, 20);
  APage.TextOut(55, 300, 'Press Ctrl+L or Esc to exit full screen mode.');
  APage.EndText;

  APage.SetSlideShow(AStyle, 5, 1);
  APage.SetFontAndSize(AFont, 20);

  if Assigned(ANextPage) then
  begin
    APage.BeginText;
    APage.TextOut(680, 50, 'Next=>');
    APage.EndText;

    rect.Left := 680;
    rect.Right := 750;
    rect.Top := 70;
    rect.Bottom := 50;
    dst := ANextPage.Destinations.Add;
    dst.SetFit;
    annot := APage.Annotations.AddLinkAnnot(rect, dst);
    annot.LinkAnnot_SetBorderStyle(0, 0, 0);
    annot.LinkAnnot_SetHighlightMode(HPDF_ANNOT_INVERT_BOX);
  end;

  if Assigned(APrevPage) then
  begin
    APage.BeginText;
    APage.TextOut(50, 50, '<=Prev');
    APage.EndText;

    rect.Left := 50;
    rect.Right := 110;
    rect.Top := 70;
    rect.Bottom := 50;
    dst := APrevPage.Destinations.Add;
    dst.SetFit;
    annot := APage.Annotations.AddLinkAnnot(rect, dst);
    annot.LinkAnnot_SetBorderStyle(0, 0, 0);
    annot.LinkAnnot_SetHighlightMode(HPDF_ANNOT_INVERT_BOX);
  end;
end;

function TSlideShowDemo.StartDemo(AFileName: String): Boolean;
var
  pdf: THaruDocument;
  font: THaruFont;
  page: array[0..16] of THaruPage;
  i: Integer;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // create default-font
      font := pdf.Fonts.GetFont('Courier');

      // add 17 pages to the document
      for i := Low(page) to High(page) do
        page[i] := pdf.Pages.Add;

      PrintPage(page[0], 'HPDF_TS_WIPE_RIGHT', font,
        HPDF_TS_WIPE_RIGHT, nil, page[1]);
      PrintPage(page[1], 'HPDF_TS_WIPE_UP', font,
        HPDF_TS_WIPE_UP, page[0], page[2]);
      PrintPage(page[2], 'HPDF_TS_WIPE_LEFT', font,
        HPDF_TS_WIPE_LEFT, page[1], page[3]);
      PrintPage(page[3], 'HPDF_TS_WIPE_DOWN', font,
        HPDF_TS_WIPE_DOWN, page[2], page[4]);
      PrintPage(page[4], 'HPDF_TS_BARN_DOORS_HORIZONTAL_OUT', font,
        HPDF_TS_BARN_DOORS_HORIZONTAL_OUT, page[3], page[5]);
      PrintPage(page[5], 'HPDF_TS_BARN_DOORS_HORIZONTAL_IN', font,
        HPDF_TS_BARN_DOORS_HORIZONTAL_IN, page[4], page[6]);
      PrintPage(page[6], 'HPDF_TS_BARN_DOORS_VERTICAL_OUT', font,
        HPDF_TS_BARN_DOORS_VERTICAL_OUT, page[5], page[7]);
      PrintPage(page[7], 'HPDF_TS_BARN_DOORS_VERTICAL_IN', font,
        HPDF_TS_BARN_DOORS_VERTICAL_IN, page[6], page[8]);
      PrintPage(page[8], 'HPDF_TS_BOX_OUT', font,
        HPDF_TS_BOX_OUT, page[7], page[9]);
      PrintPage(page[9], 'HPDF_TS_BOX_IN', font,
        HPDF_TS_BOX_IN, page[8], page[10]);
      PrintPage(page[10], 'HPDF_TS_BLINDS_HORIZONTAL', font,
        HPDF_TS_BLINDS_HORIZONTAL, page[9], page[11]);
      PrintPage(page[11], 'HPDF_TS_BLINDS_VERTICAL', font,
        HPDF_TS_BLINDS_VERTICAL, page[10], page[12]);
      PrintPage(page[12], 'HPDF_TS_DISSOLVE', font,
        HPDF_TS_DISSOLVE, page[11], page[13]);
      PrintPage(page[13], 'HPDF_TS_GLITTER_RIGHT', font,
        HPDF_TS_GLITTER_RIGHT, page[12], page[14]);
      PrintPage(page[14], 'HPDF_TS_GLITTER_DOWN', font,
        HPDF_TS_GLITTER_DOWN, page[13], page[15]);
      PrintPage(page[15], 'HPDF_TS_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT', font,
        HPDF_TS_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT, page[14], page[16]);
      PrintPage(page[16], 'HPDF_TS_REPLACE', font,
        HPDF_TS_REPLACE, page[15], nil);

      pdf.PageMode := HPDF_PAGE_MODE_FULL_SCREEN;

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
    'Slideshow',
    'A slideshow document, contains several pages with different transition styles.',
    'Navigation',
    'demos\slide_show_demo.pdf',
    'demos\slide_show_demo.png',
    TSlideShowDemo);

end.
