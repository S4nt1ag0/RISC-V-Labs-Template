.section .rodata
newline:
    .ascii "\n"

.section .text
.global func

func:
    mv t0, a0 
    mv t6, a0

LOOP_GET_ARRAY_SIZE:
    lbu t2, 0(t6)   #extrai o proximo bit
    beqz t2, PRINT_STRING    # se for \0, fim do vetor
    addi t6,t6, 1   #incrementa o endereço

    j LOOP_GET_ARRAY_SIZE


PRINT_STRING:
    addi sp, sp, -8      # reserva espaço na pilha
    sw ra, 0(sp)          # salva endereço de retorno

    sub a2, t6, t0        # carrega tamanho da string (antes do ponteiro)
    add a1, a0, 0         # a1 = endereço do texto

    li a7, 64              # syscall write
    li a0, 1               # stdout
    ecall

    # Imprime quebra de linha
    la a1, newline         # endereço do \n
    li a2, 1               # tamanho = 1
    li a7, 64              # syscall write
    li a0, 1               # stdout
    ecall

    lw ra, 0(sp)          
    addi sp, sp, 8       

    sub a0, t6, t0         # a0 = tamanho da string (retorno para C)
    ret