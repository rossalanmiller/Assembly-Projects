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
global sum_up                        ;Required so linker can find entry point
extern printf
extern sum_up

sum_up:					;Entry point of the program
	push ebp
	mov ebp, esp

;Put-code-here----------------------------------------------------------
	
	;length = [ebp + 16]
	;address = [ebp + 12]
	;element size = [ebp + 8]
	
	
	mov esi, [ebp + 12]
	mov edx, [ebp + 8]
	mov ecx, [ebp + 16]
	xor eax, eax
	xor ebx, ebx
	add_loop:
		
		add eax, [esi+ebx*edx]
		
		
	
	loop add_loop
	
	
	push dword eax
	push dword sum
	call printf
	add esp, 8
	
	

;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	mov esp, ebp
	pop ebp



[SECTION .data]                    ;Section containing initialized data
	
	
	Sum		db		"The sum of the array is %d",10,0

[SECTION .bss]                     ;Section containing uninitialized data