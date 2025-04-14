.section .text

.global func

func:

    #func(A, B, C, m, p, n);

    # MAIN stack
    addi  sp,  sp, -64
    sd   ra,  8(sp)
    sd   a0, 16(sp)
    sd   a1, 24(sp)
    sd   a2, 32(sp)
    sd   a3, 40(sp)
    sd   a4, 48(sp)
    sd   a5, 56(sp)

    # Address of matrix A = a0 x10
    # Address of matrix B = a1 x11
    # Address of matrix C = a2 x12

    # Matrix A = M (rows) * N (cols)
    # Matrix B = N (rows) * K (cols)
    # Matrix C = M (rows) * K (cols)

    # M = a3, P = a4, N = a5

    # Call subroutine MMA(C, A, B, M, N, K)
    # C += A * B
    call MMA

    # Clear MAIN stack
    ld    ra,  8(sp)
    ld   a0, 16(sp)
    ld   a1, 24(sp)
    ld   a2, 32(sp)
    ld   a3, 40(sp)
    ld   a4, 48(sp)
    ld   a5, 56(sp)
    addi  sp,  sp,  64

    # End of the program (x1 == 0)
    ret

MMA:
    # stack pointer for 3 items
    addi sp,  sp, -24
    sd s2, 16(sp)
    sd s3, 8(sp)
    sd s4, 0(sp)

    # i = 0, indicie for matriz A t0
    # j = 0, indicie for matriz B t1
    # k = 0, indicie for matriz C t2
    li t0, 0
    li t1, 0
    li t2, 0

    # c_row: integer for marking nth row in matrix C (unit: row, not bytes)
    # c_row = 0
    li t6, 0

    j MMA_MAIN
  
MMA_MAIN:
    # if k == MATRIX_B_WIDTH * MATRIX_A_HEIGHT:
    #    break
    mul s2, a3, a5
    srli s3, t2, 3 #convert bytes to elements
    beq s2, s3, MMA_EXIT

    # C[k] = C[k] + A[i] * B[j]
    # 1. Get Adresses
    add s2, a0, t0  
    add s3, a1, t1
    add s4, a2, t2
    
    #2. load values
    ld s2, 0(s2) #A
    ld s3, 0(s3) #B
    ld s4, 0(s4) #C

    # 3. temp = A[i] * B[j]
    mul s2, s2, s3    

    # 5. C[k] = C[k] + temp
    add s3, s4, s2

    add s4, a2, t2
    sd s3, 0(s4)

    # if i != 0 and (i + 1) % (MATRIX_A_WIDTH) == 0:
    beqz t0, ELSE

    # 1. Get (i + 1)
    addi s3, t0, 8
    # 2. Get MATRIX_A_WIDTH
    slli s4, a4, 3
    # 3. s2 = (i + 1) % (MATRIX_A_WIDTH)
    remu s2, s3, s4
    # 4. if s2 != x0: go to ELSE
    beqz s2, ELSE

    # get MATRIX_B_WIDTH
    slli s2, a5, 3

    # k += 1
    addi t2, t2, 8

    remu s2, t2, s2

    # if k % MATRIX_B_WIDTH == 0:
    beqz s2, NESTED_ELSE

    # c_row += 1
    # i = ((c_row) * MATRIX_A_WIDTH)
    # j = 0
    # 1. c_row += 1
    addi t6, t6, 1

    # 2. GET MATRIX_A_WIDTH
    slli s2, a4, 3

    # 3. j = 0
    li t1, 0
    
    #4. i = ((c_row) * MATRIX_A_WIDTH)
    mul t0, t6, s2

    # since this is a while loop, go back
    # to the start of the function
    j MMA_MAIN

ELSE:
    # else:
    #    i += 1
    #    j += MATRIX_B_WIDTH
    slli s2, a5, 3
    addi t0, t0, 8
    add t1, t1, s2

    # since this is a while loop, go back
    # to the start of the function
    j MMA_MAIN

NESTED_ELSE:
    # GET MATRIX_WIDTH
    slli s3, a4, 3
    slli s4, a5, 3

    # GET i and j
    mul t0, t6, s3
    remu t1, t2, s4

    # since this is a while loop, go back
    # to the start of the function
    j MMA_MAIN

MMA_EXIT:
    ld s4, 0(sp)
    ld s3, 8(sp)
    ld s2, 16(sp)
    addi sp,  sp, 24
    ret
