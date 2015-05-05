CODE	EQU	$1000
DATA	EQU	$2000
VALEUR	EQU	$3000
PRINTF	EQU	$EE88
OUT2HEX	EQU	

	ORG	DATA
VAR	DC.B	'Valeur : %d',10,0

	ORG	CODE
	CLRA		;On clear A parce qu'on veut uniquement la valeur de
			;$3000 et printf prend des mots en argument
	LDAB	VALEUR	;On charge B avec la valeur voulue en $3000
	PSHD		;On passe la valeur totale en paramètre par la pile
	LDD	#VAR	;On charge la chaine de caractère pour le printf
	JSR	[PRINTF,PCR]	;On effectue le printf
	PULD		;On récupère notre valeur.

	
	
	SWI
