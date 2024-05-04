section .note.GNU-stack
section .text
global ft_check_dup
extern ft_check_dup

%macro init_push 0
	push rbx
	push rbp
	push r12
	push r13
	push r14
	push r15
%endmacro

%macro end_pop 0
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	pop rbx
%endmacro

%macro before_call 0
	push rcx
	push rdx
	push rdi
	push rsi
	push rsp
	push r8
	push r9
	push r10
	push r11
%endmacro

%macro after_call 0
	pop r11
	pop r10
	pop r9
	pop r8
	pop rsp
	pop rsi
	pop rdi
	pop rdx
	pop rcx
%endmacro

; rbx is the string
; r9 is the return value
; r10 is the length of the base string
; r11 is the first index
; r12 is the second index
; rcx is for tmp user

; int ft_check_dup(char *str)
ft_check_dup:
	init_push
	mov r9, 0 ; prepare ret value
	cmp rdi, 0 ; check if the string is null
	jle _end_false
	mov rbx, rdi ; move in rbx the string
	mov r11, -1

_ft_extern_loop:
	inc r11
	cmp byte [rbx + r11], 0 ; check if the string reached the end
	jle _end_false
	mov r12, r11
	inc r12

_ft_start_intern_loop:
	cmp byte [rbx + r12], 0 ; check if the string reached the end
	jle _ft_extern_loop

_ft_intern_intern_loop:
	mov cl, [rbx + r11]
	cmp byte [rbx + r12], cl
	je _end_true

_ft_end_intern_loop:
	inc r12
	jmp _ft_start_intern_loop
	
_end_false:
	mov rax, 0
	end_pop
	ret

_end_true:
	mov rax, 1
	end_pop
	ret
