.section .text

.global func

func:
    li t0, 2
    bge a0, t0, RECURSIVE
    ret

RECURSIVE:
    addi sp, sp, -24 #aumenta o tamanho da pilha
    sd ra, 16(sp)    #salva o endereço de retorno da função
    sd s1, 8(sp)     #salva o valor do registrador s1 Fibonacci[n-1]
    sd s0, 0(sp)     #salva o valor do registrador s0 Fibonacci[n-2]

    mv s0, a0        #extrai o valor do argumento passado como parametro

    #s1 = f(n-1)
    addi a0, s0, -1
    call func
    mv s1, a0       
    
    #s2 = f(n-2)
    addi a0, s0, -2
    call func
    add a0, s1, a0


    ld ra, 16(sp)   #restaura o endereço de retorno para o registrador
    ld s1, 8(sp)    #restaura o valor de Fibonacci[n-1] salvo em memoria para o registrador
    ld s0, 0(sp)    #restaura o valor de Fibonacci[n-2] salvo em memoria para o registrador
    addi sp, sp, 24 #restaura a pilha
    
    ret