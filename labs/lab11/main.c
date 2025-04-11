#include <stdio.h>

extern void func(int* A, int* B, int* C, int m, int p, int n);

int main() {
    int m = 2, p = 2, n = 2;

    int A[4] = {1, 2, 3, 4};   
    int B[4] = {5, 6, 7, 8};   
    int C[4] = {0};            

    func(A, B, C, m, p, n);

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d ", C[i * n + j]);
        }
        printf("\n");
    }

    return 0;
}