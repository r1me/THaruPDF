unit harupdf.annotation;

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
  System.Types,
  System.Generics.Collections,
{$ELSE}
  Classes,
  Types,
  fgl,
{$ENDIF}
  hpdf,
  hpdf_types,
  harupdf.encoder,
  harupdf.destination,
  harupdf.image,
  harupdf.view3d;

type
  THaruAnnotation = class(TObject)
  protected
    FAnnotationHandle: HPDF_Annotation;
  public
    property AnnotationHandle: HPDF_Annotation read FAnnotationHandle;

    //
    procedure SetRGBColor(AColor: THPDF_RGBColor);
    //
    procedure SetCMYKColor(AColor: THPDF_CMYKColor);
    //
    procedure SetGrayColor(AColor: Single);
    //
    procedure SetNoColor;
    // Defines the border appearance of a text annotation
    procedure SetBorderStyle(ABorderStyle: THPDF_BSSubtype; AWidth: Single; ADashOn, ADashOff, ADashPhase: Word);
    //
    procedure Set3DView(AMmgr: HPDF_MMgr; A3DAnnotation: THaruAnnotation; AView: THaru3DView);

    // Defines the appearance when a mouse clicks on a link annotation
    procedure LinkAnnot_SetHighlightMode(AMode: THPDF_AnnotHighlightMode);
    //
    procedure LinkAnnot_SetJavaScript(AJavaScript: HPDF_JavaScript);
    // Defines the style of the annotation's border
    procedure LinkAnnot_SetBorderStyle(AWidth: Single; ADashOn: Word; ADashOff: Word);
    // Defines the style of the annotation's icon
    procedure TextAnnot_SetIcon(AIcon: THPDF_AnnotIcon);
    // Defines whether the text-annotation is initially open
    procedure TextAnnot_SetOpened(AOpened: Boolean);
    //
    procedure MarkupAnnot_SetTitle(ATitle: String; ATitlePtr: Pointer = nil);
    //
    procedure MarkupAnnot_SetSubject(ASubject: String; ASubjectPtr: Pointer = nil);
    //
    procedure MarkupAnnot_SetCreationDate(ADate: TDateTime);
    //
    procedure MarkupAnnot_SetTransparency(AValue: Single);
    //
    procedure MarkupAnnot_SetIntent(AIntent: THPDF_AnnotIntent);
    //
    procedure MarkupAnnot_SetPopup(APopup: THaruAnnotation);
    //
    procedure MarkupAnnot_SetRectDiff(ARect: TRectF);
    //
    procedure MarkupAnnot_SetCloudEffect(ACloudIntensity: Integer);
    //
    procedure MarkupAnnot_SetInteriorRGBColor(AColor: THPDF_RGBColor);
    //
    procedure MarkupAnnot_SetInteriorCMYKColor(AColor: THPDF_CMYKColor);
    //
    procedure MarkupAnnot_SetInteriorGrayColor(AColor: Single);
    //
    procedure MarkupAnnot_SetInteriorTransparent();
    //
    procedure TextMarkupAnnot_SetQuadPoints(Alb, Arb, Art, Alt: TPointF);
    //
    procedure PopupAnnot_SetOpened(AOpened: Boolean);
    //
    procedure FreeTextAnnot_SetLineEndingStyle(AStartStyle, AEndStyle: THPDF_LineAnnotEndingStyle);
    //
    procedure FreeTextAnnot_Set3PointCalloutLine(AStartPoint, AKneePoint, AEndPoint: TPointF);
    //
    procedure FreeTextAnnot_Set2PointCalloutLine(AStartPoint, AEndPoint: TPointF);
    //
    procedure FreeTextAnnot_SetDefaultStyle(AStyle: String);
    //
    procedure LineAnnot_SetPosition(AStartPoint, AEndPoint: TPointF; AStartStyle, AEndStyle: THPDF_LineAnnotEndingStyle);
    //
    procedure LineAnnot_SetLeader(ALeaderLen: Integer; ALeaderExtLen: Integer;
      ALeaderOffsetLen: Integer);
    //
    procedure LineAnnot_SetCaption(AShowCaption: Boolean; APosition: THPDF_LineAnnotCapPosition;
      AHorzOffset, AVertOffset: Integer);
    //
    procedure ProjectionAnnot_SetExData(AExData: HPDF_ExData);

    class function GetAnnotationHandle(AAnnotation: THaruAnnotation): HPDF_Annotation;
    constructor Create(AAnnotation: HPDF_Annotation);
  end;
  THaruAnnotationsList = {$IFNDEF FPC}TObjectList{$ELSE}specialize TFPGObjectList{$ENDIF}<THaruAnnotation>;

type
  THaruAnnotations = class(TObject)
  protected
    FOwnerPage: TObject;
    FOwnerDocument: TObject;
    FAnnotations: THaruAnnotationsList;
  public
    property Items: THaruAnnotationsList read FAnnotations;

    //
    function Add3DAnnot(ARect: TRectF; AToolBar: Boolean; ANavigationPanel: Boolean;
      AU3D: THaruU3D; AAppearanceImage: THaruImage): THaruAnnotation;
    //
    function AddTextAnnot(ARect: TRectF; AText: String; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil):
      THaruAnnotation;
    //
    function AddFreeTextAnnot(ARect: TRectF; AText: String; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil):
      THaruAnnotation;
    //
    function AddLineAnnot(AText: string; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil): THaruAnnotation;
    //
    function AddWidgetAnnot_WhiteOnlyWhilePrint(ARect: TRectF): THaruAnnotation;
    //
    function AddWidgetAnnot(ARect: TRectF): THaruAnnotation;
    //
    function AddLinkAnnot(ARect: TRectF; ADestination: THaruDestination): THaruAnnotation;
    //
    function AddURILinkAnnot(ARect: TRectF; AURI: string): THaruAnnotation;
    //
    function AddHighlightAnnot(ARect: TRectF; AText: string; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil):
      THaruAnnotation;
    //
    function AddUnderlineAnnot(ARect: TRectF; AText: string; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil):
      THaruAnnotation;
    //
    function AddSquigglyAnnot(ARect: TRectF; AText: string; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil):
      THaruAnnotation;
    //
    function AddStrikeOutAnnot(ARect: TRectF; AText: string; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil):
      THaruAnnotation;
    //
    function AddPopupAnnot(ARect: TRectF; AParent: THaruAnnotation): THaruAnnotation;
    //
    function AddStampAnnot(ARect: TRectF; AName: THPDF_StampAnnotName; AText: string; AEncoder:
      THaruEncoder = nil; ATextPtr: Pointer = nil): THaruAnnotation;
    //
    function AddProjectionAnnot(ARect: TRectF; AText: string; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil):
      THaruAnnotation;
    //
    function AddSquareAnnot(ARect: TRectF; AText: string; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil):
      THaruAnnotation;
    //
    function AddCircleAnnot(ARect: TRectF; AText: string; AEncoder: THaruEncoder = nil; ATextPtr: Pointer = nil):
      THaruAnnotation;

    constructor Create(AOwnerPage: TObject; ADocument: TObject);
    destructor Destroy; override;
  end;

implementation
uses
  harupdf.document,
  harupdf.page,
  harupdf.utils;

{ THaruAnnotation }

constructor THaruAnnotation.Create(AAnnotation: HPDF_Annotation);
begin
  FAnnotationHandle := AAnnotation;
end;

procedure THaruAnnotation.SetRGBColor(AColor: THPDF_RGBColor);
begin
  HPDF_Annot_SetRGBColor(FAnnotationHandle, AColor);
end;

procedure THaruAnnotation.SetCMYKColor(AColor: THPDF_CMYKColor);
begin
  HPDF_Annot_SetCMYKColor(FAnnotationHandle, AColor);
end;

procedure THaruAnnotation.SetGrayColor(AColor: Single);
begin
  HPDF_Annot_SetGrayColor(FAnnotationHandle, AColor);
end;

procedure THaruAnnotation.SetNoColor;
begin
  HPDF_Annot_SetNoColor(FAnnotationHandle);
end;

procedure THaruAnnotation.SetBorderStyle(ABorderStyle: THPDF_BSSubtype; AWidth: Single; ADashOn,
  ADashOff, ADashPhase: Word);
begin
  HPDF_Annotation_SetBorderStyle(FAnnotationHandle, ABorderStyle, AWidth, ADashOn, ADashOff,
    ADashPhase);
end;

procedure THaruAnnotation.Set3DView(AMmgr: HPDF_MMgr; A3DAnnotation: THaruAnnotation; AView: THaru3DView);
begin
  HPDF_Annot_Set3DView(AMmgr, FAnnotationHandle, A3DAnnotation.AnnotationHandle, AView);
end;

procedure THaruAnnotation.LinkAnnot_SetHighlightMode(AMode: THPDF_AnnotHighlightMode);
begin
  HPDF_LinkAnnot_SetHighlightMode(FAnnotationHandle, AMode);
end;

procedure THaruAnnotation.LinkAnnot_SetJavaScript(AJavaScript: HPDF_JavaScript);
begin
  HPDF_LinkAnnot_SetJavaScript(FAnnotationHandle, AJavaScript);
end;

procedure THaruAnnotation.LinkAnnot_SetBorderStyle(AWidth: Single; ADashOn: Word; ADashOff: Word);
begin
  HPDF_LinkAnnot_SetBorderStyle(FAnnotationHandle, AWidth, ADashOn, ADashOff);
end;

procedure THaruAnnotation.TextAnnot_SetIcon(AIcon: THPDF_AnnotIcon);
begin
  HPDF_TextAnnot_SetIcon(FAnnotationHandle, AIcon)
end;

procedure THaruAnnotation.TextAnnot_SetOpened(AOpened: Boolean);
begin
  HPDF_TextAnnot_SetOpened(FAnnotationHandle, BooleanToHaruBool(AOpened));
end;

procedure THaruAnnotation.MarkupAnnot_SetTitle(ATitle: String; ATitlePtr: Pointer = nil);
var
  pTitle: PUTF8Char;
begin
  pTitle := StringToPUTF8Char(ATitle, ATitlePtr);
  HPDF_MarkupAnnot_SetTitle(FAnnotationHandle, pTitle);
end;

procedure THaruAnnotation.MarkupAnnot_SetSubject(ASubject: String; ASubjectPtr: Pointer = nil);
var
  pSubject: PUTF8Char;
begin
  pSubject := StringToPUTF8Char(ASubject, ASubjectPtr);
  HPDF_MarkupAnnot_SetSubject(FAnnotationHandle, pSubject);
end;

procedure THaruAnnotation.MarkupAnnot_SetCreationDate(ADate: TDateTime);
begin
  HPDF_MarkupAnnot_SetCreationDate(FAnnotationHandle, DateTimeToHPDFDate(ADate));
end;

procedure THaruAnnotation.MarkupAnnot_SetTransparency(AValue: Single);
begin
  HPDF_MarkupAnnot_SetTransparency(FAnnotationHandle, AValue);
end;

procedure THaruAnnotation.MarkupAnnot_SetIntent(AIntent: THPDF_AnnotIntent);
begin
  HPDF_MarkupAnnot_SetIntent(FAnnotationHandle, AIntent);
end;

procedure THaruAnnotation.MarkupAnnot_SetPopup(APopup: THaruAnnotation);
begin
  HPDF_MarkupAnnot_SetPopup(FAnnotationHandle, APopup.AnnotationHandle);
end;

procedure THaruAnnotation.MarkupAnnot_SetRectDiff(ARect: TRectF);
begin
  HPDF_MarkupAnnot_SetRectDiff(FAnnotationHandle, RectFToHaruRect(ARect));
end;

procedure THaruAnnotation.MarkupAnnot_SetCloudEffect(ACloudIntensity: Integer);
begin
  HPDF_MarkupAnnot_SetCloudEffect(FAnnotationHandle, ACloudIntensity);
end;

procedure THaruAnnotation.MarkupAnnot_SetInteriorRGBColor(AColor: THPDF_RGBColor);
begin
  HPDF_MarkupAnnot_SetInteriorRGBColor(FAnnotationHandle, AColor);
end;

procedure THaruAnnotation.MarkupAnnot_SetInteriorCMYKColor(AColor: THPDF_CMYKColor);
begin
  HPDF_MarkupAnnot_SetInteriorCMYKColor(FAnnotationHandle, AColor);
end;

procedure THaruAnnotation.MarkupAnnot_SetInteriorGrayColor(AColor: Single);
begin
  HPDF_MarkupAnnot_SetInteriorGrayColor(FAnnotationHandle, AColor);
end;

procedure THaruAnnotation.MarkupAnnot_SetInteriorTransparent();
begin
  HPDF_MarkupAnnot_SetInteriorTransparent(FAnnotationHandle);
end;

procedure THaruAnnotation.TextMarkupAnnot_SetQuadPoints(Alb, Arb, Art, Alt: TPointF);
begin
  HPDF_TextMarkupAnnot_SetQuadPoints(FAnnotationHandle, PointFToHaruPoint(Alb),
    PointFToHaruPoint(Arb), PointFToHaruPoint(Art), PointFToHaruPoint(Alt));
end;

procedure THaruAnnotation.PopupAnnot_SetOpened(AOpened: Boolean);
begin
  HPDF_PopupAnnot_SetOpened(FAnnotationHandle, BooleanToHaruBool(AOpened));
end;

procedure THaruAnnotation.FreeTextAnnot_SetLineEndingStyle(AStartStyle, AEndStyle: THPDF_LineAnnotEndingStyle);
begin
  HPDF_FreeTextAnnot_SetLineEndingStyle(FAnnotationHandle, AStartStyle, AEndStyle);
end;

procedure THaruAnnotation.FreeTextAnnot_Set3PointCalloutLine(AStartPoint, AKneePoint, AEndPoint: TPointF);
begin
  HPDF_FreeTextAnnot_Set3PointCalloutLine(FAnnotationHandle, PointFToHaruPoint(AStartPoint),
    PointFToHaruPoint(AKneePoint), PointFToHaruPoint(AEndPoint));
end;

procedure THaruAnnotation.FreeTextAnnot_Set2PointCalloutLine(AStartPoint, AEndPoint: TPointF);
begin
  HPDF_FreeTextAnnot_Set2PointCalloutLine(FAnnotationHandle, PointFToHaruPoint(AStartPoint),
    PointFToHaruPoint(AEndPoint));
end;

procedure THaruAnnotation.FreeTextAnnot_SetDefaultStyle(AStyle: String);
var
  pStyle: PUTF8Char;
begin
  pStyle := StringToPUTF8Char(AStyle);
  HPDF_FreeTextAnnot_SetDefaultStyle(FAnnotationHandle, pStyle);
end;

procedure THaruAnnotation.LineAnnot_SetPosition(AStartPoint, AEndPoint: TPointF; AStartStyle, AEndStyle: THPDF_LineAnnotEndingStyle);
begin
  HPDF_LineAnnot_SetPosition(FAnnotationHandle, PointFToHaruPoint(AStartPoint), AStartStyle,
    PointFToHaruPoint(AEndPoint), AEndStyle);
end;

procedure THaruAnnotation.LineAnnot_SetLeader(ALeaderLen: Integer; ALeaderExtLen: Integer;
  ALeaderOffsetLen: Integer);
begin
  HPDF_LineAnnot_SetLeader(FAnnotationHandle, ALeaderLen, ALeaderExtLen, ALeaderOffsetLen);
end;

procedure THaruAnnotation.LineAnnot_SetCaption(AShowCaption: Boolean; APosition: THPDF_LineAnnotCapPosition;
  AHorzOffset, AVertOffset: Integer);
begin
  HPDF_LineAnnot_SetCaption(FAnnotationHandle, BooleanToHaruBool(AShowCaption), APosition,
    AHorzOffset, AVertOffset);
end;

procedure THaruAnnotation.ProjectionAnnot_SetExData(AExData: HPDF_ExData);
begin
  HPDF_ProjectionAnnot_SetExData(FAnnotationHandle, AExData);
end;

class function THaruAnnotation.GetAnnotationHandle(AAnnotation: THaruAnnotation):
  HPDF_Annotation;
begin
  if Assigned(AAnnotation) then
    Result := AAnnotation.AnnotationHandle
  else
    Result := nil;
end;

{ THaruAnnotations }

constructor THaruAnnotations.Create(AOwnerPage: TObject; ADocument: TObject);
begin
  FOwnerPage := AOwnerPage;
  FOwnerDocument := ADocument;
  FAnnotations := THaruAnnotationsList.Create;
end;

destructor THaruAnnotations.Destroy;
begin
  FAnnotations.Free;
  inherited;
end;

function THaruAnnotations.Add3DAnnot(ARect: TRectF; AToolBar: Boolean; ANavigationPanel: Boolean;
  AU3D: THaruU3D; AAppearanceImage: THaruImage): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
begin
  hAnnotation := HPDF_Page_Create3DAnnot(THaruPage(FOwnerPage).PageHandle, RectFToHaruRect(ARect),
    BooleanToHaruBool(AToolBar), BooleanToHaruBool(ANavigationPanel), THaruU3D.GetU3DHandle(AU3D),
    THaruImage.GetImageHandle(AAppearanceImage));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddTextAnnot(ARect: TRectF; AText: String; AEncoder:
  THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateTextAnnot(THaruPage(FOwnerPage).PageHandle, RectFToHaruRect(ARect),
    pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddFreeTextAnnot(ARect: TRectF; AText: string; AEncoder:
  THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateFreeTextAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect), pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddLineAnnot(AText: string; AEncoder: THaruEncoder; ATextPtr: Pointer):
  THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateLineAnnot(THaruPage(FOwnerPage).PageHandle,
    pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddWidgetAnnot_WhiteOnlyWhilePrint(ARect: TRectF): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
begin
  hAnnotation := HPDF_Page_CreateWidgetAnnot_WhiteOnlyWhilePrint(THaruDocument(FOwnerDocument).DocumentHandle,
    THaruPage(FOwnerPage).PageHandle, RectFToHaruRect(ARect));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddWidgetAnnot(ARect: TRectF): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
begin
  hAnnotation := HPDF_Page_CreateWidgetAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddLinkAnnot(ARect: TRectF; ADestination: THaruDestination):
  THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
begin
  hAnnotation := HPDF_Page_CreateLinkAnnot(THaruPage(FOwnerPage).PageHandle, RectFToHaruRect(ARect),
    ADestination.DestinationHandle);
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddURILinkAnnot(ARect: TRectF; AURI: string): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pURI: PUTF8Char;
begin
  pURI := StringToPUTF8Char(AURI);
  hAnnotation := HPDF_Page_CreateURILinkAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect), pURI);
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddHighlightAnnot(ARect: TRectF; AText: string; AEncoder:
  THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateHighlightAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect), pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddUnderlineAnnot(ARect: TRectF; AText: string; AEncoder:
  THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateUnderlineAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect), pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddSquigglyAnnot(ARect: TRectF; AText: string; AEncoder:
  THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateSquigglyAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect), pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddStrikeOutAnnot(ARect: TRectF; AText: string; AEncoder:
  THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateStrikeOutAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect), pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddPopupAnnot(ARect: TRectF; AParent: THaruAnnotation):
  THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
begin
  hAnnotation := HPDF_Page_CreatePopupAnnot(THaruPage(FOwnerPage).PageHandle, RectFToHaruRect(ARect),
    THaruAnnotation.GetAnnotationHandle(AParent));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddStampAnnot(ARect: TRectF; AName: THPDF_StampAnnotName; AText:
  string; AEncoder: THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateStampAnnot(THaruPage(FOwnerPage).PageHandle, RectFToHaruRect(ARect),
    AName, pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddProjectionAnnot(ARect: TRectF; AText: string; AEncoder:
  THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateProjectionAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect), pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddSquareAnnot(ARect: TRectF; AText: string; AEncoder:
  THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateSquareAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect), pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

function THaruAnnotations.AddCircleAnnot(ARect: TRectF; AText: string; AEncoder:
  THaruEncoder; ATextPtr: Pointer): THaruAnnotation;
var
  hAnnotation: HPDF_Annotation;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  hAnnotation := HPDF_Page_CreateCircleAnnot(THaruPage(FOwnerPage).PageHandle,
    RectFToHaruRect(ARect), pText, THaruEncoder.GetEncoderHandle(AEncoder));
  Result := THaruAnnotation.Create(hAnnotation);
  FAnnotations.Add(Result);
end;

end.

