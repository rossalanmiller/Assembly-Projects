;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_assignment4.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		October 21, 2016
;Desc:			Prompts user for some input 
;           	then formats it as output.
;--------------------------------------------------------------
section .data
    scan_format: db "%f",0
    print_format: db "Result: %f",0;0xA,0

section .bss
    result_num: resb 8

[SECTION .text]                    	;Section containing code
global main                        	;Required so linker can find entry point
extern printf, scanf

main:					;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------


    push result_num
    push scan_format
    call scanf
    add esp, 8

    sub esp,8  ;reserve stack for a double in stack
    mov ebx,result_num
    fld dword [ebx]   ;load float
    fstp qword [esp]  ;store double (8087 does the conversion internally)
    push print_format
    call printf
    add esp, 12

;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	pop edi			;Program restores saved register values by
	pop esi 		;popping them from the stack as they
	pop ebx			;were pushed from the beginning
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret				;Returns the control to Linux



