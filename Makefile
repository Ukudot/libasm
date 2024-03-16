NAME=libasm
LIB=libasm.a
ASSEMBLER=nasm -f elf64
SRCS=./srcs/ft_strlen.s ./srcs/ft_strcpy.s
OBJS=${SRCS:.s=.o}
COMPILER=gcc
MAIN=./srcs/main.c
FLAGS=-Wall -Werror -Wall

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
