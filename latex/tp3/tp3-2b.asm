CODE	EQU	$1000
DATA	EQU	$2000
GETCHAR	EQU	$EE84
PUTCHAR	EQU	$EE86
SCI0SR1	EQU	$CC
SCI0DRL	EQU	$CF

	ORG	DATA
VAR	DS.B	1

	ORG	CODE
	LDAA	#$02	;On charge la valeur 2 dans A pour la stocker
			;dans la mémoire
	STAA	VAR	;Il s'agit de la valeur de départ
	BSR	SCRUT	;On effectue la structation avec la fonction AUVOL
	SWI

SCRUT	BSR	AUVOL
	CMPB	#'+'	;Comme précédemment, on compare le caractère entré
	BEQ	INCREM	;Et on incrémente la variable
	CMPB	#'-'
	BEQ	DECREM
	CMPB	#$1B
	BEQ	FIN

	LDAB	#'I'		;Caractère qui va clignoter
	JSR	[PUTCHAR,PCR]	;On fait apparaitre le caractère
	BSR	TEMPO		;On attend
	LDAB	#$08		;On charge le caractère BACKSPACE
	JSR	[PUTCHAR,PCR]	;On le fait apparaitre
	BSR	TEMPO		;On attend

	BRA	SCRUT		;Et on recommence indéfiniment
	RTS
	
INCREM	INC	VAR
	BRA	SCRUT

DECREM	DEC	VAR
	BRA	SCRUT
	

;*-- TEMPORISATION -----------------------------------
TEMPO	LDAA	VAR	;On commence la tempo
REC2	LDY	#$FFFF	;Tempo à 50 000
REC1	DEY
	BNE	REC1
	DECA
	BNE	REC2
	NOP		;Tempo fini
	RTS
;*----------------------------------------------------

AUVOL	BRCLR	SCI0SR1,#$20,VIDE
	LDAB	SCI0DRL	;
	BRA	FIN

VIDE	CLRB

FIN	RTS
