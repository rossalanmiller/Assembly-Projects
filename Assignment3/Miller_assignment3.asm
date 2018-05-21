;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_assignment3.asm
;Course:		Fall - SCSC 210
;Section:		2
;Due date:		October 12, 2016
;Desc:			Prompts user for some input 
;           	then formats it as output.
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
extern printf						;reference printf function from c library
extern scanf						;reference scanf function from c library

global main                        	;Required so linker can find entry point

main:					;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	push dword name		;push address of name to stack
	call printf			;print name from top of stack
	add esp, 4			;reset stack pointer
	
	
	
	push dword num_prompt	;push address of num_prompt to stack
	call printf				;print num_prompt from top of stack
	add esp, 4				;reset stack pointer
	
	push dword num2			;push address of num2 (2nd parameter)
	push dword num1			;push address of num1 (1st parameter)
	push dword	num_fmt		;push address of num_fmt (takes two parameters)
	call scanf				;scan input into num1 then num2
	add esp, 12				;reset stack pointer
	
	
	
	push dword col_prompt	;push address of col_prompt to stack
	call printf				;print col_prompt from top of stack
	add esp, 4				;reset stack pointer
	
	push dword col			;push address of col
	push dword col_fmt		;push address of col_fmt
	call scanf				;scan input into color
	add esp, 8				;reset stack pointer
	
	
	
	push dword neg_prompt	;push address of neg_prompt to stack
	call printf				;print neg_prompt
	add esp, 4				;reset stack pointer
	
	push dword negN			;push address of neg_num
	push dword neg_fmt		;push address of neg_fmt
	call scanf				;scan input into neg
	add esp, 8				;reset stack pointer
	
	
	mov eax, [num1]			;copy value of num1 to eax
	add eax, [num2]			;eax = eax + num2
	
	push dword eax				;3rd parameter
	push dword [num2]		;2nd parameter
	push dword [num1]		;1st parameter
	push dword sum_res		;result format string
	call printf				;print result
	add esp, 16				;reset stack pointer
	
	
	
	mov eax, [num1]			;copy value of num1 to eax
	sub eax, [num2]			;eax = eax - num2
	
	push dword eax				;3rd parameter
	push dword [num2]		;2nd parameter
	push dword [num1]		;1st parameter
	push dword dif_res		;result format string
	call printf				;print result
	add esp, 16				;reset stack pointer
	
	
	
	mov eax, [num1]			;copy value of num1 to eax
	mov ebx, [negN]			;copy value of negN to ebx
	imul ebx   				;eax = eax * ebx
	
	push dword eax			;3rd parameter
	push dword ebx  		;2nd parameter
	push dword [num1]		;1st parameter
	push dword usp_res		;result format string
	call printf				;print result
	add esp, 16				;reset stack pointer
	
	
	mov eax, [num1]			;copy value of num1 to eax
	mov ebx, [negN]			;copy value of negN to ebx
	imul ebx   				;eax = eax * ebx
	
	push dword eax			;3rd parameter
	push dword ebx  		;2nd parameter
	push dword [num1]		;1st parameter
	push dword sp_res		;result format string
	call printf				;print result
	add esp, 16				;reset stack pointer
	
	
	mov edx, 0				;clear edx for division
	mov eax, [num1]			;copy value of num1 to eax
	mov ebx, [num2]			;copy value of negN to ebx
	div ebx  				;eax = eax/ebx (remainder is in edx)
	
	push dword edx			;4th parameter remainder
	push dword eax			;3rd parameter quotient
	push dword ebx  		;2nd parameter num2
	push dword [num1]		;1st parameter num1
	push dword div_res		;result format string
	call printf				;print result
	add esp, 20				;reset stack pointer
	
	
	
	
	push dword [num1]		;2nd parameter
	push dword [num1]		;1st parameter
	push dword summery_p1	;summery_p1 format
	call printf				;print summery_p1
	add esp, 8				;set the stack pointer to before the second num1

	push dword [num1]		;1st parameter
	push dword summery_p2   ;push format string to top of stack
	call printf				;print summery_p2
	add esp, 8				;reset stack pointer
	
	
	push dword [num2]		;2nd parameter
	push dword [num2]		;1st parameter
	push dword summery_p3	;summery_p1 format
	call printf				;print summery_p1
	add esp, 12				;set the stack pointer to before the second num1
	
	push dword[num2]		;1st parameter
	push dword summery_p4   ;push format string to stack
	call printf				;print summery_p2
	add esp, 8				;reset stack pointer
	
	
	
	
	push dword [num1]		;3rd parameter
	push dword [num2]		;2nd parameter
	push dword col		;1st parameter
	push dword user_name	;push user_name string
	call printf				;print user_name string
	add esp, 16				;reset stack pointer
	
	
	push dword footer	;push address of footer to stack
	call printf			;print footer from top of stack
	add esp, 4			;reset stack pointer


;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	pop edi				;Program restores saved register values by
	pop esi 				;popping them from the stack as they
	pop ebx					;were pushed from the beginning
	mov esp, ebp			;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret				;Returns the control to Linux



[SECTION .data]                    ;Section containing initialized data
	
	name	db		"Ross Miller",10,0									;Declare name string with newline
	footer	db		"***Successful Program Termination***",10,0			;Declare string footer with newline
	
	num_prompt db	"Please enter two numbers:",9,0						;Declare prompt for two numbers
	col_prompt db	"Please enter your favorite color:",9,0				;Declare prompt for favorite color
	neg_prompt db	"Please enter a negative number:",9,9,0				;Declare prompt for negative number
	
	num_fmt	db		"%d","%d\n",0										;format string for two numbers
	col_fmt	db		"%s\n",0											;format string for a color
	neg_fmt db		"%d\n",0											;format string for a negative number
	
	
	sum_res db 9,"The sum of %d and %d is %d.",10,0						;result string for num1 + num2
	dif_res db 9,"The difference between %d and %d is %d.",10,0			;result string for num1 - num2
	usp_res	db 9,"The unsigned product of %d and %d is %u.",10,0			;result string for num1 * negN (unsigned result)
	sp_res  db 9,"The signed product of %d and %d is %d.",10,0			;result string for num1 * negN (signed)
	div_res db 9,"The quotient of %d and %d is %d",10,9,9,9,9,"with a remainder of %d.",10,10,0			;result for quotient of num1/num2 and remainder
	
	
	
	summery_p1 db	"The first number, %d, holds the value %u if it is considered unsigned,",10,0		;define part1 of summery
	summery_p2 db	"and also represents the character %c.",10,0										;define part2 of summery
	summery_p3 db	"The last number, %d, holds the value %u if it is considered unsigned,",10,0		;define part3 of summery
	summery_p4 db	"and also represents the character %c.",10,10,0										;define part4 of summery
	
	
	user_name db	"Your made up Username is %s_%d%d.",10,0		;declare string with args color, num2, num1



[SECTION .bss]                     ;Section containing uninitialized data
	
	num1	resd	1													;reserve space for one 8bit number
	num2	resd	1													;reserve space for a 8bit number
	
	col		resd	6													;reserve space for up to 6 characters
	
	negN	resd	1													;reserve space for a 8bit number
