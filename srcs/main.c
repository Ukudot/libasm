#include <unistd.h>
#include <string.h>
#include <stdio.h>

extern size_t ft_strlen(char *str); 
extern char *ft_strcpy(char *dest, char *str); 

int	main(void)
{
	char *s1 = "Ciao";
	char d1[5] = "Come";
	char d2[5] = "Come";

	printf("strlen(\"Ciao come stai\"): %ld\n", strlen("Ciao come stai"));
	printf("ft_strlen(\"Ciao come stai\"): %ld\n", ft_strlen("Ciao come stai"));
	printf("dest before strcpy: %s\n", d1);
	strcpy(d1, s1);
	printf("dest after strcpy: %s\n", d1);
	printf("dest before ft_strcpy: %s\n", d2);
	ft_strcpy(d2, s1);
	printf("dest after ft_strcpy: %s\n", d2);
	return 0;
}
