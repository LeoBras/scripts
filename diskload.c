#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	int fdin, fdout, out_size;
	char buf[1024 * 1024] = {0};
	int i;

	if(argc < 3){
		printf("Usage: %s inputfile outputfile outputsize(MB)\n"
		       "Only 1MB is copied\n", argv[0]);
		return -1;
	}

	fdin = open(argv[1], O_RDONLY);
	if(fdin < 0){
		printf("%s: file not found\n",argv[1]);
		return -2;
	}

	fdout = open(argv[2], O_WRONLY);
	if(fdout < 0){
		printf("%s: file not found\n",argv[2]);
		return -2;
	}

	out_size = atoi(argv[3]);
	if(!out_size){
		printf("Output file size = 0\n");
		return -3;
	}

	read(fdin, buf, sizeof(buf));
	close(fdin);

	for(i = 0; i < out_size; i++)
		write(fdout, buf, sizeof(buf));
	close(fdout);

	return 0;
}
