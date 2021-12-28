; write an LC-3 Assembly language program that will multiply and divide two numbers
; from the keyboard by calling subroutines "Multiply" and "Division". The results
; will be shown on display. (hints: the main program's function is to retrieve the 
; two numbers and then to call the subroutines to perform the multiplication and 
; division. The subroutines will return the product and quotient back to main program.)

		.ORIG x3000
		AND R0, R0, #0
		AND R1, R1, #0
		AND R2, R2, #0
		AND R3, R3, #0
		AND R4, R4, #0
		AND R5, R5, #0
		AND R6, R6, #0
		AND R7, R7, #0
		LD R2, HEX30
		NOT R2, R2
		ADD R2, R2, #1
		LEA R0, PROMPT1				;GETTING THE FIRST NUMBER
		PUTS
		GETC
		ADD R3, R0, #-10
		BRz NEXT
		OUT
		ADD R0, R0, R2
		ST R0, FIRSTNUM				;STORE FIRST NUMBER
		
NEXT		LEA R0, PROMPT2				; GET THE SECOND NUMBER
		PUTS
		GETC
		ADD R3, R0, #-10			; GET SECOND NUMBER
		BRz DONE
		OUT
		ADD R0, R0, R2

		ST R0, SECNUM				; STORE SECOND NUMBER

DONE		LEA R0, PROMPT3				; GET OPERATION
		PUTS
		IN
		LD R1, DIV
		LD R2, MULT
		LD R4, FIRSTNUM
		LD R5, SECNUM
		ADD R3, R0, R2
		BRz MULTIPLY
		ADD R3, R0, R1
		BRz DIVISION

DIVISION	JSR DIVIDE
		LEA R0, PROMPT4
		PUTS
		LD R6, QUOTIENT
		LD R3, HEX30
		ADD R6, R6, R3
		ST R6, QUOTIENT
		LEA R0, QUOTIENT
		PUTS
		BR STOP

MULTIPLY	JSR MULTI
		LEA R0, PROMPT4
		PUTS
		LD R6, PROD
		LD R3, HEX30
		ADD R4, R6, #-10
		ADD R6, R6, R3
		ST R6, PROD
		LEA R0, PROD
		PUTS		
STOP 		HALT

HEX30		.FILL x30
MULT		.FILL #-42
DIV		.FILL #-47
FIRSTNUM	.FILL x0
SECNUM		.FILL x0
PROD		.FILL x0
		.BLKW 1
REMAINDER	.FILL x0
QUOTIENT	.FILL x0
		.BLKW 1
PROMPT1 	.STRINGZ "\nENTER FIRST NUMBER: "
PROMPT2		.STRINGZ "\nENTER SECOND NUMBER: "
PROMPT3		.STRINGZ "\nENTER OPERATION: (* or /) "
PROMPT4		.STRINGZ "\nRESULT IS: "


;--------------------------MULTIPLY SUBROUTINE


MULTI	ST R7, SAVE
	AND R6, R6, #0
	AND R3, R3, #0
	AND R5, R5, #0
	LD R3, FIRSTNUM        ;2
	LD R5, SECNUM		;4		
MULTY	ADD R6, R6, R3
	ADD R5, R5, #-1
	BRp MULTY
	ST R6, PROD
	LD R7, SAVE
	RET
	
	
	
SAVE		.FILL #0


;------------------DIVIDE SUBROUTINE

DIVIDE	ST R7, SAVER7
	AND R1, R1, #0		; FIRST NUM
	AND R2, R2, #0		; SEC NUM
	AND R3, R3, #0		; NEG OF SEC NUM	
	AND R4, R4, #0		; REMAINDER
	AND R5, R5, #0		; QUOTIENT
	AND R6, R6, #0
	LD R1, FIRSTNUM
	LD R2, SECNUM
	BRz END
	NOT R3, R2
	ADD R3, R3, #1
LOOP	ADD R1, R1, R3
	BRn NEG
	ADD R5, R5, #1
	BRz ZERO
	BRp LOOP
NEG	ADD R4, R1, R2
	ST R4, REMAINDER
ZERO	ST R5, QUOTIENT

END 	LEA R0, ERROR
	PUTS
	
	LD R7, SAVER7
	RET

SAVER7		.FILL #0		
ERROR		.STRINGZ "\nCANNOT DIVIDE BY ZERO."


			.END