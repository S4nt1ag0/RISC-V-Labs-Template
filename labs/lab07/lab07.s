.section .text

.global func

func:
    mv t0, a0 #copy adress
    li t1, 0  #indice
    addi t6, a1, -1
    li t2, 0  #flag se possui elementos fora de ordem

LOOP:
    bge t1, t6,  AVALIATE_FLAG

    lw t3, 0(t0)   #extrai o bit atual
    lw t4, 4(t0)   #extrai o proximo bit

    

    bgt t3, t4, BIGGER_THAN

    addi t0,t0, 4   #incrementa o endereço
    addi t1, t1, 1
    
    j LOOP

BIGGER_THAN:
    sw t4, 0(t0) 
    sw t3, 4(t0)

    addi t0,t0, 4   #incrementa o endereço
    addi t1, t1, 1
    
    li t2, 1

    j LOOP

AVALIATE_FLAG:
    beqz t2, END
    j func

END:
    ret