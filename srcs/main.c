#include <unistd.h>
#include <string.h>
#include <stdio.h>
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

extern size_t	ft_strlen(char *str); 
extern char		*ft_strcpy(char *dest, char *str); 
extern int		ft_strcmp(char *s1, char *s2); 


void	print_color(char *str, char *clr)
{
	printf("%s%s\033[0m", clr, str);
}

void	test_ft_strlen(void)
{
	print_color("Test 1: string=\"Ciao come stai\"\n", CYAN_BOLD);
	printf("\tstrlen(): %ld\n", strlen("Ciao come stai"));
	printf("\tft_strlen(): %ld\n", ft_strlen("Ciao come stai"));
}

void	test_ft_strcpy(void)
{
	char *s1 = "Ciao";
	char d1[5] = "Come";
	char d2[5] = "Come";

	print_color("Test 1: source=\"Ciao\"\n", CYAN_BOLD);
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

	print_color("Test 1: \"ciao\", \"come\"\n", CYAN_BOLD);
	printf("\tstrcmp(): %d\n", strcmp(s1, s2));
	printf("\tft_strcmp(): %d\n\n", ft_strcmp(s1, s2));
	print_color("Test 2: \"ciao\", \"aaaa\"\n", CYAN_BOLD);
	printf("\tstrcmp(): %d\n", strcmp(s1, s3));
	printf("\tft_strcmp(): %d\n\n", ft_strcmp(s1, s3));
	print_color("Test 3: \"ciao\", \"c\"\n", CYAN_BOLD);
	printf("\tstrcmp(): %d\n", strcmp(s1, s4));
	printf("\tft_strcmp(): %d\n\n", ft_strcmp(s1, s4));
	print_color("Test 4: \"ciao\", \"\"\n", CYAN_BOLD);
	printf("\tstrcmp(): %d\n", strcmp(s1, s5));
	printf("\tft_strcmp(): %d\n\n", ft_strcmp(s1, s5));
}

int		main(void)
{
	print_color("\n-----------TEST STRLEN-----------\n", GREEN_BOLD);
	test_ft_strlen();
	print_color("\n-----------TEST STRCPY-----------\n", GREEN_BOLD);
	test_ft_strcpy();
	print_color("\n-----------TEST STRCMP-----------\n", GREEN_BOLD);
	test_ft_strcmp();
	return 0;
}
