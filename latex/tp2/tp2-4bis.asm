CODE	EQU	$1000
DATA	EQU	$2000
DDRB	EQU	$0003
PORTB	EQU	$0001
DDRA	EQU	$0002
PORTA	EQU	$0000
SORTIE	EQU	$FF
ENTREE	EQU	$00

	ORG	DATA
TABL	DC.B	$FE,$FD,$FB,$F7,$EF,$DF,$BF,$7F,0
			;Pattern correspondant au chenillard

	ORG	CODE
	LDAA	#SORTIE	;On initialise le port B en sortie (avec les LEDs)
	STAA	DDRB	;
B1	LDY	#TABL	;On récupère l'adresse du pattern dans Y

B2	LDAA	1,Y+	;On stocke la valeur du pattern en A
	STAA	PORTB	;Et on l'envoie dans le port B
	

	LDAB	#$FA	;On commence la tempo
REC2	LDX	#$0AE7	;temps de tempo choisi "à l'oeil"
REC1	DEX
	BNE	REC1
	DECB
	BNE	REC2
	NOP		;Tempo fini

	CPY	#TABL+8	;Si on atteint la fin du tableau,
	BNE	B2	;Sinon on continue
	BRA	B1	;On reprend tout.
	

	SWI
