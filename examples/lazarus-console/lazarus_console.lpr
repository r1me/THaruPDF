program lazarus_console;

{$mode objfpc}{$H+}

uses
  Classes, SysUtils,
  harupdf.document in '..\..\harupdf.document.pas',
  hpdf in '..\..\hpdf.pas',
  hpdf_consts in '..\..\hpdf_consts.pas',
  hpdf_types in '..\..\hpdf_types.pas',
  harupdf.page in '..\..\harupdf.page.pas',
  harupdf.font in '..\..\harupdf.font.pas',
  harupdf.annotation in '..\..\harupdf.annotation.pas',
  harupdf.image in '..\..\harupdf.image.pas',
  harupdf.utils in '..\..\harupdf.utils.pas',
  harupdf.destination in '..\..\harupdf.destination.pas',
  harupdf.encoder in '..\..\harupdf.encoder.pas',
  harupdf.outline in '..\..\harupdf.outline.pas',
  harupdf.javascript in '..\..\harupdf.javascript.pas',
  harupdf.view3d in '..\..\harupdf.view3d.pas',
  hpdf_error in '..\..\hpdf_error.pas';

var
  pdf: THaruDocument;
  page: THaruPage;
  font: THaruFont;
  png_image: THaruImage;
  len: Integer;
begin
  try
    pdf := THaruDocument.Create;
    try
      // set compression mode
      pdf.SetCompressionMode(HPDF_COMP_ALL);

      // set metadata
      pdf.Creator := 'THaruPDF in Lazarus';
      pdf.SetCreationDate(Now);

      // create default font
      font := pdf.Fonts.GetFont('Helvetica');

      // add a new page
      page := pdf.Pages.Add;
      page.SetSize(HPDF_PAGE_SIZE_A5, HPDF_PAGE_PORTRAIT);

      // print some text
      page.BeginText;

      page.SetFontAndSize(font, 16);
      page.MoveTextPos(30, page.Height - 30);
      page.ShowText('THaruPDF in Lazarus');

      page.TextOut(page.Width - 100, page.Height - 30, 'Awesome!');

      page.SetFontAndSize(font, 24);
      page.TextRect(RectF(0, page.Height - 300, page.Width, page.Height - 350),
        HPDF_TALIGN_CENTER or HPDF_VALIGN_CENTER, 'Lazarus!', len);

      page.EndText;

      // draw image, center horizontally
      png_image := pdf.LoadPngImageFromFile('resources' + PathDelim + 'lazarus.png');
      page.DrawImage(png_image, (page.Width / 2) - (png_image.Width / 2), page.Height - 300);

      // save the document to a file
      pdf.SaveToFile('demos' + PathDelim + 'lazarus.pdf');
    finally
      pdf.Free;
    end;
  except
    on e: EHaruPDFException do
      WriteLn(e.Message);
  end;
end.

