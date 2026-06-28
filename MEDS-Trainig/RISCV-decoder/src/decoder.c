#include "decoder.h"

int32_t sign_extend(uint32_t value, int bits) {
    if ((value >> (bits - 1)) & 1) {
        return (int32_t)(value | (~((1U << bits) - 1)));
    }
    return (int32_t)value;
}

void decode_instruction(uint32_t raw_inst, DecodedInst *decoded) {
    decoded->raw = raw_inst;
    decoded->opcode = (Opcode)EXTRACT_BITS(raw_inst, 6, 0);
    decoded->rd = EXTRACT_BITS(raw_inst, 11, 7);
    decoded->funct3 = EXTRACT_BITS(raw_inst, 14, 12);
    decoded->rs1 = EXTRACT_BITS(raw_inst, 19, 15);
    decoded->rs2 = EXTRACT_BITS(raw_inst, 24, 20);
    decoded->funct7 = EXTRACT_BITS(raw_inst, 31, 25);
    decoded->type = TYPE_UNKNOWN;
    sprintf(decoded->assembly, "UNKNOWN");

    switch (decoded->opcode) {
        case OPCODE_R:
            decoded->type = TYPE_R;
            if (decoded->funct7 == 0x00) {
                switch (decoded->funct3) {
                    case 0x0: sprintf(decoded->assembly, "add     x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                    case 0x1: sprintf(decoded->assembly, "sll     x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                    case 0x2: sprintf(decoded->assembly, "slt     x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                    case 0x3: sprintf(decoded->assembly, "sltu    x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                    case 0x4: sprintf(decoded->assembly, "xor     x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                    case 0x5: sprintf(decoded->assembly, "srl     x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                    case 0x6: sprintf(decoded->assembly, "or      x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                    case 0x7: sprintf(decoded->assembly, "and     x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                }
            } else if (decoded->funct7 == 0x20) {
                switch (decoded->funct3) {
                    case 0x0: sprintf(decoded->assembly, "sub     x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                    case 0x5: sprintf(decoded->assembly, "sra     x%d, x%d, x%d", decoded->rd, decoded->rs1, decoded->rs2); break;
                }
            }
            break;

        case OPCODE_I_ARITH:
            decoded->type = TYPE_I;
            decoded->imm = sign_extend(EXTRACT_BITS(raw_inst, 31, 20), 12);
            switch (decoded->funct3) {
                case 0x0: sprintf(decoded->assembly, "addi    x%d, x%d, %d", decoded->rd, decoded->rs1, decoded->imm); break;
                case 0x2: sprintf(decoded->assembly, "slti    x%d, x%d, %d", decoded->rd, decoded->rs1, decoded->imm); break;
                case 0x3: sprintf(decoded->assembly, "sltiu   x%d, x%d, %d", decoded->rd, decoded->rs1, (uint32_t)decoded->imm); break;
                case 0x4: sprintf(decoded->assembly, "xori    x%d, x%d, %d", decoded->rd, decoded->rs1, decoded->imm); break;
                case 0x6: sprintf(decoded->assembly, "ori     x%d, x%d, %d", decoded->rd, decoded->rs1, decoded->imm); break;
                case 0x7: sprintf(decoded->assembly, "andi    x%d, x%d, %d", decoded->rd, decoded->rs1, decoded->imm); break;
                case 0x1: sprintf(decoded->assembly, "slli    x%d, x%d, %d", decoded->rd, decoded->rs1, decoded->imm & 0x1F); break;
                case 0x5:
                    if (decoded->funct7 == 0x00)
                        sprintf(decoded->assembly, "srli    x%d, x%d, %d", decoded->rd, decoded->rs1, decoded->imm & 0x1F);
                    else if (decoded->funct7 == 0x20)
                        sprintf(decoded->assembly, "srai    x%d, x%d, %d", decoded->rd, decoded->rs1, decoded->imm & 0x1F);
                    break;
            }
            break;

        case OPCODE_I_LOAD:
            decoded->type = TYPE_I;
            decoded->imm = sign_extend(EXTRACT_BITS(raw_inst, 31, 20), 12);
            switch (decoded->funct3) {
                case 0x0: sprintf(decoded->assembly, "lb      x%d, %d(x%d)", decoded->rd, decoded->imm, decoded->rs1); break;
                case 0x1: sprintf(decoded->assembly, "lh      x%d, %d(x%d)", decoded->rd, decoded->imm, decoded->rs1); break;
                case 0x2: sprintf(decoded->assembly, "lw      x%d, %d(x%d)", decoded->rd, decoded->imm, decoded->rs1); break;
                case 0x4: sprintf(decoded->assembly, "lbu     x%d, %d(x%d)", decoded->rd, decoded->imm, decoded->rs1); break;
                case 0x5: sprintf(decoded->assembly, "lhu     x%d, %d(x%d)", decoded->rd, decoded->imm, decoded->rs1); break;
            }
            break;

        case OPCODE_S:
            decoded->type = TYPE_S;
            decoded->imm = sign_extend((EXTRACT_BITS(raw_inst, 31, 25) << 5) | EXTRACT_BITS(raw_inst, 11, 7), 12);
            switch (decoded->funct3) {
                case 0x0: sprintf(decoded->assembly, "sb      x%d, %d(x%d)", decoded->rs2, decoded->imm, decoded->rs1); break;
                case 0x1: sprintf(decoded->assembly, "sh      x%d, %d(x%d)", decoded->rs2, decoded->imm, decoded->rs1); break;
                case 0x2: sprintf(decoded->assembly, "sw      x%d, %d(x%d)", decoded->rs2, decoded->imm, decoded->rs1); break;
            }
            break;

        case OPCODE_B:
            decoded->type = TYPE_B;
            decoded->imm = sign_extend(
                (EXTRACT_BITS(raw_inst, 31, 31) << 12) |
                (EXTRACT_BITS(raw_inst, 7, 7) << 11)   |
                (EXTRACT_BITS(raw_inst, 30, 25) << 5)  |
                (EXTRACT_BITS(raw_inst, 11, 8) << 1), 13);
            switch (decoded->funct3) {
                case 0x0: sprintf(decoded->assembly, "beq     x%d, x%d, %d", decoded->rs1, decoded->rs2, decoded->imm); break;
                case 0x1: sprintf(decoded->assembly, "bne     x%d, x%d, %d", decoded->rs1, decoded->rs2, decoded->imm); break;
                case 0x4: sprintf(decoded->assembly, "blt     x%d, x%d, %d", decoded->rs1, decoded->rs2, decoded->imm); break;
                case 0x5: sprintf(decoded->assembly, "bge     x%d, x%d, %d", decoded->rs1, decoded->rs2, decoded->imm); break;
                case 0x6: sprintf(decoded->assembly, "bltu    x%d, x%d, %d", decoded->rs1, decoded->rs2, decoded->imm); break;
                case 0x7: sprintf(decoded->assembly, "bgeu    x%d, x%d, %d", decoded->rs1, decoded->rs2, decoded->imm); break;
            }
            break;

        case OPCODE_LUI:
            decoded->type = TYPE_U;
            decoded->imm = (int32_t)(raw_inst & 0xFFFFF000);
            sprintf(decoded->assembly, "lui     x%d, 0x%X", decoded->rd, (uint32_t)EXTRACT_BITS(raw_inst, 31, 12));
            break;

        case OPCODE_AUIPC:
            decoded->type = TYPE_U;
            decoded->imm = (int32_t)(raw_inst & 0xFFFFF000);
            sprintf(decoded->assembly, "auipc   x%d, 0x%X", decoded->rd, (uint32_t)EXTRACT_BITS(raw_inst, 31, 12));
            break;

        case OPCODE_JAL:
            decoded->type = TYPE_J;
            decoded->imm = sign_extend(
                (EXTRACT_BITS(raw_inst, 31, 31) << 20) |
                (EXTRACT_BITS(raw_inst, 19, 12) << 12) |
                (EXTRACT_BITS(raw_inst, 20, 20) << 11) |
                (EXTRACT_BITS(raw_inst, 30, 21) << 1), 21);
            sprintf(decoded->assembly, "jal     x%d, %d", decoded->rd, decoded->imm);
            break;

        case OPCODE_JALR:
            decoded->type = TYPE_I;
            decoded->imm = sign_extend(EXTRACT_BITS(raw_inst, 31, 20), 12);
            sprintf(decoded->assembly, "jalr    x%d, %d(x%d)", decoded->rd, decoded->imm, decoded->rs1);
            break;
    }
}