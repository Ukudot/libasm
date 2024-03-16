section .note.GNU-stack
section .text
global ft_strcpy

ft_strcpy:
	mov rax, rdi ; save the address of destination first char

_ft_strcpy_loop:
	movzx r10, byte [rsi] ; move the char pointed by source in r10 with zero padding
	mov [rdi], r10b ; move the char stored in r10b in the destination
	cmp byte [rsi], 0 ; check if the byte pointed by source is null
	jne _increment ; if the char is not null increment the two pointer
	ret ; return the first char address of destination string stored in rax

_increment:
	inc rsi ; cycle the source string
	inc rdi ; increment the pointer of destination string
	jmp _ft_strcpy_loop ; loop back in order to copy another char
