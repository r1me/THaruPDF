unit text_annotation;

interface
uses
  System.Classes, System.Types, demoMgr,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font,
  harupdf.annotation,
  harupdf.encoder;

type
  TTextAnnotationDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

function TTextAnnotationDemo.StartDemo(AFileName: String): Boolean;
const
  rect1: TRectF = (Left: 50; Top: 400; Right: 150; Bottom: 350);
  rect2: TRectF = (Left: 210; Top: 400; Right: 350; Bottom: 350);
  rect3: TRectF = (Left: 50; Top: 300; Right: 150; Bottom: 250);
  rect4: TRectF = (Left: 210; Top: 300; Right: 350; Bottom: 250);
  rect5: TRectF = (Left: 50; Top: 200; Right: 150; Bottom: 150);
  rect6: TRectF = (Left: 210; Top: 200; Right: 350; Bottom: 150);
  rect7: TRectF = (Left: 50; Top: 100; Right: 150; Bottom: 50);
  rect8: TRectF = (Left: 210; Top: 100; Right: 350; Bottom: 50);
var
  pdf: THaruDocument;
  page: THaruPage;
  font: THaruFont;
  encoding: THaruEncoder;
  annot: THaruAnnotation;
begin
  Result := False;

  try
    pdf := THaruDocument.Create;
    try
      // use Times-Roman font
      font := pdf.Fonts.GetFont('Times-Roman');

      page := pdf.Pages.Add;

      page.Width := 400;
      page.Height := 500;

      page.BeginText;
      page.SetFontAndSize(font, 16);
      page.MoveTextPos(130, 450);
      page.ShowText('Annotation Demo');
      page.EndText;

      annot := page.Annotations.AddTextAnnot(rect1, 'Annotation with Comment Icon.' + #10 +
        'This annotation is set to be opened initially.');
      annot.TextAnnot_SetIcon(HPDF_ANNOT_ICON_COMMENT);
      annot.TextAnnot_SetOpened(True);

      annot := page.Annotations.AddTextAnnot(rect2, 'Annotation with Key Icon');
      annot.TextAnnot_SetIcon(HPDF_ANNOT_ICON_KEY);

      annot := page.Annotations.AddTextAnnot(rect3, 'Annotation with Note Icon');
      annot.TextAnnot_SetIcon(HPDF_ANNOT_ICON_NOTE);

      annot := page.Annotations.AddTextAnnot(rect4, 'Annotation with Help Icon');
      annot.TextAnnot_SetIcon(HPDF_ANNOT_ICON_HELP);

      annot := page.Annotations.AddTextAnnot(rect5, 'Annotation with NewParagraph Icon');
      annot.TextAnnot_SetIcon(HPDF_ANNOT_ICON_NEW_PARAGRAPH);

      annot := page.Annotations.AddTextAnnot(rect6, 'Annotation with Paragraph Icon');
      annot.TextAnnot_SetIcon(HPDF_ANNOT_ICON_PARAGRAPH);

      annot := page.Annotations.AddTextAnnot(rect7, 'Annotation with Insert Icon');
      annot.TextAnnot_SetIcon(HPDF_ANNOT_ICON_INSERT);

      encoding := pdf.Encoder.GetEncoder('ISO8859-2');
      page.Annotations.AddTextAnnot(rect8, '', encoding,
        PAnsiChar('Annotation with ISO8859 text ±ê¶æñó³¿¼'));

      page.SetFontAndSize(font, 11);

      page.BeginText;
      page.MoveTextPos(rect1.Left + 35, rect1.Top - 20);
      page.ShowText('Comment Icon.');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(rect2.Left + 35, rect2.Top - 20);
      page.ShowText('Key Icon.');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(rect3.Left + 35, rect3.Top - 20);
      page.ShowText('Note Icon.');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(rect4.Left + 35, rect4.Top - 20);
      page.ShowText('Help Icon.');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(rect5.Left + 35, rect5.Top - 20);
      page.ShowText('NewParagraph Icon.');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(rect6.Left + 35, rect6.Top - 20);
      page.ShowText('Paragraph Icon.');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(rect7.Left + 35, rect7.Top - 20);
      page.ShowText('Insert Icon.');
      page.EndText;

      page.BeginText;
      page.MoveTextPos(rect8.Left + 35, rect8.Top - 20);
      page.ShowText('Text Icon (ISO8859-2 text)');
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
    'Text annotation',
    'Print text annotations with all available built-in icons.',
    'Text',
    'demos\text_annotation.pdf',
    'demos\text_annotation.png',
    TTextAnnotationDemo);

end.
