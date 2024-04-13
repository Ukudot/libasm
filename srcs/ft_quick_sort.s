section .note.GNU-stack
section .text

global ft_strcmp

ft_quick_sort:
	movzx r10, byte [rdi] ; move one byte from address stored in rdi in register r10 extending the zeros
	movzx r11, byte [rsi] ; move one byte from address stored in rsi in register r11 extending the zeros
	cmp r10, r11 ; compare the values stored in r10 and r11
	jne _terminated ; if the values are different jump to terminated

_equal:
	cmp r10, 0 ; check if the char is a null byte
	je _terminated ; if the char is a null byte jump to terminated
	inc rdi ; increment rdi in order to cycle the first string
	inc rsi ; increment rsi in order to cycle the second string
	jmp ft_strcmp ; loop to check if the two new char are different

_terminated:
	mov rax, r10 ; move the char of the first string in rax
	sub rax, r11 ; subtract rax with r11 and store the value in rax
	ret ; return rax
