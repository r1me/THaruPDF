unit harupdf.outline;

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
  harupdf.destination,
  harupdf.encoder;

type
  THaruOutline = class(TObject)
  private
    FOutlineHandle: HPDF_Outline;
  public
    property OutlineHandle: HPDF_Outline read FOutlineHandle;

    //
    procedure SetOpened(AOpened: Boolean);
    //
    function SetDestination(ADestination: THaruDestination): Boolean;

    class function GetOutlineHandle(AOutline: THaruOutline): HPDF_Outline;
    constructor Create(AOwner: TObject; ATitle: string; AParent: THaruOutline;
      AEncoder: THaruEncoder; ATitlePtr: Pointer = nil);
  end;
  THaruOutlinesList = {$IFNDEF FPC}TObjectList{$ELSE}specialize TFPGObjectList{$ENDIF}<THaruOutline>;

type
  THaruOutlines = class(TObject)
  protected
    FOwner: TObject;
    FOutlines: THaruOutlinesList;
  public
    property Items: THaruOutlinesList read FOutlines;

    //
    function Add(ATitle: string; AParent: THaruOutline; AEncoder: THaruEncoder = nil;
      ATitlePtr: Pointer = nil): THaruOutline;

    constructor Create(AOwner: TObject);
    destructor Destroy; override;
  end;

implementation
uses
  harupdf.document,
  harupdf.utils;

{ THaruOutline }

constructor THaruOutline.Create(AOwner: TObject; ATitle: string; AParent: THaruOutline;
  AEncoder: THaruEncoder; ATitlePtr: Pointer);
var
  pTitle: PUTF8Char;
begin
  pTitle := StringToPUTF8Char(ATitle, ATitlePtr);
  FOutlineHandle := HPDF_CreateOutline(THaruDocument(AOwner).DocumentHandle,
    THaruOutline.GetOutlineHandle(AParent), pTitle, THaruEncoder.GetEncoderHandle(AEncoder));
end;

procedure THaruOutline.SetOpened(AOpened: Boolean);
begin
  HPDF_Outline_SetOpened(FOutlineHandle, BooleanToHaruBool(AOpened));
end;

function THaruOutline.SetDestination(ADestination: THaruDestination): Boolean;
begin
  Result := (HPDF_Outline_SetDestination(FOutlineHandle, ADestination.DestinationHandle) = HPDF_OK);
end;

class function THaruOutline.GetOutlineHandle(AOutline: THaruOutline): HPDF_Outline;
begin
  if Assigned(AOutline) then
    Result := AOutline.OutlineHandle
  else
    Result := nil;
end;

{ THaruOutlines }

constructor THaruOutlines.Create(AOwner: TObject);
begin
  FOwner := AOwner;
  FOutlines := THaruOutlinesList.Create;
end;

destructor THaruOutlines.Destroy;
begin
  FOutlines.Free;
  inherited;
end;

function THaruOutlines.Add(ATitle: String; AParent: THaruOutline; AEncoder: THaruEncoder;
  ATitlePtr: Pointer): THaruOutline;
begin
  Result := THaruOutline.Create(FOwner, ATitle, AParent, AEncoder, ATitlePtr);
end;

end.

