// Chester Ken Gallego

#include <stdio.h>

#include "cdecl.h"

int PRE_CDECL fibonacci(int) POST_CDECL; /* prototype for assembly routine */

int main(void)
{
    int n;

    printf("Enter a number: ");
    scanf("%d", &n);
    fibonacci(n);
    return 0;
}
