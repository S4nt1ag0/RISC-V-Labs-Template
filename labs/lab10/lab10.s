.section .text
.global func

func:
    addi sp, sp, -16      # Aloca espaço para s0 e s1 (16 bytes alinhados)
    sd s0, 0(sp)          # Salva s0 original
    sd s1, 8(sp)          # Salva s1 original

    mv s0, a0             # s0 = m
    mv s1, a1             # s1 = n

    beqz s0, M_EQUALS_0
    beqz s1, M_BIGGER_0_N_EQUALS_0
    j M_BIGGER_0_N_BIGGER_0

M_EQUALS_0:
    addi a0, s1, 1        # a0 = n + 1 (valor de retorno)
    j exit                # Restaura registradores e retorna

M_BIGGER_0_N_EQUALS_0:
    addi sp, sp, -16      # Alinha pilha e espaço para ra
    sd ra, 0(sp)          # Salva ra

    addi a0, s0, -1       # a0 = m - 1
    li a1, 1              # a1 = 1
    call func             # Chama A(m-1, 1)

    ld ra, 0(sp)          # Restaura ra
    addi sp, sp, 16       # Desaloca espaço de ra
    j exit                # Restaura registradores e retorna

M_BIGGER_0_N_BIGGER_0:
    addi sp, sp, -16      # Alinha pilha e espaço para ra
    sd ra, 0(sp)          # Salva ra

    addi a1, s1, -1       # a1 = n - 1
    call func             # Chama A(m, n-1)
    mv a1, a0             # a1 = resultado

    addi a0, s0, -1       # a0 = m - 1
    call func             # Chama A(m-1, a1)

    ld ra, 0(sp)          # Restaura ra
    addi sp, sp, 16       # Desaloca espaço de ra

exit:
    ld s0, 0(sp)          # Restaura s0
    ld s1, 8(sp)          # Restaura s1
    addi sp, sp, 16       # Desaloca espaço de s0/s1
    ret                   # Retorna usando ra