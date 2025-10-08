.section .text
.globl _start

# This program writes the first 20 Fibonacci numbers to memory starting at 0x80000000.

_start:
    li      sp, 0xFFFFFFF0

    mv      s0, zero
    li      s1, 0x80000000
    li      s2, 20

loop:
    beq     s0, s2, end

    mv      a0, s0
    call    fib

    slli    t0, s0, 2
    add     t0, s1, t0
    sw      a0, 0(t0)

    addi    s0, s0, 1
    j       loop
end:
    ebreak

fib:
    li      t0, 2
    blt     a0, t0, .no_recurse     # if (a0 < 2)

    addi    sp, sp, -16
    sw      ra, 12(sp)
    sw      s0, 8(sp)
    sw      s1, 4(sp)

    mv      s0, a0

    addi    a0, s0, -1
    call    fib
    mv      s1, a0                  # s1 = fib(n - 1)

    addi    a0, s0, -2
    call    fib
    add     a0, s1, a0              # a0 = fib(n - 1) + fib(n - 2)

    lw      ra, 12(sp)
    lw      s0, 8(sp)
    lw      s1, 4(sp)
    addi    sp, sp, 16

.no_recurse:
    ret
