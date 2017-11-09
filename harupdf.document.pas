unit harupdf.document;

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
  System.SysUtils,
  Vcl.Imaging.pngimage,
  Vcl.Imaging.JPEG,
{$ELSE}
  Classes,
  SysUtils,
  Graphics,
{$ENDIF}
  hpdf,
  hpdf_consts,
  hpdf_types,
  harupdf.image,
  harupdf.font,
  harupdf.page,
  harupdf.encoder,
  harupdf.destination,
  harupdf.outline,
  harupdf.view3d;

type
  EHaruPDFException = class(Exception)
  private
    FErrorCode: HPDF_STATUS;
    FDetailCode: HPDF_STATUS;
  public
    property ErrorCode: HPDF_STATUS read FErrorCode;
    property DetailCode: HPDF_STATUS read FDetailCode;

    constructor Create(AErrorCode, ADetailCode: HPDF_STATUS);
  end;

type
  THaruDocument = class(TObject)
  protected
    FDocumentHandle: HPDF_Doc;
  private
    FPages: THaruPages;
    FFonts: THaruFonts;
    FEncoders: THaruEncoders;
    FOutlines: THaruOutlines;
    FImages: THaruImagesList;
    function GetTitle: string;
    procedure SetTitle(ATitle: string);
    function GetSubject: string;
    procedure SetSubject(ASubject: string);
    function GetKeywords: string;
    procedure SetKeywords(AKeywords: string);
    function GetAuthor: string;
    procedure SetAuthor(AAuthor: string);
    function GetCreator: string;
    procedure SetCreator(ACreator: string);
    function GetProducer: string;
    procedure SetProducer(AProducer: string);

    function GetPageLayout: THPDF_PageLayout;
    procedure SetPageLayout(APageLayout: THPDF_PageLayout);
    function GetPageMode: THPDF_PageMode;
    procedure SetPageMode(APageMode: THPDF_PageMode);

    function GetViewerPreference: Cardinal;
    procedure SetViewerPreference(AViewerPreference: Cardinal);
  public
    property DocumentHandle: HPDF_Doc read FDocumentHandle;

    property Title: string read GetTitle write SetTitle;
    property Subject: string read GetSubject write SetSubject;
    property Keywords: string read GetKeywords write SetKeywords;
    property Author: string read GetAuthor write SetAuthor;
    property Creator: string read GetCreator write SetCreator;
    property Producer: string read GetProducer write SetProducer;
    procedure SetCreationDate(ACreationDate: TDateTime);
    procedure SetModificationDate(AModificationDate: TDateTime);

    //
    procedure LimitVersion(APDFVersion: THPDF_PdfVer);

    // Set the mode of compression
    function SetCompressionMode(ACompressionMode: Cardinal): Boolean;
    // Sets the pasword for the document
    function SetPassword(AOwnerPassword, AUserPassword: string): Boolean;
    // Set the flags of the permission for the document
    function SetPermission(APermission: Cardinal): Boolean;
    // Set the type of encryption
    function SetEncryptionMode(AMode: THPDF_EncryptMode; AKeyLength: Integer): Boolean;
    //
    property Pages: THaruPages read FPages write FPages;
    //
    property Fonts: THaruFonts read FFonts write FFonts;
    //
    property Encoder: THaruEncoders read FEncoders write FEncoders;
    //
    property Outlines: THaruOutlines read FOutlines write FOutlines;

    // Sets how the page should be displayed.
    property PageLayout: THPDF_PageLayout read GetPageLayout write SetPageLayout;
    // Sets how the document should be displayed
    property PageMode: THPDF_PageMode read GetPageMode write SetPageMode;
    //
    property ViewerPreference: Cardinal read GetViewerPreference write SetViewerPreference;
    // Set the first page appears when a document is opened
    function SetOpenAction(AOpenAction: THaruDestination): Boolean;
    // Adds a page labeling range for the document
    procedure AddPageLabel(APageNum: Integer; AFirstPage: Integer; AStyle: THPDF_PageNumStyle;
      APrefix: string = '');

    // Creates the object of graphics state
    function CreateExtGState: HPDF_ExtGState;
    // Defined the transparency for stroking
    function ExtGStateSetAlphaStroke(AExtGState: HPDF_ExtGState; AValue: Single): Boolean;
    // Defined the transparency for filling
    function ExtGStateSetAlphaFill(AExtGState: HPDF_ExtGState; AValue: Single): Boolean;
    // Defined the method of blending
    function ExtGStateSetBlendMode(AExtGState: HPDF_ExtGState; AMode: THPDF_BlendMode): Boolean;

    // Loads PNG image from a buffer
    function LoadPngImageFromMem(const ABuffer: Pointer; ASize: Integer): THaruImage;
    // Loads an external PNG image file
    function LoadPngImageFromFile(AFileName: string): THaruImage;
    // Loads an external PNG image file.
    // It does not load all the data immediately (only size and color properties are loaded)
    function LoadPngImageFromFile2(AFileName: string): THaruImage;
    //
    function PngImageToHaruImage(AImage: {$IFNDEF FPC}TPngImage{$ELSE}TPortableNetworkGraphic{$ENDIF}): THaruImage;
    // Loads an external JPEG image file
    function LoadJpegImageFromFile(AFileName: string): THaruImage;
    // Loads JPEG image from a buffer
    function LoadJpegImageFromMem(const ABuffer: Pointer; ASize: Integer): THaruImage;
    //
    function JpgImageToHaruImage(AImage: TJPEGImage): THaruImage;
    // Loads an 1bit image which has "raw" image format
    function LoadRaw1BitImageFromMem(const ABuffer: Pointer; AWidth, AHeight: Integer;
      ALineWidth: Integer; ABlackIs1: Boolean; ATopIsFirst: Boolean): THaruImage;
    // Loads an image which has "raw" image format
    function LoadRawImageFromFile(AFileName: string; AWidth, AHeight: Integer;
      AColorSpace: THPDF_ColorSpace): THaruImage;
    // Loads an image which has "raw" image format from buffer
    function LoadRawImageFromMem(const ABuffer: Pointer; AWidth, AHeight: Integer;
      AColorSpace: THPDF_ColorSpace; ABitsPerComponent: Integer; ASize: Integer;
      ABlackWhite: Boolean): THaruImage;
    // Loads an external 3D file (PRC/U3D)
    function Load3DFromFile(AFileName: string): THaruU3D;
    // Loads PRC/U3D from a buffer
    function Load3DFromMem(const ABuffer: Pointer; ASize: Integer): THaruU3D;

    //
    function LoadIccProfileFromFile(AFileName: String; ANumComponent: Integer): HPDF_OutputIntent;
    //
    function PDFA_AppendOutputIntents(AICCName: String; AICCProfile: HPDF_Dict): Boolean;
    //
    function SetPDFAConformance(APDFType: THPDF_PDFA_TYPE): Boolean;

    // Attach a file to the document
    function AttachFile(AFileName: string): Boolean;

    // Creates a new document. Current document is freed
    function NewDocument: Boolean;
    // Saves the current document to a file
    function SaveToFile(const AFileName: string): Boolean;
    // Saves the current document to a stream
    function SaveToStream(AStream: TStream): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation
uses
  harupdf.utils,
  hpdf_error;

{ EHaruPDFException }

constructor EHaruPDFException.Create(AErrorCode, ADetailCode: HPDF_STATUS);
begin
  inherited Create(Format('%s (error_no=%04X, detail_no=%d)',
    [HaruErrorToString(AErrorCode), AErrorCode, ADetailCode]));

  FErrorCode := AErrorCode;
  FDetailCode := ADetailCode;
end;

{ THaruDocument }

procedure haru_error_handler(error_no: HPDF_STATUS; detail_no: HPDF_STATUS; user_data: Pointer);
{$IFDEF Linux} cdecl{$ELSE} stdcall{$ENDIF};
begin
  HPDF_ResetError(THaruDocument(user_data).DocumentHandle);
  raise EHaruPDFException.Create(error_no, detail_no);
end;

constructor THaruDocument.Create;
begin
  //if ARaiseExceptions then
  FDocumentHandle := HPDF_New({$IFDEF FPC}@{$ENDIF}haru_error_handler, Self);
  //else
  //  FDocument := HPDF_New(nil, nil);
  FPages := THaruPages.Create(Self);
  FFonts := THaruFonts.Create(Self);
  FEncoders := THaruEncoders.Create(Self);
  FOutlines := THaruOutlines.Create(Self);
  FImages := THaruImagesList.Create;
end;

destructor THaruDocument.Destroy;
begin
  FPages.Free;
  FFonts.Free;
  FEncoders.Free;
  FOutlines.Free;
  FImages.Free;
  if Assigned(FDocumentHandle) then
    HPDF_Free(FDocumentHandle);
  inherited Destroy;
end;

function THaruDocument.GetTitle: string;
begin
  Result := PUTF8CharToString(HPDF_GetInfoAttr(FDocumentHandle, HPDF_INFO_TITLE));
end;

procedure THaruDocument.SetTitle(ATitle: string);
var
  pTitle: PUTF8Char;
begin
  pTitle := StringToPUTF8Char(ATitle);
  HPDF_SetInfoAttr(FDocumentHandle, HPDF_INFO_TITLE, pTitle);
end;

function THaruDocument.GetSubject: string;
begin
  Result := PUTF8CharToString(HPDF_GetInfoAttr(FDocumentHandle, HPDF_INFO_SUBJECT));
end;

procedure THaruDocument.SetSubject(ASubject: string);
var
  pSubject: PUTF8Char;
begin
  pSubject := StringToPUTF8Char(ASubject);
  HPDF_SetInfoAttr(FDocumentHandle, HPDF_INFO_SUBJECT, pSubject);
end;

function THaruDocument.GetKeywords: string;
begin
  Result := PUTF8CharToString(HPDF_GetInfoAttr(FDocumentHandle, HPDF_INFO_KEYWORDS));
end;

procedure THaruDocument.SetKeywords(AKeywords: string);
var
  pKeywords: PUTF8Char;
begin
  pKeywords := StringToPUTF8Char(AKeywords);
  HPDF_SetInfoAttr(FDocumentHandle, HPDF_INFO_KEYWORDS, pKeywords);
end;

function THaruDocument.GetAuthor: string;
begin
  Result := PUTF8CharToString(HPDF_GetInfoAttr(FDocumentHandle, HPDF_INFO_AUTHOR));
end;

procedure THaruDocument.SetAuthor(AAuthor: string);
var
  pAuthor: PUTF8Char;
begin
  pAuthor := StringToPUTF8Char(AAuthor);
  HPDF_SetInfoAttr(FDocumentHandle, HPDF_INFO_AUTHOR, pAuthor);
end;

function THaruDocument.GetCreator: string;
begin
  Result := PUTF8CharToString(HPDF_GetInfoAttr(FDocumentHandle, HPDF_INFO_CREATOR));
end;

procedure THaruDocument.SetCreator(ACreator: string);
var
  pCreator: PUTF8Char;
begin
  pCreator := StringToPUTF8Char(ACreator);
  HPDF_SetInfoAttr(FDocumentHandle, HPDF_INFO_CREATOR, pCreator);
end;

function THaruDocument.GetProducer: string;
begin
  Result := PUTF8CharToString(HPDF_GetInfoAttr(FDocumentHandle, HPDF_INFO_PRODUCER));
end;

procedure THaruDocument.SetProducer(AProducer: string);
var
  pProducer: PUTF8Char;
begin
  pProducer := StringToPUTF8Char(AProducer);
  HPDF_SetInfoAttr(FDocumentHandle, HPDF_INFO_PRODUCER, pProducer);
end;

procedure THaruDocument.SetCreationDate(ACreationDate: TDateTime);
begin
  HPDF_SetInfoDateAttr(FDocumentHandle, HPDF_INFO_CREATION_DATE, DateTimeToHPDFDate(ACreationDate));
end;

procedure THaruDocument.SetModificationDate(AModificationDate: TDateTime);
begin
  HPDF_SetInfoDateAttr(FDocumentHandle, HPDF_INFO_MOD_DATE, DateTimeToHPDFDate(AModificationDate));
end;

procedure THaruDocument.LimitVersion(APDFVersion: THPDF_PdfVer);
begin
  HPDF_LimitVersion(FDocumentHandle, APDFVersion);
end;

function THaruDocument.SetCompressionMode(ACompressionMode: Cardinal): Boolean;
begin
  Result := (HPDF_SetCompressionMode(FDocumentHandle, ACompressionMode) = HPDF_OK);
end;

function THaruDocument.SetPassword(AOwnerPassword, AUserPassword: string): Boolean;
var
  pOwnerPassword: PUTF8Char;
  pUserPassword: PUTF8Char;
begin
  pOwnerPassword := StringToPUTF8Char(AOwnerPassword);
  pUserPassword := StringToPUTF8Char(AUserPassword);
  Result := (HPDF_SetPassword(FDocumentHandle, pOwnerPassword, pUserPassword) = HPDF_OK);
end;

function THaruDocument.SetPermission(APermission: Cardinal): Boolean;
begin
  Result := (HPDF_SetPermission(FDocumentHandle, APermission) = HPDF_OK);
end;

function THaruDocument.SetEncryptionMode(AMode: THPDF_EncryptMode; AKeyLength: Integer): Boolean;
begin
  Result := (HPDF_SetEncryptionMode(FDocumentHandle, AMode, AKeyLength) = HPDF_OK);
end;

function THaruDocument.GetPageLayout: THPDF_PageLayout;
begin
  Result := HPDF_GetPageLayout(FDocumentHandle);
end;

procedure THaruDocument.SetPageLayout(APageLayout: THPDF_PageLayout);
begin
  HPDF_SetPageLayout(FDocumentHandle, APageLayout);
end;

function THaruDocument.GetPageMode: THPDF_PageMode;
begin
  Result := HPDF_GetPageMode(FDocumentHandle);
end;

procedure THaruDocument.SetPageMode(APageMode: THPDF_PageMode);
begin
  HPDF_SetPageMode(FDocumentHandle, APageMode);
end;

function THaruDocument.GetViewerPreference: Cardinal;
begin
  Result := HPDF_GetViewerPreference(FDocumentHandle);
end;

procedure THaruDocument.SetViewerPreference(AViewerPreference: Cardinal);
begin
  HPDF_SetViewerPreference(FDocumentHandle, AViewerPreference);
end;

function THaruDocument.SetOpenAction(AOpenAction: THaruDestination): Boolean;
begin
  Result := (HPDF_SetOpenAction(FDocumentHandle, AOpenAction.DestinationHandle) = HPDF_OK);
end;

procedure THaruDocument.AddPageLabel(APageNum: Integer; AFirstPage: Integer;
  AStyle: THPDF_PageNumStyle; APrefix: string = '');
var
  pPrefix: PUTF8Char;
begin
  pPrefix := StringToPUTF8Char(APrefix);
  HPDF_AddPageLabel(FDocumentHandle, APageNum, AStyle, AFirstPage, pPrefix);
end;

function THaruDocument.CreateExtGState: HPDF_ExtGState;
begin
  Result := HPDF_CreateExtGState(FDocumentHandle);
end;

function THaruDocument.ExtGStateSetAlphaStroke(AExtGState: HPDF_ExtGState; AValue: Single):
  Boolean;
begin
  Result := (HPDF_ExtGState_SetAlphaStroke(AExtGState, AValue) = HPDF_OK);
end;

function THaruDocument.ExtGStateSetAlphaFill(AExtGState: HPDF_ExtGState; AValue: Single):
  Boolean;
begin
  Result := (HPDF_ExtGState_SetAlphaFill(AExtGState, AValue) = HPDF_OK);
end;

function THaruDocument.ExtGStateSetBlendMode(AExtGState: HPDF_ExtGState; AMode: THPDF_BlendMode):
  Boolean;
begin
  Result := (HPDF_ExtGState_SetBlendMode(AExtGState, AMode) = HPDF_OK);
end;

function THaruDocument.LoadPngImageFromMem(const ABuffer: Pointer; ASize: Integer):
  THaruImage;
var
  hImage: HPDF_Image;
begin
  Result := THaruImage.Create;
  try
    hImage := HPDF_LoadPngImageFromMem(FDocumentHandle, ABuffer, ASize);
    Result.ImageHandle := hImage;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.LoadPngImageFromFile(AFileName: string): THaruImage;
var
  hImage: HPDF_Image;
  pFileName: PUTF8Char;
begin
  Result := THaruImage.Create;
  try
    pFileName := StringToPUTF8Char(AFileName);
    hImage := HPDF_LoadPngImageFromFile(FDocumentHandle, pFileName);
    Result.ImageHandle := hImage;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.LoadPngImageFromFile2(AFileName: string): THaruImage;
var
  hImage: HPDF_Image;
  pFileName: PUTF8Char;
begin
  Result := THaruImage.Create;
  try
    pFileName := StringToPUTF8Char(AFileName);
    hImage := HPDF_LoadPngImageFromFile2(FDocumentHandle, pFileName);
    Result.ImageHandle := hImage;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.PngImageToHaruImage(AImage: {$IFNDEF FPC}TPngImage{$ELSE}TPortableNetworkGraphic{$ENDIF}): THaruImage;
var
  hImage: HPDF_Image;
  ms: TMemoryStream;
begin
  Result := THaruImage.Create;
  try
    ms := TMemoryStream.Create;
    try
      AImage.SaveToStream(ms);
      hImage := HPDF_LoadPngImageFromMem(FDocumentHandle, ms.Memory, ms.Size);
      Result.ImageHandle := hImage;
    finally
      ms.Free;
    end;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.LoadJpegImageFromFile(AFileName: string): THaruImage;
var
  hImage: HPDF_Image;
  pFileName: PUTF8Char;
begin
  Result := THaruImage.Create;
  try
    pFileName := StringToPUTF8Char(AFileName);
    hImage := HPDF_LoadJpegImageFromFile(FDocumentHandle, pFileName);
    Result.ImageHandle := hImage;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.LoadJpegImageFromMem(const ABuffer: Pointer; ASize: Integer):
  THaruImage;
var
  hImage: HPDF_Image;
begin
  Result := THaruImage.Create;
  try
    hImage := HPDF_LoadJpegImageFromMem(FDocumentHandle, ABuffer, ASize);
    Result.ImageHandle := hImage;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.JpgImageToHaruImage(AImage: TJPEGImage): THaruImage;
var
  hImage: HPDF_Image;
  ms: TMemoryStream;
begin
  Result := THaruImage.Create;
  try
    ms := TMemoryStream.Create;
    try
      AImage.SaveToStream(ms);
      hImage := HPDF_LoadJpegImageFromMem(FDocumentHandle, ms.Memory, ms.Size);
      Result.ImageHandle := hImage;
    finally
      ms.Free;
    end;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.LoadRaw1BitImageFromMem(const ABuffer: Pointer;
  AWidth, AHeight: Integer; ALineWidth: Integer; ABlackIs1: Boolean; ATopIsFirst: Boolean):
  THaruImage;
var
  hImage: HPDF_Image;
begin
  Result := THaruImage.Create;
  try
    hImage := HPDF_Image_LoadRaw1BitImageFromMem(FDocumentHandle, ABuffer, AWidth, AHeight,
      ALineWidth,
      BooleanToHaruBool(ABlackIs1), BooleanToHaruBool(ATopIsFirst));
    Result.ImageHandle := hImage;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.LoadRawImageFromFile(AFileName: string;
  AWidth, AHeight: Integer; AColorSpace: THPDF_ColorSpace): THaruImage;
var
  hImage: HPDF_Image;
  pFileName: PUTF8Char;
begin
  Result := THaruImage.Create;
  try
    pFileName := StringToPUTF8Char(AFileName);
    hImage := HPDF_LoadRawImageFromFile(FDocumentHandle, pFileName, AWidth, AHeight, AColorSpace);
    Result.ImageHandle := hImage;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.LoadRawImageFromMem(const ABuffer: Pointer; AWidth, AHeight: Integer;
  AColorSpace: THPDF_ColorSpace; ABitsPerComponent: Integer; ASize: Integer; ABlackWhite: Boolean)
  : THaruImage;
var
  hImage: HPDF_Image;
begin
  Result := THaruImage.Create;
  try
    hImage := HPDF_LoadRawImageFromMem(FDocumentHandle, ABuffer, AWidth, AHeight, AColorSpace,
      ABitsPerComponent, ASize, BooleanToHaruBool(ABlackWhite));
    Result.ImageHandle := hImage;
  finally
    FImages.Add(Result);
  end;
end;

function THaruDocument.Load3DFromFile(AFileName: string): THaruU3D;
var
  hImage: HPDF_U3D;
  pFileName: PUTF8Char;
begin
  pFileName := StringToPUTF8Char(AFileName);
  hImage := HPDF_LoadU3DFromFile(FDocumentHandle, pFileName);
  Result := THaruU3D.Create(hImage);
end;

function THaruDocument.Load3DFromMem(const ABuffer: Pointer; ASize: Integer): THaruU3D;
var
  hImage: HPDF_U3D;
begin
  hImage := HPDF_LoadU3DFromMem(FDocumentHandle, ABuffer, ASize);
  Result := THaruU3D.Create(hImage);
end;

function THaruDocument.LoadIccProfileFromFile(AFileName: String; ANumComponent: Integer): HPDF_OutputIntent;
var
  pFileName: PUTF8Char;
begin
  pFileName := StringToPUTF8Char(AFileName);
  Result := HPDF_LoadIccProfileFromFile(FDocumentHandle, pFileName, ANumComponent);
end;

function THaruDocument.PDFA_AppendOutputIntents(AICCName: String; AICCProfile: HPDF_Dict): Boolean;
var
  pICCName: PUTF8Char;
begin
  pICCName := StringToPUTF8Char(AICCName);
  Result := (HPDF_PDFA_AppendOutputIntents(FDocumentHandle, pICCName, AICCProfile) = HPDF_OK);
end;

function THaruDocument.SetPDFAConformance(APDFType: THPDF_PDFA_TYPE): Boolean;
begin
  Result := (HPDF_PDFA_SetPDFAConformance(FDocumentHandle, APDFType) = HPDF_OK);
end;

function THaruDocument.AttachFile(AFileName: string): Boolean;
var
  pFileName: PUTF8Char;
begin
  pFileName := StringToPUTF8Char(AFileName);
  Result := (HPDF_AttachFile(FDocumentHandle, pFileName) = HPDF_OK);
end;

function THaruDocument.NewDocument: Boolean;
begin
  // to-do: clear fonts, pages etc.
  Result := (HPDF_NewDoc(FDocumentHandle) = HPDF_OK);
  if Result then
  begin
    FPages.Free;
    FPages := THaruPages.Create(Self);
  end;
end;

function THaruDocument.SaveToFile(const AFileName: string): Boolean;
var
  pFileName: PUTF8Char;
begin
  pFileName := StringToPUTF8Char(AFileName);
  Result := HPDF_SaveToFile(FDocumentHandle, pFileName) = HPDF_OK;
end;

function THaruDocument.SaveToStream(AStream: TStream): Boolean;
var
  buf: array[0..4096-1] of Byte;
  siz: Cardinal;
  ret: HPDF_STATUS;
begin
  Result := False;

  if (HPDF_SaveToStream(FDocumentHandle) = HPDF_OK) then
  begin
    AStream.Size := 0;
    HPDF_ResetStream(FDocumentHandle);

    while True do
    begin
      siz := 4096;
      ret := HPDF_ReadFromStream(FDocumentHandle, @buf, @siz);
      if (siz = 0) then Break;

      AStream.WriteBuffer(buf, siz);

      if (ret = HPDF_STREAM_EOF) then Break;
    end;

    Result := (AStream.Size = HPDF_GetStreamSize(FDocumentHandle));
  end;
end;

end.

