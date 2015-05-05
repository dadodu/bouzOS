CODE	EQU	$1000
DATA	EQU	$2000
PTH	EQU	$0260
DDRH	EQU	$0262
PERH	EQU	$0264
PPSH	EQU	$0265
PIEH	EQU	$0266
PIFH	EQU	$0267
PORTB	EQU	$0001
DDRB	EQU	$0003

	ORG	DATA
COMPT	DS.B	1

	ORG	CODE
INIT	SEI		;On masque l'interruption
			;Initialisation des paramètres
	LDD	#IT	;On charge l'adresse de l'interruption
	STD	$3E4C	;Pour la stocker dans le vecteur d'interruption
			;du port H

	LDAA	#$FF	;On charge $FF
	LDAB	#$00	;On charge $00

	STAA	PERH	;On active tout le port H
	STAB	PPSH	;On met le port H en pull up et fronts descendants
	STAB	DDRH	;On met tout le port H en entrée

	STAA	PIEH	;On valide les interruptions sur tous les pins du
			;port H.
	
	CLI		;On enlève le masque de l'interruption.

	STAA	DDRB	;On active les LEDs en sortie (debug)
	LDAA	#$00	;
	
	STAA	COMPT	;On met le compteur à 0.

BOUCLE	LDAB	COMPT	;On récupère la valeur du compteur
	COMB		;On l'inverse
	STAB	PORTB	;On l'affiche avec les LEDs
	COMB		;On le réinverse
	CMPB	#$05	;Si on est à 5, on arrête (debug)
	BNE	BOUCLE	;On reboucle.

	SWI

IT	INC	COMPT	;On incrémente le compteur 
	LDAA	#$FF
	STAA	PIFH	;On remet les flags d'interruption à 0
	BRA	TEMPO	;On temporise
FIN_IT	RTI		;On retourne dans le programme principal.

;*-- TEMPORISATION -----------------------------------
TEMPO	LDAA	#$FA	;Temporisation logicielle de durée grossière.
REC2	LDX	#$03E7	;Fait "à l'oeil"
REC1	DEX
	BNE	REC1
	DECA
	BNE	REC2
	NOP
	BRA	FIN_IT
;*----------------------------------------------------
