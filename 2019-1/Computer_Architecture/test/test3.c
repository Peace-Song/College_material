#include <stdio.h>

void echo(){
    char buf[4];
    gets(buf);
    puts(buf);
}

int main(){
    printf("Type: ");
    echo();
    return 0;
}
