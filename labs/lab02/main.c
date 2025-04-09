#include<stdio.h>

extern void func(int* input, int* result);

int main(){
    int input, result;
    
    input = 0b0111101;

    func(&input, &result);

    printf("%d\n", result);

    return 0;
}
