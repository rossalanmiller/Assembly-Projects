;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_assignment4.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		October 21, 2016
;Desc:			Prompts user for some input 
;           	then formats it as output using control
;				structures such as loopes and conditionals.
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
extern printf						;reference c function printf
extern scanf						;reference c function scanf

global main                        	;Required so linker can find entry point

main:					;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	push dword name		;push address of name to stack
	call printf			;print string name
	add esp, 4			;reset stack pointer


	push dword word_prompt		;push address of word_promt
	call printf					;print word_prompt
	add esp, 4					;reset stack pointer

	push dword word_in			;push address of word
	push dword word_fmt			;push address of word_fmt
	call scanf					;scan input into word
	add esp, 8					;reset stack pointer

	

	do_check_pos:
		push dword pos_prompt		;push address of pos_prompt
		call printf					;print pos_prompt
		add esp, 4					;reset stack pointer

		push dword pos_num			;push address of pos_num
		push dword pos_num_fmt		;push address of pos_fmt
		call scanf					;scan input into pos_num
		add esp, 8					;reset stack pointer

		mov eax, [pos_num]			;move value of pos_num into eax
		cmp eax,0					;subtract 0 from pos_num
		jg while_check_pos				;jump out of loop if pos_num > 0
			push dword pos_error	;push address of pos_error
			call printf				;print the error
			add esp, 4				;reset stack pointer
			jmp do_check_pos		;and jump back to the begining of the do

	while_check_pos:				;if pos_num > 0 then 
									;just exit the loop
		
		
	mov ecx, [pos_num]			;move loop counter to ecx
	loop_for_pos_num:
		push ecx					;save state of ecx
		push dword	word_in			;push address of word_in
		push dword newline_str		;push format string so that newline is printed aswell
		call printf					;print top of the stack in other words ecx
		add esp, 8					;move stack pointer so that print prints word and not ecx
		pop ecx						;load state of ecx back into itself	
	loop loop_for_pos_num			;loop till ecx = 1
	add esp, 4						;restore stack pointer to account for the initial push
		
	
	push dword newline				;push address of newline
	call printf						;print newline
	add esp, 8						;reset stack pointer


	push dword three_num_prompt		;push address of prompt for three numbers
	call printf						;print prompt
	add esp, 4						;reset stack pointer

	push dword num3					;push address of num3
	push dword num2					;push address of num2
	push dword num1					;push address of num1
	push dword nums_fmt				;push address of formatter for three numbers
	call scanf						;scan user input into num1, num2, and num3
	add esp, 20						;reset stack pointer

	push dword [num3]				;push value of num3
	push dword [num2]				;push value of num2
	push dword [num1]				;push value of num1
	push dword nums_res				;push address of result format string
	call printf						;print the three numbers in order
	add esp, 20						;reset stack pointer




	mov eax, [num1]				;move value of num1 into eax
	cmp eax,[num2]				;compare the values of num1 with num2
	jl then_1_l_2					;if num1 is less then num2
	
	else_2_l_1:						;else then num2 is less then num1
		mov eax, [num2]				;copy num2 into eax
		cmp eax,[num3]				;compare value of num2 with val of num3
		jl then_2_l_3				;jump is num2 < num3
		else_3_l_2:					;then num3 is less then num2 and num2 is less then num1
			push dword [num3]		;we have our smallest number so push it to the stack
			jmp exit_min			;we have our result so we can exit the conditional
		then_2_l_3:					;then num2 is less then num3
			push dword [num2]		;we have our smallest number so push it to the stack
			jmp exit_min			;jump to the exit of this conditional	
	then_1_l_2:						;then num1 is less then num2
		mov eax, [num1]				;copy value of num1 into eax
		cmp eax,[num3]				;now compare num1 to num3
		jl then_1_l_3				;if num1 is less then num3
		else_3_l_1:					;else num3 is less then num1
			push dword [num3]		;we have our smallest number and can push it to the stack
			jmp exit_min			;jmp to the exit
		then_1_l_3:					;then num1 is less then num3 and num2
			push dword [num1]		;we have our smallest number so push it to the stack
	exit_min:						;label to mark the exit of the conditionals



	mov eax, [num1]				;move value of num1 into eax
	cmp eax,[num2]				;compare the values of num1 with num2
	jg then_1_g_2					;if num1 is greater then num2
	
	else_2_g_1:						;else then num2 is greater then num1
		mov eax, [num2]				;copy num2 into eax
		cmp eax,[num3]				;compare value of num1 with val of num2
		jg then_2_g_3				;jump is num2 > num3
		else_3_g_2:					;then num3 is greater then num2 and num2 is greater then num1
			push dword [num3]		;we have our largest number so push it to the stack
			jmp exit_max				;we have our result so we can exit the conditional
		then_2_g_3:					;then num2 is greater then num3
			push dword [num2]		;we have our greatest number so push it to the stack
			jmp exit_max			;jump to the exit of this conditional	
	then_1_g_2:						;then num1 is greater then num2
		mov eax, [num1]				;copy value of num1 into eax
		cmp eax,[num3]				;now compare num1 to num3
		jg then_1_g_3				;if num1 is greater then num3
		else_3_g_1:					;else num3 is greater then num1
			push dword [num3]		;we have our greatest number and can push it to the stack
			jmp exit_max			;jmp to the exit
		then_1_g_3:					;then num1 is greater then num3 and num2
			push dword [num1]		;we have our greatest number so push it to the stack
	exit_max:						;label to mark the exit of the conditionals



	push dword max_res				;push the format string for the max result
	call printf						;print max result whcih is still on the stack
	add esp, 8						;reset stack pointer

	push dword min_res				;push the format string for the min result
	call printf						;print min result which is still on the stack
	add esp, 8						;reset stack pointer


	push dword newline				;push address of the newline string
	call printf						;print newline
	add esp, 4						;reset stack pointer


	do_check_year:					;begining of dowhile
		push dword year_prompt		;push address of year prompt
		call printf					;print year prompt
		add esp, 4					;reset stack pointer

		push dword year				;push address of year
		push dword year_fmt			;push address of year input formatter
		call scanf					;scan input into year
		add esp, 8					;reset stack pointer

		mov eax, [year]				;copy value of year into eax
		cmp eax, 1582				;compare the year with the limiting year
		jge while_check_year		;jump out if the input is valid
			
			push dword year_error		;push address of the year error
			call printf					;print the error
			add esp,4					;reset stack pointer
			jmp do_check_year			;loop to begining.

	while_check_year:				;label to exit loop once condition is met


	mov eax, [year]					;move value of year to eax for division
	cdq								;initialize edx by sign extend
	mov ebx, 100					;copy 100 to ebx
	div ebx							;divide [year] by 100

	cmp edx, 0						;is the remainder zero?
	jz then_rem_z					;jump if the remainder is zero
	else_rem_nz:					;if the remainder isn't zero it could still be a leap year
		mov eax, [year]					;copy value of year into eax
		cdq 							;initialize edx for division
		mov ebx, 4						;copy 4 into ebx
		div ebx							;divide eax by four
		
		cmp edx, 0						;is the remainder zero
		jz is_leap						;then year is definitly a leap year
		jmp not_leap					;then year is not a leap year
		
	then_rem_z:						;if the remainder is zero
		mov eax, [year]					;copy value of year into eax
		cdq								;initialize edx for division
		mov ebx, 400					;copy 400 into ebx
		div ebx							;check to see if eax is divisisble by 400

		cmp edx, 0						;is year also divisible by 400
		jz is_leap						;then year is a leap year
		jmp not_leap					;then year is not a leap year

	is_leap:						;label for the conditon that year is a leap year
		push dword yes					;push second parameter
		push dword [year]				;push first parameter
		push dword year_res				;push the year results formater
		call printf						;print year_res with parameters
		jmp exit_is_leap				;exit is_leap block
	not_leap:						;label for condition that year is not a leap year
		push dword no					;push second parameter
		push dword [year]				;push first parameter
		push dword year_res				;push year results formmater
		call printf						;print the results
	exit_is_leap:					;label for exit of conditional
		
	

	push dword footer	;push address of footer to stack
	call printf			;print string footer
	add esp, 4			;reset stack pointer

;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	pop edi			;Program restores saved register values by
	pop esi 		;popping them from the stack as they
	pop ebx			;were pushed from the beginning
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret				;Returns the control to Linux



[SECTION .data]                    ;Section containing initialized data

	name 			db	"Ross Miller",10,0										;Create string for my name


	word_prompt		 db	"Please enter a word:",9,9,0							;prompt for a word
	pos_prompt		 db "Please enter a positive number:",9,9,0					;prompt for a positive number
	three_num_prompt db	"Please enter three more numbers:",9,9,0				;prompt for three numbers
	year_prompt		 db	"Please enter a year no earlier than 1582:",9,9,0		;prompt for a year

	pos_error		db	"You entered a negative number",10,0					;error if user enters a negative number
	year_error		db  "That is invalid input",10,0							;error if user enters a year less then 1852
	
	nums_res		db	"You entered: %d, %d, %d",10,0							;output string for displaying three numbers
	max_res			db	"The maximum value is %d",10,0							;output string for max number
	min_res			db	"The minimum value is %d",10,0							;output string for min number
	year_res		db  "Is %d a leap year?",9,9,"%s",10,0							;output string for year
	yes				db  "yes",0													;yes string
	no				db	"no",0													;no string

	newline_str		db	"%s",10,0												;formattter that will print any string with a newline
	newline			db	"",10,0													;newline with no parrameters

	word_fmt		db	"%s\n",0												;format string for word
	pos_num_fmt		db	"%d\n",0												;format string for pos_num
	nums_fmt		db	"%d","%d","%d\n",0										;format string for three numbers
	year_fmt		db	"%d\n",0												;format string for year

	footer 			db	"***Successful Program Termination***",10,0				;String for footer


[SECTION .bss]                     ;Section containing uninitialized data

	word_in	resd	8				;reserved space for up to an 8 character word
	pos_num	resd	1				;reserve space for a positive number
	
	num1	resd	1				;reserve space for num1
	num2	resd	1				;reserve space for num2
	num3	resd	1				;reserve space for num3

	year	resd	1				;reserve space for year
	











