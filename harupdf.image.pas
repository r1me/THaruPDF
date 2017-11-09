unit harupdf.image;

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
  THaruImage = class(TObject)
  private
    FImageHandle: HPDF_Image;

    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetSize: TRectF;
    function GetColorSpace: string;
    function GetBitsPerComponent: Integer;
  public
    property ImageHandle: HPDF_Image read FImageHandle write FImageHandle;

    // Gets the width of the image
    property Width: Integer read GetWidth;
    // Gets the height of the image
    property Height: Integer read GetHeight;
    // Gets the size of the image of an image object
    property Size: TRectF read GetSize;
    // Gets the name of the image's color space
    property ColorSpace: string read GetColorSpace;
    // Gets the number of bits used to describe each color component
    property BitsPerComponent: Integer read GetBitsPerComponent;

    // Sets the soft mask image
    function AddSMask(ASMask: THaruImage): Boolean;
    // Sets the mask image
    function SetMaskImage(AMaskImage: THaruImage): Boolean;
    // Sets the transparent color of the image by the RGB range values
    function SetColorMask(ARmin, ARmax: Byte; AGmin, AGmax: Byte; ABmin, ABmax: Byte): Boolean;

    class function GetImageHandle(AImage: THaruImage): HPDF_Image;
  end;
  THaruImagesList = {$IFNDEF FPC}TObjectList{$ELSE}specialize TFPGObjectList{$ENDIF}<THaruImage>;

implementation
uses
  harupdf.utils;

{ THaruImage }

function THaruImage.GetWidth: Integer;
begin
  Result := HPDF_Image_GetWidth(FImageHandle);
end;

function THaruImage.GetHeight: Integer;
begin
  Result := HPDF_Image_GetHeight(FImageHandle);
end;

function THaruImage.GetSize: TRectF;
var
  fsize: THPDF_Point;
begin
  HPDF_Image_GetSize2(FImageHandle, @fsize);
  Result.Width := fsize.x;
  Result.Height := fsize.y;
end;

function THaruImage.GetColorSpace: string;
begin
  Result := PUTF8CharToString(HPDF_Image_GetColorSpace(FImageHandle));
end;

function THaruImage.GetBitsPerComponent: Integer;
begin
  Result := HPDF_Image_GetBitsPerComponent(FImageHandle);
end;

function THaruImage.AddSMask(ASMask: THaruImage): Boolean;
begin
  Result := (HPDF_Image_AddSMask(FImageHandle, ASMask.ImageHandle) = HPDF_OK);
end;

function THaruImage.SetMaskImage(AMaskImage: THaruImage): Boolean;
begin
  Result := (HPDF_Image_SetMaskImage(FImageHandle, AMaskImage.ImageHandle) = HPDF_OK);
end;

function THaruImage.SetColorMask(ARmin, ARmax: Byte; AGmin, AGmax: Byte; ABmin, ABmax: Byte):
  Boolean;
begin
  Result := (HPDF_Image_SetColorMask(FImageHandle, ARmin, ARmax, AGmin, AGmax, ABmin, ABmax) =
    HPDF_OK);
end;

class function THaruImage.GetImageHandle(AImage: THaruImage): HPDF_Image;
begin
  if Assigned(AImage) then
    Result := AImage.ImageHandle
  else
    Result := nil;
end;

end.

