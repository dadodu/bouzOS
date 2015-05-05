CODE	EQU	$1000
DATA	EQU	$2000
PUTCHAR	EQU	$EE86

	ORG	DATA
CHAINE	DC.B	"The Game",10,0

	ORG	CODE
	LDY	#CHAINE	;On récupère l'adresse de la chaine
			;à afficher dans Y
	BSR	AFFICH	;On effectue l'affichage
	SWI		;On arrête


AFFICH	LDAB	1,Y+	;On charge le premier caractère 
			;dans le registre B
			
	PSHY		;On backup la valeur de Y dans la pile
			;pour éviter un écrasement
			
	JSR	TEMPO	;On fait une tempo
	JSR	[PUTCHAR,PCR]	;On affiche le premier caractère
				;situé dans B
				
	PULY		;On récupère l'adresse du prochain caractère dans Y
	BNE	AFFICH	;Si on n'obtient pas le caractère nul, on continue.
	RTS		;fin de sous routine

;*-- TEMPORISATION -----------------------------------
TEMPO	LDAA	#$FA	;On commence la tempo
REC2	LDX	#$0FFF	
REC1	DEX
	BNE	REC1
	DECA
	BNE	REC2
	NOP		;Tempo fini
	RTS
;*----------------------------------------------------
