CODE	EQU	$1000
DATA	EQU	$2000
DDRB	EQU	$0003
PORTB	EQU	$0001
DDRA	EQU	$0002
PORTA	EQU	$0000
SORTIE	EQU	$FF
ENTREE	EQU	$00

	ORG	DATA
DEPART	DC.B	$7F

	ORG	CODE
	LDAA	#SORTIE	;On initialise le port B en sortie
	STAA	DDRB	;
	LDAA	DEPART	;On récupère la valeur de départ dans A
	SEC		;On initialise la carry à 1 pour éviter d'avoir
			;une double barre dans le chenillard

BOUCLE	STAA	PORTB	;On affiche ce qui est dans A
	RORA		;On rotationne vers la droite A

	BSR	TEMPO	;On temporise

	BRA	BOUCLE	;Et on recommence

	SWI


;*-- TEMPORISATION -----------------------------------
TEMPO	LDAB	#$FA	;On commence la tempo
REC2	LDY	#$0FFF	;Tempo à 50 000
REC1	DEY
	BNE	REC1
	DECB
	BNE	REC2
	NOP		;Tempo fini
	RTS
;*----------------------------------------------------
