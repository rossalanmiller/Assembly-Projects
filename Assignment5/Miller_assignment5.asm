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
extern timeConverter, magicDate, classifyNumbers, fact				;references for sub programs

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
		jnz tc_skip					;skip time converter if a-97 != 0
			push dword tc_sub_run		;push the address of the string indicating that time converter is running
			call printf					;print tc_sub_run
			add esp, 4					;reset stack pointer
			
			push dword tc_prompt_hours		;string prompt for the hours
			call printf						;print the prompt
			add esp, 4						;reset stack pointer
			
			push dword hours				;push address of hours
			push dword int_fmt				;push address of the formatter for integers
			call scanf						;scan input into the address at hours
			add esp, 8						;reset stack pointer
			
			push dword tc_prompt_mins		;string prompt for minutes
			call printf						;print the prompt
			add esp, 4						;reset stack pointer
			
			push dword mins					;push address of mins
			push dword int_fmt				;push address of formatter for integers
			call scanf						;scan input into mins
			add esp, 8						;reset stack pointer
			
			push dword [hours]				;First parameter for timeConverter
			push dword [mins]				;Second parameter for timeConverter
			call timeConverter				;convert the time a display it
			add esp, 8						;reset stack pointer

			push dword newline			;push address of newline
			call printf					;print newline
			add esp, 4					;reset stack pointer

			jmp do_menu						;continue to rerun the menu
		tc_skip:					;label for skipping the time converter



		cmp dword [opt], 98			;compare to see if option selected is 98(ascii for b)
		jnz md_skip					;jump if option b is not selected
			push dword md_sub_run	;push address of string indicating magic date is being run
			call printf				;print the string
			add esp, 4				;reset stack pointer

			push dword md_prompt	;push address of magic date prompt
			call printf				;print prompt
			add esp, 4				;reset stack pointer

			push dword year			;push address of year
			push dword day			;push address of day
			push dword month		;push address of month
			push dword date_fmt		;push date formatter
			call scanf				;scan user's input of month day year into month day year
			add esp, 16				;reset stack pointer

			push dword [month]		;push first parameter
			push dword [day]		;push second parameter
			push dword [year]		;push 3rd parameter
			call magicDate		;run is magic date
			add esp, 12				;reset stack pointer

			push dword newline			;push address of newline
			call printf					;print newline
			add esp, 4					;reset stack pointer

			jmp do_menu						;continue to rerun the menu

		md_skip:					;label for skipping magic number



		cmp dword [opt], 99			;compare to see if option selected is 99(ascii for c)
		jnz nc_skip					;skip the subprogram if opt != 99 (option c)
			push dword nc_sub_run	;push address of string indicating number classifier is being run
			call printf				;print nc_sub_run
			add esp, 4				;reset stack pointer
			
			push dword	nc_prompt	;push address of prompt for nc subprogram
			call printf				;print the prompt
			add esp, 4				;reset stack pointer
			
			push dword num			;push address of num
			push dword int_fmt		;push address of formatter for numbers
			call scanf				;scan input into num
			add esp, 4				;reset stack pointer
			
			push dword evens		;push address of the evens counter
			push dword odds			;push address of the odds counter
			push dword neg_nums		;push address of negatives counter
			push dword pos_nums		;push address of positives counter
			push dword [num]		;push value of num to stack
			call classifyNumbers	;classify num
			add esp, 20				;reset stack pointer
			
			push dword [pos_nums]		;push value in pos_nums
			push dword [neg_nums]		;push value in neg_nums
			push dword [evens]			;push value in evens
			push dword [odds]			;push value in odds
			push dword nc_results		;push address of results string
			call printf					;print results
			add esp, 20					;reset stack pointer
			
			push dword newline			;push address of newline
			call printf					;print newline
			add esp, 4					;reset stack pointer
			
			jmp do_menu					;continue to rerun the menu
			
		nc_skip:					;label to skip number classification subprogram
		
		
		cmp dword [opt], 100			;compare to see if option selected is 100(ascii for d)
		jnz fac_skip				;jump to fac_skip if opt != 99
			push dword fac_sub_run	;push address of string indicating factorial is being run
			call printf				;print fac_sub
			add esp, 4				;reset stack pointer
			
			push dword fac_prompt	;push address of fac_prompt
			call printf				;print fac_prompt
			add esp, 4				;reset stack pointer
			
			push dword num			;push address of num
			push dword int_fmt		;push formatter for an integer
			call scanf				;scan user input into num
			add esp, 8				;reset stack pointer
			
			push dword fac			;push address of where we'll store the results
			push dword [num]		;push value of num
			call fact				;find the factorial of num
			add esp, 8				;reset stack pointer
			
			
			push dword [fac]			;push adress in results_fac
			push dword [num]		;push value of number 
			push dword fac_result	;push address of results string
			call printf				;print results
			add esp, 12				;reset stack pointer
			
			
			push dword newline			;push address of newline
			call printf					;print newline
			add esp, 4					;reset stack pointer
			
			jmp do_menu					;jump back to the menu
		fac_skip:					;label for skipping factorial

		


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
					9,"a - Time Converter",10,\
					9,"b - Magic Date",10,\
					9,"c - Number Classification",10,\
					9,"d - Factorial",10,\
					9,"q - Quit",10,\
					"Please select from the above choices:",9,0		;multiline string for the prompt
					
	m_error	db		"Invalid input selected. Valid inputs are a,b,c,d and q.",10,10,0
	
	opt_fmt db		"%s/n",0										;formatter for a selecting a menu option
	int_fmt	db		"%d/n",0										;formatter for entering any integer number
	date_fmt db		"%u","%u","%u/n",0								;formatter for inputting the date

	tc_sub_run	db	"24-Hour Time Converter Subprogram:",10,0		;string to indicate that the time converter subprogram is being run
	tc_prompt_hours	db	"Please enter the hours:",9,9,0				;prompt for hours of time being converted
	tc_prompt_mins	db	"Please enter the minutes:",9,0				;prompt for minutes of time being converted
	tc_hours_fmt	db	"%u/n",0									;formatter for inputting hours


	md_sub_run	db	"Magic Date Subprogram:",10,0					;string to indicate that the magic date subprogram is being run
	md_prompt	db	"Please enter a date in the form mm dd yyyy:",9,0	;prompt for the date being checked

	
	nc_sub_run  db  "Number Classification Subprogram:",10,0		;string to indicate that the number classification subprogram is being run
	nc_prompt	db	"Please enter a number to classify:",9,0		;prompt for the number being classified
	nc_results 	db	"Total Classification thus far:",\
					"	odd = %d, even = %d, negative",\
					"= %d, positive = %d",10,0						;string for results of number classifier

	fac_sub_run	db	"Factorial Subprogram:",10,0					;string to indicate that the factorial subprogram is being run
	fac_prompt	db	"Please enter a number:",9,0					;prompt for the number to be factorialed
	fac_result	db 	"The result of %d! is %d.",10,0					;line for factorial results
	

	footer db		"***Successful Program Termination***",10,0
[SECTION .bss]                     ;Section containing uninitialized data

	opt		resd	1		;reserve space for a string of lenth 1
	
	mins	resd	1		;reserve space for minutes
	hours 	resd	1		;reserve space for hours

	month	resd	1		;reserve space for month
	day		resd	1		;reserve space for day
	year	resd	1		;reserve space for year
	
	num			resd	1		;reserve space for a number
	
	evens		resd	1		;reserve space for count of evens
	odds		resd	1		;reserve space for count of odds
	neg_nums	resd	1		;reserve space for count of negative numbers
	pos_nums	resd	1		;reserve space for count of positive numbers

	fac			resd	1		;reserve space for fac