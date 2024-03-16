section .text
global ft_strlen

ft_strlen:
	mov rax, 0

_strlen_loop:
	cmp byte [rdi], 0
	je _end
	inc rdi
	inc rax
	jmp _strlen_loop

_end:
	ret
