unit harupdf.encoder;

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
  System.DateUtils,
  System.Generics.Collections,
{$ELSE}
  Classes,
  SysUtils,
  DateUtils,
  fgl,
{$ENDIF}
  hpdf,
  hpdf_consts,
  hpdf_types;

type
  THaruEncoder = class(TObject)
  private
    FEncoderHandle: HPDF_Encoder;
  public
    property EncoderHandle: HPDF_Encoder read FEncoderHandle;

    // Gets the type of an encoding object
    function GetType: THPDF_EncoderType;
    // Returns the type of byte in the text at position index
    function GetByteType(AText: String; AIndex: Integer; ATextPtr: Pointer = nil): THPDF_ByteType;
    // Converts a specified character code to unicode
    function GetUnicode(ACode: Word): HPDF_UNICODE;
    //
    function GetUcs4(AText: String; ATextPtr: Pointer = nil): HPDF_UCS4;
    // Returns the writing mode for the encoding object
    function GetWritingMode: THPDF_WritingMode;

    class function GetEncoderHandle(AEncoder: THaruEncoder): HPDF_Encoder;
    constructor Create(AEncoder: HPDF_Encoder);
  end;
  THaruEncodersList = {$IFNDEF FPC}TObjectList{$ELSE}specialize TFPGObjectList{$ENDIF}<THaruEncoder>;

type
  THaruEncoders = class(TObject)
  protected
    FOwner: TObject;
    FEncoders: THaruEncodersList;
    function GetEncoderByHandle(AEncoderHandle: HPDF_Encoder): THaruEncoder;
  public
    // Enables Japanese encodings
    function UseJPEncodings: Boolean;
    // Enables Korean encodings
    function UseKREncodings: Boolean;
    // Enables simplified Chinese encodings
    function UseCNSEncodings: Boolean;
    // Enables traditional Chinese encodings
    function UseCNTEncodings: Boolean;
    // Enables UTF-8 encoding
    function UseUTFEncodings: Boolean;

    // Gets the encoder object by specified encoding name
    function GetEncoder(AEncodingName: string): THaruEncoder;
    // Gets the current encoder of the document object
    function GetCurrentEncoder: THaruEncoder;
    // Sets the current encoder for the document
    function SetCurrentEncoder(AEncodingName: string): Boolean;
    //
    function GetUTFEncoder(ACharEnc: THPDF_CharEnc): THaruEncoder;

    constructor Create(AOwner: TObject);
    destructor Destroy; override;
  end;

implementation
uses
  harupdf.document,
  harupdf.utils;

{ THaruEncoder }

constructor THaruEncoder.Create(AEncoder: HPDF_Encoder);
begin
  FEncoderHandle := AEncoder;
end;

function THaruEncoder.GetType: THPDF_EncoderType;
begin
  Result := HPDF_Encoder_GetType(FEncoderHandle);
end;

function THaruEncoder.GetByteType(AText: String; AIndex: Integer; ATextPtr: Pointer): THPDF_ByteType;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Encoder_GetByteType(FEncoderHandle, pText, AIndex);
end;

function THaruEncoder.GetUnicode(ACode: Word): HPDF_UNICODE;
begin
  Result := HPDF_Encoder_GetUnicode(FEncoderHandle, ACode);
end;

function THaruEncoder.GetUcs4(AText: String; ATextPtr: Pointer): HPDF_UCS4;
var
  pText: PUTF8Char;
begin
  pText := StringToPUTF8Char(AText, ATextPtr);
  Result := HPDF_Encoder_GetUcs4(FEncoderHandle, pText, nil);
end;

function THaruEncoder.GetWritingMode: THPDF_WritingMode;
begin
  Result := HPDF_Encoder_GetWritingMode(FEncoderHandle);
end;

class function THaruEncoder.GetEncoderHandle(AEncoder: THaruEncoder): HPDF_Encoder;
begin
  if Assigned(AEncoder) then
    Result := AEncoder.EncoderHandle
  else
    Result := nil;
end;

{ THaruEncoders }

constructor THaruEncoders.Create(AOwner: TObject);
begin
  FOwner := AOwner;
  FEncoders := THaruEncodersList.Create;
end;

destructor THaruEncoders.Destroy;
begin
  FEncoders.Free;
  inherited;
end;

function THaruEncoders.GetEncoderByHandle(AEncoderHandle: HPDF_Encoder): THaruEncoder;
var
  encoder: THaruEncoder;
begin
  Result := nil;
  if not Assigned(AEncoderHandle) then
    Exit;
  for encoder in FEncoders do
  begin
    if (encoder.EncoderHandle = AEncoderHandle) then
    begin
      Result := encoder;
      Exit;
    end;
  end;
  // Create encoder if not found in the list
  Result := THaruEncoder.Create(AEncoderHandle);
  FEncoders.Add(Result);
end;

function THaruEncoders.UseJPEncodings: Boolean;
begin
  Result := (HPDF_UseJPEncodings(THaruDocument(FOwner).DocumentHandle) = HPDF_OK);
end;

function THaruEncoders.UseKREncodings: Boolean;
begin
  Result := (HPDF_UseKREncodings(THaruDocument(FOwner).DocumentHandle) = HPDF_OK);
end;

function THaruEncoders.UseCNSEncodings: Boolean;
begin
  Result := (HPDF_UseCNSEncodings(THaruDocument(FOwner).DocumentHandle) = HPDF_OK);
end;

function THaruEncoders.UseCNTEncodings: Boolean;
begin
  Result := (HPDF_UseCNTEncodings(THaruDocument(FOwner).DocumentHandle) = HPDF_OK);
end;

function THaruEncoders.UseUTFEncodings: Boolean;
begin
  Result := (HPDF_UseUTFEncodings(THaruDocument(FOwner).DocumentHandle) = HPDF_OK);
end;

function THaruEncoders.GetEncoder(AEncodingName: string): THaruEncoder;
var
  hEncoder: HPDF_Encoder;
  pEncodingName: PUTF8Char;
begin
  pEncodingName := StringToPUTF8Char(AEncodingName);
  hEncoder := HPDF_GetEncoder(THaruDocument(FOwner).DocumentHandle, pEncodingName);
  Result := GetEncoderByHandle(hEncoder);
end;

function THaruEncoders.GetCurrentEncoder: THaruEncoder;
var
  hEncoder: HPDF_Encoder;
begin
  hEncoder := HPDF_GetCurrentEncoder(THaruDocument(FOwner).DocumentHandle);
  Result := GetEncoderByHandle(hEncoder);
end;

function THaruEncoders.SetCurrentEncoder(AEncodingName: string): Boolean;
var
  pEncodingName: PUTF8Char;
begin
  pEncodingName := StringToPUTF8Char(AEncodingName);
  Result := (HPDF_SetCurrentEncoder(THaruDocument(FOwner).DocumentHandle, pEncodingName) = HPDF_OK);
end;

function THaruEncoders.GetUTFEncoder(ACharEnc: THPDF_CharEnc): THaruEncoder;
var
  hEncoder: HPDF_Encoder;
begin
  hEncoder := HPDF_GetUTFEncoder(THaruDocument(FOwner).DocumentHandle, ACharEnc);
  Result := GetEncoderByHandle(hEncoder);
end;

end.

