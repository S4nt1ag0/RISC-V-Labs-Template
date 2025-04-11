.section .text

.global func

func:
    mv t0, a0 
    mv t6, a0

LOOP_GET_ARRAY_SIZE:
    lbu t2, 0(t6)   #extrai o proximo bit
    beqz t2, BACK_ONE_POSITION    # se for \0, fim do vetor
    addi t6,t6, 1   #incrementa o endereço

    j LOOP_GET_ARRAY_SIZE

BACK_ONE_POSITION:
    addi t6, t6, -1

print_string:
    addi sp, sp, -16      # reserva espaço na pilha
    sw ra, 0(sp)          # salva endereço de retorno

    sub a2, t6, t0            # carrega tamanho da string (antes do ponteiro)
    add a1, a0, 0      # a1 = endereço do texto

    li a7, 64        # syscall write
    li a0, 1         # file descriptor = 1 (stdout)
    ecall                 # chamada de sistema

    lw ra, 0(sp)          # restaura endereço de retorno
    addi sp, sp, 16       # libera espaço da pilha
    jalr zero, 0(ra)      # retorna

    j EXIT
    
EXIT:
    mv a0, t6 
    ret