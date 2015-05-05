CODE	EQU	$1000
DATA	EQU	$2000
DDRB	EQU	$0003
PORTB	EQU	$0001
DDRA	EQU	$0002
PORTA	EQU	$0000
SORTIE	EQU	$FF
ENTREE	EQU	$00

	ORG	DATA
K2000	DC.B	$E7,$DB,$BD,$7E,$BD,$DB

	ORG	CODE
	LDAA	#SORTIE	;On initialise le port B en sortie
	STAA	DDRB

BOUCLE	LDX	#K2000
	
B1	LDAA	1,X+
	STAA	PORTB

;*-- TEMPORISATION -----------------------------------
	LDAB	#$FA	;On commence la tempo
REC2	LDY	#$0FFF	;Tempo arbitraire
REC1	DEY
	BNE	REC1
	DECB
	BNE	REC2
	NOP		;Tempo fini
;*----------------------------------------------------

	CPX	#K2000+6
	BNE	B1

	BRA	BOUCLE
