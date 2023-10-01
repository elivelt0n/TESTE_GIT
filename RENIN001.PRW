#INCLUDE "MsOle.ch"
#INCLUDE "Report.ch"
#INCLUDE "Protheus.ch"
#INCLUDE "SHELL.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "TBICONN.CH"
#include 'TopConn.CH'


//-------------------------------------------------------------------
/*/{Protheus.doc} RENIN001
proposta comercial customizada para locação
mensal Intelisense

@author João Gabriel Fonseca de Souza - joao8gabriel88src@gmail.com
@since 28/04/2024

/*/
//-------------------------------------------------------------------

User Function RENIN001()
	Local aArea := GetArea()
	Private nObs := ''
	Private nSer :=''
	Private cValid := 0
	Private cObs := ' '
    if PERGUNTE('RENIN001')
       // nObs    := MV_PAR01
		nVal	:=MV_PAR01
        //cValid    := MV_PAR02c8l7da_prod
		//cObs :=MV_PAR06
        
    endif 
	
    If FP0->FP0_XEMP == '1'
    	processa({||PrintRen()},,"Gerando Impressão de Proposta Intelisense...")    
	ELSEIf FP0->FP0_XEMP =='2'
		processa({||U_PriSemp()},,"Gerando Impressão de Proposta Sempre ...") 
	ELSEIf FP0->FP0_XEMP =='3'
		processa({||U_PriVal()},,"Gerando Impressão de Proposta Valor ...") 
	Endif
	
    RestArea(aArea)
Return 

Static Function PrintRen()
	
	Local aArea			:= GetArea()
	Local cRel			:= ''
	Local cTime			:= Time() 
	Private cPath 		:= " "
	Private oPrn    	:= NIL
	Private lPRIMA 		:= .T.
	Private nMargEsq	:= 010
	Private nMargDir	:= 580
	Private nTopo		:= 010
	Private nRodape		:= 350
	Private nEspaco		:= 010
	Private nLinTex		:= 020
	Private nPagina		:= 0
	Private nVertTxt	:= 030
	Private nC01 		:= 000
	Private nC02 		:= 043
	Private nC03		:= 140
	Private nC04 		:= 193
	Private nC05 		:= 280
	Private nC06 		:= 323
	Private nC07 		:= 420
	Private nC08 		:= 473
	Private nC09 		:= 500 
	Private cFil		:= ""
	Private cVia		:= ""  
	Private nItem		:=0
	
	u_obsint2()
	
	//Definicao das Fontes
	oFont06	 	:= TFont():New("Times New Roman" 					,06,06,,.F.,,,,.T.,.F.)
	oFont06N 	:= TFont():New("Times New Roman" 					,06,06,,.T.,,,,.T.,.F.)
	
	oFont08	 	:= TFont():New("Times New Roman" 					,08,08,,.F.,,,,.T.,.F.)
	oFont08a	:= TFont():New("Times New Roman"		 					,08,08,,.F.,,,,.T.,.F.)
	oFont08N 	:= TFont():New("Times New Roman" 					,08,08,,.T.,,,,.T.,.F.)
	
	oFont09	 	:= TFont():New("Times New Roman" 					,09,09,,.F.,,,,.T.,.F.)
	oFont09N 	:= TFont():New("Times New Roman" 					,09,09,,.T.,,,,.T.,.F.)
	oFont09Na 	:= TFont():New("Times New Roman"	 						,09,09,,.T.,,,,.T.,.F.)
	
	oFont10	 	:= TFont():New("Times New Roman" 					,10,10,,.F.,,,,.T.,.F.)
	oFont10a 	:= TFont():New("Times New Roman"		 					,10,10,,.F.,,,,.T.,.F.)
	oFont10N 	:= TFont():New("Times New Roman" 					,10,10,,.T.,,,,.T.,.F.)
	oFont10Na	:= TFont():New("Times New Roman" 							,10,10,,.T.,,,,.T.,.F.)
	
	oFont11	 	:= TFont():New("Times New Roman" 					,11,11,,.F.,,,,.T.,.F.)
	oFont11b 	:= TFont():New("Times New Roman" 					,11,11,,.T.,,,,.T.,.F.)
	oFont11a 	:= TFont():New("Times New Roman"		 					,11,11,,.F.,,,,.T.,.F.)
	oFont11N 	:= TFont():New("Times New Roman" 					,11,11,,.T.,,,,.T.,.F.)
	oFont11Na	:= TFont():New("Times New Roman" 							,11,11,,.T.,,,,.T.,.F.)
	
	oFont12  	:= TFont():New("Times New Roman" 					,12,12,,.F.,,,,.T.,.F.)
	//oFont12a 	:= TFont():New("Times New Roman"		 					,12,12,,.F.,,,,.T.,.F.)
    oFont12a 	:= TFont():New("Times New Roman"		 					,12,12,,.F.,,,,.T.,.F.)
	oFont12N 	:= TFont():New("Times New Roman" 					,12,12,,.T.,,,,.T.,.F.)
	oFont12Na	:= TFont():New("Times New Roman" 	  						,12,12,,.T.,,,,.T.,.F.)
    oFont12s	:= TFont():New("Times New Roman"			                ,,12,,.F.,,,,,.T.)		//sublinhado
	
	oFont13Na	:= TFont():New("Times New Roman" 	  						,13,13,,.T.,,,,.T.,.F.)
	oFont13N 	:= TFont():New("Times New Roman" 					,13,13,,.T.,,,,.T.,.F.)
	oFont13 	:= TFont():New("Times New Roman" 					,13,13,,.F.,,,,.T.,.F.)
	
	oFont14	 	:= TFont():New("Times New Roman" 					,14,14,,.F.,,,,.T.,.F.)
   // oFont14a	:= TFont():New("Times New Roman" 							,14,14,,.F.,,,,.T.,.F.)
    oFont14a	:= TFont():New("Times New Roman" 							,14,14,,.F.,,,,.T.,.F.)
	oFont14Na	:= TFont():New("Times New Roman" 					,14,14,,.T.,,,,.T.,.F.)
    oFont14s	:= TFont():New("Times New Roman"			                ,,14,,.F.,,,,,.T.)		//sublinhado
    oFont14Ns	:= TFont():New("Times New Roman"			                ,14,14,,.T.,,,,,.T.)		//sublinhado
	
	oFont16	 	:= TFont():New("Times New Roman" 					,16,16,,.F.,,,,.T.,.F.)
	oFont16N 	:= TFont():New("Times New Roman" 					,16,16,,.T.,,,,.T.,.F.)
	oFont16Na	:= TFont():New("Times New Roman" 					,16,16,,.T.,,,,.T.,.F.)
	
	oFont20	 	:= TFont():New("Times New Roman" 					,18,18,,.F.,,,,.T.,.F.)
	oFont20N 	:= TFont():New("Times New Roman" 					,18,18,,.T.,,,,.T.,.F.)
	
	oFont26		:= TFont():New("Times New Roman"					,26,26,,.F.,,,,.T.,.F.)
	oFont26N	:= TFont():New("Times New Roman"					,26,26,,.T.,,,,.T.,.F.)
	
	wnrel := FunName()
	
	cPath := 'C:\Temp\' //cGetFile(, 'Selecione o Local Para Salvar o Relatorio', 1, , .F., nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ),.F., .T. )
	
	If AllTrim(cPath) == ''
		Return()
	EndIf
	
	cHora := SubStr(cTime, 1, 2) // Resultado: 10
	cMinutos := SubStr(cTime, 4, 2) // Resultado: 37
	cSegundos := SubStr(cTime, 7, 2) // Resultado: 17
	
	cRel := 'Proposta_'+SubStr(Alltrim(FP0_PROJET),1,9)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicio do lay-out / impressao                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lPreview := .T.
	lAdjustToLegacy := .F.
	lDisableSetup := .T.
	
	oPrn := FWMSPrinter():New(cRel+".rel", 6, lAdjustToLegacy, , lDisableSetup)//FWMSPrinter():New(cRel,6,.F.,,.T.)
	
	//Abre tela de Definicoes de Impressora
	//Define o tamanho do papel
	oPrn:SetResolution(72)
	oPrn:SetPortrait()
	oPrn:SetPaperSize(9)
	oPrn:SetMargin(00,00,00,00)
	oPrn:cPathPDF := cPath
	
	//Funcao
	FIN0001()
	
	oPrn:EndPage()
	oPrn:Preview()
	
	RestArea(aArea)
	
Return


//Aciona a funcao de impressao
Static Function FIN0001()
	
	FIN0002()
	
	//Descarrega o Spool de impressao
	Ms_Flush()
	
Return

//Monta a area de impressao e inseri os dados.
Static Function FIN0002()
	FIN0003()
Return

//Monta dados do relatório
Static Function FIN0003(oDlg,cTexto)
	Local cBitMap	:= '\system\logo_inte.bmp'    
    Local cBitMapa	:= '\system\int_prod.bmp' 
    Local cBitProd	:= '\system\LOCA_TECN.bmp'
    Local cBitmsg1	:= '\system\msg1.bmp'
    Local cBitmsg2	:= '\system\msg2.bmp'
    Local cBitmsg3	:= '\system\msg3.bmp'
	Local aArea		:= GetArea()
	Local cRetorno := ""
	Local _cQuery   := ""
    Local ddate:=   DTOC(Date())
	Local cAlias    := GetNextAlias()
	Local _CALIAS    := GetNextAlias()
	Local nTotal    := 0
	Local cProj :={}
	Local i:=0
	Local cProd:=""
	Local nTot:=0
	Local aDados := {}
	Local aDadosNew := {}
	Local nPos			:= 0
	Local _nX    := 0
	Local nZ	:= 0
 
    

    nObs:=FP0->FP0_OBSPRO


DbSelectArea("FP0")
FP0->(DbSetOrder(1))

	If lPRIMA
		oPrn:StartPage()
		lPRIMA := .F.
	Else
		oPrn:EndPage()
		oPrn:StartPage()
	EndIf 

	nLinTex := 027  
	linoa := 029

	dbselectarea("SA1")
	SA1->(dbsetorder(1))//FP0_FILIAL+FP0_CLI+FP0_LOJA
	SA1->(dbgotop())
	SA1->(dbseek(xFilial("SA1")+FP0->FP0_CLI+FP0->FP0_LOJA))

	dbselectarea("FP6")
	FP6->(dbsetorder(1))//FP0_FILIAL+FP0_PROJET+
	FP6->(dbgotop())
	FP6->(dbseek(xFilial("FP6")+FP0->FP0_PROJET))

	dbselectarea("FPA")
	FPA->(dbsetorder(1))//FP0_FILIAL+FP0_PROJET+
	FPA->(dbgotop())
	FPA->(dbseek(xFilial("FPA")+FP0->FP0_PROJET))

    dbselectarea("SE4")
    SE4->(dbsetorder(1))//E4_FILIAL+E4_COD
    SE4->(dbgotop())
    SE4->(dbseek(xFilial("SE4")+FPA->FPA_CONPAG))

	dbselectarea("FP1")
	FP1->(dbsetorder(1))//FP0_FILIAL+FP0_PROJET+
	FP1->(dbgotop())
	FP1->(dbseek(xFilial("FPA")+FP0->FP0_PROJET))

    cCond:=Substr(SE4->E4_COND,1,2)
   
	//oPrn:Line(020,020,020,570)
    //nLinTex+=nEspaco+1
    oPrn:Say(nLinTex,20,"Intelisense Radiocomunicação Ltda. ",oFont11)
	oPrn:SayBitmap(nLinTex,400,cBitMap,450/3,170/3)
	nLinTex+=nEspaco+1
    oPrn:Say(nLinTex,20,"Avenida Fagundes de Oliveira, 538 ",oFont11)
	nLinTex+=nEspaco+1
    oPrn:Say(nLinTex,20,"Galpão 25B, Piraporinha, Diadema, SP ",oFont11)
	nLinTex+=nEspaco+1
    oPrn:Say(nLinTex,20,"09950 300 ",oFont11)
	nLinTex+=nEspaco+1
    oPrn:Say(nLinTex,20,"intelisense.com.br",oFont11)
	nLinTex+=nEspaco+1
    oPrn:Say(nLinTex,20,"intelisense@intelisense.com.br",oFont11)
	nLinTex+=nEspaco+1
    oPrn:Say(nLinTex,20,"11 4422 4030",oFont11)
	nLinTex+=nEspaco+1
    oPrn:Say(nLinTex,20,"11 4422 4100",oFont11)

	dDataAtual := dDataBase

    cRetorno += cValToChar(Day(dDataAtual))
	cRetorno += " de "
    cRetorno += MesExtenso(dDataAtual)
    cRetorno += " de "
    cRetorno += cValToChar(Year(dDataAtual))


 	nLinTex+=nEspaco+6
    oPrn:Say(nLinTex,20,"São Paulo, "+cRetorno,oFont11N)
    nLinTex+=nEspaco
    
    //oPrn:SayBitmap(nLinTex,nVertTxt,cBitMap,750/3,255/3)
    nLinTex+=nEspaco+2
    oPrn:Say(nLinTex,20,"Empresa:",oFont11N)
	oPrn:Say(nLinTex,60,+AllTrim(FP0->FP0_CLINOM),oFont11)
	nLinTex+=nEspaco+2
    oPrn:Say(nLinTex,20,"A/C:",oFont11N)
	oPrn:Say(nLinTex,40,+AllTrim(FP0->FP0_NOMECO),oFont11)
	nLinTex+=nEspaco+2
    oPrn:Say(nLinTex,20,"E-mail:",oFont11N)
  	oPrn:Say(nLinTex,50,+AllTrim(FP0->FP0_CLIEMA),oFont11)
	nLinTex+=nEspaco+2
    oPrn:Say(nLinTex,20,"Tel.:",oFont11N)
    oPrn:Say(nLinTex,40,+AllTrim(FP0->FP0_CLIDDD)+"-"+AllTrim(FP0->FP0_CLITEL),oFont11)
    nLinTex+=nEspaco+7
		If	nVal==1
			oPrn:Say(nLinTex,20,"PROPOSTA COMERCIAL DE LOCAÇÃO MENSAL Nº "+AllTrim(FP0->FP0_PROJET),oFont11N)
		else			
			oPrn:Say(nLinTex,20,"PROPOSTA COMERCIAL DE LOCAÇÃO PERIÓDICA Nº "+AllTrim(FP0->FP0_PROJET),oFont11N)		
		EndIf    
    nLinTex+=nEspaco+3
    oPrn:Say(nLinTex,20,"Prezados senhores (a),",oFont11)
    nLinTex+=nEspaco+3
    oPrn:Say(nLinTex,20,"Agradecemos seu interesse pelos produtos e serviços da",oFont11)
	oPrn:Say(nLinTex,215,"Intelisense Radiocomunicação Ltda. ",oFont11N)
	nLinTex+=nEspaco
	oPrn:Say(nLinTex,20,"Temos a satisfação de apresentar a proposta comercial referente a locação mensal de solução de rádio comunicação profissional. ",oFont11)
	nLinTex+=nEspaco
	    cString :=""
        cString :="A Intelisense possui ampla experiência na locação de equipamentos, sistemas e prestação de serviços na área de rádio comunicação convencional e "    
        cString +="troncalizada, criando facilidades no gerenciamento e execução de operações em diversos segmentos como Indústria, Comércio, Eventos, Segurança, Transporte, "
        cString +="Petroquímico, Mineração, Portos, Aeroportos, Agronegócio, etc."
        nLin2 := mlcount(cString,150)
        For i := 1 to nLin2
          oPrn:Say(nLinTex,20,""+memoline(cString,150,i)+"",oFont11)
          nLinTex+=nEspaco+1
            If nLinTex >= 780 
                    nLinTex := 030
                        oPrn:StartPage()
            EndIf
        Next
	//nLinTex+=nEspaco
	    cString :=""
        cString :="Ficamos desde já a disposição de V. Sas., para quaisquer esclarecimentos que se façam necessários bem como complementar ou efetuar as adequações e/ou "    
        cString +="correções que julgarem necessárias na presente proposta comercial"
        nLin2 := mlcount(cString,150)
        For i := 1 to nLin2
          oPrn:Say(nLinTex,20,""+memoline(cString,150,i)+"",oFont11)
          nLinTex+=nEspaco
            If nLinTex >= 780 
                    nLinTex := 030
                        oPrn:StartPage()
            EndIf
        Next



	//nLinTex+=nEspaco
    oPrn:SayBitmap(nLinTex,20,cBitMapa,1680/3,30/3)
	nLinTex+=nEspaco
    oPrn:Line(nLinTex,020,nLinTex,580)
    nlin1:=nLinTex
    nLinTex+=nEspaco
    oPrn:Say(nLinTex,30,"Item ",oFont11N)
    oPrn:Say(nLinTex,76,"Modelo ",oFont11N)
    oPrn:Say(nLinTex,125,"Descrição ",oFont11N)
    oPrn:Say(nLinTex,461,"Qtd. ",oFont11N)
    oPrn:Say(nLinTex,495,"Unitário",oFont11N)
    oPrn:Say(nLinTex,540,"Total",oFont11N)
    nLinTex+=nEspaco
    oPrn:Line(nlin1,020,nLinTex,020)
    oPrn:Line(nlin1,60,nLinTex,60)
    oPrn:Line(nlin1,122,nLinTex,122)
    oPrn:Line(nlin1,450,nLinTex,450)
    oPrn:Line(nlin1,485,nLinTex,485)
    oPrn:Line(nlin1,535,nLinTex,535)
    oPrn:Line(nlin1,580,nLinTex,580)
    oPrn:Line(nLinTex,020,nLinTex,580)

	while !FPA->(EoF()) .AND. FPA->FPA_FILIAL=FP0->FP0_FILIAL .AND. FPA->FPA_PROJET==FP0->FP0_PROJET
		If FPA->FPA_PRCUNI >0
			aAdd(aDados, {FPA->FPA_SEQGRU, FPA->FPA_PRODUT, FPA->FPA_QUANT,FPA->FPA_PRCUNI,FPA->FPA_VLBRUT})
		EndIF
		FPA->(dbSkip())
	ENDDO


	For nZ := 1 To Len(aDados)
		
			nPos := aScan(aDadosNew,{|x| AllTrim(x[2])== AllTrim(aDados[nZ][2])})
			If nPos > 0
				nVal3:=aDadosNew[nPos][3]+aDados[nZ][3]
				nVal5:=aDadosNew[nPos][5]+aDados[nZ][5]
				//aLinhaBkp  := aClone(aDadosNew[nPos])
				//aDel(aDadosNew, nPos)
				aDadosNew[nPos] := {aDados[nZ][1],aDados[nZ][2],nVal3,aDados[nZ][4],nVal5}
				
				//aFill(aDadosNew[nPos],{aDados[nZ][1],aDados[nZ][2],nVal3,aDados[nZ][4],nVal5})
			Else
				//aAdd(aDadosNew,{})
				aAdd(aDadosNew,{aDados[nZ][1],aDados[nZ][2],aDados[nZ][3],aDados[nZ][4],aDados[nZ][5]})
			EndIf

	Next nZ
	
	For _nX := 1 to Len(aDadosNew)
		nLinTex+=nEspaco

		//oPrn:Say(nLinTex,40,+AllTrim(aDadosNew[_nX][01]),oFont11) 
		oPrn:Say(nLinTex,40,+Alltrim(Transform(_nX,'@E 999,999,999')),oFont11)
		oPrn:Say(nLinTex,64,+AllTrim(aDadosNew[_nX][02]),oFont10N)
		oPrn:Say(nLinTex,461,Alltrim(Transform(aDadosNew[_nX][03],'@E 999,999,999.99')),oFont11)
		oPrn:Say(nLinTex,493,Alltrim(Transform(aDadosNew[_nX][04],'@E 999,999,999.99')),oFont11)
		oPrn:Say(nLinTex,538,Alltrim(Transform(aDadosNew[_nX][05],'@E 999,999,999.99')),oFont11)
		nTot+=(aDadosNew[_nX][05])

		cString :=ALLTRIM(POSICIONE("SB1",1,xFilial("SB1")+aDadosNew[_nX][02],"B1_XOBS"))
                  
            nLin2 := mlcount(cString,90)
            For i := 1 to nLin2
              oPrn:Say(nLinTex,125,""+memoline(cString,90,i)+"",oFont11)
			  nLinTex+=nEspa
            Next

			nLinTex+=nEspaco +1

		    oPrn:Line(nlin1,20,nLinTex,20)
            oPrn:Line(nlin1,60,nLinTex,60)
            oPrn:Line(nlin1,122,nLinTex,122)
            oPrn:Line(nlin1,450,nLinTex,450)
            oPrn:Line(nlin1,485,nLinTex,485)
            oPrn:Line(nlin1,535,nLinTex,535)
			oPrn:Line(nlin1,580,nLinTex,580)
            
            oPrn:Line(nLinTex,020,nLinTex,580)
			If nLinTex >= 720 
					nLinTex := 020
					oPrn:StartPage()
					oPrn:Line(nLinTex,020,nLinTex,580)
			EndIf
			
			FPA->(dbSkip())


	Next _nX
    

    /*
	    while !FPA->(EoF()) .AND. FPA->FPA_FILIAL=FP0->FP0_FILIAL .AND. FPA->FPA_PROJET==FP0->FP0_PROJET
            nlin1:=nLinTex
            nLinTex+=nEspaco
			If AllTrim(FPA->FPA_PRODUT)==cProd

			else

			EndIf

            oPrn:Say(nLinTex,40,+AllTrim(FPA->FPA_SEQGRU),oFont11)    
            oPrn:Say(nLinTex,64,+AllTrim(FPA->FPA_PRODUT),oFont10N) 

			oPrn:Say(nLinTex,465,Alltrim(Transform(FPA->FPA_QUANT,'@E 999,999.99')),oFont11)
            oPrn:Say(nLinTex,493,Alltrim(Transform(FPA->FPA_PRCUNI,'@E 999,999.99')),oFont11)
            oPrn:Say(nLinTex,538,Alltrim(Transform(FPA->FPA_VLBRUT,'@E 999,999.99')),oFont11)
			nTot+=(FPA->FPA_VLBRUT)
			
                    cString :=ALLTRIM(POSICIONE("SB1",1,xFilial("SB1")+FPA->FPA_PRODUT,"B1_XOBS"))
                  
                        nLin2 := mlcount(cString,90)
                        For i := 1 to nLin2
                          oPrn:Say(nLinTex,125,""+memoline(cString,90,i)+"",oFont11)
						  nLinTex+=nEspaco

                        Next
      


            nLinTex+=nEspaco          

            oPrn:Line(nlin1,20,nLinTex,20)
            oPrn:Line(nlin1,60,nLinTex,60)
            oPrn:Line(nlin1,122,nLinTex,122)
            oPrn:Line(nlin1,450,nLinTex,450)
            oPrn:Line(nlin1,485,nLinTex,485)
            oPrn:Line(nlin1,535,nLinTex,535)
			oPrn:Line(nlin1,580,nLinTex,580)
            
            oPrn:Line(nLinTex,020,nLinTex,580)
			If nLinTex >= 720 
					nLinTex := 020
					oPrn:StartPage()
					oPrn:Line(nLinTex,020,nLinTex,580)
			EndIf
			
			FPA->(dbSkip())
	    EndDo
	*/
		nLinTex+=nEspaco
			oPrn:Say(nLinTex,460,"Valor total em Reais ",oFont11)
			oPrn:Say(nLinTex,538,+Alltrim(Transform(nTot,'@E 999,999,999.99')),oFont11N)
			nLinTex+=nEspaco
			oPrn:Line(nlin1,20,nLinTex,20)
			oPrn:Line(nlin1,535,nLinTex,535)
			oPrn:Line(nlin1,580,nLinTex,580)
			oPrn:Line(nLinTex,020,nLinTex,580)
        If nLinTex >= 750 
					nLinTex := 020
					oPrn:StartPage()
		EndIf
        nLinTex+=nEspaco+4
		If	nVal==2
			oPrn:Say(nLinTex,20,"Os valores apresentados nesta proposta referem-se a um período de 30 dias.",oFont11N)	
			nLinTex+=nEspaco+4
		EndIf
        oPrn:Say(nLinTex,20,"PRINCIPAIS VANTAGENS DA LOCAÇÃO ",oFont12N)
        nLinTex+=nEspaco+3

		oPrn:Say(nLinTex,20,"> Baixo investimento inicial; ",oFont11N)
		nLinTex+=nEspaco+2

		oPrn:Say(nLinTex,20,"> Frequências legalizadas na ANATEL, para uso em todo território nacional.",oFont11N)
		nLinTex+=nEspaco+2

		oPrn:Say(nLinTex,20,"> Manutenção preventiva;",oFont11N)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,30,"O serviço de manutenção preventiva tem como objetivo minimizar a ocorrência de problemas através de visitas técnicas previamente programadas com",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,30,"substituição de equipamentos que apresentem defeitos.",oFont11)
		nLinTex+=nEspaco+2
		
		If nLinTex >= 750 
					nLinTex := 020
					oPrn:StartPage()
		EndIf
		oPrn:Say(nLinTex,20,"> Manutenção corretiva;",oFont11N)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,30,"Diagnóstico e correção de anormalidade (s), incluindo todos os procedimentos e peças necessárias ao retorno do equipamento às condições normais de ",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,30,"operação, com utilização de mão de obra especializada.",oFont11)
		nLinTex+=nEspaco+2
		If nLinTex >= 750 
					nLinTex := 020
					oPrn:StartPage()
		EndIf
		oPrn:Say(nLinTex,20,"> Substituição imediata;",oFont11N)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,30,"Caso os equipamentos locados apresentem defeitos, os equipamentos serão substituídos imediatamente.",oFont11)
		nLinTex+=nEspaco+2

		oPrn:Say(nLinTex,20,"> Consultoria Técnica;",oFont11N)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,30,"A Intelisense disponibiliza para seus clientes, departamento de Engenharia para prestar consultoria em sistema de rádio comunicação, oferecendo ",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,30,"diagnósticos e sugestões fundamentais para aprimorar ainda mais o sistema de comunicação utilizado.",oFont11)
		nLinTex+=nEspaco+5
		
		If nLinTex >= 750 
					nLinTex := 020
					oPrn:StartPage()
		EndIf

		oPrn:Say(nLinTex,20,"CONDIÇÕES COMERCIAIS",oFont12N)
		nLinTex+=nEspaco
        cString := Alltrim(nObs)
        nLin := mlcount(cString,150)
        conout(cValToChar( nLin ))

        For i := 1 to nLin
            oPrn:Say(nLinTex,25,( memoline(cString,150,i)),oFont11)
                nLinTex+= nEspaco
        Next   
		/*
		oPrn:Say(nLinTex,25,"1 - Condição de entrega: Entrega por conta da Intelisense, Devolução por conta da contratante;",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,25,"2 - Prazo de entrega: Após assinatura de contrato 3 dias úteis para preparação de material;",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,25,"3 - Condição de Pagamento: Mensal / Contrato;",oFont11)
		nLinTex+=nEspaco
		If nLinTex >= 750 
					nLinTex := 020
					oPrn:StartPage()
					nLinTex+=nEspaco+2
		EndIf
		oPrn:Say(nLinTex,25,"4 - Impostos: Inclusos;",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,25,"5 - Reajuste: IGPM a cada 12 meses;",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,25,"6 - Garantia: Permanente, prestada pela Intelisense;",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,25,"7 - Validade da Proposta: 15 dias;",oFont11)
		*/
		nLinTex+=nEspaco
		
		If nLinTex >= 750 
					nLinTex := 020
					oPrn:StartPage()
					nLinTex+=nEspaco+2
		EndIf
		
		If	nVal==2
			cPer:='30 dias'	
		else
			cPer:='12 Meses'		
		EndIf
		nLinTex+=nEspaco+2
		oPrn:Say(nLinTex,20,"Atenciosamente,",oFont11)
		nLinTex+=nEspaco+6
		If nLinTex >= 750 
					nLinTex := 020
					oPrn:StartPage()
		EndIf
		oPrn:Say(nLinTex,20,FP0->FP0_NOMVEN,oFont11N)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,20,"Consultor (a) de Venda",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,20,"Intelisense Radiocomunicação Ltda.",oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,20,"11 4422 4100 / 11 4422 4030",oFont11)
		nLinTex+=nEspaco

		SA3->(dbGoTop())
		cEmail:='@'
			If SA3->(dbSeek(xFilial('SA3') + FP0->FP0_VENDED))
				cEmail:=SA3->A3_EMAIL
				cSite :=SA3->A3_HPAGE
			Endif

		oPrn:Say(nLinTex,20,cEmail,oFont11)
		nLinTex+=nEspaco
		oPrn:Say(nLinTex,20,"http://www.intelisense.com.br/",oFont11)
		nLinTex+=nEspaco
Return(NIL)

user Function obsint2()

    Local oMemo
    Private cTexto := FP0->FP0_OBSPRO
    Static oDlg

        DEFINE MSDIALOG oDlg TITLE "CONDIÇÕES COMERCIAIS" FROM 0,0 TO 555,650 PIXEL

            @ 005, 005 GET oMemo VAR cTexto MEMO SIZE 315, 250 OF oDlg PIXEL

            @ 260, 280 Button "OK" Size 018, 018 PIXEL OF oDlg Action(GRAVA(cTexto), ODLG:END()) PIXEL
            
        ACTIVATE MSDIALOG oDlg CENTERED
    
Return

STATIC Function GRAVA(cTexto)

	Local aArea := GetArea()

	RECLOCK('FP0',.F.)
	FP0_OBSPRO :=cTexto
	

	FP0->(MSUNLOCK())

	RestArea(aArea)

Return
