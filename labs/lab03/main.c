#include<stdio.h>

extern void func(char* input, int* result);

int main(){
    char input[] = "10111";
    int result;

    func(input, &result);

    printf("%d\n", result);

    return 0;
}
