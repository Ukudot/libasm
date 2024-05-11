section .note.GNU-stack
section .text
global ft_convert_to_dec
extern ft_convert_to_dec

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

; cl is the char
; r9 is the base
; r10 is the index

; void ft_convert_to_dec(char c, char *base)
ft_convert_to_dec:
	init_push
	cmp rsi, 0
	je _end_not_found
	mov cl, dil
	mov r9, rsi
	mov r10, -1
	
_init_loop:
	inc r10
	cmp byte [r9 + r10], 0
	je _end_not_found

_intern_loop:
	cmp byte [r9 + r10], cl
	je _end_found

_end_loop:
	jmp _init_loop

_end_found:
	mov rax, r10
	end_pop
	ret

_end_not_found:
	end_pop
	mov rax, 0
	ret
