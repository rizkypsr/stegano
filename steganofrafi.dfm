object FormMenu: TFormMenu
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  ClientHeight = 181
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Roboto'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 160
    Top = 32
    Width = 193
    Height = 28
    Caption = 'Aplikasi Steganografi'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Poppins Medium'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 72
    Top = 66
    Width = 369
    Height = 55
    Color = clDefault
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object BtnWriteMessage: TButton
      Left = 11
      Top = 16
      Width = 110
      Height = 25
      Caption = 'Tulis Pesan'
      TabOrder = 0
      OnClick = BtnWriteMessageClick
    end
    object BtnReadMessage: TButton
      Left = 127
      Top = 16
      Width = 110
      Height = 25
      Caption = 'Baca Pesan'
      TabOrder = 1
      OnClick = BtnReadMessageClick
    end
    object BtnExit: TButton
      Left = 243
      Top = 15
      Width = 110
      Height = 25
      Caption = 'Keluar'
      TabOrder = 2
      OnClick = BtnExitClick
    end
  end
end
