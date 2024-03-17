section .note.GNU-stack
section .text
global ft_read
extern __errno_location

ft_read:
	mov rax, 0 ; load read syscall
	syscall ; call read function

	test rax, rax ; check if rax is negative after calling rax, test set the SF with the AND between the most signigative bits
	js _error ; jump if error occoured
	ret ; return the value stored in rax

_error:
	neg rax ; negate rax
	mov rdi, rax ; move rax in order to store rax
	call __errno_location wrt ..plt ; call C function __errno_location, this returns the memory address of errno var
	mov [rax], rdi ; move rdi in errno
	mov rax, -1 ; set the return value as -1
	ret ; return the value stored in rax
