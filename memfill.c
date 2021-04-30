#include <stdio.h>
#include <stdlib.h>

#define GB (1024 * 1024 * 1024)

void * alloc_gb(void);

int main(int argc, char *argv[])
{
	void *allocated[1000];
	
	if(argc < 1)
		return -1;

	int total = atoi(argv[1]);
	

	int a ;
	for (a = 0; a < total ; a++){
		allocated[a] = alloc_gb();
		if(allocated[a] == 0)
			break;
		printf("%d Gigas Alocado\n",a);
	}
	printf("%uGB Memory allocated\n",a);
	scanf("%d",&total);
	
	for (a-= 1; a >= 0; a--)
		free(allocated[a]);
	
	return 0;

}

void * alloc_gb(void)
{
	__uint64_t *mem = malloc(GB);

	if(mem == 0)
		return 0;

	register __uint64_t a;
	for(a = 0; a < GB/sizeof(__uint64_t) ; a++){
		mem[a] = a;
	}

}

