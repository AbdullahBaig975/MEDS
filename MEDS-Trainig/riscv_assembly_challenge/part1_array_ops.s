.data
array: .word 33, -15, 83, -200, 135, -72, 125, -3, 0 ,130, -9, -22

sumStr: .string "Sum: "
minStr: .string "\nMin: "
maxStr: .string "\nMax: "
negStr: .string "\nNegative Count: "
sortedStr: .string "\nSorted Array: \n"
space:     .string " "

.text
.globl main

# sum_array(a0=array, a1=size)

sum_array:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)

    mv s0, a0
    mv s1, a1

    li t0, 0          # sum
    li t1, 0          # index

    sum_loop:
    beq t1, s1, sum_done

    lw t2, 0(s0)
    add t0, t0, t2

    addi s0, s0, 4
    addi t1, t1, 1
    j sum_loop

    sum_done:
    mv a0, t0

    lw s1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16
    ret


# find_min(a0=array, a1=size)

find_min:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)

    mv s0, a0
    mv s1, a1

    lw t0, 0(s0)      # current min
    li t1, 1

    addi s0, s0, 4

    min_loop:
    beq t1, s1, min_done

    lw t2, 0(s0)

    bge t2, t0, skip_min
    mv t0, t2

    skip_min:
    addi s0, s0, 4
    addi t1, t1, 1
    j min_loop

    min_done:
    mv a0, t0

    lw s1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16
    ret


# find_max(a0=array, a1=size)

find_max:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)

    mv s0, a0
    mv s1, a1

    lw t0, 0(s0)
    li t1, 1

    addi s0, s0, 4

    max_loop:
    beq t1, s1, max_done

    lw t2, 0(s0)

    ble t2, t0, skip_max
    mv t0, t2

    skip_max:
    addi s0, s0, 4
    addi t1, t1, 1
    j max_loop

    max_done:
    mv a0, t0

    lw s1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16
    ret

# count_negative(a0=array, a1=size)

count_negative:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)

    mv s0, a0
    mv s1, a1

    li t0, 0      # count
    li t1, 0

    neg_loop:
    beq t1, s1, neg_done

    lw t2, 0(s0)

    bgez t2, skip_neg
    addi t0, t0, 1

    skip_neg:
    addi s0, s0, 4
    addi t1, t1, 1
    j neg_loop

    neg_done:
    mv a0, t0

    lw s1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16
    ret
selection_sort:
    addi sp, sp, -20
    sw ra, 16(sp)
    sw s0, 12(sp)
    sw s1, 8(sp)
    sw s2, 4(sp)

    mv s0, a0          # array pointer
    mv s1, a1          # size

    li s2, 0           # i = 0

    outer_loop:
    addi t0, s1, -1
    bge s2, t0, sort_done

    mv t1, s2          # minIndex = i

    addi t2, s2, 1     # j = i + 1

    inner_loop:
    bge t2, s1, swap

    slli t3, t2, 2
    add t3, s0, t3
    lw t4, 0(t3)       # array[j]

    slli t5, t1, 2
    add t5, s0, t5
    lw t6, 0(t5)       # array[minIndex]

    bge t4, t6, next_j

    mv t1, t2          # minIndex = j

    next_j:
    addi t2, t2, 1
    j inner_loop

    swap:
    beq t1, s2, next_i

    slli t3, s2, 2
    add t3, s0, t3

    slli t5, t1, 2
    add t5, s0, t5

    lw t4, 0(t3)
    lw t6, 0(t5)

    sw t6, 0(t3)
    sw t4, 0(t5)

    next_i:
    addi s2, s2, 1
    j outer_loop

    sort_done:
    lw s2, 4(sp)
    lw s1, 8(sp)
    lw s0, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    ret

main:
#---------------- Sum ----------------#
    la a0, array
    li a1, 12
    call sum_array
    mv t0, a0

    li a0, 4
    la a1, sumStr
    ecall

    li a0, 1
    mv a1, t0
    ecall

#---------------- Min ----------------#
    la a0, array
    li a1, 12
    call find_min
    mv t0, a0

    li a0, 4
    la a1, minStr
    ecall

    li a0, 1
    mv a1, t0
    ecall

#---------------- Max ----------------#
    la a0, array
    li a1, 12
    call find_max
    mv t0, a0

    li a0, 4
    la a1, maxStr
    ecall

    li a0, 1
    mv a1, t0
    ecall

#------------ Negative Count ---------#
    la a0, array
    li a1, 12
    call count_negative
    mv t0, a0

    li a0, 4
    la a1, negStr
    ecall

    li a0, 1
    mv a1, t0
    ecall

#------------ Selection Sort -----------#
    la a0, array
    li a1, 12
    call selection_sort

# Print label
    li a0, 4
    la a1, sortedStr
    ecall

# Print array
    la t0, array
    li t1, 12

print_loop:
    beqz t1, done_print

    lw a1, 0(t0)
    li a0, 1
    ecall

    li a0, 4
    la a1, space
    ecall

    addi t0, t0, 4
    addi t1, t1, -1
    j print_loop

done_print:
    li a0, 10
    ecall

#--------------- Exit ----------------#
    li a0, 10
    ecall