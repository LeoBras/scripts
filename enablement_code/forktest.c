#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main (void)
{
	int a, b = 0;

	for (;;){
		if (++b & 0xF == 0)
			printf("Run %d\n", b);

		a = fork();
		system("qemu-kvm -kernel linux/vmlinux1 -nographic -m 4G 2>/dev/null");
		if (a == 0)
			return 0;
	}
}
