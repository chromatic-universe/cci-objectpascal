object frm_manip: Tfrm_manip
  Left = 645
  Height = 345
  Top = 239
  Width = 459
  Caption = 'pretty baby manip'
  ClientHeight = 345
  ClientWidth = 459
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  OnCreate = FormCreate
  OnShow = FormShow
  Position = poScreenCenter
  LCLVersion = '1.0.12.0'
  Visible = True
  object ScrollBox1: TScrollBox
    Left = 0
    Height = 345
    Top = 0
    Width = 459
    HorzScrollBar.Page = 190
    HorzScrollBar.Range = 50
    HorzScrollBar.Visible = False
    VertScrollBar.Page = 171
    VertScrollBar.Range = 50
    VertScrollBar.Visible = False
    Align = alClient
    AutoScroll = False
    ClientHeight = 343
    ClientWidth = 457
    TabOrder = 0
    object Image1: TImage
      Left = 0
      Height = 50
      Top = 0
      Width = 50
      AutoSize = True
      OnMouseDown = Image1MouseDown
      OnMouseMove = Image1MouseMove
    end
  end
  object OpenDialog1: TOpenDialog
    left = 111
    top = 32
  end
end