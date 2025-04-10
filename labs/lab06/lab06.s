.section .text

.global func

func:
    lw t0, 0(a0)
    bnez t0, POP

PUSH:
    addi sp, sp, -4
    sw a1, 0(sp)
    ret

POP:
    lw t1, 0(sp)
    sw t1, 0(a0)
    addi sp, sp, 4
    ret


