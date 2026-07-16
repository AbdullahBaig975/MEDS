# EXTENSION_SUMMARY.md

# RISC-V Compressed (C) Extension

## Overview

The **RISC-V Compressed (C) Extension** is an optional ISA extension that introduces **16-bit compressed instructions** in addition to the standard 32-bit instructions. Its primary goal is to reduce program size while maintaining compatibility with the base RISC-V instruction set. The processor automatically expands compressed instructions during execution, allowing programmers to benefit from smaller code without changing the program's behavior.

## What It Adds

The C extension adds a set of 16-bit instruction encodings for commonly used operations, such as arithmetic, load/store, branches, jumps, and stack manipulation. These compressed instructions perform the same operations as their 32-bit equivalents but occupy only half the memory space.

## Key Instructions

Some commonly used compressed instructions include:

- `c.addi` – Add an immediate value to a register.
- `c.li` – Load an immediate value into a register.
- `c.lw` – Load a 32-bit word from memory.
- `c.sw` – Store a 32-bit word to memory.
- `c.j` – Perform an unconditional jump.
- `c.beqz` – Branch if a register equals zero.
- `c.bnez` – Branch if a register is not zero.
- `c.mv` – Copy one register to another.
- `c.jr` – Jump to the address contained in a register.
- `c.ret` – Return from a function.

## Practical Applications

The Compressed (C) extension is especially useful in **embedded systems**, **Internet of Things (IoT) devices**, **microcontrollers**, and **battery-powered applications**, where memory and power consumption are limited. By reducing code size by approximately **25–30%**, it decreases instruction memory requirements, improves instruction cache utilization, reduces memory bandwidth, and can improve overall performance while lowering energy consumption.

## Summary

The RISC-V Compressed (C) extension provides a simple and efficient way to reduce program size without sacrificing functionality. Its compatibility with the base ISA and significant memory savings make it one of the most widely adopted RISC-V extensions, particularly in resource-constrained embedded systems.