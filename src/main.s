.text
.global _start

_start:

    la      a0, mat1
    la      a1, mat2
    la      a2, dest
    li      a3, 3
    li      a4, 2
    li      a5, 3

    call    matmul

loop:
    ebreak
    j       loop

matmul:
    # t0 -> i
    # t1 -> j
    # t2 -> k
    # t3 -> sum
    # s0 -> m1_base
    # s1 -> dest_base
    # s2 -> m2_base

    # t4, t5 -> temporary values

    li      s0, 0 # m1_base = 0
    li      s1, 0 # dest_base = 0

    li      t0, 0 # i = 0
    fori:
        bge     t0, a3, fori_done

        li      t1, 0 # j = 0
        forj:
            bge     t1, a5, forj_done

            li      t3, 0 # sum = 0
            li      s2, 0 # m2_base = 0

            li      t2, 0 # k = 0
            fork:
                bge     t2, a4, fork_done

                add     t4, s0, t2 # t4 = m1_base + k
                slli    t4, t4, 2  # t4 *= 4
                add     t4, t4, a0 # t4 += mat1
                lw      t4, 0(t4)

                add     t5, s2, t1 # t5 = m2_base + j
                slli    t5, t5, 2  # t5 *= 4
                add     t5, t5, a1 # t5 += mat2
                lw      t5, 0(t5)

                # TODO: change for a float multiplication
                or      t4, t4, t5

                add     t3, t3, t4 # sum += t4
                add     s2, s2, a5 # m2_base += p

                addi    t2, t2, 1
                j       fork
            fork_done:

            add     t4, s1, t1 # t4 = dest_base + j
            slli    t4, t4, 2  # t4 *= 4
            add     t4, t4, a2 # t4 += dest
            sw      t3, 0(t4)

            addi    t1, t1, 1
            j       forj
        forj_done:

        add     s0, s0, a4 # m1_base += n
        add     s1, s1, a5 # dest_base += p

        addi    t0, t0, 1
        j       fori
    fori_done:

    ret

.data

mat1:
.word 3, 4
.word 7, 2
.word 5, 9

mat2:
.word 3, 1, 5
.word 6, 9, 7

dest:
