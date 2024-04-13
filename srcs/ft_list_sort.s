section .note.GNU-stack
section .text
global ft_list_sort
extern ft_list_size

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

; r9 is the counter of the loop
; r10 is the current swapping node address
; r11 is the next swapping node address
; r12 is the header pointer address
; r13 is the previous node
; r15 is the compare function address

; void ft_list_sort(t_list **begin_list, int (*cmp)())
ft_list_sort:
	init_push
	cmp rdi, 0 ; check if header pointer is null
	jle _end
	mov rbx, rdi ; move in rbx the head pointer address
	mov r15, rsi ; move in r15 the pointer to cmp 

_ft_list_size:
	before_call
	mov rdi, [rbx] ; move in rdi the address of the head
	call ft_list_size ; calculate the size of the list
	after_call
	xor r9, r9
	mov r9, rax ; move the size of the list in the counter
	cmp r9, 1 ; check if the list size is less or equal to 1
	jle _end ; end if the size is less then or equal to 1

_prepare_loop:
	mov r10, [rbx] ; move the header in r10
	mov r11, [r10 + 8] ; move the next address in r11
	mov r12, r10 ; move the header in r12

_inner_loop:
	before_call
	mov rdi, [r10] ; move data of the first node in rdi
	mov rsi, [r11] ; move data of the seconde node in rsi
	call r15
	after_call
	cmp eax, 0 ; check if the two node need to be swapped
	jg _swap

_update_loop:
	mov r12, r10
	mov r10, r11
	mov r11, [r11 + 8]
	jmp _end_loop

_swap:
	mov r14, [r11 + 8] ; move next of the second node in r14
	mov [r10 + 8], r14
	mov [r11 + 8], r10
	cmp r12, r10 ; check if this is the first field
	je _update_header_loop
	jmp _update_previous_loop

_update_header_loop:
	mov [rbx], r11
	jmp _inverse_update_loop

_update_previous_loop:
	mov [r12 + 8], r11

_inverse_update_loop:
	mov r12, r11
	mov r11, [r10 + 8]

_end_loop:
	cmp qword r11, 0 ; if the list reached the end
	jne _inner_loop
		
_check_loop:
	sub r9, 1 ; update the counter
	cmp r9, 0 ; check if the counter reached zero
	jg _prepare_loop ; when counter is greater than zero loop

_end:
	end_pop
	ret ; test return
