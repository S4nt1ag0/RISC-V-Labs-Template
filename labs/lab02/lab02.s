.section .text

.global func

func:
    lw t0, 0(a0)
    li t1, 0

LOOP:
    andi t2, t0, 1
    add t1, t1, t2
    srli t0, t0, 1
    bnez t0, LOOP
    sw t1, 0(a1)
    ret
