.section .rodata
fmt:    .string "%d\n"

.section .text

.global func

func:
    li t0, 0          # Fibonacci[0]
    li t1, 1          # Fibonacci[1]
    mv t2, a0         # Número de elementos a imprimir
    li t3, 0          # Índice

    # Imprimir o primeiro número
    la a0, fmt
    mv a1, t0
    call printf

    addi t3, t3, 1
    beq t3, t2, end

    # Imprimir o segundo número
    la a0, fmt
    mv a1, t1
    call printf

    addi t3, t3, 1
    beq t3, t2, end


loop:
    add t4, t0, t1    # t4 = t0 + t1 (próximo Fibonacci)
    mv t0, t1         # t0 = t1
    mv t1, t4         # t1 = próximo Fibonacci

    la a0, fmt
    mv a1, t4
    call printf

    addi t3, t3, 1
    blt t3, t2, loop

end:
    ret