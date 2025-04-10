#include<stdio.h>

extern void func(char* inpu);

int main(){
    //char input[] = "castelo animado é meu filme favorito do studio ghibli";

    char input[] = "S4nt1ag0";

    func(input);

    printf("%s\n", input);

    return 0;
}
