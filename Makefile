NAME=libasm
LIB=libasm.a
ASSEMBLER=nasm -f elf64
SRCS=./srcs/ft_strlen.s ./srcs/ft_strcpy.s ./srcs/ft_strcmp.s ./srcs/ft_write.s ./srcs/ft_read.s ./srcs/ft_strdup.s \
	 ./srcs/ft_list_push_front.s ./srcs/ft_list_size.s ./srcs/ft_list_sort.s ./srcs/ft_list_remove_if.s
OBJS=${SRCS:.s=.o}
COMPILER=gcc
MAIN=./srcs/main.c
FLAGS=-Wall -Werror -Wall -g

%.o:%.s
	${ASSEMBLER} $< -o ${<:.s=.o}

${NAME}: ${OBJS}
	ar rcs ${LIB} ${OBJS}
	${COMPILER} ${FLAGS} ${MAIN} ${LIB} -o ${NAME}

all: ${NAME}

clean:
	rm -rf ${OBJS}

fclean: clean
	rm -rf ${NAME}
	rm -rf ${LIB}

re: fclean all


.PHONY:
	all clean fclean re
