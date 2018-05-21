;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_assignment4.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		October 21, 2016
;Desc:			Prompts user for some input 
;           	then formats it as output.
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global main                        	;Required so linker can find entry point
extern printf
extern sum_up

main:					;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	push dword 7
	push dword array1
	push dword 4
	call sum_up
	add esp, 12

;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	pop edi			;Program restores saved register values by
	pop esi 		;popping them from the stack as they
	pop ebx			;were pushed from the beginning
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret				;Returns the control to Linux



[SECTION .data]                    ;Section containing initialized data
	
	array1		dd			3,4,-2,7,1,0,6


[SECTION .bss]                     ;Section containing uninitialized data
