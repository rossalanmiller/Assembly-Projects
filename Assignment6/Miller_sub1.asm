;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_sub1.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		November 15, 2016
;Desc:			Takes as input two numbers and an address
;				divides the first number by the second which
;				is assumed to be a power of two and 
;				returns the remainder via the address space.
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global CalculateRemainder                      	;Required so linker can find entry point

CalculateRemainder:		;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	
	;address = [ebp + 16]
	;num2	 = [ebp + 12]
	;num1 	 = [ebp + 8]
	mov edi, [ebp + 16]			;move address into edi
	mov eax, [ebp + 8]			;move num1 into eax
	mov ebx, [ebp + 12]			;move num2 into ebx


	dec ebx						;decrement ebx by 1 to get the mask
	and eax, ebx				;and to get the remainder (this is really cool)
	mov [edi], eax				;set value at address in edi to value in eax
	
	


;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	pop edi			;Program restores saved register values by
	pop esi 		;popping them from the stack as they
	pop ebx			;were pushed from the beginning
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret				;Returns the control to Linux



[SECTION .data]                    ;Section containing initialized data



[SECTION .bss]                     ;Section containing uninitialized data
