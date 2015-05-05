CODE	EQU	$1000
DATA	EQU	$2000
GETCHAR	EQU	$EE84

	ORG	DATA
VAR	DS.B	1

	ORG	CODE
	LDX	#VAR	;On récupère l'adresse de la variable dans X
	BSR	SCRUT	;On commence la scrutation des caractères entrés
			;par l'utilisateur
	SWI

SCRUT	CLRB	;On nettoie B pour être sûr du caractère qui va être
		;récupéré
	JSR	[GETCHAR,PCR]	;On récupère le caractère
	CMPB	#'+'		;On le compare avec "+"
	BEQ	INCREM		;Si oui, incrémentation de la variable
	CMPB	#'-'		;Comparaison avec "-"
	BEQ	DECREM		;Si oui, on décrémente
	CMPB	#$1B		;Comparaison avec la touche ESC
	BNE	SCRUT		;Si non, on recommence
	RTS			;sinon on arrête
	
INCREM	INC	0,X	;On incrémente VAR
	BRA	SCRUT	;On recommence à scruter

DECREM	DEC	0,X	;On décrémente VAR
	BRA	SCRUT	;On recommence à scruter
	
	
