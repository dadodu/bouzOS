CODE	EQU	$1000
DATA	EQU	$2000
PTH	EQU	$0260
DDRH	EQU	$0262
PERH	EQU	$0264
PPSH	EQU	$0265
PIFH	EQU	$0267
PORTB	EQU	$0001
DDRB	EQU	$0003

	ORG	DATA
VAR	DS.B	1

	ORG	CODE

	LDAA	#$FF	;On charge les valeurs 255 et 0 dans les 
	LDAB	#$00	;registres A et B

	STAB	VAR	;On initialise au passage la variable qui va compter
			;les fronts descendants

	STAA	PERH	;On active tout le port H
	STAA	PIFH	;On réinitialise tous les flags du port H
	STAB	PPSH	;On met le port H en pull up et fronts descendants
	STAB	DDRH	;On met tout le port H en entrée

	STAA	DDRB	;On initialise les LEDs en sortie

BOUCLE	LDAA	PIFH	;On récupère les flags du port H
	CMPA	#$01	;Si le premier switch est activé, alors
	BEQ	INCR	;On passe à la fonction d'incrémentation
	BRA	BOUCLE	;Sinon on reboucle indéfiniment.
	SWI

INCR	INC	VAR	;On incrémente la variable
	STAA	PIFH	;On réinitialise les flags
	LDAB	VAR	;On récupère la valeur de la variable
	COMB		;On l'inverse
	STAB	PORTB	;Pour l'affichage sur les LEDs.
	BRA	BOUCLE	;Et on recommence.
