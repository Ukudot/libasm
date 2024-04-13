section .note.GNU-stack
section .text
global ft_strdup
extern ft_strlen
extern ft_strcpy
extern __errno_location
extern malloc

; char	*ft_strdup(const char *s)
ft_strdup:
	push rbx ; save the value of rbx in the stack

__ft_strlen:
	mov rbx, rdi ; store the string in rbi; remember that rbi and r12 are stored when other functions are called
	call ft_strlen ; take the length of the string

__malloc:
	add rax, 1 ; add null byte space
	mov rdi, rax ; save the length in rdi in order to prepare the call to malloc
	call malloc wrt ..plt ; call malloc function
	cmp rax, 0 ; check if rax is a NULL pointer
	je _error ; jump if error occoured

__ft_strcpy:
	mov rdi, rax ; store the destination pointer in rdi
	mov rsi, rbx ; move the string in rsi
	call ft_strcpy ; call strcpy in order to copy the string in the destionation allocated by malloc

__return:
	pop rbx ; restore rbx before ret
	ret ; return the value stored in rax

_error:
	pop rbx ; restore rbx before ret
	ret ; return the value stored in rax
