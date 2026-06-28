#include "common.h"
#include "decoder.h"
#include "memory.h"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <test_hex_file.hex>\n", argv[0]);
        return EXIT_FAILURE;
    }

    InstructionMemory mem;
    if (load_hex_file(argv[1], &mem) != 0) {
        fprintf(stderr, "Error: Could not open or read execution hex file '%s'\n", argv[1]);
        return EXIT_FAILURE;
    }

    printf("RISC-V RV32I Instruction Decoder\n");
    printf("----------------------------------------\n");
    printf("Loaded %zu instructions from %s\n\n", mem.count, argv[1]);
    printf("%-12s %-10s %s\n", "Addr", "Hex", "Assembly");
    printf("----------   ---------- -----------\n");

    size_t valid_count = 0;
    size_t unknown_count = 0;

    for (size_t i = 0; i < mem.count; i++) {
        uint32_t current_pc = mem.base_address + (uint32_t)(i * 4);
        DecodedInst decoded;
        
        decode_instruction(mem.instructions[i], &decoded);
        
        if (decoded.type == TYPE_UNKNOWN) {
            unknown_count++;
        } else {
            valid_count++;
        }

        printf("0x%08X   %08X   %s\n", current_pc, decoded.raw, decoded.assembly);
    }

    printf("\nDecoded %zu instructions (%zu valid, %zu unknown)\n", 
           mem.count, valid_count, unknown_count);

    return EXIT_SUCCESS;
}