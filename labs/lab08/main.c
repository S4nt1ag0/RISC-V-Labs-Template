#include<stdio.h>

extern void func(int fibonacci_number);

int main(){
    int fibonacci_number = 6;
    func(fibonacci_number);
    return 0;
}
