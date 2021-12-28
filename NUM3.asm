; write an LC-3 assembly language program that accepts text inputs
; encrypts it into cipher text and displays the cipher text in a text string.
;	- you can either input one character at a time until the "Enter" is pressed
;		or enter a text string ended with the "enter"
;	- the encryption key will be added is x07
;	- the encryption process adds the key to the cleartext first, and
;		then swaps the higher 4-bits with the lower 4-bits


		.ORIG x3000
		AND R0, R0, #0
		AND R1, R1, #0
		AND R2, R2, #0
		AND R3, R3, #0
		AND R4, R4, #0
		AND R5, R5, #0
		AND R6, R6, #0
		AND R7, R7, #0
		LD R3, MSG			; R3 HAS M[X310F]
	ADD R3, R3, #1			; INCREMENT M[X310F] TO GO TO NEXT LOCATION
	LEA R0, INP1			; ASK FOR MESSAGE
	PUTS				; PRINT TO CONSOLE
READ	IN				; RETRIEVE MESSAGE
	ADD R2, R0, #-10		; TEST FOR END OF LINE
	BRz WARN1
	BRnp STORE
READ2 	IN
	ADD R1, R0, #-10
	BRz LOAD
	BRnp STORE			; IF 0 ERROR

STORE 	STR R0, R3, #0
	ADD R3, R3, #1
	BRnzp READ2
	
LOAD	LD R3, MSG			; R3 HAS M[X310F]
	LD R4, RES			; R4 HAS M[X311F]

	

GET	ADD R3, R3, #1			; INCREMENT TO REACH APPROPRIATE MEM LOCATION
	ADD R4, R4, #1			; INCREMEN TO REACH APPROPRIATE MEM LOCATION
	LDR R2, R3, #0			; GET THE CHARACTER
	ADD R5, R2, #0			; TEST FOR ENDING
	BRz END
	

ENCRYPT	LD R1, KEY
	ADD R2, R1, R2			; KEY + CHAR = ENCRYPT
	ST R2, CHK

;SWAP TOP 4 BITS W LOW 4 BITS
	ADD R6, R6, #12
	AND R5, R5, #0
	AND R7, R7, #0
	LD R1, MSK

LOOP1	AND R7, R1, R2		;mask
	BRz LOOP2
	ADD R7, R5, #1
LOOP2  	ADD R2, R2, R2
	ADD R2, R2, R7
	ADD R6, R6, #-1
	BRz STORE2
	BRp LOOP1

STORE2	STR R2, R4, #0
	BR GET	

END	LEA R0, INP2
	PUTS
	LD R1, RES

LOOP	ADD R1, R1, #1
	LDR R0, R1, #0
	ADD R0, R0, #0
	BRz FINISH
	OUT
	BRnzp LOOP

WARN1	LEA R0, ERROR
	PUTS
	BRnzp READ2

FINISH	LEA R0, SPACE
	PUTS

	HALT
CHK	.FILL x0		
KEY	.FILL X0007
MSK	.FILL x8000
EOL	.FILL x0010
MSG 	.FILL x310F
RES	.FILL x311F
ERROR	.STRINGZ "TRY AGAIN.\n"
SPACE 	.STRINGZ "\nDONE\n"
INP1	.STRINGZ "ENTER MESSAGE(32 CHAR LIMIT): "
INP2	.STRINGZ "ENCRYPTED MESSAGE IS: "


		.END