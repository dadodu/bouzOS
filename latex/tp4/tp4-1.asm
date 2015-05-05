CODE	EQU	$1000
DATA	EQU	$2000
PTH	EQU	$0260
DDRH	EQU	$0262
PERH	EQU	$0264
PPSH	EQU	$0265


	ORG	DATA
VAR	DS.B	1

	ORG	CODE

	LDAA	#$FF	;On charge les valeurs 255 et 0 dans les 
	LDAB	#$00	;registres A et B

	STAA	PERH	;On active tout le port H
	STAB	PPSH	;On met le port H en pull up et fronts descendants
	STAB	DDRH	;On met tout le port H en entrée

	LDAA	PTH	;On récupère la position des switches levés
			;sous un octet
	STAA	VAR	;On stocke cet octet dans la variable définie


	SWI
