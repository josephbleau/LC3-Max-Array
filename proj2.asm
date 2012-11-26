; Purpose: This program loads an array of integers into memory and then
;		   determines the highest value of all of its elements.
; Author: Joseph Bleau
; Date: The Last Day The Project Is Due. (11/26)
; Class: COSC 221

	.ORIG x3000
; Entry Point (The beginning of the program.)
Bgn	AND R0, R0, 0	; Clear all of our registers
	AND R1, R1, 0	
	AND R2, R2, 0
	AND R3, R3, 0
	AND R4, R4, 0
	AND R5, R5, 0
	AND R6, R6, 0
	AND R7, R7, 0

	; Fill our array with some values
	LEA R0, Arr
	ST	R0, Arp

	ADD R1, R1, 11 ; Store 11 in Arr[0]
	STI R1, Arp
	AND	R1, R1, 0
	LD  R0, Arp
	ADD R0, R0, 1
	ST  R0, Arp
	
	ADD R1, R1, 2 ; Store 2 in Arr[1]
	STI R1, Arp
	AND	R1, R1, 0
	LD  R0, Arp
	ADD R0, R0, 1
	ST  R0, Arp

	ADD R1, R1, 7 ; Store 7 in Arr[2]
	STI R1, Arp
	AND	R1, R1, 0
	LD  R0, Arp
	ADD R0, R0, 1
	ST  R0, Arp
	
	ADD R1, R1, 14 ; Store 14 in Arr[3]
	STI R1, Arp
	AND	R1, R1, 0
	LD  R0, Arp
	ADD R0, R0, 1
	ST  R0, Arp

	ADD R1, R1, 15; Store 15 in Arr[4]
	STI R1, Arp
	AND	R1, R1, 0
	LD  R0, Arp
	ADD R0, R0, 1
	ST  R0, Arp

	; The array is now initialized as {11, 2, 7, 14, 15} located at Arr, using Arp to 
	; point to it when we need to.
	; Loop over the array and call Max to determine which value is the highest, R0 
	; will store our current max.
	LEA R0, Arr
	ST	R0, Arp		; Reinit array pointer
	AND R0, R0, 0
	AND R5, R5, 0 	; Clear R5 to be our loop counter.
	ADD R5, R5, 5	; We will be looping five times.
	NOT R5, R5		; Invert it and add one to create a negative 5
	ADD R5, R5, 1	

Lop	ST 	R0, SI1 ; Prepare parameters, current max
	LDI	R1, Arp
	ST  R1, SI2
	JSR Max
	LD  R0, SO1		; Store the return value of Max in R0
	LD  R4, Arp
	ADD R4, R4, 1	; Increment our array pointer
	ST	R4, Arp		; Store our new array pointer value
	ADD R5, R5, 1
	BRn	Lop			; If our loop counter is still negative, continue our loop.

	HALT
	
	; Hey look, unit tests in assembly.
	; Testing max SR (Test Passed)
	; ADD R0, R0, 5
	; ADD R1, R1, 3
	; ST  R0, SI1		; Prepare parameters
	; ST  R1, SI2
	; JSR Max
	; LD  R2, SO1		; Register 2 should be equal to register 0 at this point.

; Subroutine: Max (Takes two inputs using SI1 and SI2 and returns the value of
;                  the higher value, or SI2 if they are equal, storing the results
;                  in value SO1) 
Max	LD	R0, SI1 	; Determine which value is higher,  
	LD	R1,	SI2 	; either SI1 or SI2, and fill SO1 with it
	NOT R2, R1		; Flip R1 and Add One to it causing it to
	ADD R2, R2,	1	; be negative in twos-complemen
	AND R6, R6, 0	; Clear R6 for writing
	ADD R3, R0,	R2	; Add R0 and Negative R1
	BRp	R0G			; If R0 is greater than R1, jump to R0G, else stay with R1G and return 
R1G	ADD R6, R6, R1	; Write R1 to R6, since R1 was greater than R0
	ST	R6, SO1
	RET
R0G	ADD R6, R6, R0	; Write R0 to R6, since R0 was grater than R1
	ST  R6, SO1
	RET

; Helper stack
SI1	.FILL	xFE00 	; Used in passing values into an SR
SI2	.FILL	xFE01	; Used in passing values into an SR
SO1	.FILL	xFE02	; Used in returning values from an SR
Arr	.BLKW	5		; A 5 Word Array
Arp	.BLKW	1		; A pointer to the array
	.END