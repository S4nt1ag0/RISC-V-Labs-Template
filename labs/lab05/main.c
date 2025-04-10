#include<stdio.h>

extern void func(char* inpu);

int main(){
    char input[] = "castelo animado é meu filme favorito do studio ghibli";

    //char input[] = "LEAO";
    func(input);

    printf("%s\n", input);

    return 0;
}
