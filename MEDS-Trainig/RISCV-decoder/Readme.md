# RISC-V RV32I Instruction Decoder

A command-line tool written in C designed to parse raw hexadecimal machine code files, decode individual instructions down to their architectural primitives, and print the resulting human-readable RISC-V RV32I assembly language string. This program serves as the complete operational front-end for an architectural CPU simulator.

## Project Structure

```text
riscv-decoder/
├── Makefile            # Project compilation tool
├── include/
│   ├── common.h        # Shared bit-manipulation macros, opcodes, and enums
│   ├── decoder.h       # Decoder structures and prototypes
│   └── memory.h        # Memory buffer loading sub-system
├── src/
│   ├── main.c          # App entry point, console parser, and output loop
│   ├── decoder.c       # Instruction type decoding and sign-extension logic
│   └── memory.c        # Low-level hex file ingestion utilities
└── test/
    └── programs/       # Hex verification suites (r_type, i_type, branch, mixed)