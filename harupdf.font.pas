unit harupdf.font;

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
  hpdf_types;

type
  TMeasureTextOption = (mesWordWrap, mesCanShorten, mesIgnoreTatweel);
  TMeasureTextOptions = set of TMeasureTextOption;

type
  TFontOption = (foEmbedding, foWithoutCIDMap, foWithoutToUnicodeMap);
  TFontOptions = set of TFontOption;

type
  THaruFont = class(TObject)
  protected
    FFontHandle: HPDF_Font;
    function GetFontName: string;
    function GetEncodingName: string;
    function GetBBox: TRectF;
    function GetAscent: Integer;
    function GetDescent: Integer;
    function GetLeading: Integer;
    function GetUnderlinePosition: Integer;
    function GetUnderlineThickness: Integer;
    function GetXHeight: Integer;
    function GetCapHeight: Integer;
  public
    property FontHandle: HPDF_Font read FFontHandle;

    // Gets the name of the font
    property Name: string read GetFontName;
    // Gets the encoding name of the font
    property EncodingName: string read GetEncodingName;
    // Gets the bounding box of the font
    property BBox: TRectF read GetBBox;
    // Gets the vertical ascent of the font
    property Ascent: Integer read GetAscent;
    // Gets the vertical descent of the font
    property Descent: Integer read GetDescent;
    //
    property Leading: Integer read GetLeading;
    //
    property UnderlinePosition: Integer read GetUnderlinePosition;
    //
    property UnderlineThickness: Integer read GetUnderlineThickness;
    // Gets the distance from the baseline of lowercase letters
    property XHeight: Integer read GetXHeight;
    // Gets the distance from the baseline of uppercase letters
    property CapHeight: Integer read GetCapHeight;

    // Gets the width of a charactor in the font
    function GetUnicodeWidth(ACode: Word): Integer;
    //
    function GetUcs4(AText: String; ATextPtr: Pointer = nil): Cardinal;
    //
    function GetUcs4Width(ACode: Cardinal): Integer;
    //
    function GetCharWidth(AText: String; ACode: Cardinal; ATextPtr: Pointer = nil): Integer;
    //
    procedure SetTatweelCount(ADstTatweels, ASrcTatweels: Integer; ANumChars: Integer);
    //
    procedure SelectConverters(AIndex: Integer);
    //
    procedure PushConverter(ANewFn: THPDF_Converter_New_Func; AParam: Pointer);
    //
    procedure PushBuiltInConverter(AName: String; AParam: Pointer);
    //
    function GetByteType(AText: String; AIndex: Integer; ATextPtr: Pointer = nil): THPDF_ByteType;
    //
    procedure SetCharacterEncoding(ACharEnc: THPDF_CharEnc);
    //
    procedure SetReliefFont(AReliefFont: THaruFont);

    // Gets total width of the text, number of characters, and number of words
    function TextWidth(AText: string; ATextLen: Integer; ATextPtr: Pointer = nil): THPDF_TextWidth;
    // Calculates the byte length which can be included within the specified width
    function MeasureText(AText: string; ATextLen: Integer; AWidth: Single; AFontSize: Single; ACharSpace: Single;
      AWordSpace: Single; AOptions: TMeasureTextOptions; ATextPtr: Pointer = nil): Integer;
    //
    function MeasureTextLines(AText: string; ATextLen: Integer; ALineWidth: Single; AFontSize: Single;
      ACharSpace: Single; AWordSpace: Single; AMaxLines: Integer; AOptions: TMeasureTextOptions;
      ATextPtr: Pointer = nil): THPDF_TextLineWidth;

    constructor Create(AFontHandle: HPDF_Font);
  end;
  THaruFontsList = {$IFNDEF FPC}TList{$ELSE}specialize TFPGList{$ENDIF}<THaruFont>;

type
  THaruFonts = class(TObject)
  protected
    FOwner: TObject;
    FFonts: THaruFontsList;
    function GetFontByIdx(AFontIndex: Integer): THaruFont;
    function GetCount: Integer;
  public
    property Items[AFontIndex: Integer]: THaruFont read GetFontByIdx; default;
    property Count: Integer read GetCount;

    // Enables Japanese fonts
    function UseJPFonts: Boolean;
    // Enables Korean fonts
    function UseKRFonts: Boolean;
    // Enables simplified Chinese fonts
    function UseCNSFonts: Boolean;
    // Enables traditional Chinese fonts
    function UseCNTFonts: Boolean;

    // Loads a Type1 font from an external file and returns font name
    function LoadType1FontFromFile(const AAfmFileName, ADataFileName: String): String;
    // Loads a TrueType font from an external file and returns font name
    function LoadTTFontFromFile(const AFileName: string; AOptions: TFontOptions): string; overload;
    // Loads a TrueType font from an TrueType collection file and returns font name
    function LoadTTFontFromFile(const AFileName: string; AOptions: TFontOptions; AIndex: Integer): string;
      overload;
    // Initializes font object by specified name and encoding
    function GetFont(AFontName: String; AEncodingName: String = ''): THaruFont;

    function GetFontByHandle(AFontHandle: HPDF_Font): THaruFont;
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
  end;

function FontOptionsToInt(AOptions: TFontOptions): Cardinal;
function MeasureTextOptionsToInt(AOptions: TMeasureTextOptions): Cardinal;

implementation
uses
  harupdf.document,
  harupdf.utils;

function FontOptionsToInt(AOptions: TFontOptions): Cardinal;
var
  flags: Cardinal;
begin
  flags := 0;
  if foEmbedding in AOptions then
    flags := flags or HPDF_FONTOPT_EMBEDDING;
  if foWithoutCIDMap in AOptions then
    flags := flags or HPDF_FONTOPT_WITHOUT_CID_MAP;
  if foWithoutToUnicodeMap in AOptions then
    flags := flags or HPDF_FONTOPT_WITHOUT_TOUNICODE_MAP;

  Result := flags;
end;

function MeasureTextOptionsToInt(AOptions: TMeasureTextOptions): Cardinal;
var
  flags: Cardinal;
begin
  flags := 0;
  if mesWordWrap in AOptions then
    flags := flags or HPDF_MEASURE_WORD_WRAP;
  if mesCanShorten in AOptions then
    flags := flags or HPDF_MEASURE_CAN_SHORTEN;
  if mesIgnoreTatweel in AOptions then
    flags := flags or HPDF_MEASURE_IGNORE_TATWEEL;

  Result := flags;
end;

{ THaruFont }

constructor THaruFont.Create(AFontHandle: HPDF_Font);
begin
  FFontHandle := AFontHandle;
end;

function THaruFont.GetFontName: string;
begin
  Result := PUTF8CharToString(HPDF_Font_GetFontName(FFontHandle));
end;

function THaruFont.GetEncodingName: string;
begin
  Result := PUTF8CharToString(HPDF_Font_GetEncodingName(FFontHandle));
end;

function THaruFont.GetBBox: TRectF;
var
  box: THPDF_Rect;
begin
  box := HPDF_Font_GetBBox(FFontHandle);
  Result := RectF(box.Left, box.Top, box.Right, box.Bottom);
end;

function THaruFont.GetAscent: Integer;
begin
  Result := HPDF_Font_GetAscent(FFontHandle);
end;

function THaruFont.GetDescent: Integer;
begin
  Result := HPDF_Font_GetDescent(FFontHandle);
end;

function THaruFont.GetLeading: Integer;
begin
  Result := HPDF_Font_GetLeading(FFontHandle);
end;

function THaruFont.GetUnderlinePosition: Integer;
begin
  Result := HPDF_Font_GetUnderlinePosition(FFontHandle);
end;

function THaruFont.GetUnderlineThickness: Integer;
begin
  Result := HPDF_Font_GetUnderlineThickness(FFontHandle);
end;

function THaruFont.GetXHeight: Integer;
begin
  Result := HPDF_Font_GetXHeight(FFontHandle);
end;

function THaruFont.GetCapHeight: Integer;
begin
  Result := HPDF_Font_GetCapHeight(FFontHandle);
end;

function THaruFont.GetUnicodeWidth(ACode: Word): Integer;
begin
  Result := HPDF_Font_GetUnicodeWidth(FFontHandle, ACode);
end;

function THaruFont.GetUcs4(AText: String; ATextPtr: Pointer): Cardinal;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Font_GetUcs4(FFontHandle, pText, nil);
end;

function THaruFont.GetUcs4Width(ACode: Cardinal): Integer;
begin
  Result := HPDF_Font_GetUcs4Width(FFontHandle, ACode);
end;

function THaruFont.GetCharWidth(AText: String; ACode: Cardinal; ATextPtr: Pointer): Integer;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Font_GetCharWidth(FFontHandle, pText, nil, ACode);
end;

procedure THaruFont.SetTatweelCount(ADstTatweels, ASrcTatweels: Integer; ANumChars: Integer);
begin
  HPDF_Font_SetTatweelCount(FFontHandle, ADstTatweels, ASrcTatweels, ANumChars);
end;

procedure THaruFont.SelectConverters(AIndex: Integer);
begin
  HPDF_Font_SelectConverters(FFontHandle, AIndex);
end;

procedure THaruFont.PushConverter(ANewFn: THPDF_Converter_New_Func; AParam: Pointer);
begin
  HPDF_Font_PushConverter(FFontHandle, ANewFn, AParam);
end;

procedure THaruFont.PushBuiltInConverter(AName: String; AParam: Pointer);
var
  pName: PUTF8Char;
begin
  pName := StringToPUTF8Char(AName);
  HPDF_Font_PushBuiltInConverter(FFontHandle, pName, AParam);
end;

function THaruFont.GetByteType(AText: String; AIndex: Integer; ATextPtr: Pointer): THPDF_ByteType;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Font_GetByteType(FFontHandle, pText, AIndex);
end;

procedure THaruFont.SetCharacterEncoding(ACharEnc: THPDF_CharEnc);
begin
  HPDF_Font_SetCharacterEncoding(FFontHandle, ACharEnc);
end;

procedure THaruFont.SetReliefFont(AReliefFont: THaruFont);
begin
  HPDF_Font_SetReliefFont(FFontHandle, AReliefFont.FontHandle);
end;

function THaruFont.TextWidth(AText: string; ATextLen: Integer; ATextPtr: Pointer): THPDF_TextWidth;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Font_TextWidth(FFontHandle, pText, ATextLen);
end;

function THaruFont.MeasureText(AText: String; ATextLen: Integer; AWidth: Single; AFontSize: Single; ACharSpace:
  Single; AWordSpace: Single; AOptions: TMeasureTextOptions; ATextPtr: Pointer): Integer;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Font_MeasureText(FFontHandle, pText, ATextLen, AWidth, AFontSize, ACharSpace,
    AWordSpace, MeasureTextOptionsToInt(AOptions), nil);
end;

function THaruFont.MeasureTextLines(AText: String; ATextLen: Integer; ALineWidth: Single; AFontSize: Single;
  ACharSpace: Single; AWordSpace: Single; AMaxLines: Integer; AOptions: TMeasureTextOptions;
  ATextPtr: Pointer): THPDF_TextLineWidth;
var
  flags: Cardinal;
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  flags := 0;
  if mesWordWrap in AOptions then
    flags := flags or HPDF_MEASURE_WORD_WRAP;
  if mesCanShorten in AOptions then
    flags := flags or HPDF_MEASURE_CAN_SHORTEN;
  if mesIgnoreTatweel in AOptions then
    flags := flags or HPDF_MEASURE_IGNORE_TATWEEL;

  HPDF_Font_MeasureTextLines(FFontHandle, pText, ATextLen, ALineWidth, AFontSize,
    ACharSpace, AWordSpace, flags, Result, AMaxLines);
end;

{ THaruFonts }

constructor THaruFonts.Create(AOwner: TObject);
begin
  FOwner := AOwner;
  FFonts := THaruFontsList.Create;
end;

destructor THaruFonts.Destroy;
var
  font: THaruFont;
begin
  for font in FFonts do
    font.Free;
  FFonts.Free;
  inherited Destroy;
end;

function THaruFonts.GetFontByIdx(AFontIndex: Integer): THaruFont;
begin
  Result := nil;
  if (FFonts.Count = 0) then
    Exit;
  if (AFontIndex < 0) or (AFontIndex >= FFonts.Count) then
    raise Exception.Create('Font index out of range');
  Result := FFonts[AFontIndex];
end;

function THaruFonts.GetFontByHandle(AFontHandle: HPDF_Font): THaruFont;
var
  font: THaruFont;
begin
  Result := nil;

  for font in FFonts do
  begin
    if (font.FontHandle = AFontHandle) then
    begin
      Result := font;
      Break;
    end;
  end;
end;

function THaruFonts.GetCount: Integer;
begin
  Result := FFonts.Count;
end;

function THaruFonts.UseJPFonts: Boolean;
begin
  Result := (HPDF_UseJPFonts(THaruDocument(FOwner).DocumentHandle) = HPDF_OK);
end;

function THaruFonts.UseKRFonts: Boolean;
begin
  Result := (HPDF_UseKRFonts(THaruDocument(FOwner).DocumentHandle) = HPDF_OK);
end;

function THaruFonts.UseCNSFonts: Boolean;
begin
  Result := (HPDF_UseCNSFonts(THaruDocument(FOwner).DocumentHandle) = HPDF_OK);
end;

function THaruFonts.UseCNTFonts: Boolean;
begin
  Result := (HPDF_UseCNTFonts(THaruDocument(FOwner).DocumentHandle) = HPDF_OK);
end;

function THaruFonts.LoadType1FontFromFile(const AAfmFileName, ADataFileName: String): String;
var
  pAfmFileName: PUTF8Char;
  pDataFileName: PUTF8Char;
begin
  pAfmFileName := StringToPUTF8Char(AAfmFileName);
  pDataFileName := StringToPUTF8Char(ADataFileName);
  Result := PUTF8CharToString(HPDF_LoadType1FontFromFile(THaruDocument(FOwner).DocumentHandle,
    pAfmFileName, pDataFileName));
end;

function THaruFonts.LoadTTFontFromFile(const AFileName: string; AOptions: TFontOptions): String;
var
  pFileName: PUTF8Char;
begin
  pFileName := StringToPUTF8Char(AFileName);
  Result := PUTF8CharToString(HPDF_LoadTTFontFromFile(THaruDocument(FOwner).DocumentHandle,
    pFileName, FontOptionsToInt(AOptions)));
end;

function THaruFonts.LoadTTFontFromFile(const AFileName: string;
  AOptions: TFontOptions; AIndex: Integer): string;
var
  pFileName: PUTF8Char;
begin
  pFileName := StringToPUTF8Char(AFileName);
  Result := PUTF8CharToString(HPDF_LoadTTFontFromFile2(THaruDocument(FOwner).DocumentHandle,
    pFileName, AIndex, FontOptionsToInt(AOptions)));
end;

function THaruFonts.GetFont(AFontName: String; AEncodingName: String): THaruFont;
var
  hFont: HPDF_Font;
  pFontName: PUTF8Char;
  pEncodingName: PUTF8Char;
begin
  pFontName := StringToPUTF8Char(AFontName);
  pEncodingName := StringToPUTF8Char(AEncodingName);
  hFont := HPDF_GetFont(THaruDocument(FOwner).DocumentHandle, pFontName, pEncodingName);
  Result := THaruFont.Create(hFont);
  FFonts.Add(Result);
end;

end.

