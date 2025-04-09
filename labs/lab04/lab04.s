.section .text

.global func

func:
    mv t0, a0 #copy adress
    li t1, 0  #result
    lw t3, 0(a1)
    li t4, 0  #indice

LOOP:
    bge t4, t3,  END

    lw t2, 0(t0)   #extrai o proximo bit
    addi t0,t0, 4   #incrementa o endereço
    addi t4, t4, 1

    bgt t2, t1, BIGGER_THAN
    j LOOP

BIGGER_THAN:
    mv t1, t2
    j LOOP

END:
    sw t1, 0(a2)
    ret