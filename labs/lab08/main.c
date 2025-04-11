#include<stdio.h>

extern int func(int fibonacci_number);

int main() {
    int fibonacci_number = 9;

    printf("Sequência Fibonacci com %d termos:\n", fibonacci_number);
    for (int i = 0; i < fibonacci_number; i++) {
        int result = func(i);
        printf("%d ", result);
    }

    printf("\n");
    return 0;
}