section .text
global ft_strcpy

ft_strcpy:
	mov rax, rdi 

ft_strcpy_loop:
	mov r10b, [rsi]
	mov [rdi], r10b
	inc rsi
	inc rdi
	cmp byte [rsi], 0
	jne ft_strcpy_loop
	ret
