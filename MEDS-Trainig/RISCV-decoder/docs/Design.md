# Architectural Design Documentation: RISC-V Decoder

This document outlines the design decisions, architectural structures, and implementation methodologies behind the RV32I Instruction Decoder.

## 1. Architectural Layout & Decomposition

The project avoids a monolithic structure by dividing operations across three distinct domains to guarantee low coupling and modular encapsulation:

* **Memory Ingestion Domain (`memory.c`):** Responsible for parsing text-based hexadecimal representations of machine code from standard line-by-line arrays into a raw, contiguous array buffer inside an `InstructionMemory` tracker structure.
* **Decoding Engine (`decoder.c`):** Pure functional execution layer. It processes a 32-bit instruction word, splits it into architectural bitfields, identifies structural types, and assembles an internal structural state.
* **Output Presentation Layer (`main.c`):** Handles command-line arguments, steps through the simulated Program Counter (PC) indices, maps progress counters, and prints tabular execution reports.

## 2. Key Data Types and Representation

To prevent type ambiguity and avoid arbitrary magic numbers across the source code, types are managed explicitly using C enums and structural models:

### Operational Enums (`include/common.h`)
* `Opcode`: Maps low-level instruction codes directly to their standardized base-7 representations (e.g., `OPCODE_R = 0x33`, `OPCODE_I_ARITH = 0x13`).
* `InstType`: Classifies structural layout formats (`TYPE_R`, `TYPE_I`, `TYPE_S`, `TYPE_B`, `TYPE_U`, `TYPE_J`, `TYPE_UNKNOWN`) to dictate downstream decoding routines.

### Internal Structural Representation (`include/decoder.h`)
Every parsed instruction maps to a clean `DecodedInst` struct capture payload to maintain internal tracking state:

| Struct Field | Data Type | Description / Architectural Mapping |
| :--- | :--- | :--- |
| `raw` | `uint32_t` | Copy of the original unprocessed 32-bit binary instruction word. |
| `opcode` | `Opcode` | Lower 7 bits defining instruction class (Enums from `common.h`). |
| `type` | `InstType` | Structural format tracking flag (`TYPE_R`, `TYPE_I`, etc.). |
| `rd` | `uint8_t` | Destination register index (Bits [11:7]). |
| `rs1` | `uint8_t` | First source register index (Bits [19:15]). |
| `rs2` | `uint8_t` | Second source register index (Bits [24:20]). |
| `funct3` | `uint8_t` | 3-bit sub-operation selection code (Bits [14:12]). |
| `funct7` | `uint8_t` | 7-bit sub-operation selection code (Bits [31:25]). |
| `imm` | `int32_t` | Reconstructed, fully sign-extended immediate constant value. |
| `assembly` | `char[64]` | String buffer containing the human-readable disassembly text. |

## 3. High-Priority Design Decisions

### A. Safe Bit Extraction via Function-Like Macro
Instead of manual shift-and-mask sequences for every field, extraction is centralized inside a robust, typesafe preprocessor macro:
```c
#define EXTRACT_BITS(val, high, low) (((val) >> (low)) & ((1U << ((high) - (low) + 1)) - 1))