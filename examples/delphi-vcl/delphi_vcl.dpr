program delphi_vcl;

uses
  Vcl.Forms,
  demoMgr in 'demoMgr.pas',
  fmMain in 'fmMain.pas' {MainForm},
  harupdf.annotation in '..\..\harupdf.annotation.pas',
  harupdf.destination in '..\..\harupdf.destination.pas',
  harupdf.document in '..\..\harupdf.document.pas',
  harupdf.encoder in '..\..\harupdf.encoder.pas',
  harupdf.font in '..\..\harupdf.font.pas',
  harupdf.image in '..\..\harupdf.image.pas',
  harupdf.javascript in '..\..\harupdf.javascript.pas',
  harupdf.outline in '..\..\harupdf.outline.pas',
  harupdf.page in '..\..\harupdf.page.pas',
  harupdf.utils in '..\..\harupdf.utils.pas',
  harupdf.view3d in '..\..\harupdf.view3d.pas',
  hpdf in '..\..\hpdf.pas',
  hpdf_consts in '..\..\hpdf_consts.pas',
  hpdf_types in '..\..\hpdf_types.pas',
  hpdf_error in '..\..\hpdf_error.pas',
  grid in 'demo\grid.pas',
  attach in 'demo\attach.pas',
  encryption in 'demo\encryption.pas',
  permission in 'demo\permission.pas',
  link_annotation in 'demo\link_annotation.pas',
  bookmark_demo in 'demo\bookmark_demo.pas',
  slide_show_demo in 'demo\slide_show_demo.pas',
  text_demo in 'demo\text_demo.pas',
  text_align in 'demo\text_align.pas',
  font_demo in 'demo\font_demo.pas',
  ttfont_demo in 'demo\ttfont_demo.pas',
  text_annotation in 'demo\text_annotation.pas',
  text_circle in 'demo\text_circle.pas',
  utf_encoders in 'demo\utf_encoders.pas',
  line_demo in 'demo\line_demo.pas',
  image_demo in 'demo\image_demo.pas',
  load_image in 'demo\load_image.pas',
  blend_mode in 'demo\blend_mode.pas',
  arc_demo in 'demo\arc_demo.pas',
  u3d_demo in 'demo\u3d_demo.pas',
  page_boundary in 'demo\page_boundary.pas',
  pdfa_demo in 'demo\pdfa_demo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
