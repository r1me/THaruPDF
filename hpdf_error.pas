{*
 * << Haru Free PDF Library >> -- hpdf_error.pas
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

unit hpdf_error;

{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}

interface

const
  {* error-code *}
  HPDF_ARRAY_COUNT_ERR              = $1001;
  HPDF_ARRAY_ITEM_NOT_FOUND         = $1002;
  HPDF_ARRAY_ITEM_UNEXPECTED_TYPE   = $1003;
  HPDF_BINARY_LENGTH_ERR            = $1004;
  HPDF_CANNOT_GET_PALLET            = $1005;
  HPDF_DICT_COUNT_ERR               = $1007;
  HPDF_DICT_ITEM_NOT_FOUND          = $1008;
  HPDF_DICT_ITEM_UNEXPECTED_TYPE    = $1009;
  HPDF_DICT_STREAM_LENGTH_NOT_FOUND = $100A;
  HPDF_DOC_ENCRYPTDICT_NOT_FOUND    = $100B;
  HPDF_DOC_INVALID_OBJECT           = $100C;
{*                                    = $100D *}
  HPDF_DUPLICATE_REGISTRATION       = $100E;
{*  HPDF_EXCEED_JWW_CODE_NUM_LIMIT    = $100F; *}
{*                                    = $1000; *}
  HPDF_ENCRYPT_INVALID_PASSWORD     = $1011;
{*                                    = $1012; *}
  HPDF_ERR_UNKNOWN_CLASS            = $1013;
  HPDF_EXCEED_GSTATE_LIMIT          = $1014;
  HPDF_FAILD_TO_ALLOC_MEM           = $1015;
  HPDF_FILE_IO_ERROR                = $1016;
  HPDF_FILE_OPEN_ERROR              = $1017;
{*                                    = $1018; *}
  HPDF_FONT_EXISTS                  = $1019;
  HPDF_FONT_INVALID_WIDTHS_TABLE    = $101A;
  HPDF_INVALID_AFM_HEADER           = $101B;
  HPDF_INVALID_ANNOTATION           = $101C;
{*                                    = $101D; *}
  HPDF_INVALID_BIT_PER_COMPONENT    = $101E;
  HPDF_INVALID_CHAR_MATRICS_DATA    = $101F;
  HPDF_INVALID_COLOR_SPACE          = $1020;
  HPDF_INVALID_COMPRESSION_MODE     = $1021;
  HPDF_INVALID_DATE_TIME            = $1022;
  HPDF_INVALID_DESTINATION          = $1023;
{*                                    = $1024 *}
  HPDF_INVALID_DOCUMENT             = $1025;
  HPDF_INVALID_DOCUMENT_STATE       = $1026;
  HPDF_INVALID_ENCODER              = $1027;
  HPDF_INVALID_ENCODER_TYPE         = $1028;
{*                                    = $1029 *}
{*                                    = $102A *}
  HPDF_INVALID_ENCODING_NAME        = $102B;
  HPDF_INVALID_ENCRYPT_KEY_LEN      = $102C;
  HPDF_INVALID_FONTDEF_DATA         = $102D;
  HPDF_INVALID_FONTDEF_TYPE         = $102E;
  HPDF_INVALID_FONT_NAME            = $102F;
  HPDF_INVALID_IMAGE                = $1030;
  HPDF_INVALID_JPEG_DATA            = $1031;
  HPDF_INVALID_N_DATA               = $1032;
  HPDF_INVALID_OBJECT               = $1033;
  HPDF_INVALID_OBJ_ID               = $1034;
  HPDF_INVALID_OPERATION            = $1035;
  HPDF_INVALID_OUTLINE              = $1036;
  HPDF_INVALID_PAGE                 = $1037;
  HPDF_INVALID_PAGES                = $1038;
  HPDF_INVALID_PARAMETER            = $1039;
{*                                    = $103A *}
  HPDF_INVALID_PNG_IMAGE            = $103B;
  HPDF_INVALID_STREAM               = $103C;
  HPDF_MISSING_FILE_NAME_ENTRY      = $103D;
{*                                    = $103E *}
  HPDF_INVALID_TTC_FILE             = $103F;
  HPDF_INVALID_TTC_INDEX            = $1040;
  HPDF_INVALID_WX_DATA              = $1041;
  HPDF_ITEM_NOT_FOUND               = $1042;
  HPDF_LIBPNG_ERROR                 = $1043;
  HPDF_NAME_INVALID_VALUE           = $1044;
  HPDF_NAME_OUT_OF_RANGE            = $1045;
{*                                    = $1046 *}
{*                                    = $1047 *}
  HPDF_PAGE_INVALID_PARAM_COUNT     = $1048;
  HPDF_PAGES_MISSING_KIDS_ENTRY     = $1049;
  HPDF_PAGE_CANNOT_FIND_OBJECT      = $104A;
  HPDF_PAGE_CANNOT_GET_ROOT_PAGES   = $104B;
  HPDF_PAGE_CANNOT_RESTORE_GSTATE   = $104C;
  HPDF_PAGE_CANNOT_SET_PARENT       = $104D;
  HPDF_PAGE_FONT_NOT_FOUND          = $104E;
  HPDF_PAGE_INVALID_FONT            = $104F;
  HPDF_PAGE_INVALID_FONT_SIZE       = $1050;
  HPDF_PAGE_INVALID_GMODE           = $1051;
  HPDF_PAGE_INVALID_INDEX           = $1052;
  HPDF_PAGE_INVALID_ROTATE_VALUE    = $1053;
  HPDF_PAGE_INVALID_SIZE            = $1054;
  HPDF_PAGE_INVALID_XOBJECT         = $1055;
  HPDF_PAGE_OUT_OF_RANGE            = $1056;
  HPDF_REAL_OUT_OF_RANGE            = $1057;
  HPDF_STREAM_EOF                   = $1058;
  HPDF_STREAM_READLN_CONTINUE       = $1059;
{*                                    = $105A *}
  HPDF_STRING_OUT_OF_RANGE          = $105B;
  HPDF_THIS_FUNC_WAS_SKIPPED        = $105C;
  HPDF_TTF_CANNOT_EMBEDDING_FONT    = $105D;
  HPDF_TTF_INVALID_CMAP             = $105E;
  HPDF_TTF_INVALID_FOMAT            = $105F;
  HPDF_TTF_MISSING_TABLE            = $1060;
  HPDF_UNSUPPORTED_FONT_TYPE        = $1061;
  HPDF_UNSUPPORTED_FUNC             = $1062;
  HPDF_UNSUPPORTED_JPEG_FORMAT      = $1063;
  HPDF_UNSUPPORTED_TYPE1_FONT       = $1064;
  HPDF_XREF_COUNT_ERR               = $1065;
  HPDF_ZLIB_ERROR                   = $1066;
  HPDF_INVALID_PAGE_INDEX           = $1067;
  HPDF_INVALID_URI                  = $1068;
  HPDF_PAGE_LAYOUT_OUT_OF_RANGE     = $1069;
  HPDF_PAGE_MODE_OUT_OF_RANGE       = $1070;
  HPDF_PAGE_NUM_STYLE_OUT_OF_RANGE  = $1071;
  HPDF_ANNOT_INVALID_ICON           = $1072;
  HPDF_ANNOT_INVALID_BORDER_STYLE   = $1073;
  HPDF_PAGE_INVALID_DIRECTION       = $1074;
  HPDF_INVALID_FONT                 = $1075;
  HPDF_PAGE_INSUFFICIENT_SPACE      = $1076;
  HPDF_PAGE_INVALID_DISPLAY_TIME    = $1077;
  HPDF_PAGE_INVALID_TRANSITION_TIME = $1078;
  HPDF_INVALID_PAGE_SLIDESHOW_TYPE  = $1079;
  HPDF_EXT_GSTATE_OUT_OF_RANGE      = $1080;
  HPDF_INVALID_EXT_GSTATE           = $1081;
  HPDF_EXT_GSTATE_READ_ONLY         = $1082;
  HPDF_INVALID_U3D_DATA             = $1083;
  HPDF_NAME_CANNOT_GET_NAMES        = $1084;
  HPDF_INVALID_ICC_COMPONENT_NUM    = $1085;
  HPDF_PAGE_INVALID_BOUNDARY        = $1086;
  HPDF_TOO_SMALL_PDF_VERSION        = $1090;
  HPDF_CONVERTER_NOT_FOUND          = $1091;
  HPDF_NOT_UTF_ENCODING             = $1092;
  HPDF_FAILD_TO_NEW_CONVERTER       = $1093;
  HPDF_UNMATCHED_RELIEF_FONT        = $1094;
  HPDF_LOOPED_RELIEF_FONT           = $1095;

{*----------------------------------------------------------------------------*}

implementation

end.

