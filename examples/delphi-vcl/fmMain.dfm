object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'THaruPDF Main Demo'
  ClientHeight = 556
  ClientWidth = 677
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object panLeft: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 257
    Height = 550
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 525
    object lvDemo: TListView
      Left = 0
      Top = 0
      Width = 257
      Height = 525
      Hint = 'Double click to start a demo'
      Align = alClient
      Columns = <
        item
          Width = 230
        end>
      ColumnClick = False
      GridLines = True
      Groups = <
        item
          Header = 'General'
          GroupID = 0
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end
        item
          Header = 'Navigation'
          GroupID = 1
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end
        item
          Header = 'Text'
          GroupID = 2
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end
        item
          Header = 'Graphics'
          GroupID = 3
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end
        item
          Header = 'Other'
          GroupID = 4
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end>
      GroupView = True
      ReadOnly = True
      RowSelect = True
      ParentShowHint = False
      ShowColumnHeaders = False
      ShowHint = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = lvDemoClick
      OnDblClick = lvDemoDblClick
    end
    object btnExecuteAllExamples: TButton
      Left = 0
      Top = 525
      Width = 257
      Height = 25
      Align = alBottom
      Caption = 'Execute all examples'
      TabOrder = 1
      OnClick = btnExecuteAllExamplesClick
      ExplicitTop = 531
      ExplicitWidth = 672
    end
  end
  object panRight: TPanel
    Left = 263
    Top = 0
    Width = 414
    Height = 556
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 409
    ExplicitHeight = 531
    object panTop: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 408
      Height = 96
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 403
      object memDescr: TMemo
        Left = 0
        Top = 0
        Width = 408
        Height = 96
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 403
      end
    end
    object panImg: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 105
      Width = 408
      Height = 448
      Align = alClient
      BevelKind = bkFlat
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      ShowCaption = False
      TabOrder = 1
      ExplicitWidth = 403
      ExplicitHeight = 423
      object imgDemo: TImage
        Left = 0
        Top = 0
        Width = 404
        Height = 444
        Align = alClient
        Center = True
        ExplicitWidth = 400
        ExplicitHeight = 440
      end
    end
  end
end
