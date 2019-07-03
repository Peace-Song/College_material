#include <stdio.h>

union{
    int i;
    unsigned char c[4];
} u;

int main(){
    u.i = 0x12345678;
    printf("%x %x %x %x\n", u.c[0], u.c[1], u.c[2], u.c[3]);
}
