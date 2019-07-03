#include <stdio.h>

int min(int x, int y){
    return x < y ? x : y;
}

int getGCD(int x, int y){
    int MIN = min(x, y);
    int i;
    int GCD = 1;

    for(i = 1; i <= MIN; i++)
        if(x % i == 0 && y % i == 0)
            GCD = i;

    return GCD;
}

int CD_counter(int GCD){
    int i;
    int count = 0;
    
    for(i = 1; i <= GCD; i++)
        if(GCD % i == 0) count++;

    return count;
}

int main(){
    int i, j;
    int counter = 0;

    for(i = 2; i <= 99; i++)
        for(j = i+1; j <= 100; j++)
            if(CD_counter(getGCD(i, j)) >= 5){
                printf("|CD(%d, %d)| == %d\n", i, j, CD_counter(getGCD(i, j)));
                counter++;
            }

    printf("num : %d\n", counter);
    
    return 0;
}

