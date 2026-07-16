.data
instructions:
    .word 0x002302A1
    .word 0x00B27203
    .word 0x00543213
    .word 0x00622223
    .word 0x122354F7
    .word 0x01E102CD

opcodeStr: .string "Opcode: "
rdStr:     .string " Rd: "
rs1Str:    .string " Rs1: "
funct3Str: .string " Funct3: "
newline:   .string "\n"

.text
.globl main

main:
    la t0, instructions
    li t1, 6

loop:
    beqz t1, exit

    lw t2, 0(t0)

    # opcode = instruction & 0x7F
    andi t3, t2, 0x7F

    li a0,4
    la a1,opcodeStr
    ecall

    li a0,1
    mv a1,t3
    ecall

    # rd = bits 11:7
    srli t3,t2,7
    andi t3,t3,0x1F

    li a0,4
    la a1,rdStr
    ecall

    li a0,1
    mv a1,t3
    ecall

    # rs1 = bits 19:15
    srli t3,t2,15
    andi t3,t3,0x1F

    li a0,4
    la a1,rs1Str
    ecall

    li a0,1
    mv a1,t3
    ecall

    # funct3 = bits 14:12
    srli t3,t2,12
    andi t3,t3,0x7

    li a0,4
    la a1,funct3Str
    ecall

    li a0,1
    mv a1,t3
    ecall

    li a0,4
    la a1,newline
    ecall

    addi t0,t0,4
    addi t1,t1,-1
    j loop

exit:
    li a0,10
    ecall