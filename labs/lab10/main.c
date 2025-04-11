#include<stdio.h>

extern int func(int m, int n);

int main() {
    int m = 3;
    int n = 2;
    
    int result = func(m,n);  
    printf("Acker(%d,%d)=> %d ", m,n,result);

    
    return 0;
}