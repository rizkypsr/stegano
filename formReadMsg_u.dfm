object FormReadMsg: TFormReadMsg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 382
  ClientWidth = 702
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Poppins'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 28
  object Label1: TLabel
    Left = 13
    Top = 235
    Width = 121
    Height = 23
    Caption = 'Karakter Maksimal'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Poppins'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 29
    Top = 331
    Width = 105
    Height = 23
    Caption = 'Karakter Tersisa'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Poppins'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 18
    Top = 283
    Width = 116
    Height = 23
    Caption = 'Karakter Terpakai'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Poppins'
    Font.Style = []
    ParentFont = False
  end
  object GroupBoxMsg: TGroupBox
    Left = 8
    Top = 8
    Width = 377
    Height = 129
    Caption = 'Pesan Rahasia'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Poppins'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object MemoMsg: TMemo
      Left = 16
      Top = 27
      Width = 342
      Height = 89
      TabOrder = 0
      OnKeyDown = MemoMsgKeyDown
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 152
    Width = 265
    Height = 57
    TabOrder = 1
    object BtnImgCheck: TButton
      Left = 16
      Top = 16
      Width = 110
      Height = 25
      Caption = 'Cek Gambar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Poppins'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnImgCheckClick
    end
    object BtnReadMsg: TButton
      Left = 132
      Top = 16
      Width = 110
      Height = 25
      Caption = 'Baca Pesan'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Poppins'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BtnReadMsgClick
    end
  end
  object EditMax: TEdit
    Left = 140
    Top = 232
    Width = 121
    Height = 31
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Poppins'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object EditRemains: TEdit
    Left = 140
    Top = 328
    Width = 121
    Height = 31
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Poppins'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 391
    Top = 8
    Width = 302
    Height = 290
    Caption = 'File Gambar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Poppins'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Image: TImage
      Left = 16
      Top = 27
      Width = 273
      Height = 246
    end
  end
  object EditUsed: TEdit
    Left = 140
    Top = 280
    Width = 121
    Height = 31
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Poppins'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object MainMenu: TMainMenu
    Left = 400
    Top = 328
    object MenuFile: TMenuItem
      Caption = 'File'
      object MenuNew: TMenuItem
        Caption = 'New'
        OnClick = MenuNewClick
      end
      object MenuOpen: TMenuItem
        Caption = 'Open'
        OnClick = MenuOpenClick
      end
      object MenuSave: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = MenuSaveClick
      end
      object MenuExit: TMenuItem
        Caption = 'Exit'
        OnClick = MenuExitClick
      end
    end
    object MenuEdit: TMenuItem
      Caption = 'Edit'
      object MenuCut: TMenuItem
        Caption = 'Cut'
        ShortCut = 16472
        OnClick = MenuCutClick
      end
      object MenuCopy: TMenuItem
        Caption = 'Copy'
        ShortCut = 16451
        OnClick = MenuCopyClick
      end
      object MenuPaste: TMenuItem
        Caption = 'Paste'
        ShortCut = 16470
        OnClick = MenuPasteClick
      end
    end
    object MenuProcess: TMenuItem
      Caption = 'Proses'
      object MenuWriteMsg: TMenuItem
        Caption = 'Tulis Pesan'
        OnClick = MenuWriteMsgClick
      end
      object MenuReadMsg: TMenuItem
        Caption = 'Baca Pesan'
        OnClick = MenuReadMsgClick
      end
    end
    object MenuHelp: TMenuItem
      Caption = 'Help'
      object MenuAbout: TMenuItem
        Caption = 'About'
        OnClick = MenuAboutClick
      end
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 336
    Top = 336
  end
  object SavePictureDialog: TSavePictureDialog
    Left = 456
    Top = 344
  end
end
