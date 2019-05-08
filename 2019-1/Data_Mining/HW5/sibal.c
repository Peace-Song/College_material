#include <stdio.h>

int main(){
    int count;
    int total = 0;
    int i, j;

    for(i = 2; i <= 100; i++){
        count = 0;
        for (j = 1; j <= i; j++)
            if(i % j == 0) count++;

        if(count >= 5){
            printf("%d: %d\n", i, count);
            total++;
        }
    }
    printf("total: %d\n", total);
    return 0;
}
