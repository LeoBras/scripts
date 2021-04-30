#include <stdio.h>

void print_ident(int n){
	for(int i = 0; i < n; i++)
		putchar('\t');
}

int main(int argc, char **argv)
{
	char buf[1024], *c, l;
	int level = 0;

	if(argc > 1)
		fprintf(stderr, "Put gdb struct in stdin\n echo 'struct' | %s \n", argv[0]);


	while(fgets(buf, 1024, stdin)){
		c = buf - 1;
		while(*(++c)){
			if(*c == '\n')
				continue;
			switch(*c){
			case '\n':
				continue;
			case '}':
				putchar('\n');
				print_ident(level);
				break;
			case '\t':
			case ' ':
				if(l == ',' || l == ' ')
					continue;
				break;
			}

			putchar(*c);

			switch(*c){
			case '}':
				level--;
				break;
			case '{':
				level++;
			case ',':
				putchar('\n');
				print_ident(level);
			}
			l = *c;
		}
	}
	return 0;
}
