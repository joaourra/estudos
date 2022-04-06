VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "EstaPastaDeTrabalho"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub Importar_Inscricoes()
' Código criado pelo João Urra
'Repetição para passar por todos os centros
'Não mostrar as atualizações


Application.ScreenUpdating = False

linha_fim = 29
linha = 2
'
While linha <= linha_fim
'

'Abrindo arquivos que contém as inscrições de todos os centros esportivos

 °ARQUIVOS = Sheets("Legenda").Cells(linha, 1) ' A2.Value até 28 (nome do arquivo)
 °CAMINHO_Centros = Sheets("Legenda").Cells(1, 1) ' A1.Value (caminho no computador)C:\Users\jplur\OneDrive\Imagens\Profissional\SBC\

'Premissas Gerais nome da aba da planilha
 Workbooks.Open (°CAMINHO_Centros & "Centros Esportivos\" & °ARQUIVOS)

'Copiando as informações necessárias do arquivo com as Respostas ao formulário 1'
'Sheets("Respostas ao formulário 1").Select
 
 Cells.Select
 Selection.Copy
 
'Colando as informações copiadas no arquiv o atual'

 ThisWorkbook.Activate

 Sheets("Base de Dados").Select

 Cells.Select
 Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
 :=False, Transpose:=False
 Application.CutCopyMode = False
'Fechando arquivo que contém as INSCRICOES'
 Workbooks(°ARQUIVOS).Activate
 ActiveWorkbook.Close SaveChanges:=False
 
 ' Executa tudo
 
Call organizarBasedeDados
'
    linha = linha + 1
Wend

'Na aba inscrição já completa faz a verificação
Call Verificacao

'Move a aba Saúde para uma nova planilha
    Sheets("Saúde").Copy
    ActiveWorkbook.SaveAs Filename:= _
        °CAMINHO_Centros & "Saúde.xlsx", FileFormat:= _
        xlOpenXMLWorkbook, CreateBackup:=False
    ActiveWindow.Close
'Apagando o conteudo para esvaziar um pouco a planilha

Sheets("Saúde").Select
    Rows("2:2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.ClearContents


Sheets("Menu").Select
Worksheets("Menu").Range("A2").Value = "ORGANIZAR OK"

Application.ScreenUpdating = True

' - - - - FIM - - - IMPORTAR INSCRIÇÕES - - - -
End Sub
Sub organizarBasedeDados()
' Código criado pelo João Urra
'PARA ADULTOS

    Sheets("Base de Dados").Select
'
' Vai reexibir as colunas e as celulas de toda a planilha
'
    ActiveWorkbook.Worksheets("Base de Dados").Cells.Select
    Selection.EntireColumn.Hidden = False
    Selection.EntireRow.Hidden = False
    
' corrigindo erro para Geral
    Columns("B:B").Select
    Range(Selection, Selection.End(xlToRight)).Select
    Selection.NumberFormat = "General"
    
'MacroOrgnizar CE.Mod.Turma Macro
'AB Centro Esportivo // concatenar de AF até BZ
centroEsportivo1 = "Z1"
centroEsportivo = "Z2"
modalidade = "AA2"
modalidade1 = "AA1"
modalidadeFim = "AA2:AA"
modalidadeTudo = "AA:AA"
idade = "AB1"
vagasTotal = "AC1"
periodo = "AD1"
periodo2 = "AD2"
periodoTudo = "AD:AD"
dias = "AE1"
dias2 = "AE2"
diasTudo = "AE:AE"
horario = "AF1"
horario2 = "AF2"
horarioTudo = "AF:AF"

linha_fim = Range(centroEsportivo1).End(xlDown).Row
todasAsTurmas = "AF2;AG2;AH2;AI2;AJ2;AK2;AL2;AM2;AN2;AO2;AP2;AQ2;AR2;AS2;AT2;AU2;AV2;AW2;AX2;AY2;AZ2;BA2;BB2;BC2;BD2;BE2;BF2;BG2;BH2;BI2;BJ2;BK2;BL2;BM2;BN2;BO2;BP2;BQ2;BR2;BS2;BT2;BU2;BV2;BW2;BX2;BZ2"
paraApagar = "AG:BZ"

cpfOriginal = "F2"
listaOriginal = "P2"


' AA = onde será a modalidade depois do Centro Esportivo
    Range(modalidadeTudo).Select
'Adiciona 5 colunas
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    
    Range(modalidade).Select
    ActiveCell.FormulaLocal = "=CONCATENAR(" & todasAsTurmas & ")"
    Selection.AutoFill Destination:=Range(modalidadeFim & linha_fim)
    Range(modalidadeFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
    'colocar a parte de erro continua  On Error Resume Next
    
    Application.DisplayAlerts = False
    
    
    Selection.TextToColumns Destination:=Range(modalidade), DataType:=xlDelimited, _
        TextQualifier:=xlDoubleQuote, ConsecutiveDelimiter:=True, Tab:=False, _
        Semicolon:=False, Comma:=False, Space:=False, Other:=True, OtherChar _
        :=".", FieldInfo:=Array(Array(1, 1), Array(2, 1), Array(3, 1), Array(4, 1), Array(5, _
        1), Array(6, 1), Array(7, 1), Array(8, 1)), TrailingMinusNumbers:=True
    
    Application.DisplayAlerts = False
    
    ' On Error GoTo 0

'Apagar colunas concatenadas
    Columns(paraApagar).Select
    Selection.Delete Shift:=xlToLeft
' Nomeia as colunas
    Range(modalidade1).Value = "MODALIDADE"
    Range(idade).Value = "IDADE"
    Range(vagasTotal).Value = "VAGAS TURMA"
    Range(periodo).Value = "PERIODO"
    Range(dias).Value = "DIAS"
    Range(horario).Value = "HORÁRIO"

    ' FIM colunas de ce.modalidade.turma Organizados
    
'criar colunas uteis cpf, status, lista, turma, sexo da turma, ano de nascimento

    Range("AG1").Value = "CPF CONCAT"
    Range("AH1").Value = "STATUS CPF"
    Range("AI1").Value = "DUPLICADOS"
    Range("AJ1").Value = "STATUS DUPLICADOS"
    Range("AK1").Value = "LISTA"
    Range("AL1").Value = "TURMA"
    
 cpfConcat = "AG2"
 cpfFim = "AG2:AG"
 statusCpf = "AH2"
 statusCpfFim = "AH2:AH"
 dupli1 = "AI1"
 duplicados = "AI2"
 duplicadosFim = "AI2:AI"
 duplicados1 = "AI3"
 statusDup = "AJ2"
 statusDupFim = "AJ2:AJ"
 lista = "AK2"
 listaFim = "AK2:AK"
 listaTudo = "AK:AK"
 turma = "AL2"
 turmaFim = "AL2:AL"
 
' Para mostrar mascara no cpf e separar a turma

 Range("AU1").Value = ".###.###-"
 Range("AV1") = "|"
x = "$AU$1"
y = "$AV$1"

' CPF pra divulgar =CONCATENAR(ESQUERDA(" & cpfOriginal & ";3);" & x & ";DIREITA(" & cpfOriginal & ";2))

    Range(cpfConcat).Select
    ActiveCell.FormulaLocal = "=CONCATENAR(ESQUERDA(" & cpfOriginal & ";3);" & x & ";DIREITA(" & cpfOriginal & ";2))"
    Selection.AutoFill Destination:=Range(cpfFim & linha_fim), Type:=xlFillDefault
    Range(cpfFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM coluna do CPF CONCAT
' Agr Concatenar Duplicados =CONCATENAR(CPF;"|";CE;"|";MODALIDADE)




' Concatenar Lista "=CONCATENAR(ESQUERDA(" & listaOriginal & ";3)
    Range(lista).Select
    ActiveCell.FormulaLocal = "=CONCATENAR(ESQUERDA(" & listaOriginal & ";3))"
    Selection.AutoFill Destination:=Range(listaFim & linha_fim), Type:=xlFillDefault
    Range(listaFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False

' trocar os NEN para GERAL AK:AK
    Columns(listaTudo).Select
    Selection.Replace What:="NEN", Replacement:="GERAL", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
' Fim lista
 
'trocar os dias das semanas diasTudo
'
    Columns(diasTudo).Select
    Selection.Replace What:="Segunda", Replacement:="2ª", LookAt:=xlPart _
        , SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="Terça", Replacement:="3ª", LookAt:=xlPart _
        , SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="Quarta", Replacement:="4ª", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="Quinta", Replacement:="5ª", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="Sexta", Replacement:="6ª", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="s", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="e", Replacement:=" e ", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
'FIM trocar dias das semanas
'apagar espaços do periodo

    Columns(periodoTudo).Select
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
'
'FIM apagar espaços do periodo
'apagar "para " das modalidade

    Columns(modalidadeTudo).Select
    Selection.Replace What:="Para ", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False

'FIM apagar "para " das modalidade
'apagr espaços e acertar o as do horario
    Columns(horarioTudo).Select
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="as", Replacement:=" as ", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
        'Horário a definir
    Selection.Replace What:="Horárioadefinir", Replacement:="Horário a definir", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
'FIM horarioTudo = "AF:AF"

    


' Status CPF verificar se é verdadeiro (" & cpfOriginal & "<>""00000000000"");

        Range(statusCpf).Select
            ActiveCell.FormulaLocal = "=SE(E((" & cpfOriginal & "<>""00000000000"");NÚM.CARACT(" & cpfOriginal & ")=11;SOMA(SE(" & cpfOriginal & "=REPT({1;2;3;4;5;6;7;8;9};11);1;0))=0;SOMA(SE(ÉNÚM(VALOR(EXT.TEXTO(" & cpfOriginal & ";{1;2;3;4;5;6;7;8;9;10;11};1)));0;1))=0);E(SE(OU(11-(MOD(SOMA(INT(EXT.TEXTO(" & cpfOriginal & ";{1;2;3;4;5;6;7;8;9};1))*({10;9;8;7;6;5;4;3;2}));11))=10;11-(MOD(SOMA(INT(EXT.TEXTO(" & cpfOriginal & ";{1;2;3;4;5;6;7;8;9};1))*({10;9;8;7;6;5;4;3;2}));11))=11);0;11-(MOD(SOMA(INT(EXT.TEXTO(" & cpfOriginal & ";{1;2;3;4;5;6;7;8;9};1))*({10;9;8;7;6;5;4;3;2}));11)))=INT(EXT.TEXTO(" & cpfOriginal & ";10;1));SE(OU(11-(MOD(SOMA(INT(EXT.TEXTO(" & cpfOriginal & ";{1;2;3;4;5;6;7;8;9;10};1))*({11;10;9;8;7;6;5;4;3;2}));11))=10;11-(MOD(SOMA(INT(EXT.TEXTO(" & cpfOriginal & ";{1;2;3;4;5;6;7;8;9;10};1))*({11;10;9;8;7;6;5;4;3;2}));11))=11);0;11-(MOD(SOMA(INT(EXT.TEXTO(" & cpfOriginal & ";{1;2;3;4;5;6;7;8;9;10};1))*({11;10;9;8;7;6;5;4;3;2}));11)))=INT(EXT.TEXTO(" & cpfOriginal & ";11;1)));FALSO)"
            Selection.AutoFill Destination:=Range(statusCpfFim & linha_fim)
            Range(statusCpfFim & linha_fim).Select
            Selection.Copy
            Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
                :=False, Transpose:=False
            Application.CutCopyMode = False
'FIM até StatusCPF

' Colunas de idade e status,

    Range("AM1").Value = "IDADE MIN"
    Range("AN1").Value = "IDADE MÁX"
    nCorrigir = "AM2:AN"
idadeMin = "AM2"
idadeMinFim = "AM2:AM"
idadeMax = "AN2"
idadeMaxFim = "AN2:AN"
    
    Range("AP1").Value = "IDADE MAX VERDADE"

idadeMaxVerdade = "AP2"
idadeMaxVerdadeFim = "AP2:AP"

    Range("AQ1").Value = "ANO ALUNO"
    Range("AR1").Value = "STATUS IDADE"

anoAluno = "AQ2"
anoAlunoFim = "AQ2:AQ"
statusIdade = "AR2"
statusIdadeFim = "AR2:AR"

dataDeNascimentoOriginal = "D2"
idadeTudo = "AB:AB"
idade2 = "AB2"



' apagar a palavra 'ANOS' e 'A PARTIR DE' da coluna idade e 'espaços' //'e' por 'a'

    Columns(idadeTudo).Select
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart _
        , SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="Entre", Replacement:="", LookAt:=xlPart _
        , SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="acimade", Replacement:="", LookAt:=xlPart _
        , SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="Apartirde", Replacement:="", LookAt:=xlPart _
        , SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="e", Replacement:="a", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="a", Replacement:=" a ", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="A nos", Replacement:="anos", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
'
'
' - colar idade da turma antes de alterar TUDO
Range(idade).Value = "IDADE DA TURMA"

Range(idadeTudo).Select
    Selection.Copy
Range("BL1").Select         ' BL idade sem alteração do forms
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False

Columns(idadeTudo).Select
    Selection.Replace What:="Anos", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart _
        , SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
' FIM DAS ALTERAÇÕES


' idade minima =ESQUERDA(" & idade & ";2)
    Range(idadeMin).Select
    ActiveCell.FormulaLocal = "=ESQUERDA(" & idade2 & ";2)"
    Selection.AutoFill Destination:=Range(idadeMinFim & linha_fim), Type:=xlFillDefault
    Range(idadeMinFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM coluna do idade minima

' idade máxima =DIREITA(" & idade & ";2)
    Range(idadeMax).Select
    ActiveCell.FormulaLocal = "=DIREITA(" & idade2 & ";2)"
    Selection.AutoFill Destination:=Range(idadeMaxFim & linha_fim), Type:=xlFillDefault
    Range(idadeMaxFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' Corrigindo erro de celula como texto para numero fazendo a multiplicação por 1
    Range("AO1").Value = "1"
    Range("AO1").Copy
    Range(nCorrigir & linha_fim).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlMultiply, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
' se idade máxima = idade minima; a idade máxima recebe 110 =SE(idadeMin = idadeMax ;110; idadeMax)
    Range(idadeMaxVerdade).Select
    ActiveCell.FormulaLocal = "=SE(" & idadeMin & " = " & idadeMax & " ;110; " & idadeMax & " )"
    Selection.AutoFill Destination:=Range(idadeMaxVerdadeFim & linha_fim), Type:=xlFillDefault
    Range(idadeMaxVerdadeFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM coluna idade maxima

' ano aluno =ANO(" & dataDeNascimentoOriginal & ") DIREITA(DATA;4)
    Range(anoAluno).Select
    ActiveCell.FormulaLocal = "=DIREITA(" & dataDeNascimentoOriginal & ";4)"
    Selection.AutoFill Destination:=Range(anoAlunoFim & linha_fim), Type:=xlFillDefault
    Range(anoAlunoFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM coluna ano aluno
' COrrigindo erro de não ver ano como numero
    Range("AV1").Value = 1
    Range("AV1").Copy
    Range(anoAlunoFim & linha_fim).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlMultiply, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
' statusIdade
Range("AV1") = "|"
'=SE(AA2="HIDROGINÁSTICA INCLUSIVA";SE(OU(AK2="PCD";AK2="PLM");SE(2022-AQ2>=18;"OK";"NEGADA");"NEGADA");SE(E(2022-AQ2<=AP2;2022-AQ2>=AM2);"OK";SE(E(2022-AQ2>=18;AM2=40;OU(AK2="PLM";AK2="PCD"));"OK";"NEGADA")))
' FORMULA FINAL
'=SE(AA2="HIDROGINÁSTICA INCLUSIVA";SE(OU(AK2="PCD";AK2="PLM");"OK";"NEGADA");SE(E(2022-AQ2<=AP2;2022-AQ2>=AM2);"OK";SE(E(2022-AQ2>=18;AM2=40;OU(AK2="PLM";AK2="PCD"));"OK";"NEGADA")))
    Range(statusIdade).Select
    ActiveCell.FormulaLocal = "=SE(" & modalidade & "=""HIDROGINÁSTICA INCLUSIVA"";SE(OU(" & lista & "=""PCD"";" & lista & "=""PLM"");SE(2021-" & anoAluno & ">=18;""OK"";""NEGADA"");""NEGADA"");SE(E(2021-" & anoAluno & "<=AP2;2021-" & anoAluno & ">=" & idadeMin & ");""OK"";SE(E(2021-" & anoAluno & ">=18;" & idadeMin & "=40;OU(" & lista & "=""PLM"";" & lista & "=""PCD""));""OK"";""NEGADA"")))"
    Selection.AutoFill Destination:=Range(statusIdadeFim & linha_fim), Type:=xlFillDefault
    Range(statusIdadeFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM coluna Status Idade

' Nome em Maiuscula
nomeOriginal = "C2"
nomeCaps = "AX2"
nomeFim = "AX2:AX"
    Range(nomeCaps).Select
    ActiveCell.FormulaLocal = "=ARRUMAR(MAIÚSCULA(" & nomeOriginal & "))"
    Selection.AutoFill Destination:=Range(nomeFim & linha_fim), Type:=xlFillDefault
    Range(nomeFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM coluna do Nome em Maiuscula

' - - - - - - - - - - - - - - - - - codigos para idTurma - - - - - - - - - - - -  -
'ceCodigo="AZ2" centroEsportivo
 Range("AZ1").Value = "ceCodigo"
 ceCodigo = "AZ2"
 ceCodigoFim = "AZ2:AZ"

    Range(ceCodigo).Select
    ActiveCell.FormulaLocal = "=PROCV(" & centroEsportivo & ";Legenda!$C$2:$D$40;2)"
    Selection.AutoFill Destination:=Range(ceCodigoFim & linha_fim), Type:=xlFillDefault
    Range(ceCodigoFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM ceCodigo
'centroEsportivo =PROCV(Z2;Legenda!$C$2:$D$31;2)

'modalidade  =PROCV(AA2;Legenda!$E$2:$F$26;2)
 Range("BA1").Value = " moCodigo"
 moCodigo = "BA2"
 moCodigoFim = "BA2:BA"

    Range(moCodigo).Select
    ActiveCell.FormulaLocal = "=PROCV(" & modalidade & ";Legenda!$E$2:$F$40;2)"
    Selection.AutoFill Destination:=Range(moCodigoFim & linha_fim), Type:=xlFillDefault
    Range(moCodigoFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM modalidadeCop

'idadeMin   =SE(AM2<11;"C";SE(AM2<16;"J";SE(AM2<60;"A";"I")))
 Range("BB1").Value = "idadeCodigo"
 idadeCodigo = "BB2"
 idadeCodigoFim = "BB2:BB"

    Range(idadeCodigo).Select
    ActiveCell.FormulaLocal = "=SE(" & idadeMin & "<11;""C"";SE(" & idadeMin & "<16;""J"";SE(" & idadeMin & "<60;""A"";""I"")))"
    Selection.AutoFill Destination:=Range(idadeCodigoFim & linha_fim), Type:=xlFillDefault
    Range(idadeCodigoFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM idadeCodigo

'periodo2 = ESQUERDA(AD2)
 Range("BC1").Value = "periodoCodigo"
 periodoCodigo = "BC2"
 periodoCodigoFim = "BC2:BC"

    Range(periodoCodigo).Select
    ActiveCell.FormulaLocal = "=ESQUERDA(" & periodo2 & ")"
    Selection.AutoFill Destination:=Range(periodoCodigoFim & linha_fim), Type:=xlFillDefault
    Range(periodoCodigoFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM periodoCodigo

'dias2 =PROCV(AE2;Legenda!$G$13:$H$21;2)
 Range("BD1").Value = "diaCodigo"
 diaCodigo = "BD2"
 diaCodigoFim = "BD2:BD"


    Range(diaCodigo).Select
    ActiveCell.FormulaLocal = "=PROCV(" & dias2 & ";Legenda!$G$13:$H$21;2)"
    Selection.AutoFill Destination:=Range(diaCodigoFim & linha_fim), Type:=xlFillDefault
    Range(diaCodigoFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM diaCodigo

'idTurma =CONCATENAR(AZ2;"-";BA2;"-";BB2;"-";BC2;"-";BD2)
'ceCodigo="AZ2" 'moCodigo = "BA2" 'idadeCodigo = "BB2"
'periodoCodigo = "BC2" 'diaCodigo = "BD2" 'idTurma = "BE2"

 Range("BE1").Value = "idTurma"
 idTurma = "BE2"
 idTurmaFim = "BE2:BE"

    Range(idTurma).Select
    ActiveCell.FormulaLocal = "=CONCATENAR(" & ceCodigo & ";""-"";" & moCodigo & ";""-"";" & idadeCodigo & ";""-"";" & periodoCodigo & ";""-"";" & diaCodigo & ";""-"";ESQUERDA(" & horario2 & ";4))"
    Selection.AutoFill Destination:=Range(idTurmaFim & linha_fim), Type:=xlFillDefault
    Range(idTurmaFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
    
    Range(duplicados).Select
    ActiveCell.FormulaLocal = "=CONCATENAR(" & cpfOriginal & ";" & y & ";" & centroEsportivo & ";" & y & ";" & moCodigo & ")"
    Selection.AutoFill Destination:=Range(duplicadosFim & linha_fim), Type:=xlFillDefault
    Range(duplicadosFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM idTurma
'
' - - - FIM - - - - - - - - CODIGOS DAS TURMAS - - - - - - -
' - - - - - - -  Organizar pelo Duplicados de A a Z AI1 = Duplicados - - - - - - - -
' ----  --  - - - - - - - - CODIGO DA MODALIDADE ANTES DAQUI - - - - - - - - -
a1 = "A1"
    Rows("1:1").Select
    Selection.AutoFilter
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Add2 Key _
        :=Range(a1), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Add2 Key _
        :=Range(dupli1), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    Selection.AutoFilter
    
' Status Duplicados =SE(T5=T6;"NEGADA";"VÁLIDA")
'"SE("& duplicados &"="& duplicados1 &";"NEGADA";"OK")"

    Range(statusDup).Select
    ActiveCell.FormulaLocal = "=SE(" & duplicados & "=" & duplicados1 & ";"" NEGADA "";"" OK "")"
    Selection.AutoFill Destination:=Range(statusDupFim & linha_fim), Type:=xlFillDefault
    Range(statusDupFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' - - FIM - - - - - - - - Status Duplicados - - - -

'CONCATENAR TODOS OS STATUS y ="|" statusCpf statusDup statusIdade
Range("AT1").Value = "CPF|DUP|IDADE STATUS"
vagasArre = "AT2"
vagasArreFim = "AT2:AT"

    Range(vagasArre).Select
    ActiveCell.FormulaLocal = "=CONCATENAR(" & statusCpf & ";" & y & ";" & statusDup & ";" & y & ";" & statusIdade & ")"
    Selection.AutoFill Destination:=Range(vagasArreFim & linha_fim), Type:=xlFillDefault
    Range(vagasArreFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM Status concatenados
'Concatenar C.E. com Inscrições "VERDADEIRO| OK |OK" = "ok" se não "invalida"
'=SE(AT2<>AV$1;SE(OU(AT2=AW$1;AT2=AX$1;AT2=AY$1;AT2=AZ$1);"DUPLICADA";"INVÁLIDA");"OK")
' =se(" & vagasArre & "<> "AV1";SE(OU(AT2=AW$1;AT2=AX$1;AT2=AY$1;AT2=AZ$1);"DUPLICADA";"INVÁLIDA");""OK"")

Range("AV1").Value = "VERDADEIRO| OK |OK"
Range("AW1").Value = "VERDADEIRO| NEGADA |OK"
Range("AX1").Value = "VERDADEIRO| NEGADA |NEGADA"
Range("AY1").Value = "FALSO| NEGADA |OK"
Range("AZ1").Value = "FALSO| NEGADA |NEGADA"

av = "AV$1"
aw = "AW$1"
ax = "AX$1"
ay = "AY$1"
az = "AZ$1"

'moCodigo = BA2   ' Codigo modalidade
inscricaoOk = "AV2"
inscricaoOkFim = "AV2:AV"
    Range(inscricaoOk).Select   '=SE(AT2<>AV$1;SE(OU(AT2=AW$1;AT2=AX$1;AT2=AY$1;AT2=AZ$1);"DUPLICADA";SE(E(AQ2>2014;OU(BA2="NA";BA2="HG"));"INVÁLIDA";"OK"));"OK") anoAluno = Q2  APENAS NASCIDOS DEPOIS DE 2015 NA NATAÇÃO SERÃO INVALIDADOS
    ActiveCell.FormulaLocal = "=se(" & vagasArre & "<>" & av & ";SE(OU(" & vagasArre & "=" & aw & ";" & vagasArre & "=" & ax & ";" & vagasArre & "=" & ay & ";" & vagasArre & "=" & az & ");""DUPLICADA"";SE(E(" & anoAluno & ">2014;" & moCodigo & "=""NA"");""INVÁLIDA"";""OK""));""OK"")"
    Selection.AutoFill Destination:=Range(inscricaoOkFim & linha_fim), Type:=xlFillDefault
    Range(inscricaoOkFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM STATUS validos ou invalidos

vagasTotal2 = "AC2"
vagasTotal2Fim = "AC2:AC"
vagasTudo = "AC:AC"

Columns(vagasTudo).Select
    Selection.Replace What:=" ", Replacement:="", LookAt:=xlPart _
        , SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="Vagas", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
' apagar a palavra vagas
Range(vagasTotal).Value = "TOTAL DE VAGAS"

'''------------------------------------VAGAS POR LISTA---------------
' numero de vagas de acordo com a lista (PCD, NEM,...)
    Range("AS1").Value = "VAGAS LISTA"
vagasLista = "AS2"
vagasListaFim = "AS2:AS"
    Range("AO1").Value = "PORCENTEGEM DE VAGAS"
porcentagem = "AO2"
porcentagemFim = "AO2:AO"


' numero de vagas de acordo com a lista =(PCD, NEN,...)
' se lista <diferente> de NEM = 0.1 =SE("& lista &"=""NEN"";""0,7"";""*0,1"")
    Range(porcentagem).Select
    ActiveCell.FormulaLocal = "=SE(" & lista & "=""GERAL"";""0,7"";""0,1"")"
    Selection.AutoFill Destination:=Range(porcentagemFim & linha_fim), Type:=xlFillDefault
    Range(porcentagemFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM Porcentagem Fim

' multiplica "=porcentagem*vagasTotal2"
    Range(vagasLista).Select
    ActiveCell.FormulaLocal = "=" & porcentagem & "*" & vagasTotal2 & ""
    Selection.AutoFill Destination:=Range(vagasListaFim & linha_fim), Type:=xlFillDefault
    Range(vagasListaFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM multiplicação
' arredondar para baixo =ARREDONDAR.PARA.BAIXO(vagasLista; 0)
Range("AO1").Value = "VAGAS ARREDONDADAS PARA BAIXO"
vagasArre = "AO2"
vagasArreFim = "AO2:AO"
    Range(vagasArre).Select
    ActiveCell.FormulaLocal = "=ARREDONDAR.PARA.BAIXO(" & vagasLista & "; 0)"
    Selection.AutoFill Destination:=Range(vagasArreFim & linha_fim), Type:=xlFillDefault
    Range(vagasArreFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM vagas por lista
'''-------------- FIM ----------------------VAGAS POR LISTA---------------

Sheets("Base de Dados").Select

' OrganizarParaNdeSoreteio Macro
'
' A1 Data de inscrição mais antiga para a mais nova
    Rows("1:1").Select
    Selection.AutoFilter
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("A1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' BE1 idTurma por ordem alfabetica
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("BE1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' AV1 Validade ordem inversa para os OK virem antes
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("AV1"), SortOn:=xlSortOnValues, Order:=xlDescending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Base de Dados").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    Selection.AutoFilter


'FIM organizar pronto para numerar

'NUMERANDO =SE(BE1=BE2;BH1+1;1) BE1 idTurma1
idTurma1 = "BE1"
nSorteio1 = "BH1"
 Range(nSorteio1).Value = "Nº DO SORTEIO"
nSorteio = "BH2"
nSorteioFim = "BH2:BH"

' Numero do sorteio
    Range(nSorteio).Select      '=SE(AV2="OK";SE(BE1=BE2;BH1+1;1);1)
    ActiveCell.FormulaLocal = "=SE(" & inscricaoOk & "=""OK"";SE(" & idTurma1 & "=" & idTurma & ";" & nSorteio1 & "+1;1);1)"
    Selection.AutoFill Destination:=Range(nSorteioFim & linha_fim), Type:=xlFillDefault
    Range(nSorteioFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM coluna Numero do sorteio

''''''''

' Número total de inscrições validas por turma
' Levar para Legenda todas as Turmas por ordem alfabética e na frente formula de contar


' Concatenar idTurma com OK  =CONCATENAR(idTurma;inscricaoOk)
 
 Range("BF1").Value = "idTurmaOk"
 idTurmaOkConca = "BF2"
 idTurmaOkConcaFim = "BF2:BF"
 idTurmaOkConcaFixa = "$BF$2:$BF$"
    Range(idTurmaOkConca).Select
    ActiveCell.FormulaLocal = "=CONCATENAR(" & idTurma & ";" & inscricaoOk & ")"
    Selection.AutoFill Destination:=Range(idTurmaOkConcaFim & linha_fim), Type:=xlFillDefault
    Range(idTurmaOkConcaFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM Concatenar idTurma com OK
' =CONT.SE(BF2:BF57;BF2)
'
Range("BG1").Value = "SOMA idTurmaOk"
somaIdTurma = "BG2"
somaIdTurmaFim = "BG2:BG"
    Range(somaIdTurma).Select
        ActiveCell.FormulaLocal = "=CONT.SE(" & idTurmaOkConcaFixa & linha_fim & ";" & idTurmaOkConca & ")"
        Selection.AutoFill Destination:=Range(somaIdTurmaFim & linha_fim), Type:=xlFillDefault
        Range(somaIdTurmaFim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM SOMA DE TOTAL TODOS



' Concatenar idTurmaOK com LISTA =CONCATENAR(idTurmaOkConca;lista)
 
 Range("BI1").Value = "idTurmaOkLista"
 idTurmaOkLista = "BI2"
 idTurmaOkListaFim = "BI2:BI"
 idTurmaOkListaFixa = "$BI$2:$BI$"

    Range(idTurmaOkLista).Select
    ActiveCell.FormulaLocal = "=CONCATENAR(" & idTurmaOkConca & ";" & lista & ")"
    Selection.AutoFill Destination:=Range(idTurmaOkListaFim & linha_fim), Type:=xlFillDefault
    Range(idTurmaOkListaFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM Concatenar idTurmaOK com lista
' =CONT.SE(BF2:BF57;BF2)
'
Range("BJ1").Value = "SOMA idTurmaOkLista"
somaidTurmaOkLista = "BJ2"
somaidTurmaOkListaFim = "BJ2:BJ"

    Range(somaidTurmaOkLista).Select
        ActiveCell.FormulaLocal = "=CONT.SE(" & idTurmaOkListaFixa & linha_fim & ";" & idTurmaOkLista & ")"
        Selection.AutoFill Destination:=Range(somaidTurmaOkListaFim & linha_fim), Type:=xlFillDefault
        Range(somaidTurmaOkListaFim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM SOMA DE TOTAL TODOS
' ---------- FAZENDO ----------

' ----------------- ULTIMO COMANDO A FAZER -----------------
Call PassarParaInscricao
'para copiar e colar na aba Inscrição
Call PassarParaSaude

Sheets("Base de Dados").Select
    Cells.Select
    Selection.ClearContents

'FIM Organizar inscrições

End Sub
Sub PassarParaInscricao()
'Padrão para copiar e colar na BASE ORGANIZADA Range("D2:D" & linha_fim)
Sheets("Base de Dados").Select
baseDeDados = "Base de Dados"
abaInscricao = "Inscrição"

linha_fim = Range("A1").End(xlDown).Row


carimboFim = "A2:A"
    Range(carimboFim & linha_fim).Copy
    Sheets(abaInscricao).Select
linha_passar = Range("D200000").End(xlUp).Offset(1, 0).Row

carimboInscricao = "D" & linha_passar
    'desolcultar as celulas
    Cells.Select
    Selection.EntireColumn.Hidden = False
    Range(carimboInscricao).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
nomeCapsCop = "E" & linha_passar
nomeFim = "AX2:AX"

    Range(nomeFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(nomeCapsCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
cpfConcatCop = "F" & linha_passar
cpfFim = "AG2:AG"

    Range(cpfFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(cpfConcatCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select

listaCop = "G" & linha_passar
listaFim = "AK2:AK"
    Range(listaFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(listaCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
vagasTotal2Cop = "H" & linha_passar
vagasTotal2Fim = "AC2:AC"

    Range(vagasTotal2Fim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(vagasTotal2Cop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
periodo2Cop = "L" & linha_passar
periodoTudo = "AD2:AD"
    Range(periodoTudo & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(periodo2Cop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
dias2Cop = "M" & linha_passar
dias2Fim = "AE2:AE"
    Range(dias2Fim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(dias2Cop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
horario2Cop = "N" & linha_passar
horario2Fim = "AF2:AF"
    Range(horario2Fim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(horario2Cop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
inscricaoOkCop = "P" & linha_passar
inscricaoOkFim = "AV2:AV"
    Range(inscricaoOkFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(inscricaoOkCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
    ' DATA DE NASCIMENTO - NO R

emailCop = "R" & linha_passar
emailFim = "D2:D"       'DATA DE NASCIMENTO

    Range(emailFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(emailCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
emailCop = "S" & linha_passar
emailFim = "B2:B"
    Range(emailFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(emailCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
cpfOriginalCop = "T" & linha_passar
cpfOriginalFim = "F2:F"
    Range(cpfOriginalFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(cpfOriginalCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
celularCop = "U" & linha_passar
celularFim = "K2:K"
    Range(celularFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(celularCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
vagasArreStatusCop = "Q" & linha_passar
vagasArreFim = "AT2:AT"
    Range(vagasArreFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(vagasArreStatusCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
emergenciaCop = "V" & linha_passar
emergenciaFimTudo = "M2:O"
    Range(emergenciaFimTudo & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(emergenciaCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
susCepCop = "Y" & linha_passar
susCepFim = "G2:H"
    Range(susCepFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(susCepCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
bairroCop = "AA" & linha_passar
bairroFim = "J2:J"

    Range(bairroFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(bairroCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
ceCop = "J" & linha_passar
ceMoFim = "Z2:AA"

    Range(ceMoFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(ceCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select

idTurmaCop = "O" & linha_passar
idTurmaFim = "BE2:BE"

    Range(idTurmaFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(idTurmaCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
 nSorteio1 = "C" & linha_passar
 nSorteioFim = "BH2:BH"

    Range(nSorteioFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(nSorteio1).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
somaIdTurma = "I" & linha_passar
somaIdTurmaFim = "BG2:BG"

    Range(somaIdTurmaFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(somaIdTurma).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
idTurmaOkLista = "AI" & linha_passar
idTurmaOkListaFim = "BI2:BI"
    
        Range(idTurmaOkListaFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(idTurmaOkLista).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
somaidTurmaOkLista = "AJ" & linha_passar
somaidTurmaOkListaFim = "BJ2:BJ"
    
        Range(somaidTurmaOkListaFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(somaidTurmaOkLista).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
vagasArreCop = "AK" & linha_passar
vagasArreFim = "AO2:AO"

        Range(vagasArreFim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(vagasArreCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
inicio = "AN" & linha_passar    ' STATUS CPF
fim = "AH2:AH"                  'statusCpfFim = "AH2:AH"

        Range(fim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(inicio).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
inicio = "AO" & linha_passar    ' STATUS DUPLICADOS
fim = "AJ2:AJ"                  'statusDupFim = "AJ2:AJ"

        Range(fim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(inicio).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select

inicio = "AP" & linha_passar    ' STATUS IDADE
fim = "AR2:AR"                  'statusIdadeFim = "AR2:AR"

        Range(fim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(inicio).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
inicio = "AQ" & linha_passar    ' IDADE DA TURMA
fim = "BL2:BL"                  ' IDADE DA TURMA SEM ALTERAÇÃO

        Range(fim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(inicio).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
Sheets(baseDeDados).Select
    
inicio = "BG" & linha_passar    ' CODIGO DA MODALIDADE
fim = "BA2:BA"                  '

        Range(fim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(inicio).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
inicio = "BH" & linha_passar    ' CODIGO DO CENTRO ESPORRTIVO
fim = "AZ2:AZ"                  '

        Range(fim & linha_fim).Copy
    Sheets(abaInscricao).Select
    Range(inicio).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
    
'FIM PassarParaInscrição
End Sub

Sub PassarParaSaude()
'Padrão para copiar e colar na BASE ORGANIZADA Range("D2:D" & linha_fim)

baseDeDados = "Base de Dados"
Sheets(baseDeDados).Select
abaSaude = "Saúde"
linha_fim = Range("A1").End(xlDown).Row

cpfFim = "F2:F"

    Range(cpfFim & linha_fim).Copy
    Sheets(abaSaude).Select
linha_passar = Range("D200000").End(xlUp).Offset(1, 0).Row

CPF = "A" & linha_passar
    'desolcultar as celulas
    Cells.Select
    Selection.EntireColumn.Hidden = False
    ' desolcultadas
    Range(CPF).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    Sheets(baseDeDados).Select
    
sexo = "B" & linha_passar
sexoFim = "E2:E"

    Range(sexoFim & linha_fim).Copy
    Sheets(abaSaude).Select
    Range(sexo).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select

Data = "C" & linha_passar
dataFim = "D2:D"

    Range(dataFim & linha_fim).Copy
    Sheets(abaSaude).Select
    Range(Data).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False

    Sheets(baseDeDados).Select
    
ce = "D" & linha_passar
ceMoFim = "Z2:AA"
    
    Range(ceMoFim & linha_fim).Copy
    Sheets(abaSaude).Select
    Range(ce).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
periodo2Cop = "F" & linha_passar
periodoFim = "AD2:AD"
    
    Range(periodoFim & linha_fim).Copy
    Sheets(abaSaude).Select
    Range(periodo2Cop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
saude = "G" & linha_passar
saudeFim = "R2:Y"
    
    Range(saudeFim & linha_fim).Copy
    Sheets(abaSaude).Select
    Range(saude).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
inscricaoOkCop = "P" & linha_passar
inscricaoOkFim = "AV2:AV"
    Range(inscricaoOkFim & linha_fim).Copy
    Sheets(abaSaude).Select
    Range(inscricaoOkCop).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
inicio = "O" & linha_passar    ' ESCOLA
fim = "BK2:BK"                  ' ESCOLA VERIFICAR APENAS DE CRIANÇA
    Range(fim & linha_fim).Copy
    Sheets(abaSaude).Select
    Range(inicio).Select
    Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
        SkipBlanks:=False, Transpose:=False
    Application.CutCopyMode = False
    
    Sheets(baseDeDados).Select
    
    
'FIM PassarParaSaude
End Sub


Sub Sorteio()


Application.ScreenUpdating = False

' Colocação GERAL
'=PROCV(C2;Legenda!$J$2:$K$2011;2)


Sheets("Inscrição").Select


linha_fim = Range("D1").End(xlDown).Row


 legendaFixa = "Legenda!$J$2:$K$2011"
 nSorteio1 = "C2"
 colocacaoGeral = "B2"
 colocacaoGeralFim = "B2:B"

    Range(colocacaoGeral).Select
    ActiveCell.FormulaLocal = "=PROCV(" & nSorteio1 & ";" & legendaFixa & ";2)"
    Selection.AutoFill Destination:=Range(colocacaoGeralFim & linha_fim), Type:=xlFillDefault
    Range(colocacaoGeralFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM coluna Numero do sorteio


Sheets("Inscrição").Select

' OrganizarParaNdeSoreteio POR TURMA E LISTA
'
' B1 Colocação da menor para a maior
    Rows("1:1").Select
    Selection.AutoFilter
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("B1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' AI1 idTurma Ok Lista por ordem alfabetica   ESTA SEPARANDO AS VALIDAS
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("AI1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With

    Selection.AutoFilter


'FIM organizar pronto para numerar

'NUMERANDO =SE(AI1=AI2;AL1+1;1) BE1 idTurmaOkLista 1
idTurma = "AI2"
idTurma1 = "AI1"
nSorteio1 = "AL1"
nSorteio = "AL2"
nSorteioFim = "AL2:AL"

' Numero do sorteio
    Range(nSorteio).Select
    ActiveCell.FormulaLocal = "=SE(" & idTurma1 & "=" & idTurma & ";" & nSorteio1 & "+1;1)"
    Selection.AutoFill Destination:=Range(nSorteioFim & linha_fim), Type:=xlFillDefault
    Range(nSorteioFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM Coluna COLOCAÇÃO FINAL POR TURMA E LISTA

Sheets("Inscrição").Select

' OrganizarParaNdeSoreteio
'
' B1 Colocação da menor para a maior
    Rows("1:1").Select
    Selection.AutoFilter
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("B1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' O1 idTurma por ordem alfabetica
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("O1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' P1 Validade ordem inversa para os OK virem antes - DESSAFORMA FASSO COM TODOS DIFERENCIANDO VALIDADE
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("P1"), SortOn:=xlSortOnValues, Order:=xlDescending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    Selection.AutoFilter


'FIM organizar pronto para numerar

'NUMERANDO =SE(O1=O2;A1+1;1) BE1 idTurma1
idTurma = "O2"
idTurma1 = "O1"
nSorteio1 = "A1"
nSorteio = "A2"
nSorteioFim = "A2:A"

' Numero do sorteio
    Range(nSorteio).Select
    ActiveCell.FormulaLocal = "=SE(" & idTurma1 & "=" & idTurma & ";" & nSorteio1 & "+1;1)"
    Selection.AutoFill Destination:=Range(nSorteioFim & linha_fim), Type:=xlFillDefault
    Range(nSorteioFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM NUMERAR COLOCAÇÃO FINAL POR TURMA

'Verificação 1
'SE n total de inscritos menor ou igual que quantidade de vagas = Matricula
'SE n do sorteio menor ou igual a n de vagas por LISTA = Matricula
'AG =SE(I2<=H2;"Matricular";SE(AL2<=AK2;"MatriculaR";"Espera"))

totalInscritos = "I2"
totalVagas = "H2"
nSorteioLista = "AL2"
totalLista = "AK2"
inicio = "AG2"
fim = "AG2:AG"
inserirForm = "=SE(" & totalInscritos & "<=" & totalVagas & ";""Matricular"";SE(" & nSorteioLista & "<=" & totalLista & ";""MatriculaR"";""Espera""))"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM Verificação 1 de Matriculados

'Concatenar turmaOk e Matricular ou Espera AH =CONCATENAR(AG2;O2;P2)
matricular = "AG2"
turma = "O2"
OK = "P2"
inicio = "AH2"
fim = "AH2:AH"
inserirForm = "=CONCATENAR(" & matricular & ";" & turma & ";" & OK & ")"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM Concatenar Matricular ou Espera turma Ok

'Concatenar turmaOk e sempre Matricular para comparar AM =CONCATENAR(AG2;O2;P2)
matricular = "$AG$1"
turma = "O2"
OK = "P2"
inicio = "AM2"
fim = "AM2:AM"
inserirForm = "=CONCATENAR(" & matricular & ";" & turma & ";" & OK & ")"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM Concatenar sempre Matricular turma Ok

'Contar Matriculados (necessario para verificar se quantidade de matriculados é igual a quantidade de vagas
'AE =CONT.SE($AH$2:$AH$353;AM2)

concatenado = "AM2"
fixo = "$AH$2:$AH$"
inicio = "AE2"
fim = "AE2:AE"
inserirForm = "=CONT.SE(" & fixo & linha_fim & ";" & concatenado & ")"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM Contar matriculados por turmaok

' já está ordenado pela colocação final,
' Precisa Ordenar pela Espera
' AG1 Espera da menor para a maior (Espera vem primeiro)
    Rows("1:1").Select
    Selection.AutoFilter
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("AG1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    Selection.AutoFilter

'
' ordem de espera para fazer a conta de quantas pessoas faltam chamar para completar o numero de vagas
' AF =SE(AH2=AH1;AF1+1;1)
ah1 = "AH1"     'MatricularIdTurmaOk
ah2 = "AH2"
af1 = "AF1"     'Ordem de Espera
inicio = "AF2"
fim = "AF2:AF"
inserirForm = "=SE(" & ah2 & " =" & ah1 & ";" & af1 & "+1;1)"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM Ordem de Espera

' Voltar a Ordenar pela colocação final
' A1 Colocação Final da menor para a maior
    Rows("1:1").Select
    Selection.AutoFilter
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("A1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' O1 idTurma por ordem alfabetica
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("O1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' P1 Validade ordem inversa para os OK virem antes
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("P1"), SortOn:=xlSortOnValues, Order:=xlDescending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    Selection.AutoFilter

'FIM organizar pronto para numerar a Ordem de Espera

' Ultima verificação
' SE já é matricular, mantem
' SE n de espera é menor ou igual a quantidade que falta para completar a turma Matricular
' Lista de ESPERA AC =SE(AG2=$AG$1;$AG$1;SE(AF2<=H2-AE2;$AG$1;)) "& ag1 &"
ag1 = "$AG$1"   ' Matricular
ag2 = "AG2"     '
af2 = "AF2"     ' Ordem de espera
h2 = "H2"       ' Vagas total
ae2 = "AE2"     ' Total de Matriculados
inicio = "AC2"  '
fim = "AC2:AC"  '
inserirForm = "=SE(" & ag2 & "=" & ag1 & ";" & ag1 & ";SE(" & af2 & "<=" & h2 & "-" & ae2 & ";" & ag1 & ";""Espera""))"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM ordem de Espera

' - - - - - - - contar matricular final com id turma "ok"
'AM já está com sempre matricular turma e validade

'Concatenar turmaOk e Matricular ou Espera AH =CONCATENAR(AG2;O2;P2)

matricular = "AC2"      ' AC LISTA DE ESPERA FINAL
turma = "O2"
OK = "P2"
inicio = "AH2"
fim = "AH2:AH"
inserirForm = "=CONCATENAR(" & matricular & ";" & turma & ";" & OK & ")"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM Concatenar Matricular ou Espera turma Ok
'Contar Matriculados (necessario para verificar a quantidade de matriculados total para saber até onde imprimir a matricula
'AE =CONT.SE($AH$2:$AH$353;AM2)

concatenado = "AM2"
fixo = "$AH$2:$AH$"
inicio = "AE2"
fim = "AE2:AE"
inserirForm = "=CONT.SE(" & fixo & linha_fim & ";" & concatenado & ")"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM Contar matriculados final por turmaok

' se for diferente de ok coloca Espera Evitar imprimir invalidos
'repetição para passar por todas as linhas
linha = 2
'
While linha <= linha_fim
   ' verificar se P (Validade) <diferente> OK
  If Range("P" & linha).Value <> "OK" Then
                               '- Else
    ' Troca de matricular para Espera
    Range("AC" & linha).Value = "Espera"
  End If
      linha = linha + 1
Wend



Sheets("Menu").Select
Range("A8").Value = "Sorteio Antes de imprimir OK"

'FIM SORTEIO

'Call ImprimirPdf3ListaFinal


Application.ScreenUpdating = True

End Sub
Sub ImprimirPdf2NSorteio()
'
' ImprimirPdfValidos Macro
'

'
Application.ScreenUpdating = False
Call TrocarCorDasTurmas

Sheets("Inscrição").Select


linha_fim = Range("D1").End(xlDown).Row     ' D1 Carimbo
fixa = "$A$1:$BH$"
imprimir = "C1:N1"
imprimirFixo = "$C$1:$N$"


'Organizar colunas

    Columns("C:C").Select
    With Selection
        .HorizontalAlignment = xlGeneral
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    With Selection
        .HorizontalAlignment = xlCenter
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With

    'COLOCAR 90 GRAUS
    
    Range("A1:C1").Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .WrapText = True
        .Orientation = 90
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    
 ' - - - - - OCULTA OU NÃO A LISTA (GERAL, PCD ...)
    
'    Columns("G:G").Select           'Ocultar Lista
'    Selection.EntireColumn.Hidden = True
    Columns("J:J").Select           'Ocultar Centro Esportivo (Já está escrito em cima da página
    Selection.EntireColumn.Hidden = True
    Columns("O:O").Select           'Ocultar até codigo da turma P VALIDADE
    Selection.EntireColumn.Hidden = True
' FIM organizar


    Rows("1:1").Select
    Selection.AutoFilter
    ' ORDENAR POR ORDEM DE INSCRIÇÃO
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("C1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption _
        :=xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' O1 idTurma por ordem alfabetica
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("O1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' Ocultando as Invalidas
    ActiveSheet.Range(fixa & linha_fim).AutoFilter Field:=16, Criteria1:="OK"  ' SOMENTE INSCRIÇÕES VÁLIDAS

' FIM ORGANIZAR POR ORDEM DE SORTEIO E POR TURMA
    
    ' Iniciar repetição para passar por todos os CE e imprimir as inscrições válidas
    °CAMINHO_Centros = Sheets("Legenda").Cells(1, 1) ' A1.Value (caminho no computador)C:\Users\jplur\OneDrive\Imagens\Profissional\SBC

linhaFim = 25       ' Na Legenda Centro Esportivo vai até a linha 25
linha = 2
'
While linha <= linhaFim

    centroEsportivo = Range("Legenda!C" & linha).Value
    
    ActiveSheet.Range(fixa & linha_fim).AutoFilter Field:=10, Criteria1:= _
        centroEsportivo    ' NOME DO CENTRO ESPORTIVO A SER IMPRIMIDO
        
' Cabeçalho = "INSCRIÇÕES VÁLIDAS - " & centroEsportivo & "."
' Cabecalho Macro
'
    Rows("1:1").Select
    Selection.Insert Shift:=xlDown, CopyOrigin:=xlFormatFromLeftOrAbove
    With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .ThemeColor = xlThemeColorAccent2
        .TintAndShade = 0.599993896298105
        .PatternTintAndShade = 0
    End With
    Range(imprimir).Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
        .Font.Size = 14

    End With
    Selection.Merge
    ActiveCell.FormulaR1C1 = "NÚMERO PARA O SORTEIO - " & centroEsportivo
    Range(imprimir).Select
    Selection.Font.Bold = True
    With Selection.Font
        .ThemeColor = xlThemeColorLight1
        .TintAndShade = 0
    End With
    Rows("1:1").RowHeight = 23.25

' IMPRIMINDO
    Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .PrintTitleRows = "$1:$2"  ' linha que será repetida no topo de cada pagina
        .PrintTitleColumns = ""
        .PrintGridlines = True
    End With
    Application.PrintCommunication = False
    ActiveSheet.PageSetup.PrintArea = imprimirFixo & linha_fim
    Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .LeftHeader = ""
        .CenterHeader = ""
        .RightHeader = ""
        .LeftFooter = ""
        .CenterFooter = ""
        .RightFooter = "&P/&N"
        .LeftMargin = Application.InchesToPoints(0.236220472440945)
        .RightMargin = Application.InchesToPoints(0.236220472440945)
        .TopMargin = Application.InchesToPoints(0.748031496062992)
        .BottomMargin = Application.InchesToPoints(0.748031496062992)
        .HeaderMargin = Application.InchesToPoints(0.31496062992126)
        .FooterMargin = Application.InchesToPoints(0.31496062992126)
        .PrintHeadings = False
        .PrintGridlines = True
        .PrintComments = xlPrintSheetEnd
        .PrintQuality = 600
        .CenterHorizontally = True
        .CenterVertically = False
        .Orientation = xlPortrait
        .Draft = False
        .PaperSize = xlPaperA4
        .FirstPageNumber = xlAutomatic
        .Order = xlDownThenOver
        .BlackAndWhite = False
    Application.DisplayAlerts = False
        
        .Zoom = False
        
    Application.DisplayAlerts = True
    
        .FitToPagesWide = True        'Define a quantidade de páginas na largura em que os dados impressos serão escalados
        .FitToPagesTall = False
        .PrintErrors = xlPrintErrorsDisplayed
        .OddAndEvenPagesHeaderFooter = False
        .DifferentFirstPageHeaderFooter = False
        .ScaleWithDocHeaderFooter = True
        .AlignMarginsHeaderFooter = True
        .EvenPage.LeftHeader.Text = ""
        .EvenPage.CenterHeader.Text = ""
        .EvenPage.RightHeader.Text = ""
        .EvenPage.LeftFooter.Text = ""
        .EvenPage.CenterFooter.Text = ""
        .EvenPage.RightFooter.Text = ""
        .FirstPage.LeftHeader.Text = ""
        .FirstPage.CenterHeader.Text = ""
        .FirstPage.RightHeader.Text = ""
        .FirstPage.LeftFooter.Text = ""
        .FirstPage.CenterFooter.Text = ""
        .FirstPage.RightFooter.Text = ""
    End With
    Application.PrintCommunication = False
    ActiveWindow.SelectedSheets.PrintOut Copies:=1, PrintToFile:=True, Collate _
        :=True, IgnorePrintAreas:=False, PrToFileName:= _
    °CAMINHO_Centros & "Centros Esportivos pdf válidos n sorteio\" & centroEsportivo & " - Ordem de inscrição.pdf"

'Apagar cabeçalho
'Voltar padrão
    Rows("1:1").Select
    Selection.Delete Shift:=xlUp
    Selection.RowHeight = 38.25

linha = linha + 1
'linha = 50000 + 1
Wend

Rows("1:1").Select
Selection.AutoFilter
ActiveWorkbook.Worksheets("Inscrição").Cells.Select
    Selection.EntireColumn.Hidden = False
    Selection.EntireRow.Hidden = False
' apagar as configurações de cor
    Range("A2:AT" & linha_fim).Select
    With Selection.Interior
        .Pattern = xlNone
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With
    Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
    Selection.Borders(xlEdgeBottom).LineStyle = xlNone
    
    Sheets("Menu").Select
Range("A6").Value = "PDF2 NºSorteio OK"

Application.ScreenUpdating = True

 ' FIM imprimir pdf numerados

End Sub
Sub ImprimirPdf3ListaFinal()
'
' ImprimirPdfValidos Macro
'

'
Sheets("Inscrição").Select
Application.ScreenUpdating = False


linha_fim = Range("D1").End(xlDown).Row     ' D1 Carimbo
fixa = "$A$1:$BH$"
imprimir = "A1:AC1"
imprimirFixo = "$A$1:$AC$"


'Organizar colunas

    Columns("A:B").Select
    With Selection
        .HorizontalAlignment = xlGeneral

    End With
    With Selection
        .HorizontalAlignment = xlCenter

    End With
        Columns("AC:AC").Select
    With Selection
        .HorizontalAlignment = xlGeneral

    End With
    With Selection
        .HorizontalAlignment = xlCenter

    End With
    
    'COLOCAR 90 GRAUS
    
    Range("A1:C1").Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .WrapText = True
        .Orientation = 90
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    
    Columns("D:D").Select           'Ocultar DATA E HORA (Já está escrito em cima da página
    Selection.EntireColumn.Hidden = True
    Columns("B:B").Select           'Ocultar N SORTEIO GRANDE (Já está escrito em cima da página
    Selection.EntireColumn.Hidden = True
    Columns("J:J").Select           'Ocultar Centro Esportivo (Já está escrito em cima da página
    Selection.EntireColumn.Hidden = True
    Columns("O:AB").Select           'Ocultar Informaççoes antes de matricula AC
    Selection.EntireColumn.Hidden = True
' FIM organizar


' - - - - - - - - COLUNA A     Selection.NumberFormat = "0º"

Range("A:A").Select
Selection.NumberFormat = "0º"
' Para não perder essas informações
Selection.Copy
Range("AU:AU").Select
Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, _
    SkipBlanks:=False, Transpose:=False
Application.CutCopyMode = False

' ORGANIZAR POR LISTA (G) INVERSA
    Rows("1:1").Select
    Selection.AutoFilter
ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear     ' ORDENAR POR ORDEM DE TURMA
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("G1"), SortOn:=xlSortOnValues, Order:=xlDescending, DataOption _
        :=xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    
' FIM ORGANIZAR POR LISTA
' ORGANIZAR POR TURMA
ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear     ' ORDENAR POR ORDEM DE TURMA
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("O1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption _
        :=xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
 ' FIM ORGANIZAR POR ORDEM DE TURMA
' - - - - - - - - - - - - Númerar classificação por lista

'NUMERANDO =SE(E(O1=O2;G1=G2);A1+1;1) BE1 idTurma1
idTurma = "O2"
idTurma1 = "O1"
g1 = "G1"
g2 = "G2"
nSorteio1 = "A1"
nSorteio = "A2"
nSorteioFim = "A2:A"

' Numero do sorteio
    Range(nSorteio).Select
    ActiveCell.FormulaLocal = "=SE(E(" & idTurma1 & "=" & idTurma & ";" & g1 & "=" & g2 & ");" & nSorteio1 & "+1;1)"
    Selection.AutoFill Destination:=Range(nSorteioFim & linha_fim), Type:=xlFillDefault
    Range(nSorteioFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
    
' FIM NUMERAR COLOCAÇÃO FINAL POR TURMA

' pinta a linha
Call TrocarCorDasTurmas


' Ocultando as Invalidas
    Rows("1:1").Select
    Selection.AutoFilter
    ActiveSheet.Range(fixa & linha_fim).AutoFilter Field:=16, Criteria1:="OK"  ' SOMENTE INSCRIÇÕES VÁLIDAS


        
    ' Impressão definições
    Application.PrintCommunication = False
    ActiveSheet.PageSetup.PrintArea = imprimirFixo & linha_fim
    Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .RightFooter = "&P/&N"
        .LeftMargin = Application.InchesToPoints(0.236220472440945)
        .RightMargin = Application.InchesToPoints(0.236220472440945)
        .TopMargin = Application.InchesToPoints(0.748031496062992)
        .BottomMargin = Application.InchesToPoints(0.748031496062992)
        .HeaderMargin = Application.InchesToPoints(0.31496062992126)
        .FooterMargin = Application.InchesToPoints(0.31496062992126)
        .PrintHeadings = False
        .PrintGridlines = True
        .PrintComments = xlPrintSheetEnd
        .PrintQuality = 600
        .CenterHorizontally = True
        .CenterVertically = False
        .Orientation = xlPortrait
        .Draft = False
        .PaperSize = xlPaperA4
        .FirstPageNumber = xlAutomatic
        .Order = xlDownThenOver
        .BlackAndWhite = False
    Application.DisplayAlerts = False
        
        .Zoom = False
        
    Application.DisplayAlerts = True
    
        .FitToPagesWide = True        'Define a quantidade de páginas na largura em que os dados impressos serão escalados
        .FitToPagesTall = False
        .PrintErrors = xlPrintErrorsDisplayed
        .OddAndEvenPagesHeaderFooter = False
        .DifferentFirstPageHeaderFooter = False
        .ScaleWithDocHeaderFooter = True
        .AlignMarginsHeaderFooter = True

    End With
'Definições de impressão
    ' Iniciar repetição para passar por todos os CE e imprimir as inscrições válidas
    °CAMINHO_Centros = Sheets("Legenda").Cells(1, 1) ' A1.Value (caminho no computador)C:\Users\jplur\OneDrive\Imagens\Profissional\SBC/
linhaFim = 25       ' Na Legenda Centro Esportivo vai até a linha 25
linha = 2
'
While linha <= linhaFim

    centroEsportivo = Range("Legenda!C" & linha).Value
    
    ActiveSheet.Range(fixa & linha_fim).AutoFilter Field:=10, Criteria1:= _
        centroEsportivo    ' NOME DO CENTRO ESPORTIVO A SER IMPRIMIDO
        
' Cabeçalho = "INSCRIÇÕES VÁLIDAS - " & centroEsportivo & "."
' Cabecalho Macro
'
    Rows("1:1").Select
    Selection.Insert Shift:=xlDown, CopyOrigin:=xlFormatFromLeftOrAbove
    With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .ThemeColor = xlThemeColorAccent2
        .TintAndShade = 0.599993896298105
        .PatternTintAndShade = 0
    End With
    Range(imprimir).Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
        .Font.Size = 14

    End With
    Selection.Merge
    ActiveCell.FormulaR1C1 = "LISTA FINAL - " & centroEsportivo & "."
    Range(imprimir).Select
    Selection.Font.Bold = True
    With Selection.Font
        .ThemeColor = xlThemeColorLight1
        .TintAndShade = 0
    End With
    Rows("1:1").RowHeight = 23.25

' IMPRIMINDO
    Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .PrintTitleRows = "$1:$2"  ' linha que será repetida no topo de cada pagina

    End With
    
    Application.PrintCommunication = False
    ActiveWindow.SelectedSheets.PrintOut Copies:=1, PrintToFile:=True, Collate _
        :=True, IgnorePrintAreas:=False, PrToFileName:= _
    °CAMINHO_Centros & "Centros Esportivos pdf Lista Final\" & centroEsportivo & " - Lista Final.pdf"

'Apagar cabeçalho
'Voltar padrão
    Rows("1:1").Select
    Selection.Delete Shift:=xlUp
    Selection.RowHeight = 38.25

linha = linha + 1
'linha = linha + 50
Wend

Rows("1:1").Select
Selection.AutoFilter
ActiveWorkbook.Worksheets("Inscrição").Cells.Select
    Selection.EntireColumn.Hidden = False
    Selection.EntireRow.Hidden = False
    ' apagar as configurações de cor
    Range("A2:AT" & linha_fim).Select
    With Selection.Interior
        .Pattern = xlNone
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With
    Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
    Selection.Borders(xlEdgeBottom).LineStyle = xlNone
    
    Sheets("Menu").Select
Range("A10").Value = "PDF3 Lista Final OK"

Application.ScreenUpdating = True

 ' FIM imprimir pdf SORTEADOS para MATRICULAR

End Sub

Sub TrocarCorDasTurmas()
    
Application.ScreenUpdating = False
Sheets("Inscrição").Select
linha_fim = Range("D1").End(xlDown).Row     ' D1 Carimbo

'repetição para passar por todas as linhas
linha = 2
'
While linha <= linha_fim
    
   ' verificar se AT = zero (pintar as linhas que tem o at = 0
  If Range("AT" & linha).Value = 0 Then
                                '- Else
    'pintar a linha
    Range("A" & linha & ":AT" & linha).Select
    With Selection.Interior
    
        .ThemeColor = xlThemeColorDark2
    End With
    With Selection.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .ThemeColor = 1
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With Selection.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .ThemeColor = 1
        .TintAndShade = 0
        .Weight = xlThin
    End With
    With Selection.Borders(xlInsideHorizontal)
        .LineStyle = xlContinuous
        .ThemeColor = 1
        .TintAndShade = 0
        .Weight = xlThin
    End With
    
  End If
  
      linha = linha + 1
Wend

End Sub
Sub TaxarInvalidos()
 Application.ScreenUpdating = False
Sheets("Inscrição").Select
linha_fim = Range("D1").End(xlDown).Row     ' D1 Carimbo

linha = 2
' repetição para taxar
While linha <= linha_fim
    
   ' verificar se P VALIDADE = duplicada
  If Range("P" & linha).Value <> "OK" Then
                                '- Else
    'Taxar
    Range("A" & linha & ":AT" & linha).Select
    With Selection.Font
        .Strikethrough = True
    End With
  End If
  
      linha = linha + 1
Wend

End Sub

Sub ImprimirPdf1()
'
' ImprimirPdfValidos Macro
'
Application.ScreenUpdating = False

Sheets("Inscrição").Select

' Range("E1").Value = "NOME DO INTERESSADO (de A a Z)"
'
linha_fim = Range("D1").End(xlDown).Row     ' D1 Carimbo

'Organizar colunas
Rows("2:1048576").Select
    With Selection.Font
        .Name = "Arial"
        .Size = 10
        .Strikethrough = False
        .Superscript = False
        .Subscript = False
        .OutlineFont = False
        .Shadow = False
        .Underline = xlUnderlineStyleNone
  '      .ThemeColor = xlThemeColorLight1
        .TintAndShade = 0
        .ThemeFont = xlThemeFontNone
    End With
Columns("D:D").Select
    With Selection
        .HorizontalAlignment = xlLeft
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
Columns("F:I").Select
    With Selection
        .HorizontalAlignment = xlGeneral

    End With
    With Selection
        .HorizontalAlignment = xlCenter

    End With
    Columns("L:P").Select
    With Selection
        .HorizontalAlignment = xlGeneral

    End With
    With Selection
        .HorizontalAlignment = xlCenter

    End With
    
        'COLOCAR 90 GRAUS
    
    Range("A1:C1").Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .WrapText = True
        .Orientation = 90
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With

Call TrocarCorDasTurmas
    
'Taxar Duplicadas
Call TaxarInvalidos
    
    Columns("G:J").Select           'Ocultar DE VAGAS A Centro Esportivo
    Selection.EntireColumn.Hidden = True
    Columns("O:O").Select           'Ocultar até P VALIDADE
    Selection.EntireColumn.Hidden = True
' FIM organizar


fixa = "$A$1:$BH$"

' Ocultando as Validas NÃO MAIS
    Rows("1:1").Select
    Selection.AutoFilter
 '   ActiveSheet.Range(fixa & linha_fim).AutoFilter Field:=16, Criteria1:="INVÁLIDA"  ' SOMENTE INSCRIÇÕES INVÁLIDAS
 
 ' ORDENAR POR ORDEM DE INSCRIÇÃO D
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("D1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption _
        :=xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' FIM ORGANIZAR POR ORDEM DE INSCRIÇÃO
' ORDENAR POR ORDEM DE TURMA
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("O1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption _
        :=xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    Selection.AutoFilter
' FIM ORGANIZAR POR ORDEM DE TURMA
    
 

°CAMINHO_Centros = Sheets("Legenda").Cells(1, 1) ' A1.Value (caminho no computador)C:\Users\jplur\OneDrive\Imagens\Profissional\SBC/
imprimir = "D1:P1"
imprimirFixo = "$D$1:$P$"
' Definir impressão

    Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .RightFooter = "&P/&N"
        .LeftMargin = Application.InchesToPoints(0.236220472440945)
        .RightMargin = Application.InchesToPoints(0.236220472440945)
        .TopMargin = Application.InchesToPoints(0.748031496062992)
        .BottomMargin = Application.InchesToPoints(0.748031496062992)
        .HeaderMargin = Application.InchesToPoints(0.31496062992126)
        .FooterMargin = Application.InchesToPoints(0.31496062992126)
        .PrintComments = xlPrintSheetEnd
        .PrintQuality = 600
        .CenterHorizontally = True
        .CenterVertically = False
        .Orientation = xlPortrait
        .Draft = False
        .PaperSize = xlPaperA4
        .FirstPageNumber = xlAutomatic
        .Order = xlDownThenOver
        .BlackAndWhite = False
    Application.DisplayAlerts = False
        
        .Zoom = False
        
    Application.DisplayAlerts = True
    
        .FitToPagesWide = True        'Define a quantidade de páginas na largura em que os dados impressos serão escalados
        .FitToPagesTall = False
        .PrintErrors = xlPrintErrorsDisplayed
        .OddAndEvenPagesHeaderFooter = False
        .DifferentFirstPageHeaderFooter = False
        .ScaleWithDocHeaderFooter = True
        .AlignMarginsHeaderFooter = True
    End With

' Iniciar repetição para passar por todos os CE e imprimir as inscrições
    
linhaFim = 25       ' Na Legenda Centro Esportivo vai até a linha 25
linha = 2
'
While linha <= linhaFim

    centroEsportivo = Range("Legenda!C" & linha).Value
    
    ActiveSheet.Range(fixa & linha_fim).AutoFilter Field:=10, Criteria1:= _
        centroEsportivo    ' NOME DO CENTRO ESPORTIVO A SER IMPRIMIDO
        
' Cabeçalho = "INSCRIÇÕES VÁLIDAS - " & centroEsportivo & "."
' Cabecalho Macro


    Rows("1:1").Select
    Selection.Insert Shift:=xlDown, CopyOrigin:=xlFormatFromLeftOrAbove
    With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .ThemeColor = xlThemeColorAccent2
        .TintAndShade = 0.599993896298105
        .PatternTintAndShade = 0
    End With
    Range(imprimir).Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
        .Font.Size = 14

    End With
    Selection.Merge
    ActiveCell.FormulaR1C1 = "INSCRIÇÕES REALIZADAS (Válidas e Invalidas) - " & centroEsportivo
    Range(imprimir).Select
    Selection.Font.Bold = True
    With Selection.Font
        .ThemeColor = xlThemeColorLight1
        .TintAndShade = 0
    End With
    Rows("1:1").RowHeight = 23.25
' - - FIM  - - - cabeçalho
' IMPRIMINDO
    Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .PrintTitleRows = "$1:$2"  ' linha que será repetida no topo de cada pagina
        .PrintTitleColumns = ""
        .PrintGridlines = True
    End With
    Application.PrintCommunication = False
    ActiveSheet.PageSetup.PrintArea = imprimirFixo & linha_fim
    Application.PrintCommunication = False
    ActiveWindow.SelectedSheets.PrintOut Copies:=1, PrintToFile:=True, Collate _
        :=True, IgnorePrintAreas:=False, PrToFileName:= _
    °CAMINHO_Centros & "Centros Esportivos pdf todas as inscrições\" & centroEsportivo & " - Todas as inscrições.pdf"

'Apagar cabeçalho
'Voltar padrão
    Rows("1:1").Select
    Selection.Delete Shift:=xlUp
    Selection.RowHeight = 38.25

linha = linha + 1

Wend

Rows("1:1").Select
Selection.AutoFilter
ActiveWorkbook.Worksheets("Inscrição").Cells.Select
    Selection.EntireColumn.Hidden = False
    Selection.EntireRow.Hidden = False
    
        ' apagar as configurações de cor e TaxarInvalidos
    Range("A2:AT" & linha_fim).Select
    With Selection.Interior
        .Pattern = xlNone
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With
' deixa ou não o taxado?
    With Selection.Font
        .Strikethrough = False
    End With
         
    Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
    Selection.Borders(xlEdgeBottom).LineStyle = xlNone
    
    Sheets("Menu").Select
Range("A4").Value = "PDF1 OK"

Application.ScreenUpdating = True

 ' FIM imprimir pdf INVÁLIDAS
 
End Sub
Sub Verificacao()

Application.ScreenUpdating = False
Sheets("Inscrição").Select
linha_fim = Range("D1").End(xlDown).Row     ' D1 Carimbo
' ADICIONANDO AS COLUNAS DE VERIFICAÇÃO

'Concatenar DIREITA e fazer a conta da idade

'AR ANO IDADE =2021-ANO(R2)
y = "R2"     ' ano cpf original
inicio = "AR2"
fim = "AR2:AR"
unicaFormula = "=2021 - DIREITA(" & y & ";4)"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM  Idade

' numerar para poder pintar alternando as cores das turmas


    Rows("1:1").Select
    Selection.AutoFilter
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear     ' ORDENAR POR ORDEM DE TURMA
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("O1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption _
        :=xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    Selection.AutoFilter
' FIM ORGANIZAR POR ORDEM DE TURMA


' AS = =SE(O1=O2;AS1;AS1+1)
o1 = "O1=O2"    ' Turma se for igual
as1 = "AS1"     ' AS1 = 0 ... conta para ficar numero par ou impar
inicio = "AS2"
fim = "AS2:AS"
unicaFormula = "=SE(" & o1 & ";" & as1 & ";" & as1 & "+1)"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM numeração das turmas

    ' AT = =MOD(AS2;2)Resultado em 0 e 1
    
as2 = "AS2"     ' AS2 = 0 ... valor par ou impar
inicio = "AT2"  ' Recebe 0 ou 1 (se par 0 se impar 1)
fim = "AT2:AT"
unicaFormula = "=MOD(" & as2 & ";2)"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM par ou impar

'apagar excesso de informações
inicio = "AS2:AS"
Range(inicio & linha_fim).Select
Selection.ClearContents
'
' - - - - - - - - CORRIGIR ERRO DE NÃO SUBSTITUIR O VERDADEIRO E FALSO - - - - - - -
' PASSANDO PRA MAIUSCULA
nomeOriginal = "AN2"   ' status cpf
nomeCaps = "BA2"       ' vou apagar depois
nomeFim = "BA2:BA"
    Range(nomeCaps).Select
    ActiveCell.FormulaLocal = "=ARRUMAR(MAIÚSCULA(" & nomeOriginal & "))"
    Selection.AutoFill Destination:=Range(nomeFim & linha_fim), Type:=xlFillDefault
    Range(nomeFim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM coluna d PARA Maiuscula
    Range(nomeFim & linha_fim).Cut
Range(nomeOriginal).Select
    ActiveSheet.Paste
Selection.NumberFormat = "@"
' trocar os STATUS
trocar = "AN:AN"    'STATUS CPF
    Columns(trocar).Select
On Error Resume Next
    Selection.Find(What:="VERDADEIRO", After:=ActiveCell, LookIn:=xlFormulas _
        , LookAt:=xlPart, SearchOrder:=xlByColumns, SearchDirection:=xlNext, _
        MatchCase:=False, SearchFormat:=False).Activate
    Selection.Replace What:="VERDADEIRO", Replacement:=" ", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Find(What:="FALSO", After:=ActiveCell, LookIn:=xlFormulas _
        , LookAt:=xlPart, SearchOrder:=xlByColumns, SearchDirection:=xlNext, _
        MatchCase:=False, SearchFormat:=False).Activate
    Selection.Replace What:="FALSO", Replacement:="CPF", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
On Error Resume Next
        
' Fim status CPF
trocar = "AO:AO"    'STATUS DUPLICADOS
    Columns(trocar).Select
    Selection.Replace What:=" NEGADA ", Replacement:="ERRO", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:=" OK ", Replacement:=" ", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
' Fim status DUPLICADOS
trocar = "AP:AP"    'STATUS IDADE
    Columns(trocar).Select
    Selection.Replace What:="NEGADA", Replacement:="IDADE", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
    Selection.Replace What:="OK", Replacement:=" ", LookAt:=xlPart, _
        SearchOrder:=xlByColumns, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False
' Fim status DUPLICADOS
'  - - - - - FIM TROCA DE STATUS - - - - -

'AU ARRUMAR  =ARRUMAR(CONCATENAR(AN2;" ";AP2))
x = "AN2"     ' CPF
y = "AP2"
inicio = "AU2"
fim = "AU2:AU"
unicaFormula = "=ARRUMAR(CONCATENAR(" & x & ";"" "";" & y & "))"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM ARRUMAR


End Sub

Sub ImprimirPdf4Matricula()
'
Application.ScreenUpdating = False
Sheets("Inscrição").Select
linha_fim = Range("D1").End(xlDown).Row     ' D1 Carimbo




' A1 Colocação Final da menor para a maior
    Rows("1:1").Select
    Selection.AutoFilter
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("A1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' O1 idTurma por ordem alfabetica
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("O1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' AC Validade ordem inversa para os MATRICULAR virem antes
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("AC1"), SortOn:=xlSortOnValues, Order:=xlDescending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    Selection.AutoFilter

'FIM organizar pronto para numerar a Ordem de MATRICULA

' Ultima verificação
' SE já é matricular, mantem
' SE n de espera é menor ou igual a quantidade que falta para completar a turma Matricular
' Lista de ESPERA AD =SE(AC2="Matricular";SE(O2=O1;AD1+1;1);100)
ag1 = "$AG$1"   ' Matricular
ac2 = "AC2"     ' Lista de Espera
o2 = "O2"     ' id Turma
o1 = "O1"
ad1 = "AD1"     ' Ordem de Matriculados
inicio = "AD2"  '
fim = "AD2:AD"  '=SE(AC2="Matricular";SE(O2=O1;AD1+1;1);100)
inserirForm = "=SE(" & ac2 & "=""Matricular"";SE(" & o2 & "=" & o1 & ";" & ad1 & "+1;1);100)"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM ordem de Espera

'Definições de impressão

Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .RightFooter = "&P/&N"
  '      .LeftMargin = Application.InchesToPoints(0.708661417322835)
   '     .RightMargin = Application.InchesToPoints(0.708661417322835)
    '    .TopMargin = Application.InchesToPoints(0.590551181102362)
     '   .BottomMargin = Application.InchesToPoints(0.511811023622047)
      '  .HeaderMargin = Application.InchesToPoints(0.31496062992126)
       ' .FooterMargin = Application.InchesToPoints(0.31496062992126)
        
        .RightMargin = Application.InchesToPoints(0.33)
        .HeaderMargin = Application.InchesToPoints(0.17)
        .TopMargin = Application.InchesToPoints(0.3)
        .RightMargin = Application.InchesToPoints(0.29)
        .LeftMargin = Application.InchesToPoints(0.39)
        .FooterMargin = Application.InchesToPoints(0.23)
        .BottomMargin = Application.InchesToPoints(0.43)
        
        .PrintHeadings = False
        .PrintGridlines = False
        .PrintComments = xlPrintNoComments
        .PrintQuality = 600
        .CenterHorizontally = True
        .CenterVertically = False
        .Orientation = xlPortrait
        .Draft = False
        .PaperSize = xlPaperA4
        .FirstPageNumber = xlAutomatic
        .Order = xlDownThenOver
        .BlackAndWhite = False
        
        Application.DisplayAlerts = False
        .Zoom = False
        Application.DisplayAlerts = True
        
        .FitToPagesWide = True
        .FitToPagesTall = False
        .PrintErrors = xlPrintErrorsDisplayed
        .OddAndEvenPagesHeaderFooter = False
        .DifferentFirstPageHeaderFooter = False
        .ScaleWithDocHeaderFooter = True
        .AlignMarginsHeaderFooter = True

    End With
    'fim definições de impressão
linha = 2
' passar por todas as linhas
While linha <= linha_fim

'verifica se é 100 para não criar uma cópia e parar de imprimir

nmatricula = Worksheets("Inscrição").Range("AD" & linha).Value ' Numero de matricula,
   ' verificar se AD (Ordem de matricula) <diferente> 100
  If nmatricula <> 100 Then
'Definir os valores que vou colar
' ABA INSCRIÇÃO VALORES
no = Worksheets("Inscrição").Range("E" & linha).Value     ' Nome E,
da = Worksheets("Inscrição").Range("R" & linha).Value     ' Data de Nascimento R &
an = Worksheets("Inscrição").Range("AR" & linha).Value    ' AR anos,
cp = Worksheets("Inscrição").Range("T" & linha).Value     ' CPF T,
su = Worksheets("Inscrição").Range("Y" & linha).Value     ' SUS Y,
li = Worksheets("Inscrição").Range("G" & linha).Value     ' Lista G,
cel = Worksheets("Inscrição").Range("U" & linha).Value    ' Celular U
cep = Worksheets("Inscrição").Range("Z" & linha).Value    ' CEP Z,
ba = Worksheets("Inscrição").Range("AA" & linha).Value    ' Bairro AA,
emno = Worksheets("Inscrição").Range("V" & linha).Value   ' Emergencia (nome V,
empa = Worksheets("Inscrição").Range("W" & linha).Value   ' parentesco W e
emcel = Worksheets("Inscrição").Range("X" & linha).Value  ' Celular X)
ultimaMatricula = Worksheets("Inscrição").Range("AE" & linha).Value  ' AE ultima pessoa pra imprmir)
obs = Worksheets("Inscrição").Range("AV" & linha).Value  ' AU Obs arrumado

' se for a primeira pessoa cria o cabeçalho
        If nmatricula = 1 Then
        
ce = Worksheets("Inscrição").Range("J" & linha).Value     ' Centro Esportivo J
mo = Worksheets("Inscrição").Range("K" & linha).Value     ' Modalidade K,
pe = Worksheets("Inscrição").Range("L" & linha).Value     ' Periodo L,
di = Worksheets("Inscrição").Range("M" & linha).Value     ' Dias M,
ho = Worksheets("Inscrição").Range("N" & linha).Value     ' Horario N,
idT = Worksheets("Inscrição").Range("O" & linha).Value     ' idTurma O
        
'copia
    Sheets("Matricula").Select
    Sheets("Matricula").Copy Before:=Sheets(1)
' - - - - - - - - - - Preenchendo o Cabeçlho - - - - - - - - - - - - - -

Worksheets("Matricula (2)").Range("B1").Value = ce    ' Centro Esportivo B1
Worksheets("Matricula (2)").Range("B2").Value = mo    ' Modalidade B2,
Worksheets("Matricula (2)").Range("H2").Value = pe & " - " & di & " - " & ho ' G2 Periodo - dia - hora
Worksheets("Matricula (2)").Range("M2").Value = idT   ' idTurma N2

    'Matricula Padrão (2)

' Primeiro matriculado informações
passar = nmatricula + 2
Worksheets("Matricula (2)").Range("C" & passar).Value = no  ' Nome C3,
Worksheets("Matricula (2)").Range("H" & passar).Value = da & " (" & an & " anos)" ' G3 Data de Nascimento  & AR anos,
Worksheets("Matricula (2)").Range("K" & passar).Value = obs

passar = passar + 1
Worksheets("Matricula (2)").Range("E" & passar).Value = li  ' Lista D4,
Worksheets("Matricula (2)").Range("G" & passar).Value = cp  ' CPF F4,
Worksheets("Matricula (2)").Range("I" & passar).Value = su  ' SUS H4,

passar = passar + 1
Worksheets("Matricula (2)").Range("C" & passar).Value = cep ' CEP J3,
Worksheets("Matricula (2)").Range("F" & passar).Value = ba  ' Bairro M3,
Worksheets("Matricula (2)").Range("I" & passar).Value = cel ' Celular K4

passar = passar + 1
Worksheets("Matricula (2)").Range("D" & passar).Value = emno  ' Emergencia (nome M4,
Worksheets("Matricula (2)").Range("H" & passar).Value = empa ' parentesco P4 e
Worksheets("Matricula (2)").Range("I" & passar).Value = emcel ' Celular Q6)

            
        Else
' Segundo matriculado (linha 7 e 8)em diante soma 7
passar = nmatricula * 4 - 1         ' Primeiro matriculado 3 // Segundo matriculado 7 = 2 * 4 - 1  // 3º 11 = 3 * 4 - 1...
Worksheets("Matricula (2)").Range("C" & passar).Value = no  ' Nome C3,
Worksheets("Matricula (2)").Range("H" & passar).Value = da & " (" & an & " anos)" ' G3 Data de Nascimento  & AR anos,
Worksheets("Matricula (2)").Range("K" & passar).Value = obs

passar = passar + 1
Worksheets("Matricula (2)").Range("E" & passar).Value = li  ' Lista D4,
Worksheets("Matricula (2)").Range("G" & passar).Value = cp  ' CPF F4,
Worksheets("Matricula (2)").Range("I" & passar).Value = su  ' SUS H4,

passar = passar + 1
Worksheets("Matricula (2)").Range("C" & passar).Value = cep ' CEP J3,
Worksheets("Matricula (2)").Range("F" & passar).Value = ba  ' Bairro M3,
Worksheets("Matricula (2)").Range("I" & passar).Value = cel ' Celular K4

passar = passar + 1
Worksheets("Matricula (2)").Range("D" & passar).Value = emno  ' Emergencia (nome M4,
Worksheets("Matricula (2)").Range("H" & passar).Value = empa ' parentesco P4 e
Worksheets("Matricula (2)").Range("I" & passar).Value = emcel ' Celular Q6)

            
        'Fim Preencher Matricula
        End If

' se for a ultima pessoa
        If nmatricula = ultimaMatricula Then
' - - - - -- - - - - - - - - - - - - - - Imprimir e apagar - - - - - - - - - - - - - -


°CAMINHO_Centros = Sheets("Legenda").Cells(1, 1) ' A1.Value (caminho no computador)C:\Users\jplur\OneDrive\Imagens\Profissional\SBC/

If ultimaMatricula <= 19 Then
linha_imprimir = 78
Else
    If ultimaMatricula <= 38 Then
    linha_imprimir = 154
    Else
        If ultimaMatricula <= 57 Then
        linha_imprimir = 230
        Else
        If ultimaMatricula <= 76 Then
            linha_imprimir = 306
            Else
            End If
        End If
    End If
End If
imprimirFixo = "$A$1:$Q$" & linha_imprimir


Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .PrintTitleRows = "$1:$2"
    End With
    Application.PrintCommunication = True
    ActiveSheet.PageSetup.PrintArea = imprimirFixo
    
    Application.PrintCommunication = False
    ActiveWindow.SelectedSheets.PrintOut Copies:=1, PrintToFile:=True, Collate _
        :=True, IgnorePrintAreas:=False, PrToFileName:= _
    °CAMINHO_Centros & "Matricula Turmas\" & idT & " - Matricula.pdf"

' - - - - - - - - - - - - - - - - - - - - APAGA A COPIA Após imprimir- - - - - - - - - - - - - - - -
Application.DisplayAlerts = False
            Sheets("Matricula (2)").Delete 'Delete Select
            'ocultar mensagens
Application.DisplayAlerts = True
        End If
  '  ActiveWindow.SelectedSheets.Delete
End If
'soma para continuar
      linha = linha + 1
Wend

Sheets("Menu").Select
Range("A12").Value = "PDF4 MATRICULAS OK"

End Sub
Sub Tudo()

Call Importar_Inscricoes
Call ImprimirPdf1
Call ImprimirPdf2NSorteio
'Call Sorteio
'Call ImprimirPdf3ListaFinal
'Call ImprimirPdf4Matricula

End Sub

Sub Verificacao2()

Application.ScreenUpdating = False
Sheets("Inscrição").Select
linha_fim = Range("D1").End(xlDown).Row     ' D1 Carimbo
' ADICIONANDO AS COLUNAS DE VERIFICAÇÃO

'Concatenar DIREITA e fazer a conta da idade

'AR ANO IDADE =2021-ANO(R2)
x = "R2"     ' T2 cpf original
inicio = "AS2"
fim = "AS2:AS"
unicaFormula = "=DIREITA(" & x & ";4)"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM  Idade
'AR ANO IDADE =2021-ANO(R2)
x = "AS2"     ' T2 cpf original
inicio = "AR2"
fim = "AR2:AR"
unicaFormula = "=2021-" & x
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM  Idade
'AU CONCATENAR CPF COM OK =CONCATENAR(T2;"OK")
x = "T2"     ' T2 cpf original
inicio = "AU2"
fim = "AU2:AU"
mo = "BG2"
ce = "BH2"
unicaFormula = "=CONCATENAR(" & x & ";""OK"";" & ce & ";" & mo & ")"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Concatenar CPF com OK
'AV CONCATENAR CPF COM VALIDADE =CONCATENAR(T2;P2)
x = "T2"    ' T2 cpf original
y = "P2"    ' P2 validade
inicio = "AV2"
fim = "AV2:AV"
unicaFormula = "=CONCATENAR(" & x & ";" & y & ";" & ce & ";" & mo & ")"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Concatenar CPF com VALIDADE
'AW CONTAR CPF OK =CONT.SE(AV:AV;AU2)
x = "AV2:AV" & linha_fim   ' T2 cpf original
y = "AU2"    ' P2 validade
inicio = "AW2"
fim = "AW2:AW"
p = "P2"
unicaFormula = "=SE(" & p & "=""OK"";1;CONT.SE(" & x & ";" & y & "))"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Contar CPF Válidos
'apagar excesso de informações
inicio = "AV2:AU"
Range(inicio & linha_fim).Select
Selection.ClearContents
'

'AX CACATENAR SUS COM OK =CONCATENAR(Y2;"OK")
x = "Y2"     ' Y2 SUS original
inicio = "AX2"
fim = "AX2:AX"
unicaFormula = "=CONCATENAR(" & x & ";""OK"";" & ce & ";" & mo & ")"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Concatenar SUS com OK
'AY CONCATENAR SUS OK =CONCATENAR(Y2;P2)
x = "Y2"     ' Y2 SUS original
y = "P2"    ' VALIDADE STATUS
inicio = "AY2"
fim = "AY2:AY"
unicaFormula = "=CONCATENAR(" & x & ";" & y & ";" & ce & ";" & mo & ")"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Concatenar SUS com VALIDADE

'AZ CONTAR =CONT.SE(AY:AY;AX2)
x = "AY2:AY" & linha_fim   ' T2 cpf original
y = "AX2"    ' P2 validade
inicio = "AZ2"
fim = "AZ2:AZ"
p = "P2"
unicaFormula = "=SE(" & p & "=""OK"";1;CONT.SE(" & x & ";" & y & "))"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Contar CPF Válidos
'apagar excesso de informações
inicio = "AX2:AY"
Range(inicio & linha_fim).Select
Selection.ClearContents
'

' - - - - - - - - NOME E EMAIL - - - - - -

'BA CONCATENAR NOME COM VALIDADE =CONCATENAR(E2;P2)
x = "E2"     ' E2 NOME original
inicio = "BA2"
fim = "BA2:BA"
unicaFormula = "=CONCATENAR(" & x & ";""OK"";" & ce & ";" & mo & ")"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Concatenar CPF com OK
'BB CONCATENAR NOME COM VALIDADE =CONCATENAR(E2;P2)
x = "E2"    ' E2 NOME original
y = "P2"    ' P2 validade
inicio = "BB2"
fim = "BB2:BB"
unicaFormula = "=CONCATENAR(" & x & ";" & y & ";" & ce & ";" & mo & ")"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Concatenar CPF com VALIDADE
'BC CONTAR NOME OK =CONT.SE(BB:BB;BA2)
x = "BB2:BB" & linha_fim   '
y = "BA2"    '
inicio = "BC2"
fim = "BC2:BC"
p = "P2"
unicaFormula = "=SE(" & p & "=""OK"";1;CONT.SE(" & x & ";" & y & "))"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Contar CPF Válidos
'apagar excesso de informações
inicio = "BA2:BB"
Range(inicio & linha_fim).Select
Selection.ClearContents
'
'BD CACATENAR EMAIL COM OK =CONCATENAR(S2;"OK")
x = "S2"     ' EMAIL original
inicio = "BD2"
fim = "BD2:BD"
unicaFormula = "=CONCATENAR(" & x & ";""OK"";" & ce & ";" & mo & ")"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Concatenar com OK
'BE CONCATENAR EMAILOK =CONCATENAR(S2;P2)
x = "S2"     ' EMAIL original
y = "P2"    ' VALIDADE STATUS
inicio = "BE2"
fim = "BE2:BE"
unicaFormula = "=CONCATENAR(" & x & ";" & y & ";" & ce & ";" & mo & ")"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Concatenar SUS com VALIDADE

'BF CONTAR =CONT.SE(BE:BE;BD2)
x = "BE2:BE" & linha_fim   ' T2 cpf original
y = "BD2"    ' P2 validade
inicio = "BF2"
fim = "BF2:BF"
p = "P2"
unicaFormula = "=SE(" & p & "=""OK"";1;CONT.SE(" & x & ";" & y & "))"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM Contar CPF Válidos
'apagar excesso de informações
inicio = "BD2:BE"
Range(inicio & linha_fim).Select
Selection.ClearContents
'
' - FIM - - - - - - - - CPF, SUS, NOME E EMAIL - - - - - -

' numerar para poder pintar alternando as cores das turmas
    Rows("1:1").Select
    Selection.AutoFilter
ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear     ' ORDENAR POR ORDEM DE TURMA
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("O1:O" & linha_fim), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption _
        :=xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' FIM ORGANIZAR POR ORDEM DE TURMA


' AS = =SE(O1=O2;AS1;AS1+1)
o1 = "O1=O2"    ' Turma se for igual
as1 = "AS1"     ' AS1 = 0 ... conta para ficar numero par ou impar
inicio = "AS2"
fim = "AS2:AS"
unicaFormula = "=SE(" & o1 & ";" & as1 & ";" & as1 & "+1)"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM numeração das turmas

    ' AT = =MOD(AS2;2)Resultado em 0 e 1
    
as2 = "AS2"     ' AS2 = 0 ... valor par ou impar
inicio = "AT2"  ' Recebe 0 ou 1 (se par 0 se impar 1)
fim = "AT2:AT"
unicaFormula = "=MOD(" & as2 & ";2)"
    Range(inicio).Select
        ActiveCell.FormulaLocal = unicaFormula
        Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
        Range(fim & linha_fim).Select
        Selection.Copy
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
        Application.CutCopyMode = False
' FIM par ou impar

'apagar excesso de informações
inicio = "AS2:AS"
Range(inicio & linha_fim).Select
Selection.ClearContents
'

End Sub

Sub ImprimirPdf5Espera()
'
Application.ScreenUpdating = False
Sheets("Inscrição").Select
linha_fim = Range("D1").End(xlDown).Row     ' D1 Carimbo

' ORGANIZAR PARA LISTA DE ESPERA
'AS =SE(OU(AC2="Matricular";P2<>"OK");"ZZ";O2)
ac2 = "AC2"     ' Lista de Espera
o2 = "O2"     ' id Turma
p2 = "P2"
inicio = "AS2"  '
fim = "AS2:AS"  '=SE(OU(AC2="Matricular";P2<>"OK");"ZZ";O2)
inserirForm = "=SE(OU(" & ac2 & "=""Matricular"";" & p2 & "<>""OK"");""ZZ"";" & o2 & ")"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM AS
'AW = =SE(AS2="ZZ";999;CONT.SE(AS:AS;AS2))

as2 = "AS2"  '
asFim = "AS:AS"
inicio = "AW2"  '
fim = "AW2:AW" '=SE(AS2="ZZ";999;CONT.SE(AS:AS;AS2))
inserirForm = "=SE(" & as2 & "=""ZZ"";999;CONT.SE(" & asFim & ";" & as2 & "))"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM

' AU1 Colocação Final da menor para a maior
    Rows("1:1").Select
    Selection.AutoFilter
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("AU1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
' AS1 idTurma APENAS ESPERA por ordem alfabetica
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort.SortFields.Add2 Key:= _
        Range("AS1"), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
        xlSortNormal
    With ActiveWorkbook.Worksheets("Inscrição").AutoFilter.Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With

    Selection.AutoFilter

'FIM organizar pronto para numerar a Ordem de ESPERA
'AX ==SE(AS2=AS1;AX1+1;1)
as2 = "AS2"  '
as1 = "AS1"
ax1 = "AX1"
inicio = "AX2"  '
fim = "AX2:AX" '=SE(AS2=AS1;AX1+1;1)
inserirForm = "=SE(" & as2 & "=" & as1 & ";" & ax1 & "+1;1)"

    Range(inicio).Select
    ActiveCell.FormulaLocal = inserirForm
    Selection.AutoFill Destination:=Range(fim & linha_fim), Type:=xlFillDefault
    Range(fim & linha_fim).Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
' FIM

'Definições de impressão

Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .RightFooter = "&P/&N"
  '      .LeftMargin = Application.InchesToPoints(0.708661417322835)
   '     .RightMargin = Application.InchesToPoints(0.708661417322835)
    '    .TopMargin = Application.InchesToPoints(0.590551181102362)
     '   .BottomMargin = Application.InchesToPoints(0.511811023622047)
      '  .HeaderMargin = Application.InchesToPoints(0.31496062992126)
       ' .FooterMargin = Application.InchesToPoints(0.31496062992126)
        
        .RightMargin = Application.InchesToPoints(0.33)
        .HeaderMargin = Application.InchesToPoints(0.17)
        .TopMargin = Application.InchesToPoints(0.3)
        .RightMargin = Application.InchesToPoints(0.29)
        .LeftMargin = Application.InchesToPoints(0.39)
        .FooterMargin = Application.InchesToPoints(0.23)
        .BottomMargin = Application.InchesToPoints(0.43)
        
        .PrintHeadings = False
        .PrintGridlines = False
        .PrintComments = xlPrintNoComments
        .PrintQuality = 600
        .CenterHorizontally = True
        .CenterVertically = False
        .Orientation = xlPortrait
        .Draft = False
        .PaperSize = xlPaperA4
        .FirstPageNumber = xlAutomatic
        .Order = xlDownThenOver
        .BlackAndWhite = False
        
        Application.DisplayAlerts = False
        .Zoom = False
        Application.DisplayAlerts = True
        
        .FitToPagesWide = True
        .FitToPagesTall = False
        .PrintErrors = xlPrintErrorsDisplayed
        .OddAndEvenPagesHeaderFooter = False
        .DifferentFirstPageHeaderFooter = False
        .ScaleWithDocHeaderFooter = True
        .AlignMarginsHeaderFooter = True

    End With
    'fim definições de impressão
linha = 2
' passar por todas as linhas
While linha <= linha_fim

'verifica se é 999 para não criar uma cópia e parar de imprimir

nmatricula = Worksheets("Inscrição").Range("AX" & linha).Value ' Numero de ESPERA,
   ' verificar se AW (Ordem de matricula) <diferente> 999
  If nmatricula <> 999 And nmatricula <= 172 Then
'Definir os valores que vou colar
' ABA INSCRIÇÃO VALORES
no = Worksheets("Inscrição").Range("E" & linha).Value     ' Nome E,
da = Worksheets("Inscrição").Range("R" & linha).Value     ' Data de Nascimento R &
an = Worksheets("Inscrição").Range("AR" & linha).Value    ' AR anos,
cp = Worksheets("Inscrição").Range("T" & linha).Value     ' CPF T,
su = Worksheets("Inscrição").Range("Y" & linha).Value     ' SUS Y,
li = Worksheets("Inscrição").Range("G" & linha).Value     ' Lista G,
cel = Worksheets("Inscrição").Range("U" & linha).Value    ' Celular U
cep = Worksheets("Inscrição").Range("Z" & linha).Value    ' CEP Z,
ba = Worksheets("Inscrição").Range("AA" & linha).Value    ' Bairro AA,
emno = Worksheets("Inscrição").Range("V" & linha).Value   ' Emergencia (nome V,
empa = Worksheets("Inscrição").Range("W" & linha).Value   ' parentesco W e
emcel = Worksheets("Inscrição").Range("X" & linha).Value  ' Celular X)
ultimaMatricula = Worksheets("Inscrição").Range("AW" & linha).Value  ' AW ultima pessoa pra imprmir DEPENDENDO DA MODALIDADE)
obs = Worksheets("Inscrição").Range("AV" & linha).Value  ' AU Obs arrumado

' se for a primeira pessoa cria o cabeçalho
        If nmatricula = 1 Then
        
ce = Worksheets("Inscrição").Range("J" & linha).Value     ' Centro Esportivo J
mo = Worksheets("Inscrição").Range("K" & linha).Value     ' Modalidade K,
pe = Worksheets("Inscrição").Range("L" & linha).Value     ' Periodo L,
di = Worksheets("Inscrição").Range("M" & linha).Value     ' Dias M,
ho = Worksheets("Inscrição").Range("N" & linha).Value     ' Horario N,
idT = Worksheets("Inscrição").Range("O" & linha).Value     ' idTurma O
        
'copia
    Sheets("Matricula").Select
    Sheets("Matricula").Copy Before:=Sheets(1)
' - - - - - - - - - - Preenchendo o Cabeçlho - - - - - - - - - - - - - -

Worksheets("Matricula (2)").Range("B1").Value = ce    ' Centro Esportivo B1
Worksheets("Matricula (2)").Range("B2").Value = mo    ' Modalidade B2,
Worksheets("Matricula (2)").Range("H2").Value = pe & " - " & di & " - " & ho ' G2 Periodo - dia - hora
Worksheets("Matricula (2)").Range("M2").Value = idT   ' idTurma N2
Worksheets("Matricula (2)").Range("M1").Value = "LISTA DE ESPERA"
    'Matricula Padrão (2)

' Primeiro matriculado informações
passar = nmatricula + 2
Worksheets("Matricula (2)").Range("C" & passar).Value = no  ' Nome C3,
Worksheets("Matricula (2)").Range("H" & passar).Value = da & " (" & an & " anos)" ' G3 Data de Nascimento  & AR anos,
Worksheets("Matricula (2)").Range("K" & passar).Value = obs

passar = passar + 1
Worksheets("Matricula (2)").Range("E" & passar).Value = li  ' Lista D4,
Worksheets("Matricula (2)").Range("G" & passar).Value = cp  ' CPF F4,
Worksheets("Matricula (2)").Range("I" & passar).Value = su  ' SUS H4,

passar = passar + 1
Worksheets("Matricula (2)").Range("C" & passar).Value = cep ' CEP J3,
Worksheets("Matricula (2)").Range("F" & passar).Value = ba  ' Bairro M3,
Worksheets("Matricula (2)").Range("I" & passar).Value = cel ' Celular K4

passar = passar + 1
Worksheets("Matricula (2)").Range("D" & passar).Value = emno  ' Emergencia (nome M4,
Worksheets("Matricula (2)").Range("H" & passar).Value = empa ' parentesco P4 e
Worksheets("Matricula (2)").Range("I" & passar).Value = emcel ' Celular Q6)

            
        Else
' Segundo matriculado (linha 7 e 8)em diante soma 7
passar = nmatricula * 4 - 1         ' Primeiro matriculado 3 // Segundo matriculado 7 = 2 * 4 - 1  // 3º 11 = 3 * 4 - 1...
Worksheets("Matricula (2)").Range("C" & passar).Value = no  ' Nome C3,
Worksheets("Matricula (2)").Range("H" & passar).Value = da & " (" & an & " anos)" ' G3 Data de Nascimento  & AR anos,
Worksheets("Matricula (2)").Range("K" & passar).Value = obs

passar = passar + 1
Worksheets("Matricula (2)").Range("E" & passar).Value = li  ' Lista D4,
Worksheets("Matricula (2)").Range("G" & passar).Value = cp  ' CPF F4,
Worksheets("Matricula (2)").Range("I" & passar).Value = su  ' SUS H4,

passar = passar + 1
Worksheets("Matricula (2)").Range("C" & passar).Value = cep ' CEP J3,
Worksheets("Matricula (2)").Range("F" & passar).Value = ba  ' Bairro M3,
Worksheets("Matricula (2)").Range("I" & passar).Value = cel ' Celular K4

passar = passar + 1
Worksheets("Matricula (2)").Range("D" & passar).Value = emno  ' Emergencia (nome M4,
Worksheets("Matricula (2)").Range("H" & passar).Value = empa ' parentesco P4 e
Worksheets("Matricula (2)").Range("I" & passar).Value = emcel ' Celular Q6)

            
        'Fim Preencher Matricula
        End If

' se for a ultima pessoa
        If nmatricula = ultimaMatricula Or nmatricula > 171 Then
' - - - - -- - - - - - - - - - - - - - - Imprimir e apagar - - - - - - - - - - - - - -


°CAMINHO_Centros = Sheets("Legenda").Cells(1, 1) ' A1.Value (caminho no computador)C:\Users\jplur\OneDrive\Imagens\Profissional\SBC/

If ultimaMatricula <= 19 Then
linha_imprimir = 78
Else
    If ultimaMatricula <= 38 Then
    linha_imprimir = 154
    Else
        If ultimaMatricula <= 57 Then
        linha_imprimir = 230
        Else
            If ultimaMatricula <= 76 Then
            linha_imprimir = 306
            Else
                If ultimaMatricula <= 95 Then
                linha_imprimir = 382
                Else
                    If ultimaMatricula <= 114 Then
                    linha_imprimir = 458
                    Else
                        If ultimaMatricula <= 133 Then
                        linha_imprimir = 534
                        Else
                            If ultimaMatricula <= 152 Then
                            linha_imprimir = 610
                            Else
                            linha_imprimir = 686
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End If
End If
imprimirFixo = "$A$1:$Q$" & linha_imprimir


Application.PrintCommunication = False
    With ActiveSheet.PageSetup
        .PrintTitleRows = "$1:$2"
    End With
    Application.PrintCommunication = True
    ActiveSheet.PageSetup.PrintArea = imprimirFixo
    
    Application.PrintCommunication = False
    ActiveWindow.SelectedSheets.PrintOut Copies:=1, PrintToFile:=True, Collate _
        :=True, IgnorePrintAreas:=False, PrToFileName:= _
    °CAMINHO_Centros & "Espera Turmas\" & idT & " - Lista de Espera.pdf"

' - - - - - - - - - - - - - - - - - - - - APAGA A COPIA Após imprimir- - - - - - - - - - - - - - - -
Application.DisplayAlerts = False
            Sheets("Matricula (2)").Delete 'Delete Select
            'ocultar mensagens
Application.DisplayAlerts = True
        End If
  '  ActiveWindow.SelectedSheets.Delete
End If
'soma para continuar
      linha = linha + 1
Wend

Sheets("Menu").Select
Range("A14").Value = "PDF4 ESPERA OK"

End Sub

