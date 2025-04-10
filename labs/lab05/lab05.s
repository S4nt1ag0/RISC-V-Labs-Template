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

#Nesse momento se entrou aqui em teoria tenho um ponteiro para o começo t0 e fim da lista (t6)
LOOP_SWAP:   #copia 4 elementos
    lbu t1, 0(t0)
    lbu t2, 1(t0)
    lbu a1, 2(t0)
    lbu a2, 3(t0)
    lbu a3, 4(t0)
    lbu t3, 5(t0)
    lbu a4, -5(t6)
    lbu a5, -4(t6)
    lbu a6, -3(t6)
    lbu a7, -2(t6)
    lbu t4, -1(t6)
    lbu t5, 0(t6)


    sb t5, 0(t0) # salva elementos na memoria nas posições trocadas
    sb t4, 1(t0)
    sb a7, 2(t0)
    sb a6, 3(t0)
    sb a5, 4(t0)
    sb a4, 5(t0)
    sb t3, -5(t6)
    sb a3, -4(t6)
    sb a2, -3(t6)
    sb a1, -2(t6)
    sb t2, -1(t6)
    sb t1, 0(t6)

    addi t0, t0, 2  #movendo o ponteiro inicial para avançar 2 casa
    addi t6, t6, -2 #movendo o ponteiro final para recuar 2 casas

    bgeu t0, t6, EXIT
    j LOOP_SWAP

EXIT:
    ret