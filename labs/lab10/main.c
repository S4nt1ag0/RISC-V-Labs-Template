#include<stdio.h>

extern int func(int m, int n);

int main() {
    int m = 2;
    int m = 3;
    
    int result = func(m,n);  
    printf("%d ", result);

    
    return 0;
}