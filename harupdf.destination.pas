unit harupdf.destination;

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
  hpdf_consts;

type
  THaruDestination = class(TObject)
  private
    FDestinationHandle: HPDF_Destination;
  public
    property DestinationHandle: HPDF_Destination read FDestinationHandle;

    // Defines the appearance of a page with three parameters which are left, top and zoom
    function SetXYZ(ALeft, ATop, AZoom: Single): Boolean;
    // Sets the appearance of the page to displaying entire page within the window
    function SetFit: Boolean;
    // Defines the appearance of a page to magnifying to fit the width of the page within the window
    // and setting the top position of the page to the value of the "top" parameter
    function SetFitH(ATop: Single): Boolean;
    // Defines the appearance of a page to magnifying to fit the height of the page within the window
    // and setting the left position of the page to the value of the "left" parameter
    function SetFitV(ALeft: Single): Boolean;
    // Defines the appearance of a page to magnifying the page to fit a rectangle specified parameter
    function SetFitR(ARect: TRectF): Boolean;
    // Sets the appearance of the page to magnifying to fit the bounding box of the page within the window
    function SetFitB: Boolean;
    // Defines the appearance of a page to magnifying to fit the width of the bounding box of the page
    // within the window and setting the top position of the page to the value of the "top" parameter
    function SetFitBH(ATop: Single): Boolean;
    // Defines the appearance of a page to magnifying to fit the height of the bounding box of the page
    // within the window and setting the top position of the page to the value of the "left" parameter
    function SetFitBV(ALeft: Single): Boolean;

    constructor Create(APage: HPDF_Page);
  end;
  THaruDestinationsList = {$IFNDEF FPC}TObjectList{$ELSE}specialize TFPGObjectList{$ENDIF}<THaruDestination>;

type
  THaruDestinations = class(TObject)
  protected
    FOwnerPage: TObject;
    FDestinations: THaruDestinationsList;
  public
    property Items: THaruDestinationsList read FDestinations;

    //
    function Add: THaruDestination;

    constructor Create(APage: TObject);
    destructor Destroy; override;
  end;

implementation
uses
  harupdf.page;

{ THaruDestination }

constructor THaruDestination.Create(APage: HPDF_Page);
begin
  FDestinationHandle := HPDF_Page_CreateDestination(APage);
end;

function THaruDestination.SetXYZ(ALeft, ATop, AZoom: Single): Boolean;
begin
  Result := (HPDF_Destination_SetXYZ(FDestinationHandle, ALeft, ATop, AZoom) = HPDF_OK);
end;

function THaruDestination.SetFit: Boolean;
begin
  Result := (HPDF_Destination_SetFit(FDestinationHandle) = HPDF_OK);
end;

function THaruDestination.SetFitH(ATop: Single): Boolean;
begin
  Result := (HPDF_Destination_SetFitH(FDestinationHandle, ATop) = HPDF_OK);
end;

function THaruDestination.SetFitV(ALeft: Single): Boolean;
begin
  Result := (HPDF_Destination_SetFitV(FDestinationHandle, ALeft) = HPDF_OK);
end;

function THaruDestination.SetFitR(ARect: TRectF): Boolean;
begin
  Result := (HPDF_Destination_SetFitR(FDestinationHandle, ARect.Left, ARect.Bottom, ARect.Right,
    ARect.Top) = HPDF_OK);
end;

function THaruDestination.SetFitB: Boolean;
begin
  Result := (HPDF_Destination_SetFitB(FDestinationHandle) = HPDF_OK);
end;

function THaruDestination.SetFitBH(ATop: Single): Boolean;
begin
  Result := (HPDF_Destination_SetFitBH(FDestinationHandle, ATop) = HPDF_OK);
end;

function THaruDestination.SetFitBV(ALeft: Single): Boolean;
begin
  Result := (HPDF_Destination_SetFitBV(FDestinationHandle, ALeft) = HPDF_OK);
end;

{ THaruDestinations }

constructor THaruDestinations.Create(APage: TObject);
begin
  FOwnerPage := APage;
  FDestinations := THaruDestinationsList.Create;
end;

destructor THaruDestinations.Destroy;
begin
  FDestinations.Free;
  inherited;
end;

function THaruDestinations.Add: THaruDestination;
begin
  Result := THaruDestination.Create(THaruPage(FOwnerPage).PageHandle);
  FDestinations.Add(Result);
end;

end.

