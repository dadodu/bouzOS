CODE	EQU	$1000
DATA	EQU	$2000
DDRB	EQU	$0003
PORTB	EQU	$0001
DDRA	EQU	$0002
PORTA	EQU	$0000
SORTIE	EQU	$FF
ENTREE	EQU	$00

	ORG	DATA


	ORG	CODE
	
	LDAA	#SORTIE	;On initialise le port B en sortie
	STAA	DDRB	;

	LDAA	#ENTREE	;On initialise le port A en entrée
	STAA	DDRA	;

BOUCLE	LDAA	PORTA	;On récupère le port A
	STAA	PORTB	;On le met dans le port B

	BRA	BOUCLE	;On recommence


	SWI
