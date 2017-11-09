unit harupdf.view3d;

{ MIT License

 Copyright (c) 2017 THaruPDF, Damian Woroch, http://r1me.pl

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE. }

{$IFDEF FPC}{$mode objfpc}{$H+}{$ENDIF}

interface
uses
{$IFNDEF FPC}
  System.Classes,
  System.Generics.Collections,
{$ELSE}
  Classes,
  fgl,
{$ENDIF}
  hpdf,
  hpdf_types,
  harupdf.encoder;

type
  THaru3DMeasure = class(TObject)
  protected
    FMeasureHandle: HPDF_3DMeasure;
  public
    property MeasureHandle: HPDF_3DMeasure read FMeasureHandle;

    procedure SetName(AName: String);
    procedure SetColor(AColor: THPDF_RGBColor);
    procedure SetTextSize(ATextSize: Single);

    procedure SetTextBoxSize(Ax, Ay: Integer);
    procedure SetText(AText: String; AEncoder: THaruEncoder = nil);
    procedure SetProjectionAnotation(AProjectionAnnotation: TObject);

    class function Create3DC3DMeasure(APage: TObject; AFirstAnchorPoint: THPDF_Point3D;
      ATextAnchorPoint: THPDF_Point3D): THaru3DMeasure;
    class function CreatePD33DMeasure(APage: TObject; AAnnotationPlaneNormal: THPDF_Point3D;
      AFirstAnchorPoint, ASecondAnchorPoint: THPDF_Point3D;
      ALeaderLinesDirection: THPDF_Point3D; AMeasurementValuePoint: THPDF_Point3D;
      ATextYDirection: THPDF_Point3D; AValue: Single; AUnitsString: String): THaru3DMeasure;

    constructor Create(A3DMeasure: HPDF_3DMeasure);
  end;

type
  THaruU3D = class;
  THaru3DView = class;

  THaru3DViewNode = class(TObject)
  protected
    FNodeHandle: HPDF_Dict;
  public
    property NodeHandle: HPDF_Dict read FNodeHandle;

    procedure SetOpacity(AOpacity: Single);
    procedure SetVisibility(AVisible: Boolean);
    procedure SetMatrix(AMat3D: THPDF_3DMatrix);

    constructor Create(A3DView: THaru3DView; AName: String);
  end;

  THaru3DView = class(TObject)
  protected
    FViewHandle: HPDF_Dict;
  public
    property ViewHandle: HPDF_Dict read FViewHandle;

    function CreateNode(AName: String): THaru3DViewNode;
    procedure SetLighting(AScheme: String);
    procedure SetBackgroundColor(ARed, AGreen, ABlue: Single);
    procedure SetPerspectiveProjection(AFov: Single);
    procedure SetOrthogonalProjection(AMag: Single);
    procedure SetCamera(ACentreOrbitX, ACentreOrbitY, ACentreOrbitZ: Single;
      ACameraDirectionVectorX, ACameraDirectionVectorY, ACameraDirectionVectorZ: Single;
      AOrbitalRadius: Single; ACameraRoll: Single);
    procedure SetCameraByMatrix(AMat3D: THPDF_3DMatrix; AOrbitalRadius: Single);
    procedure SetCrossSectionOn(ACenterX, ACenterY, ACenterZ: Single; ARoll: Single; APitch: Single;
      AOpacity: Single; AShowIntersection: Boolean);
    procedure SetCrossSectionOff;
    procedure Add3DMeasure(AMeasure: THaru3DMeasure);

    class function Create3DView(AU3D: THaruU3D; AName: String): THaru3DView;

    class function Get3DViewHandle(A3DView: THaru3DView): HPDF_Dict;
    constructor Create(A3DView: HPDF_Dict);
  end;

  THaru3DViews = {$IFNDEF FPC}TObjectList{$ELSE}specialize TFPGObjectList{$ENDIF}<THaru3DView>;

  THaruU3D = class(TObject)
  protected
    FU3DHandle: HPDF_U3D;
    F3DViews: THaru3DViews;
  public
    property U3DHandle: HPDF_U3D read FU3DHandle;

    procedure Add3DView(AView: THaru3DView);
    procedure SetDefault3DView(AName: String);
    procedure AddOnInstantiate(AJavaScript: HPDF_Javascript);

    class function GetU3DHandle(AU3D: THaruU3D): HPDF_U3D;
    constructor Create(AU3D: HPDF_U3D);
    destructor Destroy; override;
  end;

implementation
uses
  harupdf.page,
  harupdf.annotation,
  harupdf.utils;

{ THaru3DMeasure }

constructor THaru3DMeasure.Create(A3DMeasure: HPDF_3DMeasure);
begin
  FMeasureHandle := A3DMeasure;
end;

class function THaru3DMeasure.Create3DC3DMeasure(APage: TObject; AFirstAnchorPoint: THPDF_Point3D;
  ATextAnchorPoint: THPDF_Point3D): THaru3DMeasure;
var
  hMeasure: HPDF_3DMeasure;
begin
  hMeasure := HPDF_Page_Create3DC3DMeasure(THaruPage(APage).PageHandle, AFirstAnchorPoint, ATextAnchorPoint);
  Result := THaru3DMeasure.Create(hMeasure);
end;

class function THaru3DMeasure.CreatePD33DMeasure(APage: TObject; AAnnotationPlaneNormal: THPDF_Point3D;
  AFirstAnchorPoint, ASecondAnchorPoint: THPDF_Point3D;
  ALeaderLinesDirection: THPDF_Point3D; AMeasurementValuePoint: THPDF_Point3D;
  ATextYDirection: THPDF_Point3D; AValue: Single; AUnitsString: String): THaru3DMeasure;
var
  hMeasure: HPDF_3DMeasure;
  pUnitsString: PUTF8Char;
begin
  pUnitsString := StringToPUTF8Char(AUnitsString);
  hMeasure := HPDF_Page_CreatePD33DMeasure(THaruPage(APage).PageHandle, AAnnotationPlaneNormal,
    AFirstAnchorPoint, ASecondAnchorPoint, ALeaderLinesDirection, AMeasurementValuePoint,
    ATextYDirection, AValue, pUnitsString);
  Result := THaru3DMeasure.Create(hMeasure);
end;

procedure THaru3DMeasure.SetName(AName: String);
var
  pName: PUTF8Char;
begin
  pName := StringToPUTF8Char(AName);
  HPDF_3DMeasure_SetName(FMeasureHandle, pName);
end;

procedure THaru3DMeasure.SetColor(AColor: THPDF_RGBColor);
begin
  HPDF_3DMeasure_SetColor(FMeasureHandle, AColor);
end;

procedure THaru3DMeasure.SetTextSize(ATextSize: Single);
begin
  HPDF_3DMeasure_SetTextSize(FMeasureHandle, ATextSize);
end;

procedure THaru3DMeasure.SetTextBoxSize(Ax, Ay: Integer);
begin
  HPDF_3DC3DMeasure_SetTextBoxSize(FMeasureHandle, Ax, Ay);
end;

procedure THaru3DMeasure.SetText(AText: String; AEncoder: THaruEncoder);
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText);
  HPDF_3DC3DMeasure_SetText(FMeasureHandle, pText, THaruEncoder.GetEncoderHandle(AEncoder));
end;

procedure THaru3DMeasure.SetProjectionAnotation(AProjectionAnnotation: TObject);
begin
  HPDF_3DC3DMeasure_SetProjectionAnotation(FMeasureHandle, THaruAnnotation(AProjectionAnnotation).AnnotationHandle);
end;

{ THaru3DViewNode }

procedure THaru3DViewNode.SetOpacity(AOpacity: Single);
begin
  HPDF_3DViewNode_SetOpacity(FNodeHandle, AOpacity);
end;

procedure THaru3DViewNode.SetVisibility(AVisible: Boolean);
begin
  HPDF_3DViewNode_SetVisibility(FNodeHandle, BooleanToHaruBool(AVisible));
end;

procedure THaru3DViewNode.SetMatrix(AMat3D: THPDF_3DMatrix);
begin
  HPDF_3DViewNode_SetMatrix(FNodeHandle, AMat3D);
end;

constructor THaru3DViewNode.Create(A3DView: THaru3DView; AName: String);
var
  pName: PUTF8Char;
begin
  pName := StringToPUTF8Char(AName);
  FNodeHandle := HPDF_3DView_CreateNode(THaru3DView.Get3DViewHandle(A3DView), pName);
end;

{ THaru3DView }

constructor THaru3DView.Create(A3DView: HPDF_Dict);
begin
  FViewHandle := A3DView;
end;

class function THaru3DView.Create3DView(AU3D: THaruU3D; AName: String): THaru3DView;
var
  hView: HPDF_Dict;
  hMMgr: HPDF_MMgr;
  pName: PUTF8Char;
begin
  pName := StringToPUTF8Char(AName);
  hMMgr := HPDF_GetU3DMMgr(AU3D.U3DHandle);
  hView := HPDF_Create3DView(hMMgr, pName);
  Result := THaru3DView.Create(hView);
end;

class function THaru3DView.Get3DViewHandle(A3DView: THaru3DView): HPDF_Dict;
begin
  if Assigned(A3DView) then
    Result := A3DView.ViewHandle
  else
    Result := nil;
end;

function THaru3DView.CreateNode(AName: String): THaru3DViewNode;
begin
  Result := THaru3DViewNode.Create(Self, AName);
  HPDF_3DView_AddNode(FViewHandle, Result.NodeHandle);
end;

procedure THaru3DView.SetLighting(AScheme: String);
var
  pScheme: PUTF8Char;
begin
  pScheme := StringToPUTF8Char(AScheme);
  HPDF_3DView_SetLighting(FViewHandle, pScheme);
end;

procedure THaru3DView.SetBackgroundColor(ARed, AGreen, ABlue: Single);
begin
  HPDF_3DView_SetBackgroundColor(FViewHandle, ARed, AGreen, ABlue);
end;

procedure THaru3DView.SetPerspectiveProjection(AFov: Single);
begin
  HPDF_3DView_SetPerspectiveProjection(FViewHandle, AFov);
end;

procedure THaru3DView.SetOrthogonalProjection(AMag: Single);
begin
  HPDF_3DView_SetOrthogonalProjection(FViewHandle, AMag);
end;

procedure THaru3DView.SetCamera(ACentreOrbitX, ACentreOrbitY, ACentreOrbitZ: Single;
  ACameraDirectionVectorX, ACameraDirectionVectorY, ACameraDirectionVectorZ: Single;
  AOrbitalRadius: Single; ACameraRoll: Single);
begin
  HPDF_3DView_SetCamera(FViewHandle, ACentreOrbitX, ACentreOrbitY, ACentreOrbitZ,
    ACameraDirectionVectorX, ACameraDirectionVectorY, ACameraDirectionVectorZ, AOrbitalRadius,
    ACameraRoll);
end;

procedure THaru3DView.SetCameraByMatrix(AMat3D: THPDF_3DMatrix; AOrbitalRadius: Single);
begin
  HPDF_3DView_SetCameraByMatrix(FViewHandle, AMat3D, AOrbitalRadius);
end;

procedure THaru3DView.SetCrossSectionOn(ACenterX, ACenterY, ACenterZ: Single; ARoll: Single; APitch: Single;
  AOpacity: Single; AShowIntersection: Boolean);
var
  point: THPDF_Point3D;
begin
  point.x := ACenterX;
  point.y := ACenterY;
  point.z := ACenterZ;
  HPDF_3DView_SetCrossSectionOn(FViewHandle, point, ARoll, APitch, AOpacity, BooleanToHaruBool(AShowIntersection));
end;

procedure THaru3DView.SetCrossSectionOff;
begin
  HPDF_3DView_SetCrossSectionOff(FViewHandle);
end;

procedure THaru3DView.Add3DMeasure(AMeasure: THaru3DMeasure);
begin
  HPDF_3DView_Add3DC3DMeasure(FViewHandle, AMeasure.MeasureHandle);
end;

{ THaruU3D }

constructor THaruU3D.Create(AU3D: HPDF_U3D);
begin
  FU3DHandle := AU3D;
  F3DViews := THaru3DViews.Create;
end;

destructor THaruU3D.Destroy;
begin
  F3DViews.Free;
  inherited;
end;

class function THaruU3D.GetU3DHandle(AU3D: THaruU3D): HPDF_U3D;
begin
  if Assigned(AU3D) then
    Result := AU3D.U3DHandle
  else
    Result := nil;
end;

procedure THaruU3D.Add3DView(AView: THaru3DView);
begin
  HPDF_U3D_Add3DView(FU3DHandle, AView.ViewHandle);
  F3DViews.Add(AView);
end;

procedure THaruU3D.SetDefault3DView(AName: String);
var
  pName: PUTF8Char;
begin
  pName := StringToPUTF8Char(AName);
  HPDF_U3D_SetDefault3DView(FU3DHandle, pName);
end;

procedure THaruU3D.AddOnInstantiate(AJavaScript: HPDF_Javascript);
begin
  HPDF_U3D_AddOnInstantiate(FU3DHandle, AJavaScript);
end;

end.
