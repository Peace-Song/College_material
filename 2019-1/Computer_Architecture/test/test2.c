#include <stdio.h>

void swap(long *xp, long *yp){
    long t0 = *xp;
    long t1 = *yp;
    *xp = t1;
    *yp = t0;
    return;
}

int main(){
    long a = 0;
    long b = 1;
    swap(&a, &b);
}
