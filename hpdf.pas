{*
 * << Haru Free PDF Library >> -- hpdf.pas
 *
 * URL: http://libharu.org
 *
 * Copyright (c) 1999-2006 Takeshi Kanno <takeshi_kanno@est.hi-ho.ne.jp>
 * Copyright (c) 2007-2009 Antony Dovgal <tony@daylessday.org>
 *
 * Permission to use, copy, modify, distribute and sell this software
 * and its documentation for any purpose is hereby granted without fee,
 * provided that the above copyright notice appear in all copies and
 * that both that copyright notice and this permission notice appear
 * in supporting documentation.
 * It is provided "as is" without express or implied warranty.
 *
 *}

unit hpdf;

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}

interface

uses
  hpdf_types,
  {$IFNDEF FPC}Winapi.Windows{$ELSE}dynlibs{$ENDIF}, SysUtils;

const
{$IFDEF FPC}
  LIBHPDF_DLL = 'libhpdf.' + SharedSuffix;
{$ELSE}
  {$IFDEF Linux}
    LIBHPDF_DLL = 'libhpdf.so';
  {$ELSE}
    LIBHPDF_DLL = 'libhpdf.dll';
  {$ENDIF}
{$ENDIF}

type
  HPDF_HANDLE = Pointer;
  HPDF_Doc = HPDF_HANDLE;
  HPDF_Page = HPDF_HANDLE;
  HPDF_Pages = HPDF_HANDLE;
  HPDF_Stream = HPDF_HANDLE;
  HPDF_Image = HPDF_HANDLE;
  HPDF_Font = HPDF_HANDLE;
  HPDF_Outline = HPDF_HANDLE;
  HPDF_Encoder = HPDF_HANDLE;
  HPDF_3DMeasure = HPDF_HANDLE;
  HPDF_ExData = HPDF_HANDLE;
  HPDF_Destination = HPDF_HANDLE;
  HPDF_XObject = HPDF_HANDLE;
  HPDF_Annotation = HPDF_HANDLE;
  HPDF_ExtGState = HPDF_HANDLE;
  HPDF_FontDef = HPDF_HANDLE;
  HPDF_U3D = HPDF_HANDLE;
  HPDF_JavaScript = HPDF_HANDLE;
  HPDF_Error = HPDF_HANDLE;
  HPDF_MMgr = HPDF_HANDLE;
  HPDF_Dict = HPDF_HANDLE;
  HPDF_EmbeddedFile = HPDF_HANDLE;
  HPDF_OutputIntent = HPDF_HANDLE;
  HPDF_Xref = HPDF_HANDLE;
  HPDF_STATUS = Cardinal;

var
  HPDF_GetVersion: function(): HPDF_PCHAR; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_NewEx: function (user_error_fn: THPDF_Error_Handler;
        user_alloc_fn: THPDF_Alloc_Func; user_free_fn: THPDF_Free_Func;
        mem_pool_buf_size: HPDF_UINT; user_data: Pointer): HPDF_Doc;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_New: function (user_error_fn: THPDF_Error_Handler; user_data: Pointer): HPDF_Doc;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetErrorHandler: function (pdf: HPDF_Doc; user_error_fn: THPDF_Error_Handler):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Free: procedure (pdf: HPDF_Doc); {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_NewDoc: function (pdf: HPDF_Doc): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_FreeDoc: procedure  (pdf: HPDF_Doc); {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_HasDoc: function (pdf: HPDF_Doc): HPDF_BOOL; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_FreeDocAll: procedure  (pdf: HPDF_Doc); {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LimitVersion: function (pdf: HPDF_Doc; max_ver: THPDF_PdfVer): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SaveToStream: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetContents: function (pdf: HPDF_Doc; buf: HPDF_PBYTE; size: HPDF_PUINT32): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetStreamSize: function (pdf: HPDF_Doc): HPDF_UINT32;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_ReadFromStream: function (pdf: HPDF_Doc; buf: HPDF_PBYTE;
         size: HPDF_PUINT): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_ResetStream: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SaveToFile: function (pdf: HPDF_Doc; const file_name: HPDF_PCHAR): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetError: function (pdf: HPDF_Doc): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetErrorDetail: function (pdf: HPDF_Doc): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_ResetError: procedure (pdf: HPDF_Doc); {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_CheckError: function (error: HPDF_Error): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetPagesConfiguration: function (pdf: HPDF_Doc; page_per_pages: HPDF_UINT):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetPageByIndex: function (pdf: HPDF_Doc; index: HPDF_UINT): HPDF_Page;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetPageMMgr: function (page: HPDF_Page): HPDF_MMgr;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetPageLayout: function (pdf: HPDF_Doc): THPDF_PageLayout;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetPageLayout: function (pdf: HPDF_Doc; layout: THPDF_PageLayout): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetPageMode: function (pdf: HPDF_Doc): THPDF_PageMode;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetPageMode: function (pdf: HPDF_Doc; mode: THPDF_PageMode): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetViewerPreference: function (pdf: HPDF_Doc): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetViewerPreference: function (pdf: HPDF_Doc; value: HPDF_UINT): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetOpenAction: function (pdf: HPDF_Doc; open_action: HPDF_Destination):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetCurrentPage: function (pdf: HPDF_Doc): HPDF_Page;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_AddPage: function (pdf: HPDF_Doc): HPDF_Page; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_InsertPage: function (pdf: HPDF_Doc; page: HPDF_Page): HPDF_Page;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetWidth: function (page: HPDF_Page; value: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetHeight: function (page: HPDF_Page; value: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetBoundary: function (page: HPDF_Page; boundary: THPDF_PageBoundary; left: HPDF_REAL;
    bottom: HPDF_REAL; right: HPDF_REAL; top: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetSize: function (page: HPDF_Page; size: THPDF_PageSizes;
        direction: THPDF_PageDirection): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetRotate: function (page: HPDF_Page; angle: HPDF_UINT16): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetZoom: function (page: HPDF_Page; zoom: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetFont: function (pdf: HPDF_Doc; const font_name: HPDF_PCHAR;
        const encoding_name: HPDF_PCHAR): HPDF_Font; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadType1FontFromFile: function (pdf: HPDF_Doc; afmfilename: HPDF_PCHAR;
        pfmfilename: HPDF_PCHAR): HPDF_PCHAR; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetTTFontDefFromFile: function (pdf: HPDF_Doc; const file_name: HPDF_PCHAR;
        options: HPDF_INT): HPDF_FontDef; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadTTFontFromFile: function (pdf: HPDF_Doc; const file_name: HPDF_PCHAR;
        options: HPDF_INT): HPDF_PCHAR; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadTTFontFromFile2: function (pdf: HPDF_Doc; const file_name: HPDF_PCHAR;
        index: HPDF_UINT; options: HPDF_INT): HPDF_PCHAR;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};

  HPDF_AddPageLabel: function (pdf: HPDF_Doc; page_num: HPDF_UINT;
        style: THPDF_PageNumStyle; first_page: HPDF_UINT; const prefix: HPDF_PCHAR):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_UseJPFonts: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_UseKRFonts: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_UseCNSFonts: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_UseCNTFonts: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_CreateOutline: function (pdf: HPDF_Doc; parent: HPDF_Outline;
        const title: HPDF_PCHAR; encoder: HPDF_Encoder): HPDF_Outline;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Outline_SetOpened: function (outline: HPDF_Outline; opened: HPDF_BOOL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Outline_SetDestination: function (outline: HPDF_Outline;
        dst: HPDF_Destination): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateDestination: function (page: HPDF_Page): HPDF_Destination;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Destination_SetXYZ: function (dst: HPDF_Destination; left: HPDF_REAL;
        top: HPDF_REAL; zoom: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Destination_SetFit: function (dst: HPDF_Destination): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Destination_SetFitH: function (dst: HPDF_Destination; top: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Destination_SetFitV: function (dst: HPDF_Destination; left: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Destination_SetFitR: function (dst: HPDF_Destination; left: HPDF_REAL;
        bottom: HPDF_REAL; right: HPDF_REAL; top: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Destination_SetFitB: function (dst: HPDF_Destination): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Destination_SetFitBH : function(dst: HPDF_Destination; top: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Destination_SetFitBV: function (dst: HPDF_Destination; left: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetEncoder: function (pdf: HPDF_Doc; const encoding_name: HPDF_PCHAR):
        HPDF_Encoder; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetCurrentEncoder: function (pdf: HPDF_Doc): HPDF_Encoder;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetCurrentEncoder: function (pdf: HPDF_Doc; const encoding_name: HPDF_PCHAR):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Encoder_GetType: function (encoder: HPDF_Encoder): THPDF_EncoderType;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  // with converter, use HPDF_Font_GetByteType
  HPDF_Encoder_GetByteType: function (encoder: HPDF_Encoder; const text: HPDF_PCHAR;
        index: HPDF_UINT): THPDF_ByteType; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  // obsoleted, use HPDF_Encoder_GetUcs4 or HPDF_Font_GetUcs4
  HPDF_Encoder_GetUnicode: function (encoder: HPDF_Encoder; code: HPDF_UINT16):
        HPDF_UNICODE; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  // with converter, use HPDF_Font_GetUcs4
  HPDF_Encoder_GetUcs4: function (encoder: HPDF_Encoder; const text: HPDF_PCHAR; bytes: HPDF_PUINT):
        HPDF_UCS4; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Encoder_GetWritingMode: function (encoder: HPDF_Encoder): THPDF_WritingMode;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_UseJPEncodings: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_UseKREncodings: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_UseCNSEncodings: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_UseCNTEncodings: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_UseUTFEncodings: function (pdf: HPDF_Doc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetUTFEncoder: function (pdf: HPDF_Doc; charenc: THPDF_CharEnc): HPDF_Encoder;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateXObjectFromImage: function (pdf: HPDF_Doc; page: HPDF_Page; rect: THPDF_Rect;
        image: HPDF_Image; zoom: HPDF_BOOL): HPDF_XObject;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateXObjectAsWhiteRect: function (pdf: HPDF_Doc; page: HPDF_Page; rect: THPDF_Rect):
        HPDF_XObject; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Create3DAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        tb: HPDF_BOOL; np: HPDF_BOOL; u3d: HPDF_U3D; ap: HPDF_Image): HPDF_Annotation;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateTextAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        const text: HPDF_PCHAR; encoder: HPDF_Encoder): HPDF_Annotation;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateFreeTextAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        const text: HPDF_PCHAR; encoder: HPDF_Encoder): HPDF_Annotation;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateLineAnnot: function (page: HPDF_Page; const text: HPDF_PCHAR;
        encoder: HPDF_Encoder): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateWidgetAnnot_WhiteOnlyWhilePrint: function (pdf: HPDF_Doc; page: HPDF_Page;
        rect: THPDF_Rect): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateWidgetAnnot: function (page: HPDF_Page; rect: THPDF_Rect): HPDF_Annotation;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateLinkAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        dst: HPDF_Destination): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateURILinkAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        const uri: HPDF_PCHAR): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateHighlightAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        const text: HPDF_PCHAR; encoder: HPDF_Encoder): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateUnderlineAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        const text: HPDF_PCHAR; encoder: HPDF_Encoder): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateSquigglyAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        const text: HPDF_PCHAR; encoder: HPDF_Encoder): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateStrikeOutAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        const text: HPDF_PCHAR; encoder: HPDF_Encoder): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreatePopupAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        parent: HPDF_Annotation): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateStampAnnot: function (page: HPDF_Page; rect: THPDF_Rect;
        name: THPDF_StampAnnotName; const text: HPDF_PCHAR; encoder: HPDF_Encoder): HPDF_Annotation;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateProjectionAnnot: function (page: HPDF_Page; rect: THPDF_Rect; const text: HPDF_PCHAR;
        encoder: HPDF_Encoder): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateSquareAnnot: function (page: HPDF_Page; rect: THPDF_Rect; const text: HPDF_PCHAR;
        encoder: HPDF_Encoder): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreateCircleAnnot: function (page: HPDF_Page; rect: THPDF_Rect; const text: HPDF_PCHAR;
        encoder: HPDF_Encoder): HPDF_Annotation; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LinkAnnot_SetHighlightMode: function (annot: HPDF_Annotation;
        mode: THPDF_AnnotHighlightMode): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LinkAnnot_SetJavaScript: function (annot: HPDF_Annotation;
        javascript: HPDF_JavaScript): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LinkAnnot_SetBorderStyle: function (annot: HPDF_Annotation; width: HPDF_REAL;
        dash_on: HPDF_UINT16; dash_off: HPDF_UINT16): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_TextAnnot_SetIcon: function (annot: HPDF_Annotation; icon: THPDF_AnnotIcon):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_TextAnnot_SetOpened: function (annot: HPDF_Annotation; opened: HPDF_BOOL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Annot_SetRGBColor: function (annot: HPDF_Annotation; color: THPDF_RGBColor):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Annot_SetCMYKColor: function (annot: HPDF_Annotation; color: THPDF_CMYKColor):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Annot_SetGrayColor: function (annot: HPDF_Annotation; color: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Annot_SetNoColor: function (annot: HPDF_Annotation):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetTitle: function (annot: HPDF_Annotation; const name: HPDF_PCHAR):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetSubject: function (annot: HPDF_Annotation; const name: HPDF_PCHAR):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetCreationDate: function (annot: HPDF_Annotation; value: THPDF_Date):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetTransparency: function (annot: HPDF_Annotation; value: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetIntent: function (annot: HPDF_Annotation; value: THPDF_AnnotIntent):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetPopup: function (annot: HPDF_Annotation; popup: HPDF_Annotation):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetRectDiff: function (annot: HPDF_Annotation; rect: THPDF_Rect):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetCloudEffect: function (annot: HPDF_Annotation; cloudIntensity: HPDF_INT):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetInteriorRGBColor: function (annot: HPDF_Annotation; color: THPDF_RGBColor):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetInteriorCMYKColor: function (annot: HPDF_Annotation; color: THPDF_CMYKColor):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetInteriorGrayColor: function (annot: HPDF_Annotation; color: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_MarkupAnnot_SetInteriorTransparent: function (annot: HPDF_Annotation):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_TextMarkupAnnot_SetQuadPoints: function (annot: HPDF_Annotation; lb: THPDF_Point; rb: THPDF_Point;
        rt: THPDF_Point; lt: THPDF_Point): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Annot_Set3DView: function (mmgr: HPDF_MMgr; annot: HPDF_Annotation; annot3d: HPDF_Annotation;
        view: HPDF_Dict): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_PopupAnnot_SetOpened: function (annot: HPDF_Annotation; opened: HPDF_BOOL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_FreeTextAnnot_SetLineEndingStyle: function (annot: HPDF_Annotation;
        startStyle: THPDF_LineAnnotEndingStyle; endStyle: THPDF_LineAnnotEndingStyle): HPDF_STATUS;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_FreeTextAnnot_Set3PointCalloutLine: function (annot: HPDF_Annotation;
        startPoint: THPDF_Point; kneePoint: THPDF_Point; endPoint: THPDF_Point): HPDF_STATUS;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_FreeTextAnnot_Set2PointCalloutLine: function (annot: HPDF_Annotation;
        startPoint: THPDF_Point; endPoint: THPDF_Point): HPDF_STATUS;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_FreeTextAnnot_SetDefaultStyle: function (annot: HPDF_Annotation;
        const style: HPDF_PCHAR): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LineAnnot_SetPosition: function (annot: HPDF_Annotation;
        startPoint: THPDF_Point; startStyle: THPDF_LineAnnotEndingStyle;
        endPoint: THPDF_Point; endStyle: THPDF_LineAnnotEndingStyle): HPDF_STATUS;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LineAnnot_SetLeader: function (annot: HPDF_Annotation; leaderLen: HPDF_INT; leaderExtLen: HPDF_INT;
        leaderOffsetLen: HPDF_INT): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LineAnnot_SetCaption: function (annot: HPDF_Annotation; showCaption: HPDF_BOOL;
        position: THPDF_LineAnnotCapPosition; horzOffset: HPDF_INT; vertOffset: HPDF_INT):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Annotation_SetBorderStyle: function (annot: HPDF_Annotation; subtype: THPDF_BSSubtype;
        width: HPDF_REAL; dash_on: HPDF_UINT16; dash_off: HPDF_UINT16; dash_phase: HPDF_UINT16):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_ProjectionAnnot_SetExData: function (annot: HPDF_Annotation; exdata: HPDF_ExData): HPDF_STATUS;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Create3DC3DMeasure: function (page: HPDF_Page; firstanchorpoint: THPDF_Point3D;
        textanchorpoint: THPDF_Point3D): HPDF_3DMeasure; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CreatePD33DMeasure: function (page: HPDF_Page; annotationPlaneNormal: THPDF_Point3D;
        firstAnchorPoint: THPDF_Point3D; secondAnchorPoint: THPDF_Point3D; leaderLinesDirection: THPDF_Point3D;
        measurementValuePoint: THPDF_Point3D; textYDirection: THPDF_Point3D; value: HPDF_REAL;
        const unitsString: HPDF_PCHAR): HPDF_3DMeasure; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DMeasure_SetName: function (measure: HPDF_3DMeasure; const name: HPDF_PCHAR):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DMeasure_SetColor: function (measure: HPDF_3DMeasure; color: THPDF_RGBColor):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DMeasure_SetTextSize: function (measure: HPDF_3DMeasure; textsize: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DC3DMeasure_SetTextBoxSize: function (measure: HPDF_3DMeasure; x: HPDF_INT32; y: HPDF_INT32):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DC3DMeasure_SetText: function (measure: HPDF_3DMeasure; const text: HPDF_PCHAR; encoder: HPDF_Encoder):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DC3DMeasure_SetProjectionAnotation: function (measure: HPDF_3DMeasure;
        projectionanotation: HPDF_Annotation): HPDF_STATUS;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Create3DAnnotExData: function (page: HPDF_Page): HPDF_ExData;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DAnnotExData_Set3DMeasurement: function (exdata: HPDF_ExData; measure: HPDF_3DMeasure):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Create3DView: function (page: HPDF_Page; u3d: HPDF_U3D; annot3d: HPDF_Annotation;
        const name: HPDF_PCHAR): HPDF_Dict; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_Add3DC3DMeasure: function (view: HPDF_Dict; measure: HPDF_3DMeasure):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadPngImageFromMem: function (pdf: HPDF_Doc; const buffer: HPDF_PBYTE;
        size: HPDF_UINT): HPDF_Image; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadPngImageFromFile: function (pdf: HPDF_Doc; filename: HPDF_PCHAR):
        HPDF_Image; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadPngImageFromFile2: function (pdf: HPDF_Doc; filename: HPDF_PCHAR):
        HPDF_Image; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadJpegImageFromFile: function (pdf: HPDF_Doc; filename: HPDF_PCHAR):
        HPDF_Image; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadJpegImageFromMem: function (pdf: HPDF_Doc; const buffer: HPDF_PBYTE;
        size: HPDF_UINT): HPDF_Image; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadU3DFromFile: function (pdf: HPDF_Doc; filename: HPDF_PCHAR):
        HPDF_U3D; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadU3DFromMem: function (pdf: HPDF_Doc; const buffer: HPDF_PBYTE;
        size: HPDF_UINT): HPDF_U3D; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Image_LoadRaw1BitImageFromMem: function (pdf: HPDF_Doc; const buf: HPDF_PBYTE;
        width: HPDF_UINT; height: HPDF_UINT; line_width: HPDF_UINT;
        black_is1: HPDF_BOOL; top_is_first: HPDF_BOOL): HPDF_Image;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadRawImageFromFile: function (pdf: HPDF_Doc; filename: HPDF_PCHAR;
        width: HPDF_UINT; height: HPDF_UINT; color_space: THPDF_ColorSpace):
        HPDF_Image; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadRawImageFromMem: function (pdf: HPDF_Doc; const buf: HPDF_PBYTE;
        width: HPDF_UINT; height: HPDF_UINT; color_space: THPDF_ColorSpace;
        bits_per_component: HPDF_UINT; size: HPDF_UINT; black_white: HPDF_BOOL): HPDF_Image;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Image_AddSMask: function (image: HPDF_Image; smask: HPDF_Image):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  function HPDF_Image_GetSize (image: HPDF_Image): THPDF_Point;


var
  HPDF_Image_GetSize2: function (image: HPDF_Image; size: PHPDF_Point): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Image_GetWidth: function (image: HPDF_Image): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Image_GetHeight: function (image: HPDF_Image): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Image_GetBitsPerComponent: function (image: HPDF_Image): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Image_GetColorSpace: function (image: HPDF_Image): HPDF_PCHAR;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Image_SetColorMask: function (image: HPDF_Image; rmin: HPDF_UINT;
        rmax: HPDF_UINT; gmin: HPDF_UINT; gmax: HPDF_UINT; bmin: HPDF_UINT;
        bmax: HPDF_UINT): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Image_SetMaskImage: function (image: HPDF_Image; mask_image: HPDF_Image):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetInfoAttr: function (pdf: HPDF_Doc; info_type: THPDF_InfoType;
        const value: HPDF_PCHAR): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetInfoAttr: function (pdf: HPDF_Doc; info_type: THPDF_InfoType): HPDF_PCHAR;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetInfoDateAttr: function (pdf: HPDF_Doc; info_type: THPDF_InfoType; value: THPDF_Date):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetPassword: function (pdf: HPDF_Doc; const owner_passwd: HPDF_PCHAR;
        const user_passwd: HPDF_PCHAR): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetPermission: function (pdf: HPDF_Doc; permission: HPDF_UINT): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetEncryptionMode: function (pdf: HPDF_Doc; mode: THPDF_EncryptMode;
        key_len: HPDF_UINT): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_SetCompressionMode: function (pdf: HPDF_Doc; mode: HPDF_UINT): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetFontName: function (font: HPDF_Font): HPDF_PCHAR;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetEncodingName: function (font: HPDF_Font): HPDF_PCHAR;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  // obsoleted, use HPDF_Font_GetUcs4Width
  HPDF_Font_GetUnicodeWidth: function (font: HPDF_Font; code: HPDF_UNICODE): HPDF_INT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  // consider HPDF_Font_GetCharWidth
  HPDF_Font_GetUcs4Width: function (font: HPDF_Font; ucs4: HPDF_UCS4): HPDF_INT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  // not fully convert but convert only charenc
  HPDF_Font_GetCharWidth: function (font: HPDF_Font; const text: HPDF_PCHAR;
         bytes: HPDF_PUINT; ucs4: HPDF_UCS4): HPDF_INT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetBBox: function (font: HPDF_Font): THPDF_Rect;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetAscent: function (font: HPDF_Font): HPDF_INT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetDescent: function (font: HPDF_Font): HPDF_INT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetLeading: function (font: HPDF_Font): HPDF_INT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetUnderlinePosition: function (font: HPDF_Font): HPDF_INT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetUnderlineThickness: function (font: HPDF_Font): HPDF_INT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetXHeight: function (font: HPDF_Font): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetCapHeight: function (font: HPDF_Font): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_TextWidth: function  (font: HPDF_Font; const text: HPDF_PCHAR; len: HPDF_UINT): THPDF_TextWidth;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_MeasureText: function (font: HPDF_Font; const text: HPDF_PCHAR; len: HPDF_UINT;
        width: HPDF_REAL; font_size: HPDF_REAL; char_space: HPDF_REAL;
        word_space: HPDF_REAL; options: HPDF_INT; real_width: HPDF_PREAL) : HPDF_UINT;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_MeasureTextLines: function (font: HPDF_Font; const text: HPDF_PCHAR; len: HPDF_UINT;
        line_width: HPDF_REAL; font_size: HPDF_REAL; char_space: HPDF_REAL; word_space: HPDF_REAL;
        options: HPDF_INT; out width: THPDF_TextLineWidth; max_lines: HPDF_UINT) : HPDF_UINT;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_SetTatweelCount: function  (font: HPDF_Font; dst_tatweels: HPDF_UINT; src_tatweels: HPDF_UINT;
        numchars: HPDF_UINT): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_SelectConverters: function  (font: HPDF_Font; index: HPDF_INT): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_SetCharacterEncoding: function  (font: HPDF_Font; charenc: THPDF_CharEnc): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_PushConverter: function  (font: HPDF_Font; new_fn: THPDF_Converter_New_Func; param: Pointer):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_PushBuiltInConverter: function  (font: HPDF_Font; const name: HPDF_PCHAR; param: Pointer):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_GetByteType: function  (font: HPDF_Font; const text: HPDF_PCHAR; index: HPDF_UINT):
        THPDF_ByteType; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  // not fully convert but convert only charenc
  HPDF_Font_GetUcs4: function  (font: HPDF_Font; const text: HPDF_PCHAR; bytes: HPDF_PUINT): HPDF_UCS4;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Font_SetReliefFont: function  (font: HPDF_Font; relief_font: HPDF_Font): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_AttachFile: function (pdf: HPDF_Doc; const filename: HPDF_PCHAR): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_CreateExtGState: function (pdf: HPDF_Doc) : HPDF_ExtGState;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_ExtGState_SetAlphaStroke: function  (ext_gstate: HPDF_ExtGState;
         value: HPDF_REAL) : HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_ExtGState_SetAlphaFill: function  (ext_gstate: HPDF_ExtGState;
         value: HPDF_REAL) : HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_ExtGState_SetBlendMode: function  (ext_gstate: HPDF_ExtGState;
         mode: THPDF_BlendMode) : HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_TextWidth: function (page: HPDF_Page; const text: HPDF_PCHAR): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_MeasureText: function (page: HPDF_Page; const text: HPDF_PCHAR;
        width: HPDF_REAL; options: HPDF_INT; real_width: HPDF_PREAL): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_MeasureTextLines: function (page: HPDF_Page; const text: HPDF_PCHAR; line_width: HPDF_REAL;
        options: HPDF_INT; out width: THPDF_TextLineWidth; max_lines: HPDF_UINT): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetWidth: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetHeight: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetGMode: function (page: HPDF_Page): HPDF_UINT16;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  function HPDF_Page_GetCurrentPos (page: HPDF_Page): THPDF_Point;


var
  HPDF_Page_GetCurrentPos2: function (page: HPDF_Page; pos: PHPDF_Point): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  function HPDF_Page_GetCurrentTextPos (page: HPDF_Page): THPDF_Point;


var
  HPDF_Page_GetCurrentTextPos2: function (page: HPDF_Page; pos: PHPDF_Point): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetCurrentFont: function (page: HPDF_Page): HPDF_Font;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetCurrentFontSize: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetTransMatrix: function (page: HPDF_Page): THPDF_TransMatrix;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetLineWidth: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetLineCap: function (page: HPDF_Page): THPDF_LineCap;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetLineJoin: function (page: HPDF_Page): THPDF_LineJoin;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetMiterLimit: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetDash: function (page: HPDF_Page): THPDF_DashMode;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetFlat: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetCharSpace: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetWordSpace: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetHorizontalScalling: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetTextLeading: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetTextRenderingMode: function (page: HPDF_Page): THPDF_TextRenderingMode;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetTextRise: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetRGBFill: function (page: HPDF_Page): THPDF_RGBColor;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetRGBStroke: function (page: HPDF_Page): THPDF_RGBColor;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetCMYKFill: function (page: HPDF_Page): THPDF_CMYKColor;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetCMYKStroke: function (page: HPDF_Page): THPDF_CMYKColor;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetGrayFill: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetGrayStroke: function (page: HPDF_Page): HPDF_REAL;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetStrokingColorSpace: function (page: HPDF_Page): THPDF_ColorSpace;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetFillingColorSpace: function (page: HPDF_Page): THPDF_ColorSpace;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetTextMatrix: function (page: HPDF_Page): THPDF_TransMatrix;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GetGStateDepth: function (page: HPDF_Page): HPDF_UINT;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetLineWidth: function (page: HPDF_Page; line_width: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetLineCap: function (page: HPDF_Page; line_cap: THPDF_LineCap):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetLineJoin: function (page: HPDF_Page; line_join: THPDF_LineJoin):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetMiterLimit: function (page: HPDF_Page; miter_limit: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetDash: function (page: HPDF_Page; ptn: HPDF_PREAL; num_param: HPDF_UINT;
        phase: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetFlat: function (page: HPDF_Page; flatness: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetExtGState: function (page: HPDF_Page; ext_gstate: HPDF_ExtGState): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GSave: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_GRestore: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Concat: function (page: HPDF_Page; a: HPDF_REAL; b: HPDF_REAL; c: HPDF_REAL;
        d: HPDF_REAL; x: HPDF_REAL; y: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_MoveTo: function (page: HPDF_Page; x: HPDF_REAL; y: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_LineTo: function (page: HPDF_Page; x: HPDF_REAL; y: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CurveTo: function (page: HPDF_Page; x1: HPDF_REAL; y1: HPDF_REAL;
        x2: HPDF_REAL; y2: HPDF_REAL; x3: HPDF_REAL; y3: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CurveTo2: function (page: HPDF_Page; x2: HPDF_REAL; y2: HPDF_REAL;
        x3: HPDF_REAL; y3: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_CurveTo3: function (page: HPDF_Page; x1: HPDF_REAL; y1: HPDF_REAL;
        x3: HPDF_REAL; y3: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_ClosePath: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Rectangle: function (page: HPDF_Page; x: HPDF_REAL; y: HPDF_REAL;
        width: HPDF_REAL; height: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Stroke: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_ClosePathStroke: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Fill: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Eofill: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_FillStroke: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_EofillStroke: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_ClosePathFillStroke: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_ClosePathEofillStroke: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_EndPath: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Clip: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Eoclip: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_BeginText: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_EndText: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetCharSpace: function (page: HPDF_Page; value: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetWordSpace: function (page: HPDF_Page; value: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetHorizontalScalling: function (page: HPDF_Page; value: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetTextLeading: function (page: HPDF_Page; value: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetFontAndSize: function (page: HPDF_Page; font: HPDF_Font;
        size: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetTextRenderingMode: function (page: HPDF_Page;
        mode: THPDF_TextRenderingMode): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetTextRise: function (page: HPDF_Page; value: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_MoveTextPos: function (page: HPDF_Page; x: HPDF_REAL; y: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_MoveTextPos2: function (page: HPDF_Page; x: HPDF_REAL; y: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetTextMatrix: function (page: HPDF_Page; a: HPDF_REAL; b: HPDF_REAL;
        c: HPDF_REAL; d: HPDF_REAL; x: HPDF_REAL; y: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_MoveToNextLine: function (page: HPDF_Page): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_ShowText: function (page: HPDF_Page; const text: HPDF_PCHAR): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_ShowTextNextLine: function (page: HPDF_Page; const text: HPDF_PCHAR):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_ShowTextNextLineEx: function (page: HPDF_Page; word_space: HPDF_REAL;
        char_space: HPDF_REAL; const text: HPDF_PCHAR): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetGrayFill: function (page: HPDF_Page; gray: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetGrayStroke: function (page: HPDF_Page; gray: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetRGBFill: function (page: HPDF_Page; r: HPDF_REAL; g: HPDF_REAL;
        b: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetRGBStroke: function (page: HPDF_Page; r: HPDF_REAL; g: HPDF_REAL;
        b: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetCMYKFill: function (page: HPDF_Page; c: HPDF_REAL; m: HPDF_REAL;
        y: HPDF_REAL; k: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetCMYKStroke: function (page: HPDF_Page; c: HPDF_REAL; m: HPDF_REAL;
        y: HPDF_REAL; k: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_ExecuteXObject: function (page: HPDF_Page; obj: HPDF_XObject): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_New_Content_Stream: function (page: HPDF_Page; new_stream: HPDF_Dict): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Insert_Shared_Content_Stream: function (page: HPDF_Page; shared_stream: HPDF_Dict): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_DrawImage: function (page: HPDF_Page; image: HPDF_Image; x: HPDF_REAL;
        y: HPDF_REAL; width: HPDF_REAL; height: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Circle: function (page: HPDF_Page; x: HPDF_REAL; y: HPDF_REAL;
        ray: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Ellipse: function (page: HPDF_Page; x: HPDF_REAL; y: HPDF_REAL;
        xray: HPDF_REAL; yray: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_Arc: function (page: HPDF_Page; x: HPDF_REAL; y: HPDF_REAL; ray: HPDF_REAL;
        ang1: HPDF_REAL; ang2: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_TextOut: function (page: HPDF_Page; xpos: HPDF_REAL; ypos: HPDF_REAL;
         const text: HPDF_PCHAR): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_TextRect : function (page: HPDF_Page; left: HPDF_REAL; top: HPDF_REAL;
        right: HPDF_REAL; bottom: HPDF_REAL; const text: HPDF_PCHAR;
        align: Cardinal; len: HPDF_PUINT): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetJustifyRatio: function (page: HPDF_Page; word_space: HPDF_REAL; char_space: HPDF_REAL;
        kashida: HPDF_REAL): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_InterlinearAnnotationRatio: function (page: HPDF_Page; ratio: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_SetSlideShow : function (page: HPDF_Page; sstype: THPDF_TransitionStyle;
        disp_time: HPDF_REAL; trans_time: HPDF_REAL): HPDF_STATUS;
         {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_ICC_LoadIccFromMem: function (pdf: HPDF_Doc; mmgr: HPDF_MMgr; iccdata: HPDF_Stream; xref: HPDF_Xref;
        numcomponent: Integer): HPDF_OutputIntent; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadIccProfileFromFile: function (pdf: HPDF_Doc; icc_file_name: HPDF_PCHAR;
  numcomponent: Integer): HPDF_OutputIntent; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Page_WriteComment: function (page: HPDF_Page; const text: HPDF_PCHAR): HPDF_STATUS;
  {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_PDFA_AppendOutputIntents: function (pdf: HPDF_Doc; const iccname: HPDF_PCHAR;
        iccdict: HPDF_Dict): HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_PDFA_SetPDFAConformance: function (pdf: HPDF_Doc; pdfatype: THPDF_PDFA_TYPE):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_CreateJavaScript: function (pdf: HPDF_Doc; const code: HPDF_PCHAR):
        HPDF_JavaScript; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_LoadJSFromFile: function (pdf: HPDF_Doc; const filename: HPDF_PCHAR):
        HPDF_JavaScript; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_Create3DView: function (mmgr: HPDF_MMgr; const name: HPDF_PCHAR):
        HPDF_Dict; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_GetU3DMMgr: function (u3d: HPDF_U3D): HPDF_MMgr; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_U3D_Add3DView: function (u3d: HPDF_U3D; view: HPDF_Dict):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_U3D_SetDefault3DView: function (u3d: HPDF_U3D; const name: HPDF_PCHAR):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_U3D_AddOnInstantiate: function (u3d: HPDF_U3D; javaScript: HPDF_JavaScript):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_CreateNode: function (view: HPDF_Dict; const name: HPDF_PCHAR):
        HPDF_Dict; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DViewNode_SetOpacity: function (node: HPDF_Dict; opacity: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DViewNode_SetVisibility: function (node: HPDF_Dict; visible: HPDF_BOOL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DViewNode_SetMatrix: function (node: HPDF_Dict; Mat3D: THPDF_3DMatrix):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_AddNode: function (view: HPDF_Dict; node: HPDF_Dict):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_SetLighting: function (view: HPDF_Dict; const scheme: HPDF_PCHAR):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_SetBackgroundColor: function (view: HPDF_Dict; r: HPDF_REAL; g: HPDF_REAL; b: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_SetPerspectiveProjection: function (view: HPDF_Dict; fov: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_SetOrthogonalProjection: function (view: HPDF_Dict; mag: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_SetCamera: function (view: HPDF_Dict; coox: HPDF_REAL; cooy: HPDF_REAL; cooz: HPDF_REAL;
        c2cx: HPDF_REAL; c2cy: HPDF_REAL; c2cz: HPDF_REAL; roo: HPDF_REAL; roll: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_SetCameraByMatrix: function (view: HPDF_Dict; Mat3D: THPDF_3DMatrix; co: HPDF_REAL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_SetCrossSectionOn: function (view: HPDF_Dict; center: THPDF_Point3D; Roll: HPDF_REAL;
        Pitch: HPDF_REAL; opacity: HPDF_REAL; showintersection: HPDF_BOOL):
        HPDF_STATUS; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  HPDF_3DView_SetCrossSectionOff: function (view: HPDF_Dict): HPDF_STATUS;
        {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


implementation

var
  hLibHaru: THandle;

procedure FreeHaruLib;
begin
  if (hLibHaru <> 0) then
  begin
    FreeLibrary(hLibHaru);
    hLibHaru := 0;
  end;
end;

function InitHaruLib: Boolean;

  function LoadLibHaruProc(AProcName: String): Pointer;
  begin
    Result := GetProcAddress(hLibHaru, PChar(AProcName));
  end;

begin
  Result := False;

  if (hLibHaru = 0) then
  begin
    hLibHaru := LoadLibrary({$IFDEF FPC}ExtractFilePath(ParamStr(0)) + LIBHPDF_DLL{$ELSE}PChar(LIBHPDF_DLL){$ENDIF});
    if (hLibHaru <> 0) then
    begin
      @HPDF_GetVersion := LoadLibHaruProc('HPDF_GetVersion');
      @HPDF_NewEx := LoadLibHaruProc('HPDF_NewEx');
      @HPDF_New := LoadLibHaruProc('HPDF_New');
      @HPDF_SetErrorHandler := LoadLibHaruProc('HPDF_SetErrorHandler');
      @HPDF_Free := LoadLibHaruProc('HPDF_Free');
      @HPDF_NewDoc := LoadLibHaruProc('HPDF_NewDoc');
      @HPDF_FreeDoc := LoadLibHaruProc('HPDF_FreeDoc');
      @HPDF_HasDoc := LoadLibHaruProc('HPDF_HasDoc');
      @HPDF_FreeDocAll := LoadLibHaruProc('HPDF_FreeDocAll');
      @HPDF_LimitVersion := LoadLibHaruProc('HPDF_LimitVersion');
      @HPDF_SaveToStream := LoadLibHaruProc('HPDF_SaveToStream');
      @HPDF_GetContents := LoadLibHaruProc('HPDF_GetContents');
      @HPDF_GetStreamSize := LoadLibHaruProc('HPDF_GetStreamSize');
      @HPDF_ReadFromStream := LoadLibHaruProc('HPDF_ReadFromStream');
      @HPDF_ResetStream := LoadLibHaruProc('HPDF_ResetStream');
      @HPDF_SaveToFile := LoadLibHaruProc('HPDF_SaveToFile');
      @HPDF_GetError := LoadLibHaruProc('HPDF_GetError');
      @HPDF_GetErrorDetail := LoadLibHaruProc('HPDF_GetErrorDetail');
      @HPDF_ResetError := LoadLibHaruProc('HPDF_ResetError');
      @HPDF_CheckError := LoadLibHaruProc('HPDF_CheckError');
      @HPDF_SetPagesConfiguration := LoadLibHaruProc('HPDF_SetPagesConfiguration');
      @HPDF_GetPageByIndex := LoadLibHaruProc('HPDF_GetPageByIndex');
      @HPDF_GetPageMMgr := LoadLibHaruProc('HPDF_GetPageMMgr');
      @HPDF_GetPageLayout := LoadLibHaruProc('HPDF_GetPageLayout');
      @HPDF_SetPageLayout := LoadLibHaruProc('HPDF_SetPageLayout');
      @HPDF_GetPageMode := LoadLibHaruProc('HPDF_GetPageMode');
      @HPDF_SetPageMode := LoadLibHaruProc('HPDF_SetPageMode');
      @HPDF_GetViewerPreference := LoadLibHaruProc('HPDF_GetViewerPreference');
      @HPDF_SetViewerPreference := LoadLibHaruProc('HPDF_SetViewerPreference');
      @HPDF_SetOpenAction := LoadLibHaruProc('HPDF_SetOpenAction');
      @HPDF_GetCurrentPage := LoadLibHaruProc('HPDF_GetCurrentPage');
      @HPDF_AddPage := LoadLibHaruProc('HPDF_AddPage');
      @HPDF_InsertPage := LoadLibHaruProc('HPDF_InsertPage');
      @HPDF_Page_SetWidth := LoadLibHaruProc('HPDF_Page_SetWidth');
      @HPDF_Page_SetHeight := LoadLibHaruProc('HPDF_Page_SetHeight');
      @HPDF_Page_SetBoundary := LoadLibHaruProc('HPDF_Page_SetBoundary');
      @HPDF_Page_SetSize := LoadLibHaruProc('HPDF_Page_SetSize');
      @HPDF_Page_SetRotate := LoadLibHaruProc('HPDF_Page_SetRotate');
      @HPDF_Page_SetZoom := LoadLibHaruProc('HPDF_Page_SetZoom');
      @HPDF_GetFont := LoadLibHaruProc('HPDF_GetFont');
      @HPDF_LoadType1FontFromFile := LoadLibHaruProc('HPDF_LoadType1FontFromFile');
      @HPDF_GetTTFontDefFromFile := LoadLibHaruProc('HPDF_GetTTFontDefFromFile');
      @HPDF_LoadTTFontFromFile := LoadLibHaruProc('HPDF_LoadTTFontFromFile');
      @HPDF_LoadTTFontFromFile2 := LoadLibHaruProc('HPDF_LoadTTFontFromFile2');
      @HPDF_AddPageLabel := LoadLibHaruProc('HPDF_AddPageLabel');
      @HPDF_UseJPFonts := LoadLibHaruProc('HPDF_UseJPFonts');
      @HPDF_UseKRFonts := LoadLibHaruProc('HPDF_UseKRFonts');
      @HPDF_UseCNSFonts := LoadLibHaruProc('HPDF_UseCNSFonts');
      @HPDF_UseCNTFonts := LoadLibHaruProc('HPDF_UseCNTFonts');
      @HPDF_CreateOutline := LoadLibHaruProc('HPDF_CreateOutline');
      @HPDF_Outline_SetOpened := LoadLibHaruProc('HPDF_Outline_SetOpened');
      @HPDF_Outline_SetDestination := LoadLibHaruProc('HPDF_Outline_SetDestination');
      @HPDF_Page_CreateDestination := LoadLibHaruProc('HPDF_Page_CreateDestination');
      @HPDF_Destination_SetXYZ := LoadLibHaruProc('HPDF_Destination_SetXYZ');
      @HPDF_Destination_SetFit := LoadLibHaruProc('HPDF_Destination_SetFit');
      @HPDF_Destination_SetFitH := LoadLibHaruProc('HPDF_Destination_SetFitH');
      @HPDF_Destination_SetFitV := LoadLibHaruProc('HPDF_Destination_SetFitV');
      @HPDF_Destination_SetFitR := LoadLibHaruProc('HPDF_Destination_SetFitR');
      @HPDF_Destination_SetFitB := LoadLibHaruProc('HPDF_Destination_SetFitB');
      @HPDF_Destination_SetFitBH := LoadLibHaruProc('HPDF_Destination_SetFitBH');
      @HPDF_Destination_SetFitBV := LoadLibHaruProc('HPDF_Destination_SetFitBV');
      @HPDF_GetEncoder := LoadLibHaruProc('HPDF_GetEncoder');
      @HPDF_GetCurrentEncoder := LoadLibHaruProc('HPDF_GetCurrentEncoder');
      @HPDF_SetCurrentEncoder := LoadLibHaruProc('HPDF_SetCurrentEncoder');
      @HPDF_Encoder_GetType := LoadLibHaruProc('HPDF_Encoder_GetType');
      @HPDF_Encoder_GetByteType := LoadLibHaruProc('HPDF_Encoder_GetByteType');
      @HPDF_Encoder_GetUnicode := LoadLibHaruProc('HPDF_Encoder_GetUnicode');
      @HPDF_Encoder_GetUcs4 := LoadLibHaruProc('HPDF_Encoder_GetUcs4');
      @HPDF_Encoder_GetWritingMode := LoadLibHaruProc('HPDF_Encoder_GetWritingMode');
      @HPDF_UseJPEncodings := LoadLibHaruProc('HPDF_UseJPEncodings');
      @HPDF_UseKREncodings := LoadLibHaruProc('HPDF_UseKREncodings');
      @HPDF_UseCNSEncodings := LoadLibHaruProc('HPDF_UseCNSEncodings');
      @HPDF_UseCNTEncodings := LoadLibHaruProc('HPDF_UseCNTEncodings');
      @HPDF_UseUTFEncodings := LoadLibHaruProc('HPDF_UseUTFEncodings');
      @HPDF_GetUTFEncoder := LoadLibHaruProc('HPDF_GetUTFEncoder');
      @HPDF_Page_CreateXObjectFromImage := LoadLibHaruProc('HPDF_Page_CreateXObjectFromImage');
      @HPDF_Page_CreateXObjectAsWhiteRect := LoadLibHaruProc('HPDF_Page_CreateXObjectAsWhiteRect');
      @HPDF_Page_Create3DAnnot := LoadLibHaruProc('HPDF_Page_Create3DAnnot');
      @HPDF_Page_CreateTextAnnot := LoadLibHaruProc('HPDF_Page_CreateTextAnnot');
      @HPDF_Page_CreateFreeTextAnnot := LoadLibHaruProc('HPDF_Page_CreateFreeTextAnnot');
      @HPDF_Page_CreateLineAnnot := LoadLibHaruProc('HPDF_Page_CreateLineAnnot');
      @HPDF_Page_CreateWidgetAnnot_WhiteOnlyWhilePrint := LoadLibHaruProc('HPDF_Page_CreateWidgetAnnot_WhiteOnlyWhilePrint');
      @HPDF_Page_CreateWidgetAnnot := LoadLibHaruProc('HPDF_Page_CreateWidgetAnnot');
      @HPDF_Page_CreateLinkAnnot := LoadLibHaruProc('HPDF_Page_CreateLinkAnnot');
      @HPDF_Page_CreateURILinkAnnot := LoadLibHaruProc('HPDF_Page_CreateURILinkAnnot');
      @HPDF_Page_CreateHighlightAnnot := LoadLibHaruProc('HPDF_Page_CreateHighlightAnnot');
      @HPDF_Page_CreateUnderlineAnnot := LoadLibHaruProc('HPDF_Page_CreateUnderlineAnnot');
      @HPDF_Page_CreateSquigglyAnnot := LoadLibHaruProc('HPDF_Page_CreateSquigglyAnnot');
      @HPDF_Page_CreateStrikeOutAnnot := LoadLibHaruProc('HPDF_Page_CreateStrikeOutAnnot');
      @HPDF_Page_CreatePopupAnnot := LoadLibHaruProc('HPDF_Page_CreatePopupAnnot');
      @HPDF_Page_CreateStampAnnot := LoadLibHaruProc('HPDF_Page_CreateStampAnnot');
      @HPDF_Page_CreateProjectionAnnot := LoadLibHaruProc('HPDF_Page_CreateProjectionAnnot');
      @HPDF_Page_CreateSquareAnnot := LoadLibHaruProc('HPDF_Page_CreateSquareAnnot');
      @HPDF_Page_CreateCircleAnnot := LoadLibHaruProc('HPDF_Page_CreateCircleAnnot');
      @HPDF_LinkAnnot_SetHighlightMode := LoadLibHaruProc('HPDF_LinkAnnot_SetHighlightMode');
      @HPDF_LinkAnnot_SetJavaScript := LoadLibHaruProc('HPDF_LinkAnnot_SetJavaScript');
      @HPDF_LinkAnnot_SetBorderStyle := LoadLibHaruProc('HPDF_LinkAnnot_SetBorderStyle');
      @HPDF_TextAnnot_SetIcon := LoadLibHaruProc('HPDF_TextAnnot_SetIcon');
      @HPDF_TextAnnot_SetOpened := LoadLibHaruProc('HPDF_TextAnnot_SetOpened');
      @HPDF_Annot_SetRGBColor := LoadLibHaruProc('HPDF_Annot_SetRGBColor');
      @HPDF_Annot_SetCMYKColor := LoadLibHaruProc('HPDF_Annot_SetCMYKColor');
      @HPDF_Annot_SetGrayColor := LoadLibHaruProc('HPDF_Annot_SetGrayColor');
      @HPDF_Annot_SetNoColor := LoadLibHaruProc('HPDF_Annot_SetNoColor');
      @HPDF_MarkupAnnot_SetTitle := LoadLibHaruProc('HPDF_MarkupAnnot_SetTitle');
      @HPDF_MarkupAnnot_SetSubject := LoadLibHaruProc('HPDF_MarkupAnnot_SetSubject');
      @HPDF_MarkupAnnot_SetCreationDate := LoadLibHaruProc('HPDF_MarkupAnnot_SetCreationDate');
      @HPDF_MarkupAnnot_SetTransparency := LoadLibHaruProc('HPDF_MarkupAnnot_SetTransparency');
      @HPDF_MarkupAnnot_SetIntent := LoadLibHaruProc('HPDF_MarkupAnnot_SetIntent');
      @HPDF_MarkupAnnot_SetPopup := LoadLibHaruProc('HPDF_MarkupAnnot_SetPopup');
      @HPDF_MarkupAnnot_SetRectDiff := LoadLibHaruProc('HPDF_MarkupAnnot_SetRectDiff');
      @HPDF_MarkupAnnot_SetCloudEffect := LoadLibHaruProc('HPDF_MarkupAnnot_SetCloudEffect');
      @HPDF_MarkupAnnot_SetInteriorRGBColor := LoadLibHaruProc('HPDF_MarkupAnnot_SetInteriorRGBColor');
      @HPDF_MarkupAnnot_SetInteriorCMYKColor := LoadLibHaruProc('HPDF_MarkupAnnot_SetInteriorCMYKColor');
      @HPDF_MarkupAnnot_SetInteriorGrayColor := LoadLibHaruProc('HPDF_MarkupAnnot_SetInteriorGrayColor');
      @HPDF_MarkupAnnot_SetInteriorTransparent := LoadLibHaruProc('HPDF_MarkupAnnot_SetInteriorTransparent');
      @HPDF_TextMarkupAnnot_SetQuadPoints := LoadLibHaruProc('HPDF_TextMarkupAnnot_SetQuadPoints');
      @HPDF_Annot_Set3DView := LoadLibHaruProc('HPDF_Annot_Set3DView');
      @HPDF_PopupAnnot_SetOpened := LoadLibHaruProc('HPDF_PopupAnnot_SetOpened');
      @HPDF_FreeTextAnnot_SetLineEndingStyle := LoadLibHaruProc('HPDF_FreeTextAnnot_SetLineEndingStyle');
      @HPDF_FreeTextAnnot_Set3PointCalloutLine := LoadLibHaruProc('HPDF_FreeTextAnnot_Set3PointCalloutLine');
      @HPDF_FreeTextAnnot_Set2PointCalloutLine := LoadLibHaruProc('HPDF_FreeTextAnnot_Set2PointCalloutLine');
      @HPDF_FreeTextAnnot_SetDefaultStyle := LoadLibHaruProc('HPDF_FreeTextAnnot_SetDefaultStyle');
      @HPDF_LineAnnot_SetPosition := LoadLibHaruProc('HPDF_LineAnnot_SetPosition');
      @HPDF_LineAnnot_SetLeader := LoadLibHaruProc('HPDF_LineAnnot_SetLeader');
      @HPDF_LineAnnot_SetCaption := LoadLibHaruProc('HPDF_LineAnnot_SetCaption');
      @HPDF_Annotation_SetBorderStyle := LoadLibHaruProc('HPDF_Annotation_SetBorderStyle');
      @HPDF_ProjectionAnnot_SetExData := LoadLibHaruProc('HPDF_ProjectionAnnot_SetExData');
      @HPDF_Page_Create3DC3DMeasure := LoadLibHaruProc('HPDF_Page_Create3DC3DMeasure');
      @HPDF_Page_CreatePD33DMeasure := LoadLibHaruProc('HPDF_Page_CreatePD33DMeasure');
      @HPDF_3DMeasure_SetName := LoadLibHaruProc('HPDF_3DMeasure_SetName');
      @HPDF_3DMeasure_SetColor := LoadLibHaruProc('HPDF_3DMeasure_SetColor');
      @HPDF_3DMeasure_SetTextSize := LoadLibHaruProc('HPDF_3DMeasure_SetTextSize');
      @HPDF_3DC3DMeasure_SetTextBoxSize := LoadLibHaruProc('HPDF_3DC3DMeasure_SetTextBoxSize');
      @HPDF_3DC3DMeasure_SetText := LoadLibHaruProc('HPDF_3DC3DMeasure_SetText');
      @HPDF_3DC3DMeasure_SetProjectionAnotation := LoadLibHaruProc('HPDF_3DC3DMeasure_SetProjectionAnotation');
      @HPDF_Page_Create3DAnnotExData := LoadLibHaruProc('HPDF_Page_Create3DAnnotExData');
      @HPDF_3DAnnotExData_Set3DMeasurement := LoadLibHaruProc('HPDF_3DAnnotExData_Set3DMeasurement');
      @HPDF_Page_Create3DView := LoadLibHaruProc('HPDF_Page_Create3DView');
      @HPDF_3DView_Add3DC3DMeasure := LoadLibHaruProc('HPDF_3DView_Add3DC3DMeasure');
      @HPDF_LoadPngImageFromMem := LoadLibHaruProc('HPDF_LoadPngImageFromMem');
      @HPDF_LoadPngImageFromFile := LoadLibHaruProc('HPDF_LoadPngImageFromFile');
      @HPDF_LoadPngImageFromFile2 := LoadLibHaruProc('HPDF_LoadPngImageFromFile2');
      @HPDF_LoadJpegImageFromFile := LoadLibHaruProc('HPDF_LoadJpegImageFromFile');
      @HPDF_LoadJpegImageFromMem := LoadLibHaruProc('HPDF_LoadJpegImageFromMem');
      @HPDF_LoadU3DFromFile := LoadLibHaruProc('HPDF_LoadU3DFromFile');
      @HPDF_LoadU3DFromMem := LoadLibHaruProc('HPDF_LoadU3DFromMem');
      @HPDF_Image_LoadRaw1BitImageFromMem := LoadLibHaruProc('HPDF_Image_LoadRaw1BitImageFromMem');
      @HPDF_LoadRawImageFromFile := LoadLibHaruProc('HPDF_LoadRawImageFromFile');
      @HPDF_LoadRawImageFromMem := LoadLibHaruProc('HPDF_LoadRawImageFromMem');
      @HPDF_Image_AddSMask := LoadLibHaruProc('HPDF_Image_AddSMask');
      @HPDF_Image_GetSize2 := LoadLibHaruProc('HPDF_Image_GetSize2');
      @HPDF_Image_GetWidth := LoadLibHaruProc('HPDF_Image_GetWidth');
      @HPDF_Image_GetHeight := LoadLibHaruProc('HPDF_Image_GetHeight');
      @HPDF_Image_GetBitsPerComponent := LoadLibHaruProc('HPDF_Image_GetBitsPerComponent');
      @HPDF_Image_GetColorSpace := LoadLibHaruProc('HPDF_Image_GetColorSpace');
      @HPDF_Image_SetColorMask := LoadLibHaruProc('HPDF_Image_SetColorMask');
      @HPDF_Image_SetMaskImage := LoadLibHaruProc('HPDF_Image_SetMaskImage');
      @HPDF_SetInfoAttr := LoadLibHaruProc('HPDF_SetInfoAttr');
      @HPDF_GetInfoAttr := LoadLibHaruProc('HPDF_GetInfoAttr');
      @HPDF_SetInfoDateAttr := LoadLibHaruProc('HPDF_SetInfoDateAttr');
      @HPDF_SetPassword := LoadLibHaruProc('HPDF_SetPassword');
      @HPDF_SetPermission := LoadLibHaruProc('HPDF_SetPermission');
      @HPDF_SetEncryptionMode := LoadLibHaruProc('HPDF_SetEncryptionMode');
      @HPDF_SetCompressionMode := LoadLibHaruProc('HPDF_SetCompressionMode');
      @HPDF_Font_GetFontName := LoadLibHaruProc('HPDF_Font_GetFontName');
      @HPDF_Font_GetEncodingName := LoadLibHaruProc('HPDF_Font_GetEncodingName');
      @HPDF_Font_GetUnicodeWidth := LoadLibHaruProc('HPDF_Font_GetUnicodeWidth');
      @HPDF_Font_GetUcs4Width := LoadLibHaruProc('HPDF_Font_GetUcs4Width');
      @HPDF_Font_GetCharWidth := LoadLibHaruProc('HPDF_Font_GetCharWidth');
      @HPDF_Font_GetBBox := LoadLibHaruProc('HPDF_Font_GetBBox');
      @HPDF_Font_GetAscent := LoadLibHaruProc('HPDF_Font_GetAscent');
      @HPDF_Font_GetDescent := LoadLibHaruProc('HPDF_Font_GetDescent');
      @HPDF_Font_GetLeading := LoadLibHaruProc('HPDF_Font_GetLeading');
      @HPDF_Font_GetUnderlinePosition := LoadLibHaruProc('HPDF_Font_GetUnderlinePosition');
      @HPDF_Font_GetUnderlineThickness := LoadLibHaruProc('HPDF_Font_GetUnderlineThickness');
      @HPDF_Font_GetXHeight := LoadLibHaruProc('HPDF_Font_GetXHeight');
      @HPDF_Font_GetCapHeight := LoadLibHaruProc('HPDF_Font_GetCapHeight');
      @HPDF_Font_TextWidth := LoadLibHaruProc('HPDF_Font_TextWidth');
      @HPDF_Font_MeasureText := LoadLibHaruProc('HPDF_Font_MeasureText');
      @HPDF_Font_MeasureTextLines := LoadLibHaruProc('HPDF_Font_MeasureTextLines');
      @HPDF_Font_SetTatweelCount := LoadLibHaruProc('HPDF_Font_SetTatweelCount');
      @HPDF_Font_SelectConverters := LoadLibHaruProc('HPDF_Font_SelectConverters');
      @HPDF_Font_SetCharacterEncoding := LoadLibHaruProc('HPDF_Font_SetCharacterEncoding');
      @HPDF_Font_PushConverter := LoadLibHaruProc('HPDF_Font_PushConverter');
      @HPDF_Font_PushBuiltInConverter := LoadLibHaruProc('HPDF_Font_PushBuiltInConverter');
      @HPDF_Font_GetByteType := LoadLibHaruProc('HPDF_Font_GetByteType');
      @HPDF_Font_GetUcs4 := LoadLibHaruProc('HPDF_Font_GetUcs4');
      @HPDF_Font_SetReliefFont := LoadLibHaruProc('HPDF_Font_SetReliefFont');
      @HPDF_AttachFile := LoadLibHaruProc('HPDF_AttachFile');
      @HPDF_CreateExtGState := LoadLibHaruProc('HPDF_CreateExtGState');
      @HPDF_ExtGState_SetAlphaStroke := LoadLibHaruProc('HPDF_ExtGState_SetAlphaStroke');
      @HPDF_ExtGState_SetAlphaFill := LoadLibHaruProc('HPDF_ExtGState_SetAlphaFill');
      @HPDF_ExtGState_SetBlendMode := LoadLibHaruProc('HPDF_ExtGState_SetBlendMode');
      @HPDF_Page_TextWidth := LoadLibHaruProc('HPDF_Page_TextWidth');
      @HPDF_Page_MeasureText := LoadLibHaruProc('HPDF_Page_MeasureText');
      @HPDF_Page_MeasureTextLines := LoadLibHaruProc('HPDF_Page_MeasureTextLines');
      @HPDF_Page_GetWidth := LoadLibHaruProc('HPDF_Page_GetWidth');
      @HPDF_Page_GetHeight := LoadLibHaruProc('HPDF_Page_GetHeight');
      @HPDF_Page_GetGMode := LoadLibHaruProc('HPDF_Page_GetGMode');
      @HPDF_Page_GetCurrentPos2 := LoadLibHaruProc('HPDF_Page_GetCurrentPos2');
      @HPDF_Page_GetCurrentTextPos2 := LoadLibHaruProc('HPDF_Page_GetCurrentTextPos2');
      @HPDF_Page_GetCurrentFont := LoadLibHaruProc('HPDF_Page_GetCurrentFont');
      @HPDF_Page_GetCurrentFontSize := LoadLibHaruProc('HPDF_Page_GetCurrentFontSize');
      @HPDF_Page_GetTransMatrix := LoadLibHaruProc('HPDF_Page_GetTransMatrix');
      @HPDF_Page_GetLineWidth := LoadLibHaruProc('HPDF_Page_GetLineWidth');
      @HPDF_Page_GetLineCap := LoadLibHaruProc('HPDF_Page_GetLineCap');
      @HPDF_Page_GetLineJoin := LoadLibHaruProc('HPDF_Page_GetLineJoin');
      @HPDF_Page_GetMiterLimit := LoadLibHaruProc('HPDF_Page_GetMiterLimit');
      @HPDF_Page_GetDash := LoadLibHaruProc('HPDF_Page_GetDash');
      @HPDF_Page_GetFlat := LoadLibHaruProc('HPDF_Page_GetFlat');
      @HPDF_Page_GetCharSpace := LoadLibHaruProc('HPDF_Page_GetCharSpace');
      @HPDF_Page_GetWordSpace := LoadLibHaruProc('HPDF_Page_GetWordSpace');
      @HPDF_Page_GetHorizontalScalling := LoadLibHaruProc('HPDF_Page_GetHorizontalScalling');
      @HPDF_Page_GetTextLeading := LoadLibHaruProc('HPDF_Page_GetTextLeading');
      @HPDF_Page_GetTextRenderingMode := LoadLibHaruProc('HPDF_Page_GetTextRenderingMode');
      @HPDF_Page_GetTextRise := LoadLibHaruProc('HPDF_Page_GetTextRise');
      @HPDF_Page_GetRGBFill := LoadLibHaruProc('HPDF_Page_GetRGBFill');
      @HPDF_Page_GetRGBStroke := LoadLibHaruProc('HPDF_Page_GetRGBStroke');
      @HPDF_Page_GetCMYKFill := LoadLibHaruProc('HPDF_Page_GetCMYKFill');
      @HPDF_Page_GetCMYKStroke := LoadLibHaruProc('HPDF_Page_GetCMYKStroke');
      @HPDF_Page_GetGrayFill := LoadLibHaruProc('HPDF_Page_GetGrayFill');
      @HPDF_Page_GetGrayStroke := LoadLibHaruProc('HPDF_Page_GetGrayStroke');
      @HPDF_Page_GetStrokingColorSpace := LoadLibHaruProc('HPDF_Page_GetStrokingColorSpace');
      @HPDF_Page_GetFillingColorSpace := LoadLibHaruProc('HPDF_Page_GetFillingColorSpace');
      @HPDF_Page_GetTextMatrix := LoadLibHaruProc('HPDF_Page_GetTextMatrix');
      @HPDF_Page_GetGStateDepth := LoadLibHaruProc('HPDF_Page_GetGStateDepth');
      @HPDF_Page_SetLineWidth := LoadLibHaruProc('HPDF_Page_SetLineWidth');
      @HPDF_Page_SetLineCap := LoadLibHaruProc('HPDF_Page_SetLineCap');
      @HPDF_Page_SetLineJoin := LoadLibHaruProc('HPDF_Page_SetLineJoin');
      @HPDF_Page_SetMiterLimit := LoadLibHaruProc('HPDF_Page_SetMiterLimit');
      @HPDF_Page_SetDash := LoadLibHaruProc('HPDF_Page_SetDash');
      @HPDF_Page_SetFlat := LoadLibHaruProc('HPDF_Page_SetFlat');
      @HPDF_Page_SetExtGState := LoadLibHaruProc('HPDF_Page_SetExtGState');
      @HPDF_Page_GSave := LoadLibHaruProc('HPDF_Page_GSave');
      @HPDF_Page_GRestore := LoadLibHaruProc('HPDF_Page_GRestore');
      @HPDF_Page_Concat := LoadLibHaruProc('HPDF_Page_Concat');
      @HPDF_Page_MoveTo := LoadLibHaruProc('HPDF_Page_MoveTo');
      @HPDF_Page_LineTo := LoadLibHaruProc('HPDF_Page_LineTo');
      @HPDF_Page_CurveTo := LoadLibHaruProc('HPDF_Page_CurveTo');
      @HPDF_Page_CurveTo2 := LoadLibHaruProc('HPDF_Page_CurveTo2');
      @HPDF_Page_CurveTo3 := LoadLibHaruProc('HPDF_Page_CurveTo3');
      @HPDF_Page_ClosePath := LoadLibHaruProc('HPDF_Page_ClosePath');
      @HPDF_Page_Rectangle := LoadLibHaruProc('HPDF_Page_Rectangle');
      @HPDF_Page_Stroke := LoadLibHaruProc('HPDF_Page_Stroke');
      @HPDF_Page_ClosePathStroke := LoadLibHaruProc('HPDF_Page_ClosePathStroke');
      @HPDF_Page_Fill := LoadLibHaruProc('HPDF_Page_Fill');
      @HPDF_Page_Eofill := LoadLibHaruProc('HPDF_Page_Eofill');
      @HPDF_Page_FillStroke := LoadLibHaruProc('HPDF_Page_FillStroke');
      @HPDF_Page_EofillStroke := LoadLibHaruProc('HPDF_Page_EofillStroke');
      @HPDF_Page_ClosePathFillStroke := LoadLibHaruProc('HPDF_Page_ClosePathFillStroke');
      @HPDF_Page_ClosePathEofillStroke := LoadLibHaruProc('HPDF_Page_ClosePathEofillStroke');
      @HPDF_Page_EndPath := LoadLibHaruProc('HPDF_Page_EndPath');
      @HPDF_Page_Clip := LoadLibHaruProc('HPDF_Page_Clip');
      @HPDF_Page_Eoclip := LoadLibHaruProc('HPDF_Page_Eoclip');
      @HPDF_Page_BeginText := LoadLibHaruProc('HPDF_Page_BeginText');
      @HPDF_Page_EndText := LoadLibHaruProc('HPDF_Page_EndText');
      @HPDF_Page_SetCharSpace := LoadLibHaruProc('HPDF_Page_SetCharSpace');
      @HPDF_Page_SetWordSpace := LoadLibHaruProc('HPDF_Page_SetWordSpace');
      @HPDF_Page_SetHorizontalScalling := LoadLibHaruProc('HPDF_Page_SetHorizontalScalling');
      @HPDF_Page_SetTextLeading := LoadLibHaruProc('HPDF_Page_SetTextLeading');
      @HPDF_Page_SetFontAndSize := LoadLibHaruProc('HPDF_Page_SetFontAndSize');
      @HPDF_Page_SetTextRenderingMode := LoadLibHaruProc('HPDF_Page_SetTextRenderingMode');
      @HPDF_Page_SetTextRise := LoadLibHaruProc('HPDF_Page_SetTextRise');
      @HPDF_Page_MoveTextPos := LoadLibHaruProc('HPDF_Page_MoveTextPos');
      @HPDF_Page_MoveTextPos2 := LoadLibHaruProc('HPDF_Page_MoveTextPos2');
      @HPDF_Page_SetTextMatrix := LoadLibHaruProc('HPDF_Page_SetTextMatrix');
      @HPDF_Page_MoveToNextLine := LoadLibHaruProc('HPDF_Page_MoveToNextLine');
      @HPDF_Page_ShowText := LoadLibHaruProc('HPDF_Page_ShowText');
      @HPDF_Page_ShowTextNextLine := LoadLibHaruProc('HPDF_Page_ShowTextNextLine');
      @HPDF_Page_ShowTextNextLineEx := LoadLibHaruProc('HPDF_Page_ShowTextNextLineEx');
      @HPDF_Page_SetGrayFill := LoadLibHaruProc('HPDF_Page_SetGrayFill');
      @HPDF_Page_SetGrayStroke := LoadLibHaruProc('HPDF_Page_SetGrayStroke');
      @HPDF_Page_SetRGBFill := LoadLibHaruProc('HPDF_Page_SetRGBFill');
      @HPDF_Page_SetRGBStroke := LoadLibHaruProc('HPDF_Page_SetRGBStroke');
      @HPDF_Page_SetCMYKFill := LoadLibHaruProc('HPDF_Page_SetCMYKFill');
      @HPDF_Page_SetCMYKStroke := LoadLibHaruProc('HPDF_Page_SetCMYKStroke');
      @HPDF_Page_ExecuteXObject := LoadLibHaruProc('HPDF_Page_ExecuteXObject');
      @HPDF_Page_New_Content_Stream := LoadLibHaruProc('HPDF_Page_New_Content_Stream');
      @HPDF_Page_Insert_Shared_Content_Stream := LoadLibHaruProc('HPDF_Page_Insert_Shared_Content_Stream');
      @HPDF_Page_DrawImage := LoadLibHaruProc('HPDF_Page_DrawImage');
      @HPDF_Page_Circle := LoadLibHaruProc('HPDF_Page_Circle');
      @HPDF_Page_Ellipse := LoadLibHaruProc('HPDF_Page_Ellipse');
      @HPDF_Page_Arc := LoadLibHaruProc('HPDF_Page_Arc');
      @HPDF_Page_TextOut := LoadLibHaruProc('HPDF_Page_TextOut');
      @HPDF_Page_TextRect := LoadLibHaruProc('HPDF_Page_TextRect');
      @HPDF_Page_SetJustifyRatio := LoadLibHaruProc('HPDF_Page_SetJustifyRatio');
      @HPDF_Page_InterlinearAnnotationRatio := LoadLibHaruProc('HPDF_Page_InterlinearAnnotationRatio');
      @HPDF_Page_SetSlideShow := LoadLibHaruProc('HPDF_Page_SetSlideShow');
      @HPDF_ICC_LoadIccFromMem := LoadLibHaruProc('HPDF_ICC_LoadIccFromMem');
      @HPDF_LoadIccProfileFromFile := LoadLibHaruProc('HPDF_LoadIccProfileFromFile');
      @HPDF_Page_WriteComment := LoadLibHaruProc('HPDF_Page_WriteComment');
      @HPDF_PDFA_AppendOutputIntents := LoadLibHaruProc('HPDF_PDFA_AppendOutputIntents');
      @HPDF_PDFA_SetPDFAConformance := LoadLibHaruProc('HPDF_PDFA_SetPDFAConformance');
      @HPDF_CreateJavaScript := LoadLibHaruProc('HPDF_CreateJavaScript');
      @HPDF_LoadJSFromFile := LoadLibHaruProc('HPDF_LoadJSFromFile');
      @HPDF_Create3DView := LoadLibHaruProc('HPDF_Create3DView');
      @HPDF_GetU3DMMgr := LoadLibHaruProc('HPDF_GetU3DMMgr');
      @HPDF_U3D_Add3DView := LoadLibHaruProc('HPDF_U3D_Add3DView');
      @HPDF_U3D_SetDefault3DView := LoadLibHaruProc('HPDF_U3D_SetDefault3DView');
      @HPDF_U3D_AddOnInstantiate := LoadLibHaruProc('HPDF_U3D_AddOnInstantiate');
      @HPDF_3DView_CreateNode := LoadLibHaruProc('HPDF_3DView_CreateNode');
      @HPDF_3DViewNode_SetOpacity := LoadLibHaruProc('HPDF_3DViewNode_SetOpacity');
      @HPDF_3DViewNode_SetVisibility := LoadLibHaruProc('HPDF_3DViewNode_SetVisibility');
      @HPDF_3DViewNode_SetMatrix := LoadLibHaruProc('HPDF_3DViewNode_SetMatrix');
      @HPDF_3DView_AddNode := LoadLibHaruProc('HPDF_3DView_AddNode');
      @HPDF_3DView_SetLighting := LoadLibHaruProc('HPDF_3DView_SetLighting');
      @HPDF_3DView_SetBackgroundColor := LoadLibHaruProc('HPDF_3DView_SetBackgroundColor');
      @HPDF_3DView_SetPerspectiveProjection := LoadLibHaruProc('HPDF_3DView_SetPerspectiveProjection');
      @HPDF_3DView_SetOrthogonalProjection := LoadLibHaruProc('HPDF_3DView_SetOrthogonalProjection');
      @HPDF_3DView_SetCamera := LoadLibHaruProc('HPDF_3DView_SetCamera');
      @HPDF_3DView_SetCameraByMatrix := LoadLibHaruProc('HPDF_3DView_SetCameraByMatrix');
      @HPDF_3DView_SetCrossSectionOn := LoadLibHaruProc('HPDF_3DView_SetCrossSectionOn');
      @HPDF_3DView_SetCrossSectionOff := LoadLibHaruProc('HPDF_3DView_SetCrossSectionOff');

      Result := Assigned(HPDF_GetVersion) and
                Assigned(HPDF_NewEx) and
                Assigned(HPDF_New) and
                Assigned(HPDF_SetErrorHandler) and
                Assigned(HPDF_Free) and
                Assigned(HPDF_NewDoc) and
                Assigned(HPDF_FreeDoc) and
                Assigned(HPDF_HasDoc) and
                Assigned(HPDF_FreeDocAll) and
                Assigned(HPDF_LimitVersion) and
                Assigned(HPDF_SaveToStream) and
                Assigned(HPDF_GetContents) and
                Assigned(HPDF_GetStreamSize) and
                Assigned(HPDF_ReadFromStream) and
                Assigned(HPDF_ResetStream) and
                Assigned(HPDF_SaveToFile) and
                Assigned(HPDF_GetError) and
                Assigned(HPDF_GetErrorDetail) and
                Assigned(HPDF_ResetError) and
                Assigned(HPDF_CheckError) and
                Assigned(HPDF_SetPagesConfiguration) and
                Assigned(HPDF_GetPageByIndex) and
                Assigned(HPDF_GetPageMMgr) and
                Assigned(HPDF_GetPageLayout) and
                Assigned(HPDF_SetPageLayout) and
                Assigned(HPDF_GetPageMode) and
                Assigned(HPDF_SetPageMode) and
                Assigned(HPDF_GetViewerPreference) and
                Assigned(HPDF_SetViewerPreference) and
                Assigned(HPDF_SetOpenAction) and
                Assigned(HPDF_GetCurrentPage) and
                Assigned(HPDF_AddPage) and
                Assigned(HPDF_InsertPage) and
                Assigned(HPDF_Page_SetWidth) and
                Assigned(HPDF_Page_SetHeight) and
                Assigned(HPDF_Page_SetBoundary) and
                Assigned(HPDF_Page_SetSize) and
                Assigned(HPDF_Page_SetRotate) and
                Assigned(HPDF_Page_SetZoom) and
                Assigned(HPDF_GetFont) and
                Assigned(HPDF_LoadType1FontFromFile) and
                Assigned(HPDF_GetTTFontDefFromFile) and
                Assigned(HPDF_LoadTTFontFromFile) and
                Assigned(HPDF_LoadTTFontFromFile2) and
                Assigned(HPDF_AddPageLabel) and
                Assigned(HPDF_UseJPFonts) and
                Assigned(HPDF_UseKRFonts) and
                Assigned(HPDF_UseCNSFonts) and
                Assigned(HPDF_UseCNTFonts) and
                Assigned(HPDF_CreateOutline) and
                Assigned(HPDF_Outline_SetOpened) and
                Assigned(HPDF_Outline_SetDestination) and
                Assigned(HPDF_Page_CreateDestination) and
                Assigned(HPDF_Destination_SetXYZ) and
                Assigned(HPDF_Destination_SetFit) and
                Assigned(HPDF_Destination_SetFitH) and
                Assigned(HPDF_Destination_SetFitV) and
                Assigned(HPDF_Destination_SetFitR) and
                Assigned(HPDF_Destination_SetFitB) and
                Assigned(HPDF_Destination_SetFitBH) and
                Assigned(HPDF_Destination_SetFitBV) and
                Assigned(HPDF_GetEncoder) and
                Assigned(HPDF_GetCurrentEncoder) and
                Assigned(HPDF_SetCurrentEncoder) and
                Assigned(HPDF_Encoder_GetType) and
                Assigned(HPDF_Encoder_GetByteType) and
                Assigned(HPDF_Encoder_GetUnicode) and
                Assigned(HPDF_Encoder_GetUcs4) and
                Assigned(HPDF_Encoder_GetWritingMode) and
                Assigned(HPDF_UseJPEncodings) and
                Assigned(HPDF_UseKREncodings) and
                Assigned(HPDF_UseCNSEncodings) and
                Assigned(HPDF_UseCNTEncodings) and
                Assigned(HPDF_UseUTFEncodings) and
                Assigned(HPDF_GetUTFEncoder) and
                Assigned(HPDF_Page_CreateXObjectFromImage) and
                Assigned(HPDF_Page_CreateXObjectAsWhiteRect) and
                Assigned(HPDF_Page_Create3DAnnot) and
                Assigned(HPDF_Page_CreateTextAnnot) and
                Assigned(HPDF_Page_CreateFreeTextAnnot) and
                Assigned(HPDF_Page_CreateLineAnnot) and
                Assigned(HPDF_Page_CreateWidgetAnnot_WhiteOnlyWhilePrint) and
                Assigned(HPDF_Page_CreateWidgetAnnot) and
                Assigned(HPDF_Page_CreateLinkAnnot) and
                Assigned(HPDF_Page_CreateURILinkAnnot) and
                Assigned(HPDF_Page_CreateHighlightAnnot) and
                Assigned(HPDF_Page_CreateUnderlineAnnot) and
                Assigned(HPDF_Page_CreateSquigglyAnnot) and
                Assigned(HPDF_Page_CreateStrikeOutAnnot) and
                Assigned(HPDF_Page_CreatePopupAnnot) and
                Assigned(HPDF_Page_CreateStampAnnot) and
                Assigned(HPDF_Page_CreateProjectionAnnot) and
                Assigned(HPDF_Page_CreateSquareAnnot) and
                Assigned(HPDF_Page_CreateCircleAnnot) and
                Assigned(HPDF_LinkAnnot_SetHighlightMode) and
                Assigned(HPDF_LinkAnnot_SetJavaScript) and
                Assigned(HPDF_LinkAnnot_SetBorderStyle) and
                Assigned(HPDF_TextAnnot_SetIcon) and
                Assigned(HPDF_TextAnnot_SetOpened) and
                Assigned(HPDF_Annot_SetRGBColor) and
                Assigned(HPDF_Annot_SetCMYKColor) and
                Assigned(HPDF_Annot_SetGrayColor) and
                Assigned(HPDF_Annot_SetNoColor) and
                Assigned(HPDF_MarkupAnnot_SetTitle) and
                Assigned(HPDF_MarkupAnnot_SetSubject) and
                Assigned(HPDF_MarkupAnnot_SetCreationDate) and
                Assigned(HPDF_MarkupAnnot_SetTransparency) and
                Assigned(HPDF_MarkupAnnot_SetIntent) and
                Assigned(HPDF_MarkupAnnot_SetPopup) and
                Assigned(HPDF_MarkupAnnot_SetRectDiff) and
                Assigned(HPDF_MarkupAnnot_SetCloudEffect) and
                Assigned(HPDF_MarkupAnnot_SetInteriorRGBColor) and
                Assigned(HPDF_MarkupAnnot_SetInteriorCMYKColor) and
                Assigned(HPDF_MarkupAnnot_SetInteriorGrayColor) and
                Assigned(HPDF_MarkupAnnot_SetInteriorTransparent) and
                Assigned(HPDF_TextMarkupAnnot_SetQuadPoints) and
                Assigned(HPDF_Annot_Set3DView) and
                Assigned(HPDF_PopupAnnot_SetOpened) and
                Assigned(HPDF_FreeTextAnnot_SetLineEndingStyle) and
                Assigned(HPDF_FreeTextAnnot_Set3PointCalloutLine) and
                Assigned(HPDF_FreeTextAnnot_Set2PointCalloutLine) and
                Assigned(HPDF_FreeTextAnnot_SetDefaultStyle) and
                Assigned(HPDF_LineAnnot_SetPosition) and
                Assigned(HPDF_LineAnnot_SetLeader) and
                Assigned(HPDF_LineAnnot_SetCaption) and
                Assigned(HPDF_Annotation_SetBorderStyle) and
                Assigned(HPDF_ProjectionAnnot_SetExData) and
                Assigned(HPDF_Page_Create3DC3DMeasure) and
                Assigned(HPDF_Page_CreatePD33DMeasure) and
                Assigned(HPDF_3DMeasure_SetName) and
                Assigned(HPDF_3DMeasure_SetColor) and
                Assigned(HPDF_3DMeasure_SetTextSize) and
                Assigned(HPDF_3DC3DMeasure_SetTextBoxSize) and
                Assigned(HPDF_3DC3DMeasure_SetText) and
                Assigned(HPDF_3DC3DMeasure_SetProjectionAnotation) and
                Assigned(HPDF_Page_Create3DAnnotExData) and
                Assigned(HPDF_3DAnnotExData_Set3DMeasurement) and
                Assigned(HPDF_Page_Create3DView) and
                Assigned(HPDF_3DView_Add3DC3DMeasure) and
                Assigned(HPDF_LoadPngImageFromMem) and
                Assigned(HPDF_LoadPngImageFromFile) and
                Assigned(HPDF_LoadPngImageFromFile2) and
                Assigned(HPDF_LoadJpegImageFromFile) and
                Assigned(HPDF_LoadJpegImageFromMem) and
                Assigned(HPDF_LoadU3DFromFile) and
                Assigned(HPDF_LoadU3DFromMem) and
                Assigned(HPDF_Image_LoadRaw1BitImageFromMem) and
                Assigned(HPDF_LoadRawImageFromFile) and
                Assigned(HPDF_LoadRawImageFromMem) and
                Assigned(HPDF_Image_AddSMask) and
                Assigned(HPDF_Image_GetSize2) and
                Assigned(HPDF_Image_GetWidth) and
                Assigned(HPDF_Image_GetHeight) and
                Assigned(HPDF_Image_GetBitsPerComponent) and
                Assigned(HPDF_Image_GetColorSpace) and
                Assigned(HPDF_Image_SetColorMask) and
                Assigned(HPDF_Image_SetMaskImage) and
                Assigned(HPDF_SetInfoAttr) and
                Assigned(HPDF_GetInfoAttr) and
                Assigned(HPDF_SetInfoDateAttr) and
                Assigned(HPDF_SetPassword) and
                Assigned(HPDF_SetPermission) and
                Assigned(HPDF_SetEncryptionMode) and
                Assigned(HPDF_SetCompressionMode) and
                Assigned(HPDF_Font_GetFontName) and
                Assigned(HPDF_Font_GetEncodingName) and
                Assigned(HPDF_Font_GetUnicodeWidth) and
                Assigned(HPDF_Font_GetUcs4Width) and
                Assigned(HPDF_Font_GetCharWidth) and
                Assigned(HPDF_Font_GetBBox) and
                Assigned(HPDF_Font_GetAscent) and
                Assigned(HPDF_Font_GetDescent) and
                Assigned(HPDF_Font_GetLeading) and
                Assigned(HPDF_Font_GetUnderlinePosition) and
                Assigned(HPDF_Font_GetUnderlineThickness) and
                Assigned(HPDF_Font_GetXHeight) and
                Assigned(HPDF_Font_GetCapHeight) and
                Assigned(HPDF_Font_TextWidth) and
                Assigned(HPDF_Font_MeasureText) and
                Assigned(HPDF_Font_MeasureTextLines) and
                Assigned(HPDF_Font_SetTatweelCount) and
                Assigned(HPDF_Font_SelectConverters) and
                Assigned(HPDF_Font_SetCharacterEncoding) and
                Assigned(HPDF_Font_PushConverter) and
                Assigned(HPDF_Font_PushBuiltInConverter) and
                Assigned(HPDF_Font_GetByteType) and
                Assigned(HPDF_Font_GetUcs4) and
                Assigned(HPDF_Font_SetReliefFont) and
                Assigned(HPDF_AttachFile) and
                Assigned(HPDF_CreateExtGState) and
                Assigned(HPDF_ExtGState_SetAlphaStroke) and
                Assigned(HPDF_ExtGState_SetAlphaFill) and
                Assigned(HPDF_ExtGState_SetBlendMode) and
                Assigned(HPDF_Page_TextWidth) and
                Assigned(HPDF_Page_MeasureText) and
                Assigned(HPDF_Page_MeasureTextLines) and
                Assigned(HPDF_Page_GetWidth) and
                Assigned(HPDF_Page_GetHeight) and
                Assigned(HPDF_Page_GetGMode) and
                Assigned(HPDF_Page_GetCurrentPos2) and
                Assigned(HPDF_Page_GetCurrentTextPos2) and
                Assigned(HPDF_Page_GetCurrentFont) and
                Assigned(HPDF_Page_GetCurrentFontSize) and
                Assigned(HPDF_Page_GetTransMatrix) and
                Assigned(HPDF_Page_GetLineWidth) and
                Assigned(HPDF_Page_GetLineCap) and
                Assigned(HPDF_Page_GetLineJoin) and
                Assigned(HPDF_Page_GetMiterLimit) and
                Assigned(HPDF_Page_GetDash) and
                Assigned(HPDF_Page_GetFlat) and
                Assigned(HPDF_Page_GetCharSpace) and
                Assigned(HPDF_Page_GetWordSpace) and
                Assigned(HPDF_Page_GetHorizontalScalling) and
                Assigned(HPDF_Page_GetTextLeading) and
                Assigned(HPDF_Page_GetTextRenderingMode) and
                Assigned(HPDF_Page_GetTextRise) and
                Assigned(HPDF_Page_GetRGBFill) and
                Assigned(HPDF_Page_GetRGBStroke) and
                Assigned(HPDF_Page_GetCMYKFill) and
                Assigned(HPDF_Page_GetCMYKStroke) and
                Assigned(HPDF_Page_GetGrayFill) and
                Assigned(HPDF_Page_GetGrayStroke) and
                Assigned(HPDF_Page_GetStrokingColorSpace) and
                Assigned(HPDF_Page_GetFillingColorSpace) and
                Assigned(HPDF_Page_GetTextMatrix) and
                Assigned(HPDF_Page_GetGStateDepth) and
                Assigned(HPDF_Page_SetLineWidth) and
                Assigned(HPDF_Page_SetLineCap) and
                Assigned(HPDF_Page_SetLineJoin) and
                Assigned(HPDF_Page_SetMiterLimit) and
                Assigned(HPDF_Page_SetDash) and
                Assigned(HPDF_Page_SetFlat) and
                Assigned(HPDF_Page_SetExtGState) and
                Assigned(HPDF_Page_GSave) and
                Assigned(HPDF_Page_GRestore) and
                Assigned(HPDF_Page_Concat) and
                Assigned(HPDF_Page_MoveTo) and
                Assigned(HPDF_Page_LineTo) and
                Assigned(HPDF_Page_CurveTo) and
                Assigned(HPDF_Page_CurveTo2) and
                Assigned(HPDF_Page_CurveTo3) and
                Assigned(HPDF_Page_ClosePath) and
                Assigned(HPDF_Page_Rectangle) and
                Assigned(HPDF_Page_Stroke) and
                Assigned(HPDF_Page_ClosePathStroke) and
                Assigned(HPDF_Page_Fill) and
                Assigned(HPDF_Page_Eofill) and
                Assigned(HPDF_Page_FillStroke) and
                Assigned(HPDF_Page_EofillStroke) and
                Assigned(HPDF_Page_ClosePathFillStroke) and
                Assigned(HPDF_Page_ClosePathEofillStroke) and
                Assigned(HPDF_Page_EndPath) and
                Assigned(HPDF_Page_Clip) and
                Assigned(HPDF_Page_Eoclip) and
                Assigned(HPDF_Page_BeginText) and
                Assigned(HPDF_Page_EndText) and
                Assigned(HPDF_Page_SetCharSpace) and
                Assigned(HPDF_Page_SetWordSpace) and
                Assigned(HPDF_Page_SetHorizontalScalling) and
                Assigned(HPDF_Page_SetTextLeading) and
                Assigned(HPDF_Page_SetFontAndSize) and
                Assigned(HPDF_Page_SetTextRenderingMode) and
                Assigned(HPDF_Page_SetTextRise) and
                Assigned(HPDF_Page_MoveTextPos) and
                Assigned(HPDF_Page_MoveTextPos2) and
                Assigned(HPDF_Page_SetTextMatrix) and
                Assigned(HPDF_Page_MoveToNextLine) and
                Assigned(HPDF_Page_ShowText) and
                Assigned(HPDF_Page_ShowTextNextLine) and
                Assigned(HPDF_Page_ShowTextNextLineEx) and
                Assigned(HPDF_Page_SetGrayFill) and
                Assigned(HPDF_Page_SetGrayStroke) and
                Assigned(HPDF_Page_SetRGBFill) and
                Assigned(HPDF_Page_SetRGBStroke) and
                Assigned(HPDF_Page_SetCMYKFill) and
                Assigned(HPDF_Page_SetCMYKStroke) and
                Assigned(HPDF_Page_ExecuteXObject) and
                Assigned(HPDF_Page_New_Content_Stream) and
                Assigned(HPDF_Page_Insert_Shared_Content_Stream) and
                Assigned(HPDF_Page_DrawImage) and
                Assigned(HPDF_Page_Circle) and
                Assigned(HPDF_Page_Ellipse) and
                Assigned(HPDF_Page_Arc) and
                Assigned(HPDF_Page_TextOut) and
                Assigned(HPDF_Page_TextRect) and
                Assigned(HPDF_Page_SetJustifyRatio) and
                Assigned(HPDF_Page_InterlinearAnnotationRatio) and
                Assigned(HPDF_Page_SetSlideShow) and
                Assigned(HPDF_ICC_LoadIccFromMem) and
                Assigned(HPDF_LoadIccProfileFromFile) and
                Assigned(HPDF_Page_WriteComment) and
                Assigned(HPDF_PDFA_AppendOutputIntents) and
                Assigned(HPDF_PDFA_SetPDFAConformance) and
                Assigned(HPDF_CreateJavaScript) and
                Assigned(HPDF_LoadJSFromFile) and
                Assigned(HPDF_Create3DView) and
                Assigned(HPDF_GetU3DMMgr) and
                Assigned(HPDF_U3D_Add3DView) and
                Assigned(HPDF_U3D_SetDefault3DView) and
                Assigned(HPDF_U3D_AddOnInstantiate) and
                Assigned(HPDF_3DView_CreateNode) and
                Assigned(HPDF_3DViewNode_SetOpacity) and
                Assigned(HPDF_3DViewNode_SetVisibility) and
                Assigned(HPDF_3DViewNode_SetMatrix) and
                Assigned(HPDF_3DView_AddNode) and
                Assigned(HPDF_3DView_SetLighting) and
                Assigned(HPDF_3DView_SetBackgroundColor) and
                Assigned(HPDF_3DView_SetPerspectiveProjection) and
                Assigned(HPDF_3DView_SetOrthogonalProjection) and
                Assigned(HPDF_3DView_SetCamera) and
                Assigned(HPDF_3DView_SetCameraByMatrix) and
                Assigned(HPDF_3DView_SetCrossSectionOn) and
                Assigned(HPDF_3DView_SetCrossSectionOff);

      if not Result then
        FreeHaruLib;
    end;
  end;
end;

function HPDF_Page_GetCurrentPos (page: HPDF_Page): THPDF_Point;
var
  pos: THPDF_Point;
begin
  HPDF_Page_GetCurrentPos2 (page, @pos);
  result := pos;
end;

function HPDF_Page_GetCurrentTextPos (page: HPDF_Page): THPDF_Point;
var
  pos: THPDF_Point;
begin
  HPDF_Page_GetCurrentTextPos2 (page, @pos);
  result := pos;
end;

function HPDF_Image_GetSize (image: HPDF_Image): THPDF_Point;
var
  size: THPDF_Point;
begin
  HPDF_Image_GetSize2 (image, @size);
  result := size;
end;

initialization
  if not InitHaruLib then
    raise Exception.Create('Couldn''t load ' + LIBHPDF_DLL);

finalization
  FreeHaruLib;

end.

