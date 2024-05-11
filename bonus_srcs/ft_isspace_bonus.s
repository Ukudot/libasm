section .note.GNU-stack
section .text
global ft_isspace
extern ft_isspace

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
; r15 is the base string

; void ft_isspace(char c)
ft_isspace:
	init_push
	cmp dil, 32
	je _end_true
	cmp dil, 9
	jge _check_less
	jmp _end_false

_check_less:
	cmp dil, 13
	jle _end_true

_end_false:
	end_pop
	mov rax, 0
	ret

_end_true:
	end_pop
	mov rax, 1
	ret
