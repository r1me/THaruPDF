unit harupdf.page;

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
  System.SysUtils,
  System.DateUtils,
  System.Generics.Collections,
{$ELSE}
  Classes,
  Types,
  SysUtils,
  DateUtils,
  fgl,
{$ENDIF}
  hpdf,
  hpdf_consts,
  hpdf_error,
  hpdf_types,
  harupdf.image,
  harupdf.font,
  harupdf.destination,
  harupdf.annotation,
  harupdf.view3d;

type
  THaruPage = class(TObject)
  protected
    FOwner: TObject;
    FPageHandle: HPDF_Page;
    FDestinations: THaruDestinations;
    FAnnotations: THaruAnnotations;
    function GetWidth: Single;
    procedure SetWidth(AWidth: Single);
    function GetHeight: Single;
    procedure SetHeight(AHeight: Single);

    function GetCurrentFont: THaruFont;
    function GetCurrentFontSize: Single;

    function GetCharSpace: Single;
    procedure SetCharSpace(ACharSpace: Single);
    function GetWordSpace: Single;
    procedure SetWordSpace(AWordSpace: Single);
    function GetTextLeading: Single;
    procedure SetTextLeading(ATextLeading: Single);
    function GetHorizontalScalling: Single;
    procedure SetHorizontalScalling(AHorizontalScalling: Single);
    function GetTextRenderingMode: THPDF_TextRenderingMode;
    procedure SetTextRenderingMode(ATextRenderingMode: THPDF_TextRenderingMode);
    function GetTextRise: Single;
    procedure SetTextRise(ATextRise: Single);
    function GetTextMatrix: THPDF_TransMatrix;
    procedure SetTextMatrix(ATextMatrix: THPDF_TransMatrix);

    function GetGMode: Word;
    function GetGStateDepth: Cardinal;

    function GetFlat: Single;
    procedure SetFlat(AFlat: Single);

    function GetGrayFill: Single;
    procedure SetGrayFill(AGrayFill: Single);
    function GetGrayStroke: Single;
    procedure SetGrayStroke(AGrayStroke: Single);
    function GetRGBFill: THPDF_RGBColor;
    procedure SetRGBFill(ARGBFill: THPDF_RGBColor);
    function GetRGBStroke: THPDF_RGBColor;
    procedure SetRGBStroke(ARGBStroke: THPDF_RGBColor);
    function GetCMYKFill: THPDF_CMYKColor;
    procedure SetCMYKFill(ACMYKFill: THPDF_CMYKColor);
    function GetCMYKStroke: THPDF_CMYKColor;
    procedure SetCMYKStroke(ACMYKStroke: THPDF_CMYKColor);

    function GetStrokingColorSpace: THPDF_ColorSpace;
    function GetFillingColorSpace: THPDF_ColorSpace;

    function GetLineWidth: Single;
    procedure SetLineWidth(ALineWidth: Single);
    function GetLineCap: THPDF_LineCap;
    procedure SetLineCap(ALineCap: THPDF_LineCap);
    function GetLineJoin: THPDF_LineJoin;
    procedure SetLineJoin(ALineJoin: THPDF_LineJoin);
    function GetMiterLimit: Single;
    procedure SetMiterLimit(AMiterLimit: Single);

    function GetTransMatrix: THPDF_TransMatrix;
  public
    property PageHandle: HPDF_Page read FPageHandle;

    // Changes the width of a page
    property Width: Single read GetWidth write SetWidth;
    // Changes the height of a page
    property Height: Single read GetHeight write SetHeight;
    // Sets different page boundaries
    procedure SetBoundary(ABoundary: THPDF_PageBoundary; ARect: TRectF);
    // Changes the size and direction of a page to a predefined size
    procedure SetSize(APageSize: THPDF_PageSizes; APageDirection: THPDF_PageDirection);
    // Sets rotation angle of the page
    procedure SetRotate(ARotationAngle: Word);
    // Sets zoom factor of the page
    procedure SetZoom(AZoom: Single);

    // Gets page's current font
    property Font: THaruFont read GetCurrentFont;
    // Gets the size of the page's current font
    property FontSize: Single read GetCurrentFontSize;
    // Sets the type of font and size leading
    function SetFontAndSize(AFont: THaruFont; AFontSize: Single): Boolean;
    // Sets character spacing
    property CharSpace: Single read GetCharSpace write SetCharSpace;
    // Sets word spacing
    property WordSpace: Single read GetWordSpace write SetWordSpace;
    // Sets line spacing
    property TextLeading: Single read GetTextLeading write SetTextLeading;
    // Sets horizontal scalling for text showing
    property HorizontalScalling: Single read GetHorizontalScalling write SetHorizontalScalling;
    //
    procedure SetJustifyRatio(AWordSpace, ACharacterSpace, AKashida: Single);
    //
    procedure SetInterlinearAnnotationRatio(ARatio: Single);
    // Sets text rendering mode
    property TextRenderingMode: THPDF_TextRenderingMode read GetTextRenderingMode write
      SetTextRenderingMode;
    // Sets text rising
    property TextRise: Single read GetTextRise write SetTextRise;
    // Sets a transformation matrix for text to be drawn in using ShowText
    property TextMatrix: THPDF_TransMatrix read GetTextMatrix write SetTextMatrix;
    // Begins a text object and sets the text position to (0, 0)
    function BeginText: Boolean;
    // Ends a text object
    procedure EndText;
    // Gets the current position for text showing
    function GetCurrentTextPos: TPointF;
    // Changes the current text position, using the specified offset values
    procedure MoveTextPos(Ax, Ay: Single);
    // Changes the current text position, using the specified offset values,
    // the text-leading is set to -y
    procedure MoveTextPos2(Ax, Ay: Single);
    // Moves current position for the text showing to a next line
    function MoveToNextLine: Boolean;
    // Prints the text at the current position on the page
    function ShowText(const AText: string; ATextPtr: Pointer = nil): Boolean;

    // Moves the current text position to the start of the next line,
    // then prints the text at the current position
    function ShowTextNextLine(const AText: string; ATextPtr: Pointer = nil): Boolean; overload;
    // Moves the current text position to the start of the next line, sets
    // word spacing and character spacing. Prints the text at the current position
    function ShowTextNextLine(const AText: string; AWordSpace, ACharacterSpace: Single;
      ATextPtr: Pointer = nil): Boolean; overload;
    // Prints the text on the specified position
    function TextOut(Ax, Ay: Single; const AText: string; ATextPtr: Pointer = nil): Boolean;
    //
    procedure TextOutCircle(Ax, Ay, ARadius, AStartAngle: Single; const AText: String);
    // Prints the text inside the specified region
    function TextRect(ARect: TRectF; ATextAlignment: Cardinal; const AText: string;
      out ATextLen: Integer; ATextPtr: Pointer = nil): Boolean;
    // Gets the width of the text in current fontsize, character spacing and word spacing
    function TextWidth(AText: string; ATextPtr: Pointer = nil): Single; overload;

    // Calculates the byte length which can be included within the specified width
    function MeasureText(AText: string; AWidth: Single; AOptions: TMeasureTextOptions;
      ATextPtr: Pointer = nil): Integer;
    //
    function MeasureTextLines(AText: string; ALineWidth: Single; AOptions: TMeasureTextOptions;
      AMaxLines: Integer; ATextPtr: Pointer = nil): Integer;

    property Destinations: THaruDestinations read FDestinations write FDestinations;
    property Annotations: THaruAnnotations read FAnnotations write FAnnotations;

    // Gets the current graphics mode
    property GMode: Word read GetGMode;
    // Saves the page's current graphics parameter to the stack
    function GSave: Boolean;
    // Restore the graphics state which is saved by GSave
    procedure GRestore;
    // Gets the number of the page's graphics state stack
    property GStateDepth: Cardinal read GetGStateDepth;
    // Applies the graphics state to the page
    procedure SetExtGState(AExtGState: HPDF_ExtGState);

    // Sets filling color. Valid only when the page's stroking color space is HPDF_CS_DEVICE_GRAY
    property GrayFill: Single read GetGrayFill write SetGrayFill;
    // Sets stroking color. Valid only when the page's stroking color space is HPDF_CS_DEVICE_GRAY
    property GrayStroke: Single read GetGrayStroke write SetGrayStroke;
    // Sets filling color. Valid only when the page's filling color space is HPDF_CS_DEVICE_RGB
    property RGBFill: THPDF_RGBColor read GetRGBFill write SetRGBFill;
    // Sets stroking color. Valid only when the page's filling color space is HPDF_CS_DEVICE_RGB
    property RGBStroke: THPDF_RGBColor read GetRGBStroke write SetRGBStroke;
    // Sets filling color. Valid only when the page's filling color space is HPDF_CS_DEVICE_CMYK
    property CMYKFill: THPDF_CMYKColor read GetCMYKFill write SetCMYKFill;
    // Sets stroking color. Valid only when the page's filling color space is HPDF_CS_DEVICE_CMYK
    property CMYKStroke: THPDF_CMYKColor read GetCMYKStroke write SetCMYKStroke;
    // Gets the current value of the page's stroking color space
    property StrokingColorSpace: THPDF_ColorSpace read GetStrokingColorSpace;
    // Gets the current value of the page's stroking color space
    property FillingColorSpace: THPDF_ColorSpace read GetFillingColorSpace;

    // Sets the width of the line used to stroke a path
    property LineWidth: Single read GetLineWidth write SetLineWidth;
    // Sets the shape to be used at the ends of lines
    property LineCap: THPDF_LineCap read GetLineCap write SetLineCap;
    // Sets the line join style in the page
    property LineJoin: THPDF_LineJoin read GetLineJoin write SetLineJoin;
    // Sets the maximum miter length
    property MiterLimit: Single read GetMiterLimit write SetMiterLimit;
    // Sets the dash pattern for lines in the page
    function GetDash: THPDF_DashMode;
    procedure SetDash(const ADash: array of Single; APhase: Single);

    // Gets the current position for path painting
    function GetCurrentPos: TPointF;
    // Sets the current position for path painting
    procedure MoveTo(Ax, Ay: Single);
    // Appends a path from the current point to the specified point
    procedure LineTo(Ax, Ay: Single);
    // Appends a Bézier curve to the current path using the control points (x1, y1) and (x2, y2) and (x3, y3)
    procedure CurveTo(Ax1, Ay1: Single; Ax2, Ay2: Single; Ax3, Ay3: Single);
    // Appends a Bézier curve to the current path using the current point and (x2, y2) and (x3, y3) as control points
    procedure CurveTo2(Ax2, Ay2: Single; Ax3, Ay3: Single);
    // Appends a Bézier curve to the current path using the current point and (x1, y1) and (x3, y3) as control points
    procedure CurveTo3(Ax1, Ay1: Single; Ax3, Ay3: Single);
    // Appends a straight line from the current point to the start point of sub path
    procedure ClosePath;
    // Appends a rectangle to the current path
    procedure Rectangle(Ax, Ay: Single; AWidth, AHeight: Single); overload;
    procedure Rectangle(ARect: TRectF); overload;
    // Appends a circle to the current path
    procedure Circle(Ax, Ay: Single; ARadius: Single);
    // Appends an ellipse to the current path
    procedure Ellipse(Ax, Ay: Single; ARadiusX, ARadiusY: Single);
    // Appends a circle arc to the current path
    procedure Arc(Ax, Ay: Single; ARadius: Single; Angle1, Angle2: Single);
    // Paints the current path
    procedure Stroke;
    // Closes the current path, then paints the path
    procedure ClosePathStroke;
    // Fills the current path using the nonzero winding number rule
    procedure Fill;
    // Fills the current path using the even-odd rule
    procedure Eofill;
    // Fills the current path using the nonzero winding number rule, then paints the path
    procedure FillStroke;
    // Fills the current path using the even-odd rule, then paints the path
    procedure EofillStroke;
    // Closes the current path, fills the current path using the nonzero winding number rule, then paints the path
    procedure ClosePathFillStroke;
    // Closes the current path, fills the current path using the even-odd rule, then paints the path
    procedure ClosePathEofillStroke;
    // Ends the path object without filling or painting
    procedure EndPath;
    // Modifies the current clipping path by intersecting it with the current path using the nonzero winding number rule
    procedure Clip;
    // Modifies the current clipping path by intersecting it with the current path using the even-odd rule
    procedure Eoclip;

    // Shows an image in one operation
    function DrawImage(AImage: THaruImage; Ax, Ay: Single; AWidth: Single = -1; AHeight: Single = -1): Boolean;
    //
    function CreateXObjectFromImage(ARect: TRectF; AImage: THaruImage; AZoom: Boolean):
      HPDF_XObject;
    //
    function CreateXObjectAsWhiteRect(ARect: TRectF): HPDF_XObject;
    //
    function ExecuteXObject(AObject: HPDF_XObject): Boolean;
    //
    function Create3DView(AU3D: THaruU3D; A3DAnnotation: THaruAnnotation; AName: String): THaru3DView;
    //
    function Create3DAnnotExData: HPDF_ExData;
    //
    procedure AnnotExData_Set3DMeasurement(AExData: HPDF_ExData; AMeasure: THaru3DMeasure);

    // Gets the current transformation matrix of the page
    property TransMatrix: THPDF_TransMatrix read GetTransMatrix;
    // Concatenates the page's current transformation matrix and specified matrix
    function Concat(Aa, Ab, Ac, Ad, Ax, Ay: Single): Boolean;
    // Sets page flatness
    property Flat: Single read GetFlat write SetFlat;

    // Defines transition style for the page
    procedure SetSlideShow(AType: THPDF_TransitionStyle; ADispTime: Single; ATransTime: Single);

    constructor Create(AOwner: TObject; APageHandle: HPDF_Page);
    destructor Destroy; override;
  end;
  THaruPagesList = {$IFNDEF FPC}TList{$ELSE}specialize TFPGList{$ENDIF}<THaruPage>;

type
  THaruPages = class(TObject)
  protected
    FOwner: TObject;
    FPages: THaruPagesList;
    function GetCurrentPage: THaruPage;
    function GetPageByIdx(APageIndex: Integer): THaruPage;
    function GetCount: Integer;
  public
    property Items[APageIndex: Integer]: THaruPage read GetPageByIdx; default;
    property Count: Integer read GetCount;
    function GetPageByHandle(APageHandle: HPDF_Page): THaruPage;

    // The maximum number of pages becomes 8191 * APagePerPages. Must be set before adding any page
    procedure SetPagesConfiguration(APagePerPages: Integer);
    // Returns the current page object
    property CurrentPage: THaruPage read GetCurrentPage;
    // Creates a new page and adds it after the last page of a document
    function Add: THaruPage;
    // Creates a new page and inserts it just before the specified page
    function InsertPage(ATargetPage: THaruPage): THaruPage; overload;
    function InsertPage(ATargetPageIndex: Integer): THaruPage; overload;

    // Call to begin/end writing shared content to a stream
    function BeginEndSharedContent(APage: THaruPage; var AContentStream: HPDF_DICT): Boolean;
    // Inserts shared content on the page
    function InsertSharedContent(APage: THaruPage; const AContentStream: HPDF_DICT): Boolean;

    constructor Create(AOwner: TObject);
    destructor Destroy; override;
  end;

implementation
uses
  harupdf.document,
  harupdf.utils;

{ THaruPage }

constructor THaruPage.Create(AOwner: TObject; APageHandle: HPDF_Page);
begin
  FOwner := AOwner;
  FPageHandle := APageHandle;
  FDestinations := THaruDestinations.Create(Self);
  FAnnotations := THaruAnnotations.Create(Self, AOwner);
end;

destructor THaruPage.Destroy;
begin
  FDestinations.Free;
  FAnnotations.Free;
  inherited;
end;

function THaruPage.GetWidth: Single;
begin
  Result := HPDF_Page_GetWidth(FPageHandle);
end;

procedure THaruPage.SetWidth(AWidth: Single);
begin
  HPDF_Page_SetWidth(FPageHandle, AWidth);
end;

function THaruPage.GetHeight: Single;
begin
  Result := HPDF_Page_GetHeight(FPageHandle);
end;

procedure THaruPage.SetHeight(AHeight: Single);
begin
  HPDF_Page_SetHeight(FPageHandle, AHeight);
end;

procedure THaruPage.SetBoundary(ABoundary: THPDF_PageBoundary; ARect: TRectF);
begin
  HPDF_Page_SetBoundary(FPageHandle, ABoundary, ARect.Left, ARect.Bottom, ARect.Right, ARect.Top);
end;

procedure THaruPage.SetSize(APageSize: THPDF_PageSizes; APageDirection: THPDF_PageDirection);
begin
  HPDF_Page_SetSize(FPageHandle, APageSize, APageDirection);
end;

procedure THaruPage.SetRotate(ARotationAngle: Word);
begin
  HPDF_Page_SetRotate(FPageHandle, ARotationAngle);
end;

procedure THaruPage.SetZoom(AZoom: Single);
begin
  HPDF_Page_SetZoom(FPageHandle, AZoom);
end;

function THaruPage.GetCurrentFont: THaruFont;
var
  hCurrentFont: HPDF_Font;
begin
  hCurrentFont := HPDF_Page_GetCurrentFont(FPageHandle);
  Result := THaruDocument(FOwner).Fonts.GetFontByHandle(hCurrentFont);
end;

function THaruPage.GetCurrentFontSize: Single;
begin
  Result := HPDF_Page_GetCurrentFontSize(FPageHandle);
end;

function THaruPage.SetFontAndSize(AFont: THaruFont; AFontSize: Single): Boolean;
begin
  Result := (HPDF_Page_SetFontAndSize(FPageHandle, AFont.FontHandle, AFontSize) = HPDF_OK);
end;

function THaruPage.GetCharSpace: Single;
begin
  Result := HPDF_Page_GetCharSpace(FPageHandle);
end;

procedure THaruPage.SetCharSpace(ACharSpace: Single);
begin
  HPDF_Page_SetCharSpace(FPageHandle, ACharSpace);
end;

function THaruPage.GetWordSpace: Single;
begin
  Result := HPDF_Page_GetWordSpace(FPageHandle);
end;

procedure THaruPage.SetWordSpace(AWordSpace: Single);
begin
  HPDF_Page_SetWordSpace(FPageHandle, AWordSpace);
end;

function THaruPage.GetTextLeading: Single;
begin
  Result := HPDF_Page_GetTextLeading(FPageHandle);
end;

procedure THaruPage.SetTextLeading(ATextLeading: Single);
begin
  HPDF_Page_SetTextLeading(FPageHandle, ATextLeading);
end;

function THaruPage.GetHorizontalScalling: Single;
begin
  Result := HPDF_Page_GetHorizontalScalling(FPageHandle);
end;

procedure THaruPage.SetHorizontalScalling(AHorizontalScalling: Single);
begin
  HPDF_Page_SetHorizontalScalling(FPageHandle, AHorizontalScalling);
end;

procedure THaruPage.SetJustifyRatio(AWordSpace, ACharacterSpace, AKashida: Single);
begin
  HPDF_Page_SetJustifyRatio(FPageHandle, AWordSpace, ACharacterSpace, AKashida);
end;

procedure THaruPage.SetInterlinearAnnotationRatio(ARatio: Single);
begin
  HPDF_Page_InterlinearAnnotationRatio(FPageHandle, ARatio);
end;

function THaruPage.GetTextRenderingMode: THPDF_TextRenderingMode;
begin
  Result := HPDF_Page_GetTextRenderingMode(FPageHandle);
end;

procedure THaruPage.SetTextRenderingMode(ATextRenderingMode: THPDF_TextRenderingMode);
begin
  HPDF_Page_SetTextRenderingMode(FPageHandle, ATextRenderingMode);
end;

function THaruPage.GetTextRise: Single;
begin
  Result := HPDF_Page_GetTextRise(FPageHandle);
end;

procedure THaruPage.SetTextRise(ATextRise: Single);
begin
  HPDF_Page_SetTextRise(FPageHandle, ATextRise);
end;

function THaruPage.GetTextMatrix: THPDF_TransMatrix;
begin
  Result := HPDF_Page_GetTextMatrix(FPageHandle);
end;

procedure THaruPage.SetTextMatrix(ATextMatrix: THPDF_TransMatrix);
begin
  HPDF_Page_SetTextMatrix(FPageHandle, ATextMatrix.a, ATextMatrix.b, ATextMatrix.c,
    ATextMatrix.d, ATextMatrix.x, ATextMatrix.y);
end;

function THaruPage.BeginText: Boolean;
begin
  Result := (HPDF_Page_BeginText(FPageHandle) = HPDF_OK);
end;

procedure THaruPage.EndText;
begin
  HPDF_Page_EndText(FPageHandle);
end;

function THaruPage.GetGrayFill: Single;
begin
  Result := HPDF_Page_GetGrayFill(FPageHandle);
end;

procedure THaruPage.SetGrayFill(AGrayFill: Single);
begin
  HPDF_Page_SetGrayFill(FPageHandle, AGrayFill);
end;

function THaruPage.GetGrayStroke: Single;
begin
  Result := HPDF_Page_GetGrayStroke(FPageHandle);
end;

procedure THaruPage.SetGrayStroke(AGrayStroke: Single);
begin
  HPDF_Page_SetGrayStroke(FPageHandle, AGrayStroke);
end;

function THaruPage.GetRGBFill: THPDF_RGBColor;
begin
  Result := HPDF_Page_GetRGBFill(FPageHandle);
end;

procedure THaruPage.SetRGBFill(ARGBFill: THPDF_RGBColor);
begin
  HPDF_Page_SetRGBFill(FPageHandle, ARGBFill.r, ARGBFill.g, ARGBFill.b);
end;

function THaruPage.GetRGBStroke: THPDF_RGBColor;
begin
  Result := HPDF_Page_GetRGBStroke(FPageHandle);
end;

procedure THaruPage.SetRGBStroke(ARGBStroke: THPDF_RGBColor);
begin
  HPDF_Page_SetRGBStroke(FPageHandle, ARGBStroke.r, ARGBStroke.g, ARGBStroke.b);
end;

function THaruPage.GetCMYKFill: THPDF_CMYKColor;
begin
  Result := HPDF_Page_GetCMYKFill(FPageHandle);
end;

procedure THaruPage.SetCMYKFill(ACMYKFill: THPDF_CMYKColor);
begin
  HPDF_Page_SetCMYKFill(FPageHandle, ACMYKFill.c, ACMYKFill.m, ACMYKFill.y, ACMYKFill.k);
end;

function THaruPage.GetCMYKStroke: THPDF_CMYKColor;
begin
  Result := HPDF_Page_GetCMYKStroke(FPageHandle);
end;

procedure THaruPage.SetCMYKStroke(ACMYKStroke: THPDF_CMYKColor);
begin
  HPDF_Page_SetCMYKStroke(FPageHandle, ACMYKStroke.c, ACMYKStroke.m, ACMYKStroke.y, ACMYKStroke.k);
end;

function THaruPage.GetStrokingColorSpace: THPDF_ColorSpace;
begin
  Result := HPDF_Page_GetStrokingColorSpace(FPageHandle);
end;

function THaruPage.GetFillingColorSpace: THPDF_ColorSpace;
begin
  Result := HPDF_Page_GetFillingColorSpace(FPageHandle);
end;

function THaruPage.GetLineWidth: Single;
begin
  Result := HPDF_Page_GetLineWidth(FPageHandle);
end;

procedure THaruPage.SetLineWidth(ALineWidth: Single);
begin
  HPDF_Page_SetLineWidth(FPageHandle, ALineWidth);
end;

function THaruPage.GetLineCap: THPDF_LineCap;
begin
  Result := HPDF_Page_GetLineCap(FPageHandle);
end;

procedure THaruPage.SetLineCap(ALineCap: THPDF_LineCap);
begin
  HPDF_Page_SetLineCap(FPageHandle, ALineCap);
end;

function THaruPage.GetLineJoin: THPDF_LineJoin;
begin
  Result := HPDF_Page_GetLineJoin(FPageHandle);
end;

procedure THaruPage.SetLineJoin(ALineJoin: THPDF_LineJoin);
begin
  HPDF_Page_SetLineJoin(FPageHandle, ALineJoin);
end;

function THaruPage.GetMiterLimit: Single;
begin
  Result := HPDF_Page_GetMiterLimit(FPageHandle);
end;

procedure THaruPage.SetMiterLimit(AMiterLimit: Single);
begin
  HPDF_Page_SetMiterLimit(FPageHandle, AMiterLimit);
end;

function THaruPage.GetDash: THPDF_DashMode;
begin
  Result := HPDF_Page_GetDash(FPageHandle);
end;

procedure THaruPage.SetDash(const ADash: array of Single; APhase: Single);
begin
  if Length(ADash) > 0 then
    HPDF_Page_SetDash(FPageHandle, @ADash[0], Length(ADash), APhase)
  else
    HPDF_Page_SetDash(FPageHandle, nil, 0, 0);
end;

function THaruPage.DrawImage(AImage: THaruImage; Ax, Ay: Single; AWidth, AHeight: Single):
  Boolean;
begin
  if Assigned(AImage) then
  begin
    if (AWidth = -1) and
       (AHeight = -1) then
    begin
      Result := (HPDF_Page_DrawImage(FPageHandle, AImage.ImageHandle, Ax, Ay, AImage.Width,
        AImage.Height) = HPDF_OK);
    end else
      Result := (HPDF_Page_DrawImage(FPageHandle, AImage.ImageHandle, Ax, Ay, AWidth, AHeight) =
        HPDF_OK);
  end else
    Result := False;
end;

function THaruPage.CreateXObjectFromImage(ARect: TRectF; AImage: THaruImage; AZoom: Boolean):
  HPDF_XObject;
begin
  Result := HPDF_Page_CreateXObjectFromImage(THaruDocument(FOwner).DocumentHandle, FPageHandle,
    RectFToHaruRect(ARect), AImage.ImageHandle, BooleanToHaruBool(AZoom));
end;

function THaruPage.CreateXObjectAsWhiteRect(ARect: TRectF): HPDF_XObject;
begin
  Result := HPDF_Page_CreateXObjectAsWhiteRect(THaruDocument(FOwner).DocumentHandle, FPageHandle,
    RectFToHaruRect(ARect));
end;

function THaruPage.ExecuteXObject(AObject: HPDF_XObject): Boolean;
begin
  Result := (HPDF_Page_ExecuteXObject(FPageHandle, AObject) = HPDF_OK);
end;

function THaruPage.Create3DView(AU3D: THaruU3D; A3DAnnotation: THaruAnnotation;
  AName: String): THaru3DView;
var
  hView: HPDF_Dict;
  pName: PUTF8Char;
begin
  pName := StringToPUTF8Char(AName);
  hView := HPDF_Page_Create3DView(FPageHandle, AU3D.U3DHandle, A3DAnnotation.AnnotationHandle,
    pName);
  Result := THaru3DView.Create(hView);
end;

function THaruPage.Create3DAnnotExData: HPDF_ExData;
begin
  Result := HPDF_Page_Create3DAnnotExData(FPageHandle);
end;

procedure THaruPage.AnnotExData_Set3DMeasurement(AExData: HPDF_ExData; AMeasure: THaru3DMeasure);
begin
  HPDF_3DAnnotExData_Set3DMeasurement(AExData, AMeasure.MeasureHandle);
end;

function THaruPage.GetTransMatrix: THPDF_TransMatrix;
begin
  Result := HPDF_Page_GetTransMatrix(FPageHandle);
end;

function THaruPage.Concat(Aa, Ab, Ac, Ad, Ax, Ay: Single): Boolean;
begin
  Result := (HPDF_Page_Concat(FPageHandle, Aa, Ab, Ac, Ad, Ax, Ay) = HPDF_OK);
end;

function THaruPage.GetGStateDepth: Cardinal;
begin
  Result := HPDF_Page_GetGStateDepth(FPageHandle);
end;

procedure THaruPage.SetExtGState(AExtGState: HPDF_ExtGState);
begin
  HPDF_Page_SetExtGState(FPageHandle, AExtGState);
end;

function THaruPage.GetCurrentPos: TPointF;
var
  pos: THPDF_Point;
begin
  pos := HPDF_Page_GetCurrentPos(FPageHandle);
  Result.x := pos.x;
  Result.y := pos.y;
end;

procedure THaruPage.MoveTo(Ax, Ay: Single);
begin
  HPDF_Page_MoveTo(FPageHandle, Ax, Ay);
end;

procedure THaruPage.LineTo(Ax, Ay: Single);
begin
  HPDF_Page_LineTo(FPageHandle, Ax, Ay);
end;

procedure THaruPage.CurveTo(Ax1, Ay1: Single; Ax2, Ay2: Single; Ax3, Ay3: Single);
begin
  HPDF_Page_CurveTo(FPageHandle, Ax1, Ay1, Ax2, Ay2, Ax3, Ay3);
end;

procedure THaruPage.CurveTo2(Ax2, Ay2: Single; Ax3, Ay3: Single);
begin
  HPDF_Page_CurveTo2(FPageHandle, Ax2, Ay2, Ax3, Ay3);
end;

procedure THaruPage.CurveTo3(Ax1, Ay1: Single; Ax3, Ay3: Single);
begin
  HPDF_Page_CurveTo3(FPageHandle, Ax1, Ay1, Ax3, Ay3);
end;

procedure THaruPage.ClosePath;
begin
  HPDF_Page_ClosePath(FPageHandle);
end;

procedure THaruPage.Rectangle(Ax, Ay: Single; AWidth, AHeight: Single);
begin
  HPDF_Page_Rectangle(FPageHandle, Ax, Ay, AWidth, AHeight);
end;

procedure THaruPage.Rectangle(ARect: TRectF);
begin
  HPDF_Page_Rectangle(FPageHandle, ARect.Left, ARect.Top, ARect.Width, ARect.Height);
end;

procedure THaruPage.Circle(Ax, Ay: Single; ARadius: Single);
begin
  HPDF_Page_Circle(FPageHandle, Ax, Ay, ARadius);
end;

procedure THaruPage.Ellipse(Ax, Ay: Single; ARadiusX, ARadiusY: Single);
begin
  HPDF_Page_Ellipse(FPageHandle, Ax, Ay, ARadiusX, ARadiusY);
end;

procedure THaruPage.Arc(Ax, Ay: Single; ARadius: Single; Angle1, Angle2: Single);
begin
  HPDF_Page_Arc(FPageHandle, Ax, Ay, ARadius, Angle1, Angle2);
end;

procedure THaruPage.Stroke;
begin
  HPDF_Page_Stroke(FPageHandle);
end;

procedure THaruPage.ClosePathStroke;
begin
  HPDF_Page_ClosePathStroke(FPageHandle);
end;

procedure THaruPage.Fill;
begin
  HPDF_Page_Fill(FPageHandle);
end;

procedure THaruPage.Eofill;
begin
  HPDF_Page_Eofill(FPageHandle);
end;

procedure THaruPage.FillStroke;
begin
  HPDF_Page_FillStroke(FPageHandle);
end;

procedure THaruPage.EofillStroke;
begin
  HPDF_Page_EofillStroke(FPageHandle);
end;

procedure THaruPage.ClosePathFillStroke;
begin
  HPDF_Page_ClosePathFillStroke(FPageHandle);
end;

procedure THaruPage.ClosePathEofillStroke;
begin
  HPDF_Page_ClosePathEofillStroke(FPageHandle);
end;

procedure THaruPage.EndPath;
begin
  HPDF_Page_EndPath(FPageHandle);
end;

procedure THaruPage.Clip;
begin
  HPDF_Page_Clip(FPageHandle);
end;

procedure THaruPage.Eoclip;
begin
  HPDF_Page_Eoclip(FPageHandle);
end;

function THaruPage.GetFlat: Single;
begin
  Result := HPDF_Page_GetFlat(FPageHandle);
end;

procedure THaruPage.SetFlat(AFlat: Single);
begin
  HPDF_Page_SetFlat(FPageHandle, AFlat);
end;

procedure THaruPage.SetSlideShow(AType: THPDF_TransitionStyle;
  ADispTime: Single; ATransTime: Single);
begin
  HPDF_Page_SetSlideShow(FPageHandle, AType, ADispTime, ATransTime);
end;

function THaruPage.TextWidth(AText: string; ATextPtr: Pointer): Single;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Page_TextWidth(FPageHandle, pText);
end;

function THaruPage.MeasureText(AText: string; AWidth: Single; AOptions: TMeasureTextOptions; ATextPtr: Pointer): Integer;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Page_MeasureText(FPageHandle, pText, AWidth, MeasureTextOptionsToInt(AOptions), nil);
end;

function THaruPage.MeasureTextLines(AText: string; ALineWidth: Single; AOptions: TMeasureTextOptions;
  AMaxLines: Integer; ATextPtr: Pointer): Integer;
var
  lWidth: THPDF_TextLineWidth;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Page_MeasureTextLines(FPageHandle, pText, ALineWidth,
    MeasureTextOptionsToInt(AOptions), lWidth, AMaxLines);
end;

function THaruPage.GetGMode: Word;
begin
  Result := HPDF_Page_GetGMode(FPageHandle);
end;

function THaruPage.GSave: Boolean;
begin
  Result := (HPDF_Page_GSave(FPageHandle) = HPDF_OK);
end;

procedure THaruPage.GRestore;
begin
  HPDF_Page_GRestore(FPageHandle);
end;

function THaruPage.GetCurrentTextPos: TPointF;
var
  pos: THPDF_Point;
begin
  pos := HPDF_Page_GetCurrentTextPos(FPageHandle);
  Result.x := pos.x;
  Result.y := pos.y;
end;

procedure THaruPage.MoveTextPos(Ax, Ay: Single);
begin
  HPDF_Page_MoveTextPos(FPageHandle, Ax, Ay);
end;

procedure THaruPage.MoveTextPos2(Ax, Ay: Single);
begin
  HPDF_Page_MoveTextPos2(FPageHandle, Ax, Ay);
end;

function THaruPage.MoveToNextLine: Boolean;
begin
  Result := (HPDF_Page_MoveToNextLine(FPageHandle) = HPDF_OK);
end;

function THaruPage.ShowText(const AText: string; ATextPtr: Pointer): Boolean;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := (HPDF_Page_ShowText(FPageHandle, pText) = HPDF_OK);
end;

function THaruPage.ShowTextNextLine(const AText: string; ATextPtr: Pointer): Boolean;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := (HPDF_Page_ShowTextNextLine(FPageHandle, pText) = HPDF_OK);
end;

function THaruPage.ShowTextNextLine(const AText: string; AWordSpace, ACharacterSpace: Single;
  ATextPtr: Pointer): Boolean;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := (HPDF_Page_ShowTextNextLineEx(FPageHandle, AWordSpace, ACharacterSpace, pText) = HPDF_OK);
end;

function THaruPage.TextOut(Ax, Ay: Single; const AText: string; ATextPtr: Pointer): Boolean;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := (HPDF_Page_TextOut(FPageHandle, Ax, Ay, pText) = HPDF_OK);
end;

procedure THaruPage.TextOutCircle(Ax, Ay, ARadius, AStartAngle: Single; const AText: String);
var
  angle1, angle2: Single;
  rad1, rad2: Single;
  x, y: Single;
  i: Integer;
begin
  if (Length(AText) > 0) then
  begin
    angle1 := 360 / Length(AText);
    angle2 := 180;

    for i := 1 to Length(AText) do
    begin
      rad1 := (angle2 - AStartAngle) / 180 * Pi;
      rad2 := (angle2 - AStartAngle + 90) / 180 * Pi;

      x := Ax + cos(rad2) * ARadius;
      y := Ay + sin(rad2) * ARadius;

      Self.TextMatrix := THPDF_TransMatrix.Create(cos(rad1), sin(rad1), -sin(rad1), cos(rad1), x, y);

      Self.ShowText(AText[i]);
      angle2 := angle2 - angle1;
    end;
  end;
end;

function THaruPage.TextRect(ARect: TRectF; ATextAlignment: Cardinal; const AText: String;
  out ATextLen: Integer; ATextPtr: Pointer): Boolean;
var
  res: HPDF_STATUS;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  try
    res := HPDF_Page_TextRect(FPageHandle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom,
      pText, ATextAlignment, @ATextLen);
    Result := (res = HPDF_OK) or (res = HPDF_PAGE_INSUFFICIENT_SPACE);
  except
    on E: EHaruPDFException do
      Result := (E.ErrorCode = HPDF_PAGE_INSUFFICIENT_SPACE);
  end;
end;

{ THaruPages }

constructor THaruPages.Create(AOwner: TObject);
begin
  FOwner := AOwner;
  FPages := THaruPagesList.Create;
end;

destructor THaruPages.Destroy;
var
  page: THaruPage;
begin
  for page in FPages do
    page.Free;
  FPages.Free;
  inherited Destroy;
end;

function THaruPages.GetPageByIdx(APageIndex: Integer): THaruPage;
begin
  Result := nil;
  if (FPages.Count = 0) then
    Exit;
  if (APageIndex < 0) or (APageIndex >= FPages.Count) then
    raise Exception.Create('Page index out of range');
  Result := FPages[APageIndex];
end;

function THaruPages.GetCount: Integer;
begin
  Result := FPages.Count;
end;

function THaruPages.GetPageByHandle(APageHandle: HPDF_Page): THaruPage;
var
  page: THaruPage;
begin
  Result := nil;

  for page in FPages do
  begin
    if (page.PageHandle = APageHandle) then
    begin
      Result := page;
      Break;
    end;
  end;
end;

procedure THaruPages.SetPagesConfiguration(APagePerPages: Integer);
begin
  HPDF_SetPagesConfiguration(THaruDocument(FOwner).DocumentHandle, APagePerPages);
end;

function THaruPages.GetCurrentPage: THaruPage;
var
  hCurrentPage: HPDF_Page;
begin
  hCurrentPage := HPDF_GetCurrentPage(THaruDocument(FOwner).DocumentHandle);
  Result := GetPageByHandle(hCurrentPage);
end;

function THaruPages.Add: THaruPage;
var
  hPage: HPDF_Page;
begin
  hPage := HPDF_AddPage(THaruDocument(FOwner).DocumentHandle);
  Result := THaruPage.Create(FOwner, hPage);
  FPages.Add(Result);
end;

function THaruPages.InsertPage(ATargetPage: THaruPage): THaruPage;
var
  hPage: HPDF_Page;
begin
  hPage := HPDF_InsertPage(THaruDocument(FOwner).DocumentHandle, ATargetPage.PageHandle);
  Result := THaruPage.Create(FOwner, hPage);
  FPages.Insert(FPages.IndexOf(ATargetPage), Result);
end;

function THaruPages.InsertPage(ATargetPageIndex: Integer): THaruPage;
var
  hPage: HPDF_Page;
begin
  hPage := HPDF_InsertPage(THaruDocument(FOwner).DocumentHandle,
    FPages[ATargetPageIndex].PageHandle);
  Result := THaruPage.Create(FOwner, hPage);
  FPages.Insert(ATargetPageIndex, Result);
end;

function THaruPages.BeginEndSharedContent(APage: THaruPage; var AContentStream: HPDF_DICT): Boolean;
begin
  Result := (HPDF_Page_New_Content_Stream(APage.PageHandle, AContentStream) = HPDF_OK);
end;

function THaruPages.InsertSharedContent(APage: THaruPage; const AContentStream: HPDF_DICT): Boolean;
begin
  Result := (HPDF_Page_Insert_Shared_Content_Stream(APage.PageHandle, AContentStream) = HPDF_OK);
end;

end.

