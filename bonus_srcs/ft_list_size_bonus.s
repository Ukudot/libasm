section .note.GNU-stack
section .text
global ft_list_size

; int ft_list_size(t_list *begin_list)
ft_list_size:
	xor rax, rax

__loop:
	cmp rdi, 0
	je __return
	add rax, 1
	mov rdi, [rdi + 8]
	jmp __loop

__return:
	ret
