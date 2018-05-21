;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_sub2.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		November 15, 2016
;Desc:			Takes as input an an address of an array
;				the length of that array, and the size
;				of each element, and returns via eax
;				the largest element in the array.
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global FindMax                   	;Required so linker can find entry point
extern printf, scanf

FindMax:		;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	;size 	= [ebp + 16]
	;length = [ebp + 12]
	;address = [ebp + 8]

	
	
	mov ecx, [ebp + 12]				;length
	mov esi, [ebp +8]				;address of array

	mov al, [esi]					;initialize with an aribitrarily small value that's garanteed to less then or eqaul to the first element in the array.
	xor edx, edx					;zero edx to act as an index
	
	xor ebx, ebx
	
	
	loop_max:								;begin loop
			
		push dword ecx						;store ecx
		xor ebx, ebx
		
		cmp [ebp+16], dword 1				;if the size = 1
		jnz not_one							;jump if not zero
			mov bl, [esi + 1*edx]			;move a byte into bl
		not_one:							;exit if size isn't 1
		
		cmp [ebp+16], dword 2				;if size = 2
		jnz not_two							;jump if the difference isn't zero
			mov bx, [esi + 2*edx]			;move a word into bx
		not_two:							;exit if size isn't 2
		
		cmp [ebp+16], dword 4				;if size = 4
		jnz not_four						;jump if the difference isn't zero	
			mov ebx, [esi + 4*edx]			;move a double word into ebx
		not_four:							;exit if not four
		
		
		cmp eax, ebx						;compare eax with ebx
		jg eax_greater						;exit the conditonal if eax is greater
			mov eax, ebx					;else move ebx into eax
		eax_greater:						;exit the conditional
		
		
		inc edx
		pop ecx								;restore ecx
	loop loop_max							;loop back to loop_double




	
;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	pop edi			;Program restores saved register values by
	pop esi 		;popping them from the stack as they
	pop ebx			;were pushed from the beginning
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret				;Returns the control to Linux



[SECTION .data]                    ;Section containing initialized data

	array db		"Array = %d",10,0

[SECTION .bss]                     ;Section containing uninitialized data

