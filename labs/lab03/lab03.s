.section .text

.global func

func:
    mv t0, a0 
    li t1, 0  #result

LOOP:
    lbu t2, 0(t0)   #extrai o proximo bit
    beqz t2, END    # se for \0, fim do vetor

    slli t1, t1, 1  #desloca o result
    addi t2, t2, -48
    add t1, t1, t2  #incrementa o bit extraido no resul
    addi t0,t0, 1   #incrementa o endereço

    j LOOP

END:
    sw t1, 0(a1)
    ret