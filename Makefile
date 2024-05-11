NAME=libasm
BONUS_NAME=libasm_bonus
LIB=libasm.a
ASSEMBLER=nasm -f elf64
SRCS=./srcs/ft_strlen.s ./srcs/ft_strcpy.s ./srcs/ft_strcmp.s ./srcs/ft_write.s ./srcs/ft_read.s ./srcs/ft_strdup.s
BONUS_SRCS=./bonus_srcs/ft_list_push_front_bonus.s ./bonus_srcs/ft_list_size_bonus.s ./bonus_srcs/ft_list_sort_bonus.s ./bonus_srcs/ft_list_remove_if_bonus.s \
	 ./bonus_srcs/ft_check_dup_bonus.s ./bonus_srcs/ft_check_in_bonus.s ./bonus_srcs/ft_check_in_str_bonus.s ./bonus_srcs/ft_isspace_bonus.s ./bonus_srcs/ft_issign_bonus.s \
	 ./bonus_srcs/ft_isnumber_bonus.s ./bonus_srcs/ft_convert_to_dec_bonus.s ./bonus_srcs/ft_atoi_base_bonus.s
OBJS=${SRCS:.s=.o}
BONUS_OBJS=${BONUS_SRCS:.s=.o}
COMPILER=gcc
MAIN=./srcs/main.c
BONUS_MAIN=./bonus_srcs/main_bonus.c
FLAGS=-Wall -Werror -Wall -g

%.o:%.s
	${ASSEMBLER} $< -o ${<:.s=.o}

${NAME}: ${OBJS}
	ar rcs ${LIB} ${OBJS}
	${COMPILER} ${FLAGS} ${MAIN} ${LIB} -o ${NAME}

${BONUS_NAME}: ${OBJS} ${BONUS_OBJS}
	ar rcs ${LIB} ${OBJS} ${BONUS_OBJS}
	${COMPILER} ${FLAGS} ${BONUS_MAIN} ${LIB} -o ${BONUS_NAME}

all: ${NAME}

clean:
	rm -rf ${OBJS}
	rm -rf ${BONUS_OBJS}

fclean: clean
	rm -rf ${NAME}
	rm -rf ${BONUS_NAME}
	rm -rf ${LIB}

re: fclean all

bonus: ${BONUS_NAME}


.PHONY:
	all clean fclean re bonus
