unit fmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Imaging.Pngimage;

type
  TMainForm = class(TForm)
    memDescr: TMemo;
    imgDemo: TImage;
    panImg: TPanel;
    lvDemo: TListView;
    btnExecuteAllExamples: TButton;
    panLeft: TPanel;
    panRight: TPanel;
    panTop: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure lvDemoClick(Sender: TObject);
    procedure btnExecuteAllExamplesClick(Sender: TObject);
    procedure lvDemoDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OnHaruException(ASender: TObject; AException: Exception);
  end;

var
  MainForm: TMainForm;

implementation
uses
  demoMgr,
  Winapi.ShellAPI;

{$R *.dfm}

procedure TMainForm.btnExecuteAllExamplesClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to DemoManager.DemoList.Count-1 do
    DemoManager.StartDemo(i, ExtractFilePath(Application.ExeName));
  ShellExecute(Application.Handle, 'explore', PChar(ExtractFilePath(Application.ExeName) + 'demos\'), nil, nil, SW_NORMAL);
end;

procedure TMainForm.FormCreate(Sender: TObject);

  function GetGroupID(const AListView: TListView; AGroup: String): Integer;
  var
    j: Integer;
  begin
    for j := 0 to AListView.Groups.Count-1 do
    begin
      if (AListView.Groups[j].Header = AGroup) then
      begin
        Result := j;
        Exit;
      end;
    end;

    Result := AListView.Groups.Count-1;
  end;

var
  i: Integer;
  li: TListItem;
begin
  DemoManager.OnHaruException := OnHaruException;
  for i := 0 to DemoManager.DemoList.Count-1 do
  begin
    li := lvDemo.Items.Add;
    li.Caption := DemoManager.DemoList.Items[i].Name;
    li.GroupID := GetGroupID(lvDemo, DemoManager.DemoList.Items[i].Group);
  end;
end;

procedure TMainForm.lvDemoClick(Sender: TObject);
begin
  if (lvDemo.ItemIndex <> -1) then
  begin
    memDescr.Text := DemoManager.DemoList[lvDemo.ItemIndex].Description;
    if (DemoManager.DemoList[lvDemo.ItemIndex].Image <> '') then
      imgDemo.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + DemoManager.DemoList[lvDemo.ItemIndex].Image)
    else
      imgDemo.Picture := nil;
  end;
end;

procedure TMainForm.lvDemoDblClick(Sender: TObject);
begin
  if (lvDemo.ItemIndex <> -1) then
  begin
    if DemoManager.StartDemo(lvDemo.ItemIndex, ExtractFilePath(Application.ExeName)) then
    begin
      if MessageDlg('Saved to ' + DemoManager.DemoList[lvDemo.ItemIndex].OutputFileName +
        #10 + 'Do you want to open it in a default PDF viewer ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName) +
          DemoManager.DemoList[lvDemo.ItemIndex].OutputFileName), nil, nil, 0);
      end;
    end;
  end;
end;

procedure TMainForm.OnHaruException(ASender: TObject; AException: Exception);
begin
  MessageDlg(AException.UnitName + ': ' + AException.Message, mtWarning, [mbOK], 0);
end;

end.
