#include <stdio.h>

int sum(int x, int y){
    return x+y;
}

int main(){
    
    int a = 3;
    int b = 2;
    int c = sum(a, b);
    printf("sum = %d\n", c);
}

