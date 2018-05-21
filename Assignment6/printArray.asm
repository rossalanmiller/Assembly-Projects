;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_sub2.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		November 15, 2016
;Desc:			Takes as input an integer and 
;				returns via eax the greatest
;				power of 2 that divides the input
;				evenly
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global printArray                   	;Required so linker can find entry point
extern printf, scanf

printArray:		;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	;size	= [ebp + 16]
	;length = [ebp + 12]
	;address = [ebp + 8]

					
	mov edx, [ebp + 16]		;element size
	mov ecx, [ebp + 12]		;length
	mov esi, [ebp +8]		;address of array

	
	xor ebx, ebx
	loop_print:	
		push dword ecx
		push dword edx
		push dword ebx
		
		imul ebx, edx
		
		cmp edx, 1
		jnz not_one
			mov al, [esi + ebx]
		not_one:
		
		cmp edx, 2
		jnz not_two
			mov ax, [esi + ebx]
		not_two:
		
		cmp edx, 4
		jnz not_four
			mov eax, [esi + ebx]
		not_four:
		
		pop ebx
		
		
		inc ebx
		
		
		
		push dword eax
		push dword ebx
		push dword print_array
		call printf
		add esp, 12
		
		pop edx
		pop ecx
	loop loop_print
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
	print_value	db	"Value: %d",10,0
	print_array	db	"Array[%d] = %d",10,0


[SECTION .bss]                     ;Section containing uninitialized data

	size	resb	1			;reserve a byte for the size variable
