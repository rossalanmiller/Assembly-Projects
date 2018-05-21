;-------------------------------------------------------------
;Author:		Ross Miller
;Name:			Miller_assignment7.asm
;Course:		Fall - CSCI 210
;Section:		1
;Due date:		December 2, 2016
;Desc:			Uses structures and floats
;				as a means of displaying grades
;				for students.
;--------------------------------------------------------------

[SECTION .bss]                     ;Section containing uninitialized data
	thours	resd	1				;temp hours for thours
	chours resd		1				;temp storage for chours
	gpa		resq	1				;temporary storage for gpa
	
	sum		resq	1				;reseve space for sum
	diff	resq	1			;reserve space for difference
	sq_rt		resq	1			;reserve space for sqaure root
	
	
	
	struc Student					;begin student stucture definition			
		.thours: resd 1				;reserve space for total hours taken		[student + 0]
		.chours: resd 1				;reserve space for current hours taking		[student + 4]
		.gpa:	 resq 1				;reserve space for student gpa				[student + 8]
	endstruc						;end structure definition
	
	
	
	
[SECTION .data]                    ;Section containing initialized data

	ross	db		"Ross Miller",10,0									;string for my name
	footer	db		"***Successful Program Termination***",10,0			;string for the footer
	
	instructions	db		"The following information should be entered in order of total completed hours, current hours,",10,\
							"and GPA with spaces between them.",10,0				;multi line string for the program instructions
							
	promptOne		db		"Please enter StudentOne's Information: ",10,0			;prompt for studentOne
	promptTwo		db		"Please enter StudentTwo's Information: ",10,0			;prompt for studentOne
	stu_fmt			db		"%d","%d","%lf/n",0										;formatter for input for students
	
	print_studentOne	db		"StudentOne: total: %d current: %d GPA: %lf",10,0		;String to print student
	print_studentTwo	db		"StudentTwo: total: %d current: %d GPA: %lf",10,0		;String to print student
	
	update_str			db		"Updating StudentTwo:",10,0							;string indicating update
	newline				db		"",10,0												;string for newline
	
	sum_diff			db		"Computing Sum and Difference in GPAs of the two students: ",10,0		;string for sum difference results
	sum_res				db		"The sum of student GPAs is %lf",10,0				; result of sums
	diff_res			db		"The difference between the student GPAs is %lf",10,0	;result of difference
	sq_rt_res			db		"The squareRoot of the absolute value of the difference is %lf.",10,0
	
	StudentOne: 								;define StudentOne
    istruc Student 								;define as a student
        at Student.thours, dd      0			;set thours to 0
        at Student.chours, dd      0			;set chours to 0
        at Student.gpa, dq	0					;set gpa to 0
    iend										;end definition
	
	
	StudentTwo: 								;define StudentTwo
    istruc Student 								;define as a student
        at Student.thours, dd      0			;set thours to 0
        at Student.chours, dd      0			;set chours to 0
        at Student.gpa, dq	0					;set gpa to 0
    iend										;end definition


[SECTION .text]                    	;Section containing code
global main                        	;Required so linker can find entry point
extern printf, scanf				;reference C libraries for printing and scanning


main:					;Entry point of the program
	push ebp			;Sets up the stack frame(put ebp on stack at address stored in esp, decrement esp by 4
	mov ebp, esp		;Move the contents of esp into ebp
	push ebx			;put ebx on stack at address stored in esp, decrement esp by 4
	push esi			;put esi on stack at address stored in esp, decrement esp by 4
	push edi			;put edi on stack at address stored in esp, decrement esp by 4

;Put-code-here----------------------------------------------------------

	push dword ross			;push header for my name
	call printf				;print my name
	add esp, 4				;reset stack pointer
	
	
	push dword instructions	;push string for instructions
	call printf				;print instructions
	add esp, 4				;reset stack pointer
	
	
	
	
	push dword promptOne	;push prompt for first studentd
	call printf				;print first prompt 
	add esp, 4				;reset stack pointer
	
	
	push dword gpa					;push temp variable to hold gpa
	push dword chours				;push temp variable to hold chours
	push dword thours				;push temp variable to hold thours
	push dword stu_fmt				;push formatter for student variables
	call scanf						;scan input into variables
	add esp, 16						;reset stack pointer
	
	fld qword [gpa]								;move value of gpa into st0
	fstp qword [StudentOne + Student.gpa]			;move gpa into from st0 to student gpa
	
	
	mov eax, [thours]							;move value of thours into eax
	mov [StudentOne + Student.thours], eax		;move thours into studentone thours
	
	mov eax, [chours]							;move value of chours into eax
	mov [StudentOne + Student.chours], eax		;move chours into StudentOne chours
	
	
	push dword promptTwo	;push prompt for second studentd
	call printf				;print first prompt 
	add esp, 4				;reset stack pointer
	
	push dword gpa					;push temp variable to hold gpa
	push dword chours				;push temp variable to hold chours
	push dword thours				;push temp variable to hold thours
	push dword stu_fmt				;push formatter for student variables
	call scanf						;scan input into variables
	add esp, 16						;reset stack pointer
	
	fld qword [gpa]								;move value of gpa into st0
	fstp qword [StudentTwo + Student.gpa]			;move gpa into from st0 to student gpa
	
	
	mov eax, [thours]							;move value of thours into eax
	mov [StudentTwo + Student.thours], eax		;move thours into studentone thours
	
	mov eax, [chours]							;move value of chours into eax
	mov [StudentTwo + Student.chours], eax		;move chours into StudentOne chours
	
	push dword	newline							;push newline string
	call printf									;print newline
	add esp, 4									;reset stack pointer
	
	push dword [StudentOne + Student.gpa + 4]	;push second part of gpa
	push dword [StudentOne + Student.gpa]		;push first part of gpa
	push dword [StudentOne + Student.chours]	;push value studentone chours
	push dword [StudentOne + Student.thours]	;push value studenone thours
	push dword print_studentOne					;push print string for student
	call printf									;print the student results
	add esp, 20									;reset stack 
	
	
	push dword [StudentTwo + Student.gpa + 4]	;push second part of gpa
	push dword [StudentTwo + Student.gpa]		;push first part of gpa
	push dword [StudentTwo + Student.chours]	;push value studentTwo chours
	push dword [StudentTwo + Student.thours]	;push value studenTwo thours
	push dword print_studentTwo					;push print string for student
	call printf									;print the student results
	add esp, 20									;reset stack
	
	push dword	newline							;push newline string
	call printf									;print newline
	add esp, 4									;reset stack pointer
	
	push dword update_str						;push update string
	call printf									;print update stirng
	add esp, 4									;reset stack pointer
	
	mov eax, [StudentTwo + Student.thours]			;move studenttwo thours to eax
	mov ebx, [StudentTwo + Student.chours]			;move chours to ebx
	add eax, ebx									;add chours to thours
	mov [StudentTwo + Student.chours], dword 0			;zero chours
	mov [StudentTwo + Student.thours], eax			;move total to thours
	
	push dword [StudentTwo + Student.gpa + 4]	;push second part of gpa
	push dword [StudentTwo + Student.gpa]		;push first part of gpa
	push dword [StudentTwo + Student.chours]	;push value studentTwo chours
	push dword [StudentTwo + Student.thours]	;push value studenTwo thours
	push dword print_studentTwo					;push print string for student
	call printf									;print the student results
	add esp, 20									;reset stack
	
	push dword	newline							;push newline string
	call printf									;print newline
	add esp, 4									;reset stack pointer
	
	push dword sum_diff							;push sum_diff string to stack
	call printf									;print sum_diff
	add esp, 4									;reset stack pointer
	
	fld qword [StudentOne + Student.gpa]				;load studentOne gpa to ST0
	fadd qword [StudentTwo + Student.gpa]				;add studentTwo gpa to ST0
	fstp qword [sum]								;store sum of gpas in sum
	
	fld qword [StudentOne + Student.gpa]				;load studentOne gpa to ST0
	fsub qword [StudentTwo + Student.gpa]				;subtract student two gpa from student one
	fabs												;get aps value of st0
	fst qword [diff]									;store at address in difference
	
	fsqrt										;squaroot st0
	fstp qword [sq_rt]							;store in sq_rt
	
	push dword [sum	+ 4]						;push second part of sum
	push dword [sum]								;push first part of sum
	push dword sum_res							;push result string for sum
	call printf									;print the sum result
	add esp, 12									;rese stack pointer
	
	push dword [diff + 4]						;push second part of difference
	push dword [diff]							;push first part of difference
	push dword diff_res							;push result string for difference
	call printf									;print the difference result
	add esp, 12									;reset stack pointer
	
	push dword [sq_rt + 4]						;push second part of sq_rt
	push dword [sq_rt]							;push first part of sq_rt
	push dword sq_rt_res						;push result string for square root
	call printf									;print the square root result
	add esp, 12									;reset stack pointer
	
	
	
	push dword footer		;push footer
	call printf				;print footer
	add esp, 4				;reset the stack pointer



;-----------------------------------------------------------------------

		;;Bottom part of boilerplate code
	pop edi			;Program restores saved register values by
	pop esi 		;popping them from the stack as they
	pop ebx			;were pushed from the beginning
	mov esp, ebp	;Destroys stack frame before returning
	pop ebp			;Copy the top of the stack to ebp, increment esp by 4
	ret				;Returns the control to Linux





	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	