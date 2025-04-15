.section .text
.global func

func:
    # func(A, B, C, m, p, n);
    # A: m x p matrix
    # B: p x n matrix
    # C: m x n matrix (result)

    # Save registers
    addi sp, sp, -64
    sd ra, 8(sp)
    sd a0, 16(sp)  # A
    sd a1, 24(sp)  # B
    sd a2, 32(sp)  # C
    sd a3, 40(sp)  # m
    sd a4, 48(sp)  # p
    sd a5, 56(sp)  # n

    # Call matrix multiplication
    call MMA

    # Restore registers
    ld ra, 8(sp)
    ld a0, 16(sp)
    ld a1, 24(sp)
    ld a2, 32(sp)
    ld a3, 40(sp)
    ld a4, 48(sp)
    ld a5, 56(sp)
    addi sp, sp, 64

    ret

MMA:
    # Save saved registers
    addi sp, sp, -32
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)

    # Initialize counters
    li s0, 0       # i (row index for A and C)
    li s1, 0       # j (column index for B and C)
    li s2, 0       # k (index for dot product)

outer_loop:
    bge s0, a3, end_outer  # if i >= m, exit

middle_loop:
    bge s1, a5, end_middle # if j >= n, next row

    # Initialize sum for C[i][j] = 0
    # Calculate C[i][j] address: C + (i * n + j) * 4
    mul t0, s0, a5   # i * n
    add t0, t0, s1   # + j
    slli t0, t0, 2   # * sizeof(int)
    add t0, a2, t0   # C + offset
    li t1, 0
    sw t1, 0(t0)     # C[i][j] = 0

    li s2, 0         # k = 0

inner_loop:
    bge s2, a4, end_inner # if k >= p, next column

    # Load A[i][k]
    mul t0, s0, a4   # i * p
    add t0, t0, s2   # + k
    slli t0, t0, 2   # * sizeof(int)
    add t0, a0, t0   # A + offset
    lw t1, 0(t0)     # A[i][k]

    # Load B[k][j]
    mul t0, s2, a5   # k * n
    add t0, t0, s1   # + j
    slli t0, t0, 2   # * sizeof(int)
    add t0, a1, t0   # B + offset
    lw t2, 0(t0)     # B[k][j]

    # Multiply and accumulate to C[i][j]
    mul t1, t1, t2   # A[i][k] * B[k][j]
    
    # Calculate C[i][j] address again
    mul t0, s0, a5   # i * n
    add t0, t0, s1   # + j
    slli t0, t0, 2   # * sizeof(int)
    add t0, a2, t0   # C + offset
    lw t2, 0(t0)     # Load current C[i][j]
    add t2, t2, t1   # Add product
    sw t2, 0(t0)     # Store back to C[i][j]

    addi s2, s2, 1   # k++
    j inner_loop

end_inner:
    addi s1, s1, 1   # j++
    j middle_loop

end_middle:
    li s1, 0         # reset j to 0
    addi s0, s0, 1   # i++
    j outer_loop

end_outer:
    # Restore saved registers
    ld s3, 24(sp)
    ld s2, 16(sp)
    ld s1, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 32
    ret