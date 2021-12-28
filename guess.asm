;This program will simulate a simple guessing game. The program has stored the value 6. 
;The program will continually ask the user to guess a number between 0 and 9 
;The user enters the guess from the keyboard: 
	;1. If the guess is larger than 6; the program should output: Too big.	
	;2. If the guess is smaller than 6; the program should output: Too small.	
	;3. When the user finally guesses correctly, the program will output: Correct! You took # guesses.
	;4. If after 9 guesses, the user has not correctly guessed the number, the program should output: Game over. 
		;Correct answer is 6.
	;If your program encounters any non digit character, the program should output (Invalid input should still count as a guess): Invalid input. 



		.ORIG x3000
		AND R0, R0, #0
		AND R1, R1, #0
		AND R2, R2, #0
		AND R3, R3, #0
		AND R4, R4, #0
		AND R5, R5, #0
		AND R6, R6, #0
		AND R7, R7, #0
		
		
		
		ADD R5, R5, #0			;COUNTER
		LD R6, NUM			; x-54 to test if it's the right number
		LEA R0, P1			; prompt for user to guess
		PUTS				; prints to console
		
TRY		IN				; get answer
		ADD R1, R0, #0			; put it in R1
		LD R3, HEX30			; testing if the input is between 0 and 9
		NOT R3, R3
		ADD R3, R3, #1
		ADD R2, R3, R1
		BRn WARN			; if it's neg, its invalid input
		LD R4, HEX3A
		NOT R4, R4
		ADD R4, R4, #1
		ADD R2, R4, R1
		BRzp WARN			; if its zero or pos, its invalid input

TEST		ADD R0, R1, R6			; test if the input is the right number
		BRn LOW				; if neg result its too small
		BRp HIGH			; if pos result its too high
		BRz WIN				; if zero result its the right number

LOW		LEA R0, LOW2			; prompt to say that the input is too low
		PUTS				; prints to console		
		ADD R5, R5, #1			; count
		ADD R0, R5, #-9	
		BRn TRY				; keep trying
		BRz LOSE			; no more trys

HIGH		LEA R0, HIGH2			; prompt to say the input is too high
		PUTS				; print to console
		ADD R5, R5, #1			; count
		ADD R0, R5, #-9			
		BRn TRY				; keep trying
		BRz LOSE			; no more trys

WARN		LEA R0, ERROR			; invalid input prompt
		PUTS
		BRnzp TRY			; try again

WIN		LD R2, HEX30			; put x0030 in R2 to see how many guesses
		ADD R5, R5, #1			; count
		LEA R0, WIN2			; correct answer
		PUTS
		ADD R0, R5, R2			; get the number of gueses
		OUT				; DON'T USE PUTS, USE OUT 
		LEA R0, WIN3			
		PUTS	
		HALT

LOSE		LEA R0, LOSE2
		PUTS
		HALT

NUM	.FILL #-54
HEX30	.FILL x0030
HEX3A	.FILL x003A
ERROR	.STRINGZ "INVALID INPUT."
P1	.STRINGZ "GUESS THE NUMBER BETWEEN 0 AND 9."
LOW2	.STRINGZ "TOO SMALL. TRY AGAIN."
HIGH2	.STRINGZ "TOO HIGH. TRY AGAIN."
LOSE2	.STRINGZ "\nGAME OVER. THE CORRECT ANSWER IS 6."
WIN2	.STRINGZ "CORRECT ANSWER. IT TOOK "
WIN3	.STRINGZ " GUESSES. "
		.END