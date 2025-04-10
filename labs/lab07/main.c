#include<stdio.h>

extern void func(int* input, int array_size);

int main(){
    int array_size = 6;
    int input[] = {6,3,2,15,4,5};

    func(input, array_size);

    for (int i = 0; i < array_size; i++) {
        printf("%d ", input[i]);
    }
    printf("\n");

    return 0;
}
