#include <unistd.h>
#include <string.h>
#include <stdio.h>

extern size_t ft_strlen(char *str); 

int	main(void)
{
	printf("ft_strlen(\"Ciao come stai\"): %ld\n", ft_strlen("Ciao come stai"));
	printf("strlen(\"Ciao come stai\"): %ld\n", strlen("Ciao come stai"));
	return 0;
}
