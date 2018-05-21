;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			miller_classifyNumbers.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		November, 11, 2016
;Desc:			Classify an inputed number
;				an adds increments a count
;				based on the number's properties
;				(even, odd, positive, negative
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global classifyNumbers              ;Required so linker can find entry point
extern printf

classifyNumbers:				;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp

;Put-code-here----------------------------------------------------------

	;evens		= [ebp+24]
	;odds		= [ebp+20]
	;neg_nums	= [ebp+16]
	;pos_nums	= [ebp+12]
	;[num]		= [ebp+8]	
	
	rol dword [ebp+8], 1			;rotate num left once to get the sign bit
	jc then_neg				;jump if their is a carry ie the bit shifted = 1
	else_pos:				;else if the number is positive
		mov eax, [ebp+12]	;move address of positvie number to eax
		inc dword [eax]			;go to the address in eax and increment it by 1
		jmp exit_pos_neg	;exit the conditional
	then_neg:
		mov eax, [ebp+16]	;move address of neg_nums to eax
		inc dword [eax]			;go to the address in eax and increment the value
	exit_pos_neg:			;exit conditional
	
	ror	dword [ebp+8], 2			;rotate right twice to account for the 
	jc then_odd				;jump if the number is odd
	else_even:				;if the number is even
		mov eax, [ebp+24]	;move address of even into eax
		inc dword [eax]			;increment the value at the address in eax
		jmp exit_even_odd	;exit the conditional
	then_odd:
		mov eax, [ebp+20]	;move address of odd into eax
		inc dword [eax]			;increment the value at the address in eax
	exit_even_odd:			;label to exit the conditional
	
	
;-----------------------------------------------------------------------

	
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret


[SECTION .data]                    ;Section containing initialized data
	
	
[SECTION .bss]                     		;Section containing uninitialized data














