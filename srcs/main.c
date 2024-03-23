#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#define RED "\033[31m"
#define GREEN "\033[32m"
#define YELLOW "\033[33m"
#define BLUE "\033[34m"
#define MAGENTA "\033[35m"
#define CYAN "\033[36m"
#define WHITE "\033[37m"
#define RED_BOLD "\033[31;1m"
#define GREEN_BOLD "\033[32;1m"
#define YELLOW_BOLD "\033[33;1m"
#define BLUE_BOLD "\033[34;1m"
#define MAGENTA_BOLD "\033[35;1m"
#define CYAN_BOLD "\033[36;1m"
#define WHITE_BOLD "\033[37;1m"


typedef	struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

extern size_t	ft_strlen(char *str); 
extern char		*ft_strcpy(char *dest, char *str); 
extern int		ft_strcmp(char *s1, char *s2); 
extern ssize_t	ft_write(int fd, const void *buf, size_t count);
extern ssize_t	ft_read(int fd, const void *buf, size_t count);
extern char		*ft_strdup(const char *s);
extern void		ft_list_push_front(t_list **begin, void *data);


t_list	*create_new_node(void *data) {
	t_list	*new_node;

	new_node = (t_list *) malloc(sizeof(t_list));
	if (!new_node)
		return NULL;
	new_node->data = data;
	new_node->next = NULL;
	return new_node;
}

void	push_front(t_list **head, void *data) {
	t_list	*new_node;

	if (!head)
		return;
	new_node = create_new_node(data);
	if (!new_node)
		return;
	new_node->next = *head;
	*head = new_node;
}

void	print_color(char *str, char *clr)
{
	printf("%s%s\033[0m\n", clr, str);
}

void	test_ft_strlen(void)
{
	print_color("Test 1: string=\"Ciao come stai\"", CYAN_BOLD);
	printf("\tstrlen(): %ld\n", strlen("Ciao come stai"));
	printf("\tft_strlen(): %ld\n", ft_strlen("Ciao come stai"));
}

void	test_ft_strcpy(void)
{
	char *s1 = "Ciao";
	char d1[5] = "Come";
	char d2[5] = "Come";

	print_color("Test 1: source=\"Ciao\"", CYAN_BOLD);
	printf("\tdest before strcpy: %s\n", d1);
	strcpy(d1, s1);
	printf("\tdest after strcpy: %s\n", d1);
	printf("\tdest before ft_strcpy: %s\n", d2);
	ft_strcpy(d2, s1);
	printf("\tdest after ft_strcpy: %s\n", d2);
}

void	test_ft_strcmp(void)
{
	char *s1 = "ciao";
	char *s2 = "come";
	char *s3 = "aaaa";
	char *s4 = "c";
	char *s5 = "";

	print_color("Test 1: \"ciao\", \"come\"", CYAN_BOLD);
	printf("\tstrcmp(): %d\n", strcmp(s1, s2));
	printf("\tft_strcmp(): %d\n\n", ft_strcmp(s1, s2));
	print_color("Test 2: \"ciao\", \"aaaa\"", CYAN_BOLD);
	printf("\tstrcmp(): %d\n", strcmp(s1, s3));
	printf("\tft_strcmp(): %d\n\n", ft_strcmp(s1, s3));
	print_color("Test 3: \"ciao\", \"c\"", CYAN_BOLD);
	printf("\tstrcmp(): %d\n", strcmp(s1, s4));
	printf("\tft_strcmp(): %d\n\n", ft_strcmp(s1, s4));
	print_color("Test 4: \"ciao\", \"\"", CYAN_BOLD);
	printf("\tstrcmp(): %d\n", strcmp(s1, s5));
	printf("\tft_strcmp(): %d\n\n", ft_strcmp(s1, s5));
}

void	test_ft_write(void)
{
	char	*s = "Hello World!\n";
	size_t	len = strlen(s);
	ssize_t ret;

	errno = 0;
	print_color("Test 1: fd->1 string->\"Hello World!\"", CYAN_BOLD);
	ret = write(1, s, len);
	printf("\tret: %ld\n\tERRNO: %d\n", ret, errno);
	ret = ft_write(1, s, len);
	printf("\tret: %ld\n\tERRNO: %d\n", ret, errno);
	errno = 0;
	print_color("Test 2: fd->-1 string->\"Hello World!\"", CYAN_BOLD);
	ret = write(-1, s, len);
	printf("\tret: %ld\n\tERRNO: %d\n", ret, errno);
	ret = ft_write(-1, s, len);
	printf("\tret: %ld\n\tERRNO: %d\n", ret, errno);
}

void	test_ft_read(void)
{
	char	s[100];
	char	ft_s[100];
	size_t	len = 100;
	int		fd;
	ssize_t ret;
	char	*filename = "./test/prova.txt";

	bzero((void *) s, len);
	bzero((void *) ft_s, len);
	errno = 0;
	fd = open(filename, O_RDONLY);
	print_color("Test 1: fd->open(./test/prova.txt)", CYAN_BOLD);
	ret = read(fd, s, len);
	printf("\tread() ret: %ld\n\tread() ERRNO: %d\n", ret, errno);
	printf("\tread() buf: %s\n", s);
	close(fd);
	fd = open(filename, O_RDONLY);
	ret = ft_read(fd, ft_s, len);
	printf("\tft_read() ret: %ld\n\tft_read() ERRNO: %d\n", ret, errno);
	printf("\tft_read() buf: %s\n", s);
	close(fd);
	errno = 0;
	print_color("Test 2: fd->-1", CYAN_BOLD);
	ret = read(-1, s, len);
	printf("\tread() ret: %ld\n\tread() ERRNO: %d\n", ret, errno);
	ret = ft_read(-1, ft_s, len);
	printf("\tft_read() ret: %ld\n\tft_read() ERRNO: %d\n", ret, errno);
}

void	test_ft_strdup(void)
{
	const char *s = "Hello World";
	char *dest;
	char *ft_dest;

	print_color("Test 1: \"Hello World\"", CYAN_BOLD);
	dest = strdup(s);
	printf("\tstrdup() -> dest: %s\n", dest);
	ft_dest = ft_strdup(s);
	printf("\tft_strdup() -> ft_dest: %s\n", ft_dest);
	free(dest);
	free(ft_dest);
}

void	test_ft_list_push_front(void)
{
	t_list	*head;
	t_list	*elem;
	int		n[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

	print_color("Test 1: pushing the following array -> {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}", CYAN_BOLD);
	head = NULL;
	for (int i = 0; i < 10; i++)
		push_front(&head, (void *) &n[i]);

	elem = head;
	for (;elem; elem = elem->next)
		printf("\tDATA: %d\n", *((int *) elem->data));

	elem = head;
	for (; head;) {
		elem = head->next;
		free(head);
		head = elem;
	}
}

int		main(void)
{
	print_color("\n-----------TEST STRLEN-----------", GREEN_BOLD);
	test_ft_strlen();
	print_color("\n-----------TEST STRCPY-----------", GREEN_BOLD);
	test_ft_strcpy();
	print_color("\n-----------TEST STRCMP-----------", GREEN_BOLD);
	test_ft_strcmp();
	print_color("\n-----------TEST WRITE------------", GREEN_BOLD);
	test_ft_write();
	print_color("\n------------TEST READ------------", GREEN_BOLD);
	test_ft_read();
	print_color("\n-----------TEST STRDUP-----------", GREEN_BOLD);
	test_ft_strdup();
	print_color("\n---------TEST PUSH_FRONT---------", GREEN_BOLD);
	test_ft_list_push_front();
	return 0;
}
