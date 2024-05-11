section .note.GNU-stack
section .text
global ft_check_in_str
extern ft_check_in_str
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
; rcx is the set
; r11 is the index
; r9 is a tmp var

; int ft_check_in_str(const char *str, const char *set)
ft_check_in_str:
	init_push
	cmp rdi, 0
	jle _end_false
	cmp rsi, 0
	jle _end_false
	mov rbx, rdi
	mov rcx, rsi
	mov r11, -1

_ft_loop:
	inc r11
	cmp byte [rbx + r11], 0
	jle _end_false
	
_ft_intern_loop:
	before_call
	mov dil, [rbx + r11]
	mov rsi, rcx
	call ft_check_in
	after_call
	mov r9, rax
	cmp rax, 1
	je _end_true

_ft_end_loop:
	jmp _ft_loop

_end_false:
	end_pop
	mov rax, 0
	ret

_end_true:
	end_pop
	mov rax, 1
	ret
