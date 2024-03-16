section .text
global _start

_start:
	mov rdi, msg ; load buffer in rdi
	mov rax, 0 ; initializing rax
	jmp _strlen

_strlen:
	cmp byte [rdi], 0
	je _end
	inc rdi
	inc rax
	jmp _strlen

_end:
	mov rdi, rax ; set exit return
	mov rax, 60 ; load exit
	syscall ; call exit
	

section .data
	msg db "Hello World!", 10, 0
