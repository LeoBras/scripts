/*
 * Author: Leonardo Bras Soares Passos <leobras.c@gmail.com>
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <openssl/md5.h>

#define MAX_BLOCKS 4096
#define BLOCK_SIZE (2 * 1024 * 1024)

void printHex(unsigned char *str, int size)
{
	for(int i = 0; i < size; i++)
		printf("%02x",str[i]);
	puts("");
}

int main(void)
{
	int *mem[MAX_BLOCKS];
	int i, j;
	MD5_CTX ctx;
	unsigned char	before[MD5_DIGEST_LENGTH],
			after[MD5_DIGEST_LENGTH];
	FILE *rand;

	rand = fopen("/dev/urandom","r");
	MD5_Init(&ctx);

	for(i = 0; i < MAX_BLOCKS; i++){
		if(i % 128 == 0)
			printf("Block %d\n", i);

		mem[i] = malloc(BLOCK_SIZE);
		if(mem[i] == NULL)
			break;

		j = 0;
		while((j += fread(mem[i] + j, 1, BLOCK_SIZE - j, rand)) != BLOCK_SIZE)
			printf("Not enough bytes from urandom : %d\n", j);

		MD5_Update(&ctx, mem[i], BLOCK_SIZE);
	}

	MD5_Final(before, &ctx);
	printf("Allocated %d blocks of %d size.\nMd5 = ", i, BLOCK_SIZE);
	printHex(before, MD5_DIGEST_LENGTH);

	puts("Press enter key to check memory integrity");
	getchar();

	MD5_Init(&ctx);

	for(i = 0; i < MAX_BLOCKS; i++){
		if(i % 128 == 0)
			printf("Block %d\n", i);
		MD5_Update(&ctx, mem[i], BLOCK_SIZE);
		free(mem[i]);
	}

	MD5_Final(after, &ctx);
	printf("Freed %d blocks of %d size.\nMd5 = ", i, BLOCK_SIZE);
	printHex(after, MD5_DIGEST_LENGTH);

	if(strncmp(before, after, MD5_DIGEST_LENGTH))
		puts("MD5 does not match!");
	else
		puts("MD5 match!");

	return 0;
}
