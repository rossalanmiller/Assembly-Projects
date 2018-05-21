;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_sub2.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		November 15, 2016
;Desc:			Takes as an array address and it's length as
;				parameters and doubles the value
;				of every element in that aray
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global TwiceArray                   	;Required so linker can find entry point
extern printf, scanf

TwiceArray:		;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	
	;length = [ebp + 12]
	;address = [ebp + 8]

	push dword prompt				;prompt the user
	call printf						;print the prompt
	add esp, 4						;reset stack pointer

	push dword el_size				;push size variable
	push dword size_fmt			;push formatter for size
	call scanf					;scan input into size
	add esp, 8					;reset stack pointer
	
	
	mov edx, [el_size]		;element size
	mov ecx, [ebp + 12]		;length
	mov esi, [ebp +8]		;address of array

	
	xor ebx, ebx					;zero ebx to act as an index
	loop_double:					;begin loop
			
		push dword ecx				;store ecx
		push dword edx				;store edx
		push dword ebx				;store ebx
		
		imul ebx, edx				;get offset by multiplying ebx by edx
			
		cmp edx, 1							;if the size = 1
		jnz not_one							;jump if not zero
			mov al, [esi + ebx]				;move a byte into al
			imul eax, 2						;multiply it by two
			mov [esi + ebx], byte al		;move it bakc to it's original source
		not_one:							;exit if size isn't 1
		
		cmp edx, 2							;if size = 2
		jnz not_two							;jump if the difference isn't zero
			mov ax, [esi + ebx]				;move a word into ax
			imul eax, 2						;multiply it by two
			mov [esi + ebx], word ax		;move it back into it's orignal source
		not_two:							;exit if size isn't 2
		
		cmp edx, 4							;if size = 4
		jnz not_four						;jump if the difference isn't zero
			mov eax, [esi + ebx]			;move a double word into eax
			imul eax, 2						;multiply eax by 2
			mov [esi + ebx], dword eax		;store that int the original index
		not_four:							;exit if not four
		
		
		pop ebx								;restore ebx
		
				
		inc ebx								;increment the index
		
		
		
				
		pop edx								;restore edx
		pop ecx								;restore ecx
	loop loop_double						;loop back to loop_double




	
;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	pop edi			;Program restores saved register values by
	pop esi 		;popping them from the stack as they
	pop ebx			;were pushed from the beginning
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret				;Returns the control to Linux



[SECTION .data]                    ;Section containing initialized data

	prompt	db		"Please enter the element size in bytes: ",0
	size_fmt	db	"%u/n",0


[SECTION .bss]                     ;Section containing uninitialized data

	el_size	resd	1			;reserve a byte for the size variable
