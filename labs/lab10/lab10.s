.section .text

.global func

func:
    mv s0, a0       # s0 = m
    mv s1, a1       # s1 = n

    beqz s0, M_EQUALS_0
    beqz s1, M_BIGGER_0_N_EQUALS_0
    j M_BIGGER_0_N_BIGGER_0

M_EQUALS_0:
    addi s0, s1, 1 #n+1
    ret

M_BIGGER_0_N_EQUALS_0:
    addi sp, sp, -24 #aumenta o tamanho da pilha
    sd ra, 16(sp)    #salva o endereço de retorno da função
    sd s1, 8(sp)     #salva o valor de n
    sd s0, 0(sp)     #salva o valor de m


    #a0 = A(m-1,n)
    addi a0, s0, -1
    li a1, 1
    call func


    ld ra, 16(sp)   #restaura o endereço de retorno para o registrador
    ld s1, 8(sp)    #restaura o valor de n
    ld s0, 0(sp)    #restaura o valor de m
    addi sp, sp, 24 #restaura a pilha
    ret

M_BIGGER_0_N_BIGGER_0:
    addi sp, sp, -24 #aumenta o tamanho da pilha
    sd ra, 16(sp)    #salva o endereço de retorno da função
    sd s1, 8(sp)     #salva o valor de n
    sd s0, 0(sp)     #salva o valor de m

    mv s0, a0 #salva o valor de m

    #s1 = A(m, n-1)
    addi a1, s1, -1  #a1 = n-1
    call func
    mv s1, a0 


    #s0 = A(m-1,s1)
    addi a0, s0, -1 #a0 = m-1
    mv a1, s1 
    call func
    mv s0, a0 

    ld ra, 16(sp)   #restaura o endereço de retorno para o registrador
    ld s1, 8(sp)    #restaura o valor de n
    ld s0, 0(sp)    #restaura o valor de m
    addi sp, sp, 24 #restaura a pilha
    ret