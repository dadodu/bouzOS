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
TC0	EQU	$0050
TC1	EQU	$0052

PORTB	EQU	$0001
DDRB	EQU	$0003

	ORG	DATA
VAR	DS.W	1
CMPT	DS.W	1

	ORG	CODE

INIT	LDD	#$0000
	STD	VAR

INIT_TIMER	LDAA	#$80	;On initialise le timer
	STAA	TSCR1	;On met TEN à 1
	
	LDAA	#$07	;
	STAA	TSCR2	;On met le prédiviseur à 128

	LDAA	#$00	;
	STAA	TIOS	;On met tous les canaux en capture d'entrée
	
	LDAA	#$0A	;
	STAA	TCTL4	;On met le trigger du timer sur front descendant
			;pour TC0 et TC1

BOUCLE	LDAA	TFLG1	;On récupère les flags du timer
	ANDA	#$03	;On masque pour ne récupérer que TC0 et TC1
	CMPA	#$03	;On teste
	BNE	BOUCLE	;Si les deux ne sont pas levés, on recommence
	LDAB	#$03	;
	STAB	TFLG1	;Si ils sont levés, on les remets à 0 en passant 1

DIFF	LDD	TC1	;On récupère le temps de fin (TC1)
	SUBD	TC0	;On le soustrait au temps de départ
	STD	VAR	;On stocke la différence dans la variable
	
	LDX	#$03E8	;On divise par 1000 pour avoir les millisecondes.
	IDIV
	STX	CMPT

	
	SWI
