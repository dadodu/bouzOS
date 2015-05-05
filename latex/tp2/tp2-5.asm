CODE	EQU	$1000
DATA	EQU	$2000
DDRB	EQU	$0003
PORTB	EQU	$0001
DDRA	EQU	$0002
PORTA	EQU	$0000
SORTIE	EQU	$FF
ENTREE	EQU	$00

	ORG	DATA
TABL	DC.B	$32,$32,$2B,$85,$85,$47	;Les différents cas possibles
;     feux voi 3 et 4[R,O,V] - feux voi 1 et 2[R,O,V] - feux p exclus 
;#1 : 001                    - 100                    - 10 [1 = red, 0 = vert]
;#2 : 001                    - 010                    - 11
;#3 : 100                    - 001                    - 01
;#4 : 010                    - 001                    - 11


	ORG	CODE
	
	LDAA	#SORTIE	;On initialise le port A en sortie
	STAA	DDRA	;

MAIN	LDX	#TABL	;On récupère l'adresse du tableau avec le pattern

BOUCLE	LDAA	1,X+	;On récupère et on met dans le port A
	STAA	PORTA	;

	BSR	TEMPO	;On temporise

	CPX	#TABL+6	;On vérifie si on est au bout du tableau
	BNE	BOUCLE	;Sinon on continue
	BRA	MAIN	;On reprend depuis le début

	SWI
	
;*-- TEMPORISATION -----------------------------------
TEMPO	LDAB	#$FA	;On commence la tempo
REC2	LDY	#$C34F	;Tempo à 50 000
REC1	DEY
	BNE	REC1
	DECB
	BNE	REC2
	NOP		;Tempo fini
	RTS
;*----------------------------------------------------
