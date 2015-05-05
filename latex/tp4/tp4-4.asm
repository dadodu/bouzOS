CODE	EQU	$1000
DATA	EQU	$2000
PORTB	EQU	$0001
DDRB	EQU	$0003

	ORG	DATA
COMPT32	DS.B	4	;On créé un compteur 32 bits sur 4 octets
			;On pourrait également faire ça sur 2 mots binaires
			;de 16 bits

	ORG	CODE
INIT	LDX	#COMPT32;On charge le compteur 32 bits dans X
	LDD	#$0000	;On initialise l'accumulateur D
	STD	0,X	;On met à zéro la totalité du compteur
	STD	2,X	;
	LDAA	#$FF	;On charge 255 dans A
	STAA	DDRB	;On initialise les LEDs en sortie
	STAA	PORTB	;On éteint les LEDs


	SEI		;On arrête temporairement l'interruption pour
			;l'installer
	LDD	#IT	;On charge l'adresse de la fonction interruption
			;dans D
	STD	$3E72	;On charge ladresse dans le vecteur d'interruption
			;sur IRQ
			
	CLI		;On enlève le masque sur l'interruption

	
BOUCLE	BRA	BOUCLE	;On réalise une boucle infinie vide

	SWI

IT	BSR	INCR32	;L'interruption consiste en l'incrémentation du 
			;compteur 32 bits et l'affichage du poids le plus
			;faible sur les LEDs.
	LDAB	3,X	;On récupère le poids le plus faible
	COMB		;On l'inverse
	STAB	PORTB	;On l'affiche sur les LEDs
	RTI		;Retour d'interruption

;*-- Incrémentation compteur 32 bits ----------
;On va incrémenter du poids le plus faible vers 
;le poids le plus fort. Le changement se fait si
;la carry est levée. Sinon on sort de la fonction.

INCR32	INC	3,X
	BCC	FIN
	INC	2,X
	BCC	FIN
	INC	1,X
	BCC	FIN
	INC	0,X
FIN	RTS		;Retour de sous-routine
;*---------------------------------------------
