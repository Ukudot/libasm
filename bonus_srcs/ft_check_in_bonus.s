section .note.GNU-stack
section .text
global ft_check_in
extern ft_check_in

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
; cl is the char
; r11 is the index

; int ft_check_in(char c, const char *set)
ft_check_in:
	init_push
	cmp rsi, 0 ; check if the string is null
	jle _end_false
	mov cl, dil ; move in r9 the char
	mov rbx, rsi ; move in rbx the string
	mov r11, -1

_ft_loop:
	inc r11
	cmp byte [rbx + r11], 0 ; check if the string reached the end
	jle _end_false

_ft_intern_loop:
	cmp byte [rbx + r11], dil
	je _end_true

_ft_end_loop:
	jmp _ft_loop
	
_end_false:
	mov rax, 0
	end_pop
	ret

_end_true:
	mov rax, 1
	end_pop
	ret
