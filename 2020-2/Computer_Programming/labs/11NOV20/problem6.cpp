#include <stdio.h>

int main() {
    int dim;

    scanf("%d", &dim);

    int A[dim][dim];

    for (int i = 0; i < dim; i++) {
        for (int j = 0; j < dim; j++) {
            printf("A[%d][%d]=", i, j);
            scanf("%d", &A[i][j]);
        }
    }

    for (int i = 0; i < dim; i++) {
        for (int j = 0; j < dim; j++) {
            printf("%d ", A[i][j]);
        }
        printf("\n");
    }
}