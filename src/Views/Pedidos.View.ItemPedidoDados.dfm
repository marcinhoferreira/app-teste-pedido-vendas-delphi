object frameItemPedidoDados: TframeItemPedidoDados
  Left = 0
  Top = 0
  Width = 800
  Height = 82
  Constraints.MinHeight = 82
  TabOrder = 0
  object lblItemPedidoDados: TLabel
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 792
    Height = 15
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alTop
    Caption = 'Item do Pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 85
  end
  object panItemPedidoDados: TPanel
    Left = 0
    Top = 23
    Width = 800
    Height = 59
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      800
      59)
    object lblProdutoCodigo: TLabel
      Left = 8
      Top = 4
      Width = 105
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'C'#243'digo do Produto:'
    end
    object lblProdutoDescricao: TLabel
      Left = 136
      Top = 4
      Width = 54
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Descri'#231#227'o:'
    end
    object lblProdutoQuantidade: TLabel
      Left = 456
      Top = 4
      Width = 65
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      Caption = 'Quantidade:'
    end
    object lblProdutoValorUnitario: TLabel
      Left = 587
      Top = 4
      Width = 74
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      Caption = 'Valor Unit'#225'rio:'
    end
    object edtProdutoCodigo: TEdit
      Left = 8
      Top = 24
      Width = 121
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      CharCase = ecUpperCase
      TabOrder = 0
      OnChange = edtProdutoCodigoChange
      OnEnter = edtProdutoCodigoEnter
      OnKeyPress = edtProdutoCodigoKeyPress
    end
    object edtProdutoQuantidade: TEdit
      Left = 456
      Top = 24
      Width = 121
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      TabOrder = 2
      OnKeyPress = edtProdutoCodigoKeyPress
    end
    object edtProdutoValorUnitario: TEdit
      Left = 587
      Top = 24
      Width = 121
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      TabOrder = 3
      OnKeyPress = edtProdutoValorUnitarioKeyPress
    end
    object edtProdutoDescricao: TEdit
      Left = 136
      Top = 24
      Width = 312
      Height = 23
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      TabOrder = 1
      Text = 'edtProdutoDescricao'
      StyleElements = [seBorder]
    end
    object btnConfirmar: TButton
      Left = 715
      Top = 13
      Width = 75
      Height = 36
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Confirmar'
      TabOrder = 4
    end
  end
end
