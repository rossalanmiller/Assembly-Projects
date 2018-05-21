;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			miller_timeConverter.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		November, 11, 2016
;Desc:			converts 24 hour time from
;				00:00-23:59	to 12
;				hour time
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global timeConverter                        	;Required so linker can find entry point
extern printf

timeConverter:					;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp

;Put-code-here----------------------------------------------------------


	mov eax, [ebp+12]		;move hours into eax
	cmp eax, 12				;compare the time with 12
	jge	then_pm				;jump if hours is greater then or equal to 12
	else_am:						;if the time is less then 12
		push dword am				;push am string to stack
		jmp exit_time_check			;exit the time_check
	then_pm:						;if the time is greater or equal to 12
		push dword pm				;push address of pm string
	exit_time_check:				;exit check for weather time is am or pm
	

	push dword [ebp+8]				;push minutes as 2nd parameter

	cdq								;prep edx for division
	mov ebx, 12						;move 12 into ebx
	div ebx							;eax = eax/ebx
	mov eax, edx					;move edx (the remainder) into eax
	cmp eax, 0						;compare if hours is 0
	je then_equal					;jump if time is zero
	else_not_equal:					;if hours is not equal to zero					
		push eax					;else push the value of eax
		jmp exit_equal				;exit the conditional 
	then_equal:						;if the hours is 00 (12am military time)
		push dword 12				;then the time is really 12am
	exit_equal:
	
	
	
	push dword time_out				;reset stack pointer
	call printf						;print the time
	add esp, 12						;reset stack pointer

;-----------------------------------------------------------------------

	
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret


[SECTION .data]                    ;Section containing initialized data
	am	db	"am",0					;string if time is am
	pm	db	"pm",0					;string if time is pm
	time_out db	"The time for 12-Hour Clock is %d:%d %s",10,0  ;String for outputting the time.

[SECTION .bss]                     ;Section containing uninitialized data
	am_pm	resd	2				;reserve space for am or pm
