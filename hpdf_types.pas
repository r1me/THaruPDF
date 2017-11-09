{*
 * << Haru Free PDF Library >> -- hpdf_types.pas
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

unit hpdf_types;

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}

interface

uses
  SysUtils;

type
{$Z+}
{*----------------------------------------------------------------------------*}
{*----- type definition ------------------------------------------------------*}


{*  native OS integer types *}
  HPDF_INT = Integer;
  HPDF_PINT = ^HPDF_INT;
  HPDF_UINT = Cardinal;
  HPDF_PUINT = ^Cardinal;


{*  32bit integer types
 *}
  HPDF_INT32 = Longint;
  HPDF_UINT32 = Longword;
  HPDF_PUINT32 = ^Longword;


{*  16bit integer types
 *}
  HPDF_INT16 = SmallInt;
  HPDF_UINT16 = Word;
  HPDF_PUINT16 = ^Word;


{*  8bit integer types
 *}
  HPDF_INT8 = Shortint;
  HPDF_PINT8 = ^HPDF_INT8;
  HPDF_UINT8 = Byte;
  HPDF_PUINT8 = ^HPDF_UINT8;


{*  8bit binary types
 *}
  HPDF_BYTE = Byte;
  HPDF_PBYTE = ^Byte;


{*  8bit charactor types
 *}
{$IFDEF FPC}
  UTF8Char = AnsiChar;
{$ENDIF}
  HPDF_CHAR = UTF8Char;


{*  null terminated character *}
{$IFDEF FPC}
  PUTF8Char = PAnsiChar;
{$ENDIF}
  HPDF_PCHAR = PUTF8Char;


{*  float type (32bit IEEE754)
 *}
  HPDF_REAL = Single;
  HPDF_PREAL = ^HPDF_REAL;


{*  double type (64bit IEEE754)
 *}
  HPDF_DOUBLE = Double;


{*  boolean type (0: False, 1: True)
 *}
  HPDF_BOOL = Integer;


{*  error-no type (32bit unsigned integer)
 *}
  HPDF_STATUS = Cardinal;


{*  charactor-code type (16bit)
 *}
  HPDF_CID = HPDF_UINT16;
  HPDF_UNICODE = HPDF_UINT16;


{*  charactor-code type (32bit)
 *}
  HPDF_UCS4 = HPDF_UINT32;
  HPDF_CODE = HPDF_UINT32;


{*  HPDF_Point struct
 *}
  THPDF_Point = record
    x: HPDF_REAL;
    y: HPDF_REAL;
  end;
  PHPDF_Point = ^THPDF_Point;

  THPDF_Rect = record
    left: HPDF_REAL;
    bottom: HPDF_REAL;
    right: HPDF_REAL;
    top: HPDF_REAL;
  end;

{*  HPDF_Point3D struct
 *}
  THPDF_Point3D = record
    x: HPDF_REAL;
    y: HPDF_REAL;
    z: HPDF_REAL;
  end;

  THPDF_Box = THPDF_Rect;

{* HPDF_Date struct
 *}
  THPDF_Date = record
    year: HPDF_INT;
    month: HPDF_INT;
    day: HPDF_INT;
    hour: HPDF_INT;
    minutes: HPDF_INT;
    seconds: HPDF_INT;
    ind: HPDF_CHAR;
    off_hour: HPDF_INT;
    off_minutes: HPDF_INT;
  end;


  THPDF_InfoType = (
    HPDF_INFO_CREATION_DATE,
    HPDF_INFO_MOD_DATE,
    HPDF_INFO_AUTHOR,
    HPDF_INFO_CREATOR,
    HPDF_INFO_PRODUCER,
    HPDF_INFO_TITLE,
    HPDF_INFO_SUBJECT,
    HPDF_INFO_KEYWORDS,
    HPDF_INFO_TRAPPED,
    HPDF_INFO_GTS_PDFX,
    HPDF_INFO_EOF
  );

{* PDF-A Types *}

  THPDF_PDFA_TYPE = (
    HPDF_PDFA_1A = 0,
    HPDF_PDFA_1B = 1
  );

  THPDF_PdfVer = (
    HPDF_VER_12 = 0,
    HPDF_VER_13,
    HPDF_VER_14,
    HPDF_VER_15,
    HPDF_VER_16,
    HPDF_VER_17,
    HPDF_VER_EOF
  );

  THPDF_EncryptMode = (
    HPDF_ENCRYPT_R2 = 2,
    HPDF_ENCRYPT_R3 = 3
  );


THPDF_Error_Handler = procedure (error_no: HPDF_STATUS; detail_no: HPDF_STATUS;
                user_data: Pointer); {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};

THPDF_Alloc_Func = procedure (size: HPDF_UINT); {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


THPDF_Free_Func = procedure (aptr: Pointer); {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


{*---------------------------------------------------------------------------*}
{*------ text width struct --------------------------------------------------*}

  THPDF_TextWidth = record
    numchars: HPDF_UINT;
    numwords: HPDF_UINT;   {* don't use this value. *}
    width: HPDF_UINT;
    numspace: HPDF_UINT;
  end;


  THPDF_TextLineWidth = record
    flags: HPDF_UINT16;
    linebytes: HPDF_UINT16;
    numbytes: HPDF_UINT16;
    numchars: HPDF_UINT16;
    numspaces: HPDF_UINT16;
    numtatweels: HPDF_UINT16;
    charswidth: HPDF_UINT;
    width: HPDF_REAL;
  end;


{*---------------------------------------------------------------------------*}
{*------ dash mode ----------------------------------------------------------*}

  THPDF_DashMode = record
    ptn: array[0..7] of HPDF_REAL;
    num_ptn: HPDF_UINT16;
    phase: HPDF_REAL;
  end;


{*---------------------------------------------------------------------------*}
{*----- HPDF_TransMatrix struct ---------------------------------------------*}

  THPDF_TransMatrix = record
    a: HPDF_REAL;
    b: HPDF_REAL;
    c: HPDF_REAL;
    d: HPDF_REAL;
    x: HPDF_REAL;
    y: HPDF_REAL;
    constructor Create(Aa, Ab, Ac, Ad, Ax, Ay: HPDF_REAL);
  end;

{*---------------------------------------------------------------------------*}
{*----- HPDF_3DMatrix struct ------------------------------------------------*}

  THPDF_3DMatrix = record
    a: HPDF_REAL;
    b: HPDF_REAL;
    c: HPDF_REAL;
    d: HPDF_REAL;
    e: HPDF_REAL;
    f: HPDF_REAL;
    g: HPDF_REAL;
    h: HPDF_REAL;
    i: HPDF_REAL;
    tx: HPDF_REAL;
    ty: HPDF_REAL;
    tz: HPDF_REAL;
  end;

{*---------------------------------------------------------------------------*}

  THPDF_ColorSpace = (
    HPDF_CS_DEVICE_GRAY,
    HPDF_CS_DEVICE_RGB,
    HPDF_CS_DEVICE_CMYK,
    HPDF_CS_CAL_GRAY,
    HPDF_CS_CAL_RGB,
    HPDF_CS_LAB,
    HPDF_CS_ICC_BASED,
    HPDF_CS_SEPARATION,
    HPDF_CS_DEVICE_N,
    HPDF_CS_INDEXED,
    HPDF_CS_PATTERN,
    HPDF_CS_EOF
  );

{*---------------------------------------------------------------------------*}
{*----- HPDF_RGBColor struct ------------------------------------------------*}

  THPDF_RGBColor = record
    r: HPDF_REAL;
    g: HPDF_REAL;
    b: HPDF_REAL;
    constructor Create(Ar, Ag, Ab: HPDF_REAL);
  end;

{*---------------------------------------------------------------------------*}
{*----- HPDF_CMYKColor struct -----------------------------------------------*}

  THPDF_CMYKColor = record
    c: HPDF_REAL;
    m: HPDF_REAL;
    y: HPDF_REAL;
    k: HPDF_REAL;
    constructor Create(Ac, Am, Ay, Ak: HPDF_REAL);
  end;

{*---------------------------------------------------------------------------*}
{*------ The line cap style -------------------------------------------------*}

  THPDF_LineCap = (
    HPDF_BUTT_END,
    HPDF_ROUND_END,
    HPDF_PROJECTING_SQUARE_END,
    HPDF_LINECAP_EOF
  );

{*----------------------------------------------------------------------------*}
{*------ The line join style -------------------------------------------------*}

  THPDF_LineJoin = (
    HPDF_MITER_JOIN,
    HPDF_ROUND_JOIN,
    HPDF_BEVEL_JOIN
  );

{*----------------------------------------------------------------------------*}
{*------ The text rendering mode ---------------------------------------------*}

  THPDF_TextRenderingMode = (
    HPDF_FILL,
    HPDF_STROKE,
    HPDF_FILL_THEN_STROKE,
    HPDF_INVISIBLE,
    HPDF_FILL_CLIPPING,
    HPDF_STROKE_CLIPPING,
    HPDF_FILL_STROKE_CLIPPING,
    HPDF_CLIPPING,
    HPDF_RENDERING_MODE_EOF
  );


  THPDF_WritingMode = (
    HPDF_WMODE_HORIZONTAL,
    HPDF_WMODE_VERTICAL,
    HPDF_WMODE_SIDEWAYS,        {* gstate only *}
    HPDF_WMODE_MIXED,           {* gstate only *}
    HPDF_WMODE_EOF
  );


  THPDF_PageLayout = (
    HPDF_PAGE_LAYOUT_SINGLE,
    HPDF_PAGE_LAYOUT_ONE_COLUMN,
    HPDF_PAGE_LAYOUT_TWO_COLUMN_LEFT,
    HPDF_PAGE_LAYOUT_TWO_COLUMN_RIGHT,
    HPDF_PAGE_LAYOUT_TWO_PAGE_LEFT,
    HPDF_PAGE_LAYOUT_TWO_PAGE_RIGHT,
    HPDF_PAGE_LAYOUT_EOF
  );


  THPDF_PageMode = (
    HPDF_PAGE_MODE_USE_NONE,
    HPDF_PAGE_MODE_USE_OUTLINE,
    HPDF_PAGE_MODE_USE_THUMBS,
    HPDF_PAGE_MODE_FULL_SCREEN,
{*  HPDF_PAGE_MODE_USE_OC,
    HPDF_PAGE_MODE_USE_ATTACHMENTS
 *}
    HPDF_PAGE_MODE_EOF
  );


  THPDF_PageNumStyle = (
    HPDF_PAGE_NUM_STYLE_DECIMAL,
    HPDF_PAGE_NUM_STYLE_UPPER_ROMAN,
    HPDF_PAGE_NUM_STYLE_LOWER_ROMAN,
    HPDF_PAGE_NUM_STYLE_UPPER_LETTERS,
    HPDF_PAGE_NUM_STYLE_LOWER_LETTERS,
    HPDF_PAGE_NUM_STYLE_EOF
  );


  THPDF_DestinationType = (
    HPDF_XYZ,
    HPDF_FIT,
    HPDF_FIT_H,
    HPDF_FIT_V,
    HPDF_FIT_R,
    HPDF_FIT_B,
    HPDF_FIT_BH,
    HPDF_FIT_BV,
    HPDF_DST_EOF
  );


  THPDF_AnnotType = (
    HPDF_ANNOT_TEXT_NOTES,
    HPDF_ANNOT_LINK,
    HPDF_ANNOT_SOUND,
    HPDF_ANNOT_FREE_TEXT,
    HPDF_ANNOT_STAMP,
    HPDF_ANNOT_SQUARE,
    HPDF_ANNOT_CIRCLE,
    HPDF_ANNOT_STRIKE_OUT,
    HPDF_ANNOT_HIGHTLIGHT,
    HPDF_ANNOT_UNDERLINE,
    HPDF_ANNOT_INK,
    HPDF_ANNOT_FILE_ATTACHMENT,
    HPDF_ANNOT_POPUP,
    HPDF_ANNOT_3D,
    HPDF_ANNOT_SQUIGGLY,
    HPDF_ANNOT_LINE,
    HPDF_ANNOT_PROJECTION,
    HPDF_ANNOT_WIDGET
  );


  THPDF_AnnotFlgs = (
    HPDF_ANNOT_INVISIBLE,
    HPDF_ANNOT_HIDDEN,
    HPDF_ANNOT_PRINT,
    HPDF_ANNOT_NOZOOM,
    HPDF_ANNOT_NOROTATE,
    HPDF_ANNOT_NOVIEW,
    HPDF_ANNOT_READONLY
  );


  THPDF_AnnotHighlightMode = (
    HPDF_ANNOT_NO_HIGHLIGHT,
    HPDF_ANNOT_INVERT_BOX,
    HPDF_ANNOT_INVERT_BORDER,
    HPDF_ANNOT_DOWN_APPEARANCE,
    HPDF_ANNOT_HIGHTLIGHT_MODE_EOF
  );


  THPDF_AnnotIcon = (
    HPDF_ANNOT_ICON_COMMENT,
    HPDF_ANNOT_ICON_KEY,
    HPDF_ANNOT_ICON_NOTE,
    HPDF_ANNOT_ICON_HELP,
    HPDF_ANNOT_ICON_NEW_PARAGRAPH,
    HPDF_ANNOT_ICON_PARAGRAPH,
    HPDF_ANNOT_ICON_INSERT,
    HPDF_ANNOT_ICON_EOF
  );

  THPDF_AnnotIntent = (
    HPDF_ANNOT_INTENT_FREETEXTCALLOUT,
    HPDF_ANNOT_INTENT_FREETEXTTYPEWRITER,
    HPDF_ANNOT_INTENT_LINEARROW,
    HPDF_ANNOT_INTENT_LINEDIMENSION,
    HPDF_ANNOT_INTENT_POLYGONCLOUD,
    HPDF_ANNOT_INTENT_POLYLINEDIMENSION,
    HPDF_ANNOT_INTENT_POLYGONDIMENSION
  );

  THPDF_LineAnnotEndingStyle = (
    HPDF_LINE_ANNOT_NONE,
    HPDF_LINE_ANNOT_SQUARE,
    HPDF_LINE_ANNOT_CIRCLE,
    HPDF_LINE_ANNOT_DIAMOND,
    HPDF_LINE_ANNOT_OPENARROW,
    HPDF_LINE_ANNOT_CLOSEDARROW,
    HPDF_LINE_ANNOT_BUTT,
    HPDF_LINE_ANNOT_ROPENARROW,
    HPDF_LINE_ANNOT_RCLOSEDARROW,
    HPDF_LINE_ANNOT_SLASH
  );

  THPDF_LineAnnotCapPosition = (
    HPDF_LINE_ANNOT_CAP_INLINE,
    HPDF_LINE_ANNOT_CAP_TOP
  );

  THPDF_StampAnnotName = (
    HPDF_STAMP_ANNOT_APPROVED,
    HPDF_STAMP_ANNOT_EXPERIMENTAL,
    HPDF_STAMP_ANNOT_NOTAPPROVED,
    HPDF_STAMP_ANNOT_ASIS,
    HPDF_STAMP_ANNOT_EXPIRED,
    HPDF_STAMP_ANNOT_NOTFORPUBLICRELEASE,
    HPDF_STAMP_ANNOT_CONFIDENTIAL,
    HPDF_STAMP_ANNOT_FINAL,
    HPDF_STAMP_ANNOT_SOLD,
    HPDF_STAMP_ANNOT_DEPARTMENTAL,
    HPDF_STAMP_ANNOT_FORCOMMENT,
    HPDF_STAMP_ANNOT_TOPSECRET,
    HPDF_STAMP_ANNOT_DRAFT,
    HPDF_STAMP_ANNOT_FORPUBLICRELEASE
  );

{*----------------------------------------------------------------------------*}
{*------ border stype --------------------------------------------------------*}

  THPDF_BSSubtype = (
    HPDF_BS_SOLID,
    HPDF_BS_DASHED,
    HPDF_BS_BEVELED,
    HPDF_BS_INSET,
    HPDF_BS_UNDERLINED
  );


{*----- blend modes ----------------------------------------------------------*}

  THPDF_BlendMode = (
    HPDF_BM_NORMAL,
    HPDF_BM_MULTIPLY,
    HPDF_BM_SCREEN,
    HPDF_BM_OVERLAY,
    HPDF_BM_DARKEN,
    HPDF_BM_LIGHTEN,
    HPDF_BM_COLOR_DODGE,
    HPDF_BM_COLOR_BUM,
    HPDF_BM_HARD_LIGHT,
    HPDF_BM_SOFT_LIGHT,
    HPDF_BM_DIFFERENCE,
    HPDF_BM_EXCLUSHON,
    HPDF_BM_EOF
  );

{*----- slide show -----------------------------------------------------------*}

  THPDF_TransitionStyle = (
    HPDF_TS_WIPE_RIGHT,
    HPDF_TS_WIPE_UP,
    HPDF_TS_WIPE_LEFT,
    HPDF_TS_WIPE_DOWN,
    HPDF_TS_BARN_DOORS_HORIZONTAL_OUT,
    HPDF_TS_BARN_DOORS_HORIZONTAL_IN,
    HPDF_TS_BARN_DOORS_VERTICAL_OUT,
    HPDF_TS_BARN_DOORS_VERTICAL_IN,
    HPDF_TS_BOX_OUT,
    HPDF_TS_BOX_IN,
    HPDF_TS_BLINDS_HORIZONTAL,
    HPDF_TS_BLINDS_VERTICAL,
    HPDF_TS_DISSOLVE,
    HPDF_TS_GLITTER_RIGHT,
    HPDF_TS_GLITTER_DOWN,
    HPDF_TS_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT,
    HPDF_TS_REPLACE,
    HPDF_TS_EOF
  );

{*----------------------------------------------------------------------------*}

  THPDF_PageSizes = (
    HPDF_PAGE_SIZE_LETTER,
    HPDF_PAGE_SIZE_LEGAL,
    HPDF_PAGE_SIZE_A3,
    HPDF_PAGE_SIZE_A4,
    HPDF_PAGE_SIZE_A5,
    HPDF_PAGE_SIZE_B5,
    HPDF_PAGE_SIZE_EXECUTIVE,
    HPDF_PAGE_SIZE_US4x6,
    HPDF_PAGE_SIZE_US4x8,
    HPDF_PAGE_SIZE_US5x7,
    HPDF_PAGE_SIZE_COMM10,
    HPDF_PAGE_SIZE_EOF
  );


  THPDF_PageDirection = (
    HPDF_PAGE_PORTRAIT,
    HPDF_PAGE_LANDSCAPE
  );


  THPDF_PageBoundary = (
    HPDF_PAGE_MEDIABOX = 0,
    HPDF_PAGE_CROPBOX,
    HPDF_PAGE_BLEEDBOX,
    HPDF_PAGE_TRIMBOX,
    HPDF_PAGE_ARTBOX
  );


  THPDF_EncoderType = (
    HPDF_ENCODER_TYPE_SINGLE_BYTE,
    HPDF_ENCODER_TYPE_MULTI_BYTE,
    {* obsoleted *} HPDF_ENCODER_TYPE_DOUBLE_BYTE
        = HPDF_ENCODER_TYPE_MULTI_BYTE,
    HPDF_ENCODER_TYPE_UNINITIALIZED,
    HPDF_ENCODER_UNKNOWN
  );


  THPDF_ByteType = (
    HPDF_BYTE_TYPE_SINGLE,
    HPDF_BYTE_TYPE_LEAD,
    HPDF_BYTE_TYPE_TRIAL,
    HPDF_BYTE_TYPE_UNKNOWN
  );


{*----------------------------------------------------------------------------*}

{* Name Dictionary values -- see PDF reference section 7.7.4 *}
  THPDF_NameDictKey = (
    HPDF_NAME_EMBEDDED_FILES = 0,    {* TODO the rest *}
    HPDF_NAME_EOF
  );


{*----------------------------------------------------------------------------*}
{*----- text converter -------------------------------------------------------*}


  THPDF_CharEnc  = (
    HPDF_CHARENC_UNSUPPORTED = 0,
    HPDF_CHARENC_UTF8,
    HPDF_CHARENC_UTF16BE,
    HPDF_CHARENC_UTF32BE,
    HPDF_CHARENC_UTF16LE,
    HPDF_CHARENC_UTF32LE,
    HPDF_CHARENC_UNICODE,       {* UTF16 native endian *}
    HPDF_CHARENC_UCS4,          {* UTF32 native endian *}
    HPDF_CHARENC_WCHAR_T,       {* UNICODE or UCS4 *}
    HPDF_CHARENC_EOF
  );

  HPDF_Converter = ^THPDF_Converter_Rec;

  THPDF_Converter_New_Func = function (alloc_fn: THPDF_Alloc_Func; free_fn: THPDF_Free_Func; param: Pointer):
    HPDF_Converter; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  THPDF_Converter_Convert_Func = function (converter: HPDF_Converter; flags: HPDF_UINT32;
    const src: HPDF_PBYTE; src_bytes: HPDF_UINT; dst: HPDF_PBYTE): HPDF_UINT; {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};


  THPDF_Converter_Delete_Func = function (converter: HPDF_Converter; free_fn: THPDF_Free_Func): HPDF_Converter;
    {$IFDEF Linux}cdecl{$ELSE}stdcall{$ENDIF};

  THPDF_Converter_Rec = record
    convert_fn: THPDF_Converter_Convert_Func;
    delete_fn: THPDF_Converter_Delete_Func;
    src_charenc: THPDF_CharEnc;
    dst_charenc: THPDF_CharEnc;
    bytes_factor: HPDF_UINT;
    chars_factor: HPDF_UINT;
  end;

  THPDF_ConverterBiDi_Param_Rec = record
    max_chars: HPDF_UINT32;
    base_dir: HPDF_UINT32;
    bidi_types: HPDF_PUINT32;
    ar_props: HPDF_PUINT8;
    embedding_levels: HPDF_PINT8;
    positions_L_to_V: HPDF_PINT;
    positions_V_to_L: HPDF_PINT;
  end;
{$Z-}

implementation

constructor THPDF_TransMatrix.Create(Aa, Ab, Ac, Ad, Ax, Ay: HPDF_REAL);
begin
  a := Aa;
  b := Ab;
  c := Ac;
  d := Ad;
  x := Ax;
  y := Ay;
end;

constructor THPDF_RGBColor.Create(Ar, Ag, Ab: HPDF_REAL);
begin
  r := Ar;
  g := Ag;
  b := Ab;
end;

constructor THPDF_CMYKColor.Create(Ac, Am, Ay, Ak: HPDF_REAL);
begin
  c := Ac;
  m := Am;
  y := Ay;
  k := Ak;
end;

end.
