/*
    t0 - address ofset
    t1 - variavel temporaria generica
    t2 - variavel temporaria generica
    t3 - i
    t4 - j
    t5 - k
*/

.section .text
.global func

func:
    # func(A a0, B a1, C a2, m a3, p a4, n a5);
    # A: m x p matrix
    # B: p x n matrix
    # C: m x n matrix (result)

    # Initialize counters
    li t3, 0       # i (row index for A and C)
    li t4, 0       # j (column index for B and C)
    li t5, 0       # k (index for dot product)

outer_loop:
    bge t3, a3, end_outer  # if i >= m, exit

middle_loop:
    bge t4, a5, end_middle # if j >= n, next row

    # Initialize sum for C[i][j] = 0
    # Calculate C[i][j] address: C + (i * n + j) * 4
    mul t0, t3, a5   # i * n
    add t0, t0, t4   # + j
    slli t0, t0, 2   # * sizeof(int)
    add t0, a2, t0   # C + offset
    li t1, 0
    sw t1, 0(t0)     # C[i][j] = 0

    li t5, 0         # k = 0

inner_loop:
    bge t5, a4, end_inner # if k >= p, next column

    # Load A[i][k]
    mul t0, t3, a4   # i * p
    add t0, t0, t5   # + k
    slli t0, t0, 2   # * sizeof(int)
    add t0, a0, t0   # A + offset
    lw t1, 0(t0)     # A[i][k]

    # Load B[k][j]
    mul t0, t5, a5   # k * n
    add t0, t0, t4   # + j
    slli t0, t0, 2   # * sizeof(int)
    add t0, a1, t0   # B + offset
    lw t2, 0(t0)     # B[k][j]

    # Multiply and accumulate to C[i][j]
    mul t1, t1, t2   # A[i][k] * B[k][j]
    
    # Calculate C[i][j] address again
    mul t0, t3, a5   # i * n
    add t0, t0, t4   # + j
    slli t0, t0, 2   # * sizeof(int)
    add t0, a2, t0   # C + offset
    lw t2, 0(t0)     # Load current C[i][j]
    add t2, t2, t1   # Add product
    sw t2, 0(t0)     # Store back to C[i][j]

    addi t5, t5, 1   # k++
    j inner_loop

end_inner:
    addi t4, t4, 1   # j++
    j middle_loop

end_middle:
    li t4, 0         # reset j to 0
    addi t3, t3, 1   # i++
    j outer_loop

end_outer:
    ret