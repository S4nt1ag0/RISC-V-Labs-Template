#include<stdio.h>

extern int func(char* input);

int main(){
    char input[] = "castelo animado é meu filme favorito do studio ghibli";
    int result;

    result = func(input);

    printf("string de tamanho: %d\n", result);

    return 0;
}
