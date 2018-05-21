;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_assignment5.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		November, 11, 2016
;Desc:			Prompts user for input then formats it
;				as output using sub-programs
;--------------------------------------------------------------


[SECTION .text]                    	;Section containing code
global main                        	;Required so linker can find entry point
extern printf						;references the c function printf
extern scanf						;references the c function scanf
extern CalculateRemainder			;refere calculate remainder sub program
extern DivideBy
extern TwiceArray
extern FindMax
extern printArray

main:					;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	
		push dword name				;push address of name
		call printf					;print name
		add esp, 4					;reset stack pointer

	do_menu:						;label for menu loop

		push dword mPrompt			;push first parameter
		call printf					;print mPrompt
		add esp, 4					;reset stack pointer


		push dword opt				;push address of opt
		push dword opt_fmt			;push input formatter for opt
		call scanf					;scan input into opt
		add esp, 8					;reset stack pointer

		;Begin input checks
		cmp dword [opt], 97			;compare to see if option selected is 97(ascii for a)
		jnz cr_skip					;skip time converter if a-97 != 0
			push dword cr_sub_run		;push the address of the string indicating that time converter is running
			call printf					;print tc_sub_run
			add esp, 4					;reset stack pointer
			
			push dword cr_prompt_nums		;string prompt for the hours
			call printf						;print the prompt
			add esp, 4						;reset stack pointer
			
			push dword cr_num2				;num2
			push dword cr_num1
			push dword nums_fmt				;num1
			call scanf						;scan input into the address at hours
			add esp, 12						;reset stack pointer
			
			push dword cr_results
			push dword [cr_num2]				;First parameter for timeConverter
			push dword [cr_num1]				;Second parameter for timeConverter
			call CalculateRemainder				;convert the time a display it
			add esp, 12						;reset stack pointer
			
			push dword [cr_results]
			push dword cr_print
			call printf
			add esp, 8	


			push dword newline			;push address of newline
			call printf					;print newline
			add esp, 4					;reset stack pointer

			jmp do_menu						;continue to rerun the menu
		cr_skip:					;label for skipping the time converter



		cmp dword [opt], 98			;compare to see if option selected is 98(ascii for b)
		jnz db_skip					;jump if option b is not selected
			push dword db_sub_run	;push address of string indicating magic date is being run
			call printf				;print the string
			add esp, 4				;reset stack pointer

			push dword db_prompt	;push address of magic date prompt
			call printf				;print prompt
			add esp, 4				;reset stack pointer

			push dword db_num
			push dword num_fmt
			call scanf
			add esp, 8

			push dword [db_num]
			call DivideBy		;run is magic date
			add esp, 4				;reset stack pointer

			push dword eax
			push dword db_print
			call printf	
			add esp, 8

			push dword newline			;push address of newline
			call printf					;print newline
			add esp, 4					;reset stack pointer

			jmp do_menu						;continue to rerun the menu

		db_skip:					;label for skipping magic number



		cmp dword [opt], 99			;compare to see if option selected is 99(ascii for c)
		jnz ta_skip					;skip the subprogram if opt != 99 (option c)
			push dword ta_sub_run	;push address of string indicating number classifier is being run
			call printf				;print nc_sub_run
			add esp, 4				;reset stack pointer
			
			
			
			push dword [ta_length]
			push dword ta_array
			call TwiceArray
			add esp, 8
			
			push dword [ta_length]
			push dword print_value
			call printf
			add esp, 8
			
			
			push dword [ta_size]
			push dword [ta_length]
			push dword ta_array
			call printArray
			add esp, 12


			push dword newline			;push address of newline
			call printf					;print newline
			add esp, 4					;reset stack pointer
			
			jmp do_menu					;continue to rerun the menu
			
		ta_skip:					;label to skip number classification subprogram
		
		
		cmp dword [opt], 100			;compare to see if option selected is 100(ascii for d)
		jnz fm_skip				;jump to fac_skip if opt != 99
			push dword fm_sub_run	;push address of string indicating factorial is being run
			call printf				;print fac_sub
			add esp, 4				;reset stack pointer
			
			
			push dword [fm_size]		;size of each element
			push dword [fm_len]		;lenth of the array
			push dword fm_array		;address of the array
			call FindMax			;call function
			add esp, 12				;reset stack pointer

			
			push dword eax
			push dword fm_result
			call printf
			add esp, 8
			
			
			push dword fm_size		;size of each element
			push dword fm_len		;lenth of the array
			push dword fm_array		;address of array
			;call printArray
			add esp, 12

			
			push dword newline			;push address of newline
			call printf					;print newline
			add esp, 4					;reset stack pointer
			
			jmp do_menu					;jump back to the menu
		fm_skip:					;label for skipping factorial

		


		cmp dword [opt], 113		;compare to see if option selected is 97(ascii for q)
		jz quit						;end the checks if opt=113 (ascii for q)
			push dword m_error		;push address of the error for invalid input
			call printf				;print the error
			add esp, 4				;reset stack pointer
			jmp do_menu				;jump to being of the menu section

	quit:
	;End input checks

	
	push dword footer			;push address of footer
	call printf					;print the footer
	add esp, 4					;reset stack pointer	
	


;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	pop edi			;Program restores saved register values by
	pop esi 		;popping them from the stack as they
	pop ebx			;were pushed from the beginning
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret				;Returns the control to Linux



[SECTION .data]                    ;Section containing initialized data
	name	db		"Ross Miller",10,0
	newline	db		"",10,0
	mPrompt	db 		"Menu Options:",10,\
					9,"a - Calculate Remainder",10,\
					9,"b - Divide By",10,\
					9,"c - Twice Array",10,\
					9,"d - Find Max",10,\
					9,"q - Quit",10,\
					"Please select from the above choices:",9,0		;multiline string for the prompt
					
	m_error	db		"Invalid input selected. Valid inputs are a,b,c,d and q.",10,10,0
	
	opt_fmt db		"%s/n",0										;formatter for a selecting a menu option
	


	cr_sub_run		db	"Calculate Remainder Subprogram",10,0		;string to indicate that the time converter subprogram is being run
	cr_prompt_nums	db	"Please enter num1 and num2",9,9,0					;prompt for hours of time being converted
	cr_print		db	"The remainder is %d",10,0
	nums_fmt		db	"%u","%u/n",0
	

	db_sub_run	db	"Divide By Subprogram:",10,0					;string to indicate that the magic date subprogram is being run
	db_prompt	db	"Please enter a number",9,0	;prompt for the date being checked
	num_fmt		db	"%u/n",0
	db_print		db	"The greatest power of two is %u",10,0
	
	ta_sub_run  db  "Twice Array Subprogram:",10,0		;string to indicate that the number classification subprogram is being run
	ta_prompt	db	"Please enter a number:",9,0		;prompt for the number being classified
	ta_array	dw	1,2,800,4,5,6,7,8
	ta_length	dd	8
	ta_size		dd	2
													;string for results of number classifier

	fm_sub_run	db	"Find max Subprogram:",10,0					;string to indicate that the factorial subprogram is being run
	fm_prompt	db	"Please enter the array lenth and size of each element:",9,0					;prompt for the number to be factorialed
	fm_result	db	"The maximum number in the array is %d",10,0
	fm_array	dw	3,12,67,1000,5,2,225,1
	fm_size		dd	2	;size of each element
	fm_len		dd	8	;lenth of the array

	footer db		"***Successful Program Termination***",10,0
	
	print_value	db	"The value is: %d",10,0
[SECTION .bss]                     ;Section containing uninitialized data


	opt				resd	1		;reserve space for a string of lenth 1

	cr_results		resd	1			;address to store result from calculate remainder
	cr_num1			resd	1
	cr_num2			resd	1		

	db_num			resd	1

