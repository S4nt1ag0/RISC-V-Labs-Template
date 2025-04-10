#include <stdio.h>

extern void func(int* operation, int value);

int main() {
    int op = 0;
    int arg = 42;

    func(&op, arg);  // push 42
    printf("Pushed: %d\n", arg);

    arg = 12;
    func(&op, arg);  // push 12
    printf("Pushed: %d\n", arg);

    op = 1;
    func(&op, 0);    // pop → valor salvo em op
    printf("Popped: %d\n", op);

    op = 1;
    func(&op, 0);    // pop → valor salvo em op
    printf("Popped: %d\n", op);
}