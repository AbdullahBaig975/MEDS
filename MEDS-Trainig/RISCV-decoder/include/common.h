#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

// Function-like macro for robust bitfield extraction
#define EXTRACT_BITS(val, high, low) (((val) >> (low)) & ((1U << ((high) - (low) + 1)) - 1))

// Opcode constants based on RISC-V Base ISA
typedef enum {
    OPCODE_R       = 0x33, // 0110011
    OPCODE_I_ARITH = 0x13, // 0010011
    OPCODE_I_LOAD  = 0x03, // 0000011
    OPCODE_S       = 0x23, // 0100011
    OPCODE_B       = 0x63, // 1100011
    OPCODE_LUI     = 0x37, // 0110111
    OPCODE_AUIPC   = 0x17, // 0010111
    OPCODE_JAL     = 0x6F, // 1101111
    OPCODE_JALR    = 0x67  // 1100111
} Opcode;

// Instruction Types
typedef enum {
    TYPE_R, TYPE_I, TYPE_S, TYPE_B, TYPE_U, TYPE_J, TYPE_UNKNOWN
} InstType;

#endif // COMMON_H