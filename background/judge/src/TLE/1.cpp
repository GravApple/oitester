#include <cstdio>

void f(int &a, int &b)
{
	a++, b++;
	while(1) a++;
}

int main()
{
	int a, b;
	scanf("%d%d", &a, &b);
	for(int i = 1; i <= 100000; i++)
		f(a, b);

	printf("%d\n", a);

	return 0;
}
