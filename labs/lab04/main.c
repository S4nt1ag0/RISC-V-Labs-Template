#include<stdio.h>

extern void func(int* a, int*array_size, int* result);

int main(){
    int array_size = 6;
    int input[] = {6,1,2,15,4,5};
    int result;

    func(input, &array_size, &result);

    printf("%d\n", result);

    return 0;
}
