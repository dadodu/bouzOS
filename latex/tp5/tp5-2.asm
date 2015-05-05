CODE	EQU	$1000
DATA	EQU	$2000
TIOS	EQU	$0040
TSCR1	EQU	$0046
TSCR2	EQU	$004D
TCTL1	EQU	$0048
TCTL2	EQU	$0049
TCTL3	EQU	$004A
TCTL4	EQU	$004B
TFLG1	EQU	$004E
TCNT	EQU	$0044
TC2	EQU	$0054

SCI0SR1	EQU	$CC
SCI0DRL	EQU	$CF

	ORG	DATA
CMPT	DS.B	1

	ORG	CODE

INIT	LDD	#$64	;On commence avec le compteur à 100.
	STD	CMPT

INIT_T	LDAA	#$80	;On initialise le timer
	STAA	TSCR1	;On met TEN à 1
	
	LDAA	#$04	;
	STAA	TSCR2	;On met le prédiviseur à 16

	LDAA	#$04	;
	STAA	TIOS	;On met le le canal 3 en sortie sur comparaison
	
	LDAA	#$10	;
	STAA	TCTL2	;On met le basculement sur OC3

	LDD	TCNT	;On récupère le timer
	STD	TC2	;On charge dans le TC2
	
BOUCLE1	ADDD	CMPT	;On ajoute le timer au compteur initial
	STD	TC2	;On place le résultat dans le TC2
	BSR	AUVOL	;On récupère un caractère
	CMPB	#'+'	;Si c'est '+', on incrémente
	BEQ	INCR
	CMPB	#'-'	;Si c'est '-', on décrémente
	BEQ	DECR
BOUCLE2	LDAA	TFLG1	;On récupère les flags du timer
	ANDA	#$04	;On masque pour ne récupérer que C2I
	CMPA	#$04	;On teste
	BNE	BOUCLE2	;Si il n'est pas activé, on recommence
	LDAB	#$04	;
	STAB	TFLG1	;Si il est levé, on le remet à 0 en passant 1
	LDD	TC2
	BRA	BOUCLE1
	
	SWI

;*---- Fonction AUVOL ----------------
;Fonction permettant la saisie au clavier sans attente
;du programme.

AUVOL	BRCLR	SCI0SR1,#$20,VIDE
	LDAB	SCI0DRL
	BRA	FIN

FIN	RTS

VIDE	CLRB
;*------------------------------------


INCR	LDD	CMPT	;On charge le compteur
	ADDD	#$000A	;On ajoute 10 à la valeur
	STD	CMPT	;On remet en mémoire
	BRA	BOUCLE2	;On poursuit le programme principal.

DECR	LDD	CMPT	;Idem mais on enlève 10 au compteur
	SUBD	#$000A	;
	STD	CMPT
	BRA	BOUCLE2
