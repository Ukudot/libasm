section .note.GNU-stack
section .text
global ft_strlen

ft_strlen:
	xor rax, rax ; initialize to 0 the return register

_strlen_loop:
	cmp byte [rdi], 0 ; check if the char is a null character
	je _end ; if the char is null jump to end
	inc rdi ; cycle the string
	inc rax ; increment counter
	jmp _strlen_loop ; loop back to check if the char is null

_end:
	ret ; return the value stored in rax
