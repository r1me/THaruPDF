unit demoMgr;

interface
uses
  System.Classes, System.SysUtils, System.Generics.Collections;

type
  TDemo = class(TObject)
  public
    function StartDemo(AFileName: String): Boolean; virtual; abstract;
  end;
  TDemoClass = class of TDemo;

type
  TDemoDetails = class
    Name: String;
    Description: String;
    OutputFileName: String;
    Image: String;
    Group: String;
    DemoClass: TDemoClass;
  end;
  TDemoDetailsList = TList<TDemoDetails>;

type
  TOnHaruException = procedure(ASender: TObject; AException: Exception) of object;

type
  TDemoManager = class
  private
    FDemoList: TDemoDetailsList;
    FOnHaruException: TOnHaruException;
  public
    property DemoList: TDemoDetailsList read FDemoList;
    property OnHaruException: TOnHaruException read FOnHaruException write FOnHaruException;

    function StartDemo(AIndex: Integer; AOutputDir: String): Boolean;
    procedure AddDemo(AName: String; ADescription: String; AGroup: String; AOutputFileName: String;
      AImage: String; ADemoClass: TDemoClass);
    constructor Create;
    destructor Destroy; override;
  end;

var
  DemoManager: TDemoManager;

implementation

{ TDemoManager }

constructor TDemoManager.Create;
begin
  FDemoList := TDemoDetailsList.Create;
end;

destructor TDemoManager.Destroy;
var
  demoDet: TDemoDetails;
begin
  for demoDet in FDemoList do
    demoDet.Free;
  FDemoList.Free;
  inherited;
end;

function TDemoManager.StartDemo(AIndex: Integer; AOutputDir: String): Boolean;
var
  demo: TDemo;
begin
  demo := FDemoList.Items[AIndex].DemoClass.Create;
  try
    Result := demo.StartDemo(IncludeTrailingPathDelimiter(AOutputDir) + FDemoList.Items[AIndex].OutputFileName);
  finally
    demo.Free;
  end;
end;

procedure TDemoManager.AddDemo(AName: String; ADescription: String; AGroup: String;
  AOutputFileName: String; AImage: String; ADemoClass: TDemoClass);
var
  demoDet: TDemoDetails;
begin
  demoDet := TDemoDetails.Create;
  demoDet.Name := AName;
  demoDet.Description := ADescription;
  demoDet.Group := AGroup;
  demoDet.OutputFileName := AOutputFileName;
  demoDet.Image := AImage;
  demoDet.DemoClass := ADemoClass;
  FDemoList.Add(demoDet);
end;

initialization
  DemoManager := TDemoManager.Create;

finalization
  DemoManager.Free;

end.
