;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			miller_magicDate.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		November, 11, 2016
;Desc:			Calculates weather a given
;				date passed as a group of parameters
;				is a magic date
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global magicDate                    ;Required so linker can find entry point
extern printf

magicDate:				;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp

;Put-code-here----------------------------------------------------------


	;[ebp+16] = month
	;[ebp+12]  = day
	;[ebp+8]  = year

	mov eax, [ebp+8]			;move year into eax
	mov edx, 0					;clear edx for division
	mov ebx, 100				;move 100 into ebx
	div ebx						;divide eax by 100
	mov ebx, edx				;move the remainder to ebx
	mov eax, [ebp+12]			;move day into eax
	mul dword [ebp+16]				;multiply eax by month

	cmp eax, ebx				;compare last two digits of year with month*day
	jz then_magic				;jump if month = day
	else_not_magic:				
		push dword not_magic				;push address of no to stack
		push dword [ebp+8]			;push year to stack
		push dword [ebp+12]			;push day to stack
		push dword [ebp+16]			;push month to stack
		push dword no				;push results of considered
		jmp exit_magic				;exit magic conditionals
	then_magic:				
		push dword is_magic				;push address of is_magic to stack
		push dword [ebp+8]			;push year to stack
		push dword [ebp+12]			;push day to stack
		push dword [ebp+16]			;push month to stack
		push dword yes				;push results of considered
	exit_magic:
	
	push dword results			;push results to stack
	call printf					;print results with parameters
	add esp, 24					;reset stack pointer	
;-----------------------------------------------------------------------

	
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret


[SECTION .data]                    ;Section containing initialized data
	yes			db	"Yes!",0
	no			db	"No",0
	results		db	"%s %u/%u/%u is %s a Magic Date.",10,0

	is_magic	db	"considered",0		;string if the date is magic
	not_magic	db	"not considered",0 	;string if date is not magic
[SECTION .bss]                     		;Section containing uninitialized data














