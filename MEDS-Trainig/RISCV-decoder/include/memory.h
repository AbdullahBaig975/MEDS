#ifndef MEMORY_H
#define MEMORY_H

#include "common.h"

#define MAX_INSTRUCTIONS 1024

typedef struct {
    uint32_t instructions[MAX_INSTRUCTIONS];
    uint32_t base_address;
    size_t count;
} InstructionMemory;

// Memory subsystem tracking
int load_hex_file(const char *filename, InstructionMemory *mem);

#endif // MEMORY_H