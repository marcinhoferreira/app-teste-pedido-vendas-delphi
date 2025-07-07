object frameClienteDados: TframeClienteDados
  Left = 0
  Top = 0
  Width = 831
  Height = 82
  Constraints.MinHeight = 82
  TabOrder = 0
  object lblTituloClienteDados: TLabel
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 823
    Height = 15
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    Caption = 'Identifica'#231#227'o do Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 131
  end
  object panClienteDados: TPanel
    Left = 0
    Top = 23
    Width = 831
    Height = 59
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      831
      59)
    object lblClienteNome: TLabel
      Left = 12
      Top = 4
      Width = 36
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Nome:'
      FocusControl = edtClienteNome
    end
    object lblClienteCidade: TLabel
      Left = 382
      Top = 4
      Width = 40
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      Caption = 'Cidade:'
      FocusControl = edtClienteCidade
    end
    object lblClienteUF: TLabel
      Left = 752
      Top = 4
      Width = 17
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      Caption = 'UF:'
      FocusControl = edtClienteUF
    end
    object edtClienteNome: TEdit
      Left = 12
      Top = 25
      Width = 364
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'edtClienteNome'
      StyleElements = [seBorder]
    end
    object edtClienteCidade: TEdit
      Left = 380
      Top = 27
      Width = 364
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 1
      Text = 'edtClienteCidade'
      StyleElements = [seBorder]
    end
    object edtClienteUF: TEdit
      Left = 752
      Top = 25
      Width = 67
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      TabOrder = 2
      Text = 'edtClienteUF'
      StyleElements = [seBorder]
    end
  end
end
