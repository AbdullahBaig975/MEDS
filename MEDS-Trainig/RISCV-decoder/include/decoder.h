#ifndef DECODER_H
#define DECODER_H

#include "common.h"

// Parsed instruction structural representation
typedef struct {
    uint32_t raw;
    Opcode opcode;
    InstType type;
    uint8_t rd;
    uint8_t rs1;
    uint8_t rs2;
    uint8_t funct3;
    uint8_t funct7;
    int32_t imm;
    char assembly[64];
} DecodedInst;

// Core functions
void decode_instruction(uint32_t raw_inst, DecodedInst *decoded);
int32_t sign_extend(uint32_t value, int bits);

#endif // DECODER_H