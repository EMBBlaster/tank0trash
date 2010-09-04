object Form1: TForm1
  Left = 136
  Top = 143
  Width = 503
  Height = 441
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 374
    Height = 414
    Align = alClient
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 1
      Top = 1
      Width = 372
      Height = 393
      Cursor = crCross
      Align = alClient
      OnMouseDown = PaintBox1MouseDown
      OnMouseUp = PaintBox1MouseUp
    end
    object StatusBar: TStatusBar
      Left = 1
      Top = 394
      Width = 372
      Height = 19
      Panels = <>
    end
  end
  object ListBox1: TListBox
    Left = 374
    Top = 0
    Width = 121
    Height = 414
    TabStop = False
    Style = lbOwnerDrawFixed
    Align = alRight
    ImeMode = imDisable
    ItemHeight = 13
    TabOrder = 0
  end
  object Timer1: TTimer
    Interval = 20
    OnTimer = Timer1Timer
    Left = 24
    Top = 8
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 408
    Top = 16
  end
end
