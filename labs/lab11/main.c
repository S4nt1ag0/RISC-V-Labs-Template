#include <stdio.h>

extern void func(int* A, int* B, int* C, int m, int p, int n);

int main() {
    int m = 2, p = 3, n = 4;

    int A[6] = {1, 2, 5, 3, 4, 7};   
    int B[12] = {5, 6, 7, 8,0, 1, 2, 3,4,  5, 4, 7};   
    int C[8] = {0};            

    func(A, B, C, m, p, n);

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d ", C[i * n + j]);
        }
        printf("\n");
    }

    return 0;
}