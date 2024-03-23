section .note.GNU-stack
section .text
global ft_list_push_front
extern malloc

; void	ft_list_push_front(t_list **begin_list, void *data)
ft_list_push_front:
	push rbx
	push r12
	cmp rdi, 0
	je __error
	mov rbx, rdi ; move in rbx the head pointer address
	mov r12, rsi ; move in r12 the data pointer

__create_node:
	mov rdi, 16
	call malloc wrt ..plt
	cmp rax, 0
	je __error

__push_front:
	mov rdi, rax ; move the allocated memory in rdi
	mov [rdi], r12 ; move data pointer in the address stored by rdi
	mov rcx, [rbx]
	mov [rdi + 8], rcx ; move head pointer to next field
	mov [rbx], rdi
	pop r12
	pop	rbx
	ret
	
__error:
	mov rax, 0
	pop r12
	pop rbx
	ret
