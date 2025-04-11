#include<stdio.h>

extern int func(char* input);

int main(){
    char input[] = "10111";
    int result;

    result = func(input);

    printf("\nstring de tamanho: %d\n", result);

    return 0;
}
