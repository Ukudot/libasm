section .note.GNU-stack
section .text

global ft_swap

ft_swap:
	mov r10, qword [rdi] ; move the content of the first pointer in a tmp position
	mov r11, qword [rsi] ; move the content of the second pointer in a tmp position
	mov [rdi], r11
	mov [rsi], r10
