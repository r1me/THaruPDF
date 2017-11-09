unit link_annotation;

interface
uses
  System.Classes, System.SysUtils, System.Types, demoMgr,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font,
  harupdf.annotation,
  harupdf.destination;

type
  TLinkAnnotationDemo = class(TDemo)
  private
    procedure PrintPage(APage: THaruPage; AFont: THaruFont; APageNum: Integer);
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

procedure TLinkAnnotationDemo.PrintPage(APage: THaruPage; AFont: THaruFont; APageNum: Integer);
begin
  APage.Width := 200;
  APage.Height := 200;

  APage.SetFontAndSize(AFont, 20);

  APage.BeginText;
  APage.MoveTextPos(50, 150);
  APage.ShowText(Format('Page:%d', [APageNum]));
  APage.EndText;
end;

function TLinkAnnotationDemo.StartDemo(AFileName: String): Boolean;
const
  uri = 'http://libharu.org';
var
  pdf: THaruDocument;
  font: THaruFont;
  index_page: THaruPage;
  dst: THaruDestination;
  rect: TRectF;
  tp: TPointF;
  annot: THaruAnnotation;
  i: Integer;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // create default-font
      font := pdf.Fonts.GetFont('Helvetica');

      // create index page
      index_page := pdf.Pages.Add;
      index_page.Width := 300;
      index_page.Height := 220;

      // add 7 pages to the document
      for i := 0 to 6 do
        PrintPage(pdf.Pages.Add, font, i + 1);

      index_page.BeginText;
      index_page.SetFontAndSize(font, 10);
      index_page.MoveTextPos(15, 200);
      index_page.ShowText('Link Annotation Demo');
      index_page.EndText;

      // create Link-Annotation object on index page
      index_page.BeginText;
      index_page.SetFontAndSize(font, 8);
      index_page.MoveTextPos(20, 180);
      index_page.TextLeading := 23;

      // page1 (HPDF_ANNOT_NO_HIGHTLIGHT)
      tp := index_page.GetCurrentTextPos;

      index_page.ShowText('Jump to Page1 (HighlightMode=HPDF_ANNOT_NO_HIGHLIGHT)');
      rect.Left := tp.X - 4;
      rect.Bottom := tp.Y - 4;
      rect.Right := index_page.GetCurrentTextPos.X + 4;
      rect.Top := tp.Y + 10;

      index_page.MoveToNextLine;

      dst := pdf.Pages[1].Destinations.Add;

      annot := index_page.Annotations.AddLinkAnnot(rect, dst);
      annot.LinkAnnot_SetHighlightMode(HPDF_ANNOT_NO_HIGHLIGHT);

      // page2 (HPDF_ANNOT_INVERT_BOX)
      tp := index_page.GetCurrentTextPos;

      index_page.ShowText('Jump to Page2 (HighlightMode=HPDF_ANNOT_INVERT_BOX)');
      rect.Left := tp.X - 4;
      rect.Bottom := tp.Y - 4;
      rect.Right := index_page.GetCurrentTextPos.X + 4;
      rect.Top := tp.Y + 10;

      index_page.MoveToNextLine;

      dst := pdf.Pages[2].Destinations.Add;

      annot := index_page.Annotations.AddLinkAnnot(rect, dst);
      annot.LinkAnnot_SetHighlightMode(HPDF_ANNOT_INVERT_BOX);

      // page3 (HPDF_ANNOT_INVERT_BORDER)
      tp := index_page.GetCurrentTextPos;

      index_page.ShowText('Jump to Page3 (HighlightMode=HPDF_ANNOT_INVERT_BORDER)');
      rect.Left := tp.X - 4;
      rect.Bottom := tp.Y - 4;
      rect.Right := index_page.GetCurrentTextPos.X + 4;
      rect.Top := tp.Y + 10;

      index_page.MoveToNextLine;

      dst := pdf.Pages[3].Destinations.Add;

      annot := index_page.Annotations.AddLinkAnnot(rect, dst);
      annot.LinkAnnot_SetHighlightMode(HPDF_ANNOT_INVERT_BORDER);

      // page4 (HPDF_ANNOT_DOWN_APPEARANCE)
      tp := index_page.GetCurrentTextPos;

      index_page.ShowText('Jump to Page4 (HighlightMode=HPDF_ANNOT_DOWN_APPEARANCE)');
      rect.Left := tp.X - 4;
      rect.Bottom := tp.Y - 4;
      rect.Right := index_page.GetCurrentTextPos.X + 4;
      rect.Top := tp.Y + 10;

      index_page.MoveToNextLine;

      dst := pdf.Pages[4].Destinations.Add;

      annot := index_page.Annotations.AddLinkAnnot(rect, dst);
      annot.LinkAnnot_SetHighlightMode(HPDF_ANNOT_DOWN_APPEARANCE);

      // page5 (dash border)
      tp := index_page.GetCurrentTextPos;

      index_page.ShowText('Jump to Page5 (dash border)');
      rect.Left := tp.X - 4;
      rect.Bottom := tp.Y - 4;
      rect.Right := index_page.GetCurrentTextPos.X + 4;
      rect.Top := tp.Y + 10;

      index_page.MoveToNextLine;

      dst := pdf.Pages[5].Destinations.Add;

      annot := index_page.Annotations.AddLinkAnnot(rect, dst);
      annot.LinkAnnot_SetBorderStyle(1, 3, 2);

      // page6 (no border)
      tp := index_page.GetCurrentTextPos;

      index_page.ShowText('Jump to Page6 (no border)');
      rect.Left := tp.X - 4;
      rect.Bottom := tp.Y - 4;
      rect.Right := index_page.GetCurrentTextPos.X + 4;
      rect.Top := tp.Y + 10;

      index_page.MoveToNextLine;

      dst := pdf.Pages[6].Destinations.Add;

      annot := index_page.Annotations.AddLinkAnnot(rect, dst);
      annot.LinkAnnot_SetBorderStyle(0, 0, 0);

      // page7 (bold border)
      tp := index_page.GetCurrentTextPos;

      index_page.ShowText('Jump to Page7 (bold border)');
      rect.Left := tp.X - 4;
      rect.Bottom := tp.Y - 4;
      rect.Right := index_page.GetCurrentTextPos.X + 4;
      rect.Top := tp.Y + 10;

      index_page.MoveToNextLine;

      dst := pdf.Pages[7].Destinations.Add;

      annot := index_page.Annotations.AddLinkAnnot(rect, dst);
      annot.LinkAnnot_SetBorderStyle(2, 0, 0);

      // URI link
      tp := index_page.GetCurrentTextPos;

      index_page.ShowText('URI (' + uri + ')');
      rect.Left := tp.X - 4;
      rect.Bottom := tp.Y - 4;
      rect.Right := index_page.GetCurrentTextPos.X + 4;
      rect.Top := tp.Y + 10;

      index_page.Annotations.AddURILinkAnnot(rect, uri);

      index_page.EndText;

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
    'Link annotations',
    'Various styles (border and highlight) of clickable annotations that link to other pages and a URL.',
    'Navigation',
    'demos\link_annotation.pdf',
    'demos\link_annotation.png',
    TLinkAnnotationDemo);

end.
