unit harupdf.javascript;

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
{$ELSE}
  Classes,
{$ENDIF}
  hpdf;

type
  THaruJavascript = class(TObject)
  public
    class function CreateFromCode(ADocument: TObject; ACode: String): HPDF_Javascript;
    class function CreateFromFile(ADocument: TObject; AFileName: String): HPDF_Javascript;
  end;

implementation
uses
  harupdf.utils,
  harupdf.document;

{ THaruJavascript }

class function THaruJavascript.CreateFromCode(ADocument: TObject; ACode: String): HPDF_Javascript;
var
  pCode: PUTF8Char;
begin
  pCode := StringToPUTF8Char(ACode);
  Result := HPDF_CreateJavaScript(THaruDocument(ADocument).DocumentHandle, pCode);
end;

class function THaruJavascript.CreateFromFile(ADocument: TObject; AFileName: String): HPDF_Javascript;
var
  pFileName: PUTF8Char;
begin
  pFileName := StringToPUTF8Char(AFileName);
  Result := HPDF_LoadJSFromFile(THaruDocument(ADocument).DocumentHandle, pFileName);
end;

end.
