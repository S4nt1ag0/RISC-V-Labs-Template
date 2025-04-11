#include<stdio.h>

extern int func(int m, int n);

int main() {
    int m = 1;
    int n = 2;
    
    int result = func(m,n);  
    printf("%d ", result);

    
    return 0;
}