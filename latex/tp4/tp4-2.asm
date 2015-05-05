CODE	EQU	$1000
DATA	EQU	$2000
PTH	EQU	$0260
DDRH	EQU	$0262
PERH	EQU	$0264
PPSH	EQU	$0265
PORTB	EQU	$0001
DDRB	EQU	$0003

	ORG	DATA

	ORG	CODE

	LDAA	#$FF	;On charge les valeurs 255 et 0 dans les 
	LDAB	#$00	;registres A et B

	STAA	PERH	;On active tout le port H
	STAB	PPSH	;On met le port H en pull up et fronts descendants
	STAB	DDRH	;On met tout le port H en entrée

	STAA	DDRB	;On initialise les LEDs en sortie
	

	LDAA	PTH	;On récupère les switchs baissés
	STAA	PORTB	;Et on affiche sur les LEDs


	SWI
