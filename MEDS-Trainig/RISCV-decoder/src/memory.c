#include "memory.h"
#include <string.h>

int load_hex_file(const char *filename, InstructionMemory *mem) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        return -1;
    }

    mem->count = 0;
    mem->base_address = 0x00000000; // Standard base execution offset
    char line[128];

    while (fgets(line, sizeof(line), file) && mem->count < MAX_INSTRUCTIONS) {
        // Strip trailing newline characters
        line[strcspn(line, "\r\n")] = 0;
        if (strlen(line) == 0) continue;

        char *endptr;
        uint32_t val = (uint32_t)strtoul(line, &endptr, 16);
        
        if (endptr != line) {
            mem->instructions[mem->count++] = val;
        }
    }

    fclose(file);
    return 0;
}