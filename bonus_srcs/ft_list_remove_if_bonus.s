section .note.GNU-stack
section .text
global ft_list_remove_if
extern free

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
	push rdi
	push rsi
	push rdx
	push rcx
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
	pop rcx
	pop rdx
	pop rsi
	pop rdi
%endmacro

; rbx header pointer address
; r8 data ref
; r9 cmp function
; r10 free function
; r11 previous node
; r12 current node
; r13 tmp node

; void	ft_list_remove_if(t_list **begin_list, void *data_ref, int(*cmp)(), void (*free_fct)(void *))
ft_list_remove_if:
	init_push
	mov rbx, rdi
	mov r8, rsi
	mov r9, rdx
	mov r10, rcx
	

_check_null:
	cmp rbx, 0 ; check if the head pointer address is NULL
	je _end
	cmp qword [rbx], 0 ; check if the head pointer is NULL
	je _end

_init_loop:
	mov r11, [rbx] ; initialize previous node
	mov r12, r11 ; initialize current node

_loop:
	before_call
	mov rdi, [r12]
	mov rsi, r8
	call r9
	after_call
	cmp eax, 0 ; check if the current node need to be deleted
	je _delete_node
	jmp _update_loop

_delete_node:
	cmp [rbx], r12 ; check if the current node is the list head 
	je _delete_head
	mov r13, [r12 + 8] ; store the address of the next node
	mov [r11 + 8], r13 ; bind the previous node to the next node
	before_call
	mov rdi, [r12]
	call r10 ; call function free on the current node data
	after_call
	before_call
	mov rdi, r12
	call free wrt ..plt ; call free on the current node
	after_call
	mov r12, [r11 + 8] ; update the current node
	jmp _check_loop
	

_delete_head:
	mov r13, [r12 + 8]
	mov [rbx], r13 ; store the new head
	before_call
	mov rdi, [r12]
	call r10 ; call function free the current node data
	after_call
	before_call
	mov rdi, r12
	call free wrt ..plt ; call free on the current node
	after_call
	mov r11, [rbx] ; set the previous node
	mov r12, r11 ; set the current node
	jmp _check_loop
	
_update_loop:
	mov r11, r12 ; update the previous node
	mov r12, [r12 + 8] ; update the current node

_check_loop:
	cmp r12, 0 ; check if the current node has reached the end of the list
	jne _loop

_end:
	end_pop
	ret
