section .note.GNU-stack
section .text
global ft_atoi_base
extern ft_strlen
extern ft_check_dup
extern ft_isspace
extern ft_isnumber
extern ft_issign
extern ft_check_in
extern ft_check_in_str
extern ft_convert_to_dec
extern ft_atoi_base

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
; r9d is the return value
; r10d is the length of the base string
; r11 is the index
; r12d is the sign
; r15 is the base string

; void ft_atoi_base(char *str, char *base)
ft_atoi_base:
	init_push
	mov r9d, 0 ; prepare ret value;
	mov r12d, 0 ; prepare sign value;
	cmp rdi, 0 ; check if the string is null
	jle _end
	cmp rsi, 0 ; check if the base is null
	jle _end
	mov rbx, rdi ; move in rbx the string
	mov r15, rsi ; move in r15 the base string

_ft_check_base_length:
	before_call
	mov rdi, r15
	call ft_strlen ; calculate the length of the string
	after_call
	mov r10d, eax
	cmp r10d, 1
	jle _end

_ft_check_base_duplicate:
	before_call
	mov rdi, r15
	call ft_check_dup ; check duplicate
	after_call
	cmp rax, 1
	je _end

_ft_check_base_invalid_char:
	before_call
	mov rdi, r15
	lea rsi, [rel inv_set]
	call ft_check_in_str ; check invalid chars
	after_call
	cmp rax, 1
	je _end

_prepare_vars:
	mov r11, -1 ; set index
	mov r12d, -1 ; set the sign

_increment_skip_spaces:
	inc r11 ; increment

_skip_spaces:
	cmp byte [rbx + r11], 0 ; check if the string is terminated
	je _end
	before_call
	mov rdi, [rbx, r11]
	call ft_isspace ; check if the actual char is a space
	after_call
	cmp rax, 1 ; if the char's a space loop
	je _increment_skip_spaces
	jmp _count_sign

_increment_count_sign:
	inc r11; increment

_count_sign:
	cmp byte [rbx + r11], 0 ; check if the string is terminated
	je _end
	before_call
	mov rdi, [rbx, r11]
	call ft_issign ; check if the actual char is a sign
	after_call
	cmp rax, 1 ; if the char's a sing than check what's the sign
	je _switch_sign
	jmp _parse_value

_switch_sign:
	cmp byte [rbx, r11], 45 ; if the sign is '-' switch r12d
	jne _increment_count_sign
	imul r12d, -1
	jmp _increment_count_sign
	
_increment_parse_value:
	inc r11 ; increment

_parse_value:
	cmp byte [rbx + r11], 0 ; check if the string is terminated
	je _end
	before_call
	mov rdi, [rbx, r11] ; move the char
	mov rsi, r15 ; move the base
	call ft_check_in ; check if the char is in the base
	after_call
	cmp rax, 0 ; end if the char isn't in the base
	je _end
	
_update_result:
	imul r9d, r10d
	before_call
	mov rdi, [rbx, r11] ; move the char
	mov rsi, r15 ; move the base
	call ft_convert_to_dec ; convert to decimal
	after_call
	sub r9d, eax ; update return
	jmp _increment_parse_value

_end:
	imul r9d, r12d ; update sign
	mov eax, r9d ; set the return value
	end_pop
	ret ; test return

section .data
	inv_set db "+- "
