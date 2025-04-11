.section .text

.global func

func:
    beqz s1, M_EQUALS_0
    beqz s0, M_BIGGER_0_N_EQUALS_0                                                                      #REVER ESSA LOGICA, se a0 é 0 e a1 é n, faz sentido s0 ser m e s1 ser n
    j M_BIGGER_0_N_BIGGER_0

M_EQUALS_0:
    addi, s0, s0, 1 #n+1
    ret

M_BIGGER_0_N_EQUALS_0:
    addi sp, sp, -24 #aumenta o tamanho da pilha
    sd ra, 16(sp)    #salva o endereço de retorno da função
    sd s1, 8(sp)     #salva o valor de m
    sd s0, 0(sp)     #salva o valor de n


    #a0 = A(m-1,n)
    addi a0, s1, -1
    li a1, 1
    call func


    ld ra, 16(sp)   #restaura o endereço de retorno para o registrador
    ld s1, 8(sp)    #restaura o valor de m
    ld s0, 0(sp)    #restaura o valor de n
    addi sp, sp, 24 #restaura a pilha
    ret


M_BIGGER_0_N_BIGGER_0:
    addi sp, sp, -24 #aumenta o tamanho da pilha
    sd ra, 16(sp)    #salva o endereço de retorno da função
    sd s1, 8(sp)     #salva o valor de m
    sd s0, 0(sp)     #salva o valor de n

    #s1 = A(m, n-1)
    addi a1, s0, -1 #a1 = n-1
    mv a0, s1
    call func
    mv s1, a0 


    #s0 = A(m-1,s1)
    addi a0, s1, -1
    li a1, 1
    call func
    mv s1, a0 

    ld ra, 16(sp)   #restaura o endereço de retorno para o registrador
    ld s1, 8(sp)    #restaura o valor de m
    ld s0, 0(sp)    #restaura o valor de n
    addi sp, sp, 24 #restaura a pilha
    ret


RECURSIVE:
    

    mv s0, a0        #extrai o valor do argumento passado como parametro

    #s1 = f(n-1)
    addi a0, s0, -1
    call func
    mv s1, a0       
    
    #s2 = f(n-2)
    addi a0, s0, -2
    call func
    add a0, s1, a0


    
    
    ret