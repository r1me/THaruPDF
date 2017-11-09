unit utf_encoders;

interface
uses
  System.Classes, System.Types, System.SysUtils, demoMgr,
  hpdf_consts,
  hpdf_types,
  harupdf.document,
  harupdf.page,
  harupdf.font;

type
  TUTFEncodersDemo = class(TDemo)
  public
    function StartDemo(AFileName: String): Boolean; override;
  end;

implementation

const
  HELLO: WideString =
    'Hello.'+#$0009+' '+#$FFF9+'مرحبا.'+#$200F+#$FFFA+'marḥába'+#$FFFB+' สวัสดี'+#$000A+' नमस्कार.'+#$000C+' ' +
    'שלום.'+#$200F+' 안녕하세요．'+#$000D+#$FFF9+'你好'+#$FFFA+'nǐhǎo'+#$FFFB+'。こんにちは。'
    ;
const
  HELLO_ru: WideString =
    'Здравствуйте. '
    ;
const
  ONCE_UPON_A_TIME: WideString =
    '以前老夫婦が住んでいました。' +
    '老夫が山へ'+#$FFF9+'収穫'+#$FFFA+'しばかり'+#$FFFB+'に行きました。' +
    '老妻が川へ洗濯に行きました。' +#10+
    '老夫婦住。' +
    '老丈夫去到了收穫的山。' +
    '老妻在河裡去洗。' +#10+
    '老夫妇住。' +
    '老丈夫去到了收获的山。' +
    '老妻在河里去洗。' +#10+
    '이전 노부부가 살고있었습니다．' +
    '늙은 남편이 산에 수확에갔습니다．' +
    '늙은 아내가 강에 세탁갔습니다．' +#10+
    'Пожилая пара жила раньше. ' +
    'Старый муж пошел в урожай в горы. ' +
    'Старая жена пошла мыться в реке.' +#10+
    'Elderly couple lived before. ' +
    'Old hus'+#$00AD+'band went to the harvest to the moun'+#$00AD+'tain. ' +
    'Old wife went to wash in the river.' +#10+
    'Ηλικιωμένο ζευγάρι έζησε πριν. ' +
    'Παλιά σύζυγος πήγε να τη συγκομιδή στο βουνό. ' +
    'Παλιά η γυναίκα πήγε να πλύνει στο ποτάμι.' +#10+
    'Տարեցների զույգը ապրում է. ' +
    'Հին Ամուսինը գնաց բերքը լեռը. ' +
    'Հին կինը գնաց լվանում է գետը.'+#$200E+#10+
    'عاش زوجين مسنين من قبل. ' +
    'ذهـب الزوج القديم إلى الحصـاد إلى الجبل. ' +
    'زوجته البالغة من العمر ذهـب ليغسل في النـهر.'+#$200F+#10+
    'זוג קשישים חי בעבר. ' +
    'הבעל ישן הלך לקציר להר. ' +
    'אישה זקנה הלכה לרחוץ בנהר.'+#$200F+#10+
    'वृद्ध दम्पति से पहले रहते थे. ' +
    'ओल्ड पति पहाड़ को फसल के लिए गया था. ' +
    'पुरानी पत्नी नदी में धोने के लिए चला गया.'+#$200E+#10+
    'คู่สามีภรรยาสูงอายุ'+#$200B+'อาศัยอยู่'+#$200B+'ก่อน'+#$200B+
    'สามี'+#$200B+'เก่า'+#$200B+'ไป'+#$200B+'เก็บเกี่ยว'+#$200B+'ไปยังภูเขา'+#$200B+
    'ภรรยา'+#$200B+'เก่า'+#$200B+'ไป'+#$200B+'ล้าง'+#$200B+'ใน'+#$200B+'แม่น้ำ'+#10+#0
    ;

function TUTFEncodersDemo.StartDemo(AFileName: String): Boolean;
var
  pdf: THaruDocument;
  page: THaruPage;
  detail_font, detail_font_v, relief_font: THaruFont;
  detail_font_name: String;
  page_width, page_height: Single;
  len: Integer;
  rect: TRectF;
begin
  Result := False;

  try
    if (not FileExists('C:\Windows\Fonts\mangal.ttf')) or
       (not FileExists('C:\Windows\Fonts\gulim.ttc')) then
    begin
      raise Exception.Create('UTF Encoders example require Korean and Hindi languages to be installed ' +
        'in system (for "Gulim" and "Mangal" font). Also to be found in "Korean Supplemental Fonts" ' +
        'and "Devanagari Supplemental Fonts".')
    end;

    pdf := THaruDocument.Create;
    try
      pdf.SetCompressionMode(HPDF_COMP_IMAGE or HPDF_COMP_METADATA);

      pdf.Encoder.UseCNSEncodings;
      pdf.Fonts.UseCNSFonts;
      pdf.Encoder.UseKREncodings;
      pdf.Fonts.UseKRFonts;
      pdf.Encoder.UseUTFEncodings;

      // Devanagari
      detail_font_name := pdf.Fonts.LoadTTFontFromFile('C:\Windows\Fonts\mangal.ttf', [foEmbedding]);
      detail_font := pdf.Fonts.GetFont(detail_font_name, 'Ancient-UTF8-H');
      detail_font_v := pdf.Fonts.GetFont(detail_font_name, 'Ancient-UTF16-H');

      // Thai, Armenian
      detail_font_name := pdf.Fonts.LoadTTFontFromFile('C:\Windows\Fonts\tahoma.ttf', [foEmbedding]);
      relief_font := detail_font;
      detail_font := pdf.Fonts.GetFont(detail_font_name, 'Ancient-UTF8-H');
      detail_font.SetReliefFont(relief_font);
      relief_font := detail_font_v;
      detail_font_v := pdf.Fonts.GetFont(detail_font_name, 'Ancient-UTF16-H');
      detail_font_v.SetReliefFont(relief_font);

      // Korean
      detail_font_name := pdf.Fonts.LoadTTFontFromFile('C:\Windows\Fonts\gulim.ttc', [foEmbedding], 1);
      relief_font := detail_font;
      detail_font := pdf.Fonts.GetFont(detail_font_name, 'UniKS-UTF8-H');
      detail_font.SetReliefFont(relief_font);

      // Simplified Chinese, Traditional Chinese, Japanese
      detail_font_name := pdf.Fonts.LoadTTFontFromFile('C:\Windows\Fonts\simsun.ttc', [foEmbedding], 1);
      relief_font := detail_font;
      detail_font := pdf.Fonts.GetFont(detail_font_name, 'UniGB-UTF8-H');
      detail_font.SetReliefFont(relief_font);

      // Latin, Cyrillic, Greek, Arabic, Hebrew
      detail_font_name := pdf.Fonts.LoadTTFontFromFile('C:\Windows\Fonts\times.ttf', [foEmbedding]);
      relief_font := detail_font;
      detail_font := pdf.Fonts.GetFont(detail_font_name, 'Ancient-UTF8-H');
      detail_font.SetReliefFont(relief_font);

      detail_font.PushBuiltInConverter('BiDi', nil);
      detail_font.SetCharacterEncoding(HPDF_CHARENC_WCHAR_T);


      detail_font_name := 'Batang';
      relief_font := detail_font_v;
      detail_font_v := pdf.Fonts.GetFont(detail_font_name, 'UniKS-UTF16-V');
      detail_font_v.SetReliefFont(relief_font);

      detail_font_name := 'SimHei';
      relief_font := detail_font_v;
      detail_font_v := pdf.Fonts.GetFont(detail_font_name, 'UniGB-UTF16-V');
      detail_font_v.SetReliefFont(relief_font);

      detail_font_name := pdf.Fonts.LoadTTFontFromFile('C:\Windows\Fonts\arial.ttf', [foEmbedding]);
      relief_font := detail_font_v;
      detail_font_v := pdf.Fonts.GetFont(detail_font_name, 'Ancient-UTF16-H');
      detail_font_v.SetReliefFont(relief_font);

      detail_font_v.PushBuiltInConverter('BiDi', nil);
      detail_font_v.SetCharacterEncoding(HPDF_CHARENC_WCHAR_T);


      // add a new page
      page := pdf.Pages.Add;

      page_width := 595.27559;
      page_height := 841.88976;

      page.Width := page_width;
      page.Height := page_height;

      rect.Left := page_width / 2 - 10;
      rect.bottom := page_height - 60;
      rect.right := page_width / 2 + 10;
      rect.top := page_height - 80;
      page.Annotations.AddTextAnnot(rect, '', pdf.Encoder.GetUTFEncoder(HPDF_CHARENC_WCHAR_T), PWideChar(HELLO));

      page.BeginText;

      page.SetFontAndSize(detail_font, 15);
      page.WordSpace := 5;
      page.CharSpace := 0;

      page.TextOut(20, page_height - 50, '', PWideChar(HELLO));
      page.ShowText('', PWideChar(HELLO_ru));

      page.TextLeading := 0;
      page.SetJustifyRatio(1, 1, 100);

      page.TextRect(RectF(30, page_height - 60, page_width / 2 - 29, 30),
        HPDF_TALIGN_JUSTIFY or HPDF_VALIGN_JUSTIFY_ALL or HPDF_ALIGNOPT_BIDI_EACH_PARAGRAPH or
        HPDF_ALIGNOPT_REMOVE_TATWEEL, '', len, PWideChar(ONCE_UPON_A_TIME));

      page.SetFontAndSize(detail_font_v, 15);
      page.WordSpace := 0;

      page.TextLeading := 30;
      page.TextOut(page_width / 2 + 20, page_height - 90, '', PWideChar(HELLO_ru));
      page.ShowText('', PWideChar(HELLO));
      page.ShowTextNextLine('', nil);
      page.ShowText('', PWideChar(HELLO_ru));
      page.ShowText('', PWideChar('!!!!'));

      page.TextLeading := 0;
      page.TextRect(RectF(page_width / 2 + 40, page_height - 60, page_width - 30, 405),
        HPDF_TALIGN_JUSTIFY or HPDF_VALIGN_JUSTIFY, '', len, PWideChar(ONCE_UPON_A_TIME));

      page.TextLeading := -20;
      page.TextRect(RectF(page_width / 2 + 40, 380, page_width - 30, 30),
        HPDF_TALIGN_JUSTIFY or HPDF_VALIGN_JUSTIFY or HPDF_ALIGNOPT_BIDI_EACH_PARAGRAPH or
        HPDF_ALIGNOPT_REMOVE_TATWEEL, '', len, @ONCE_UPON_A_TIME[1 + len div SizeOf(WideChar)]);

      page.EndText;


      page.LineWidth := 0.5;

      page.MoveTo(10, page_height - 25);
      page.LineTo(page_width - 10, page_height - 25);
      page.Stroke;

      page.Rectangle(30, page_height - 60,
        page_width / 2 - 29 - 30, 30 - (page_height - 60));
      page.Stroke;

      page.Rectangle(page_width / 2 + 40, page_height - 60,
        page_width - 30 - (page_width / 2 + 40), 405 - (page_height - 60));
      page.Stroke;

      page.Rectangle(page_width / 2 + 40, 380,
        page_width - 30 - (page_width / 2 + 40), 30 - 380);
      page.Stroke;

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
    'UTF encoders (advanced)',
    'Prints horizontal, vertical and bi-directional text using UTF-8 and UTF-16 encoders.',
    'Text',
    'demos\utf_encoders.pdf',
    'demos\utf_encoders.png',
    TUTFEncodersDemo);

end.
