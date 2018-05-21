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
global DivideBy                    	;Required so linker can find entry point
extern printf

DivideBy:		;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	
	;num 	 = [ebp + 8]

	mov ebx, [ebp + 8]			;move num into ebx
	mov eax, 1					;move 1 to eax since 2^0 = 1

	while_not_1:					;while the last bit shifted is not 1
		shl eax, 1					;multiply eax by 2
		shr	ebx, 1					;divide ebx by 2


	jnc	while_not_1					;loop as long as the carry flag is not set
	
	shr eax, 1						;compensate for the 1 over shift before the loop ended
	


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
