;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			miller_fact.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		November, 11, 2016
;Desc:			Calculates the factorial of a 
;				number passed as a parameter
;				and stores it in an address
;				also passed as a parameter
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global fact                  ;Required so linker can find entry point
fact:						;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp

;Put-code-here----------------------------------------------------------

	;num = [ebp + 8]
	;fac = [ebp + 12]
	
	mov ebx, [ebp + 8]			;move value of num to eax
	cmp ebx, 0					;compare num with the base case
	jnz recurse					;recurse if nto the base case
	base_case:					;if num = 0
		mov eax, 1				;fatorial of 0 is 1
		jmp exit				;jump to the exit
	recurse:					;label for recursive section
		push dword ebx					;save value of ebx
		dec ebx							;decrement num to get num-1
		
		mov ecx, [ebp + 12]				;move addres in [ebp + 12]to ecx
		push dword ecx					;continue to pass the address where the result will be stored e
		push dword ebx					;push num-1 to stack
		call fact						;call fac on n-1
		add esp, 8						;reset stack pointer
		
		pop ebx							;load value to ebx
		
		mul ebx					;multiply eax by ebx
		
		
		
	exit:								;reset stack pointer
		mov ecx, [ebp + 12]
		mov [ecx], eax
;-----------------------------------------------------------------------

	
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret


[SECTION .data]                    ;Section containing initialized data

[SECTION .bss]                     ;Section containing uninitialized data

