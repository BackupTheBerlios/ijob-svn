object Form2: TForm2
  Left = 324
  Top = 298
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Form2'
  ClientHeight = 426
  ClientWidth = 638
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 638
    Height = 17
    Align = alTop
    BorderOuter = fsFlat
    TabOrder = 0
    object JvXPToolButton1: TJvXPToolButton
      Left = 1
      Top = 1
      Align = alLeft
      ImageIndex = 0
      OnClick = JvXPToolButton1Click
    end
  end
  object RzMemo1: TRzMemo
    Left = 0
    Top = 24
    Width = 625
    Height = 361
    TabOrder = 1
  end
  object RzButton1: TRzButton
    Left = 552
    Top = 392
    Caption = 'Speichern'
    TabOrder = 2
    OnClick = RzButton1Click
  end
end
