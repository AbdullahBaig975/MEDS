# RISC-V Privileged Architecture Summary

## Introduction

The **RISC-V Privileged Architecture** defines how processors manage operating systems, exceptions, interrupts, memory protection, and other system-level functions. Unlike the User-Level ISA, which specifies normal program instructions, the privileged architecture controls how software interacts with hardware at different privilege levels. It introduces privilege modes, Control and Status Registers (CSRs), and trap handling mechanisms to provide secure and efficient system operation.

---

# Privilege Levels

RISC-V supports three main privilege levels:

## Machine Mode (M-mode)

Machine Mode is the highest privilege level and is available on all RISC-V processors. It has complete access to all hardware resources and is responsible for system initialization, interrupt handling, exception processing, and low-level hardware management. Firmware and bootloaders typically execute in Machine Mode.

## Supervisor Mode (S-mode)

Supervisor Mode is designed for operating systems. It provides memory management, virtual memory support, process scheduling, and system call handling. Access to hardware resources is controlled through Machine Mode.

## User Mode (U-mode)

User Mode has the lowest privilege level and is intended for normal application programs. Applications running in User Mode cannot directly access privileged CSRs or hardware resources and must request operating system services through system calls.

---

# Control and Status Registers (CSRs)

CSRs are special registers used to control processor behavior and store system information.

## mstatus

The **mstatus** register stores the processor's current status, including the current privilege mode and interrupt enable bits. It is updated whenever traps occur or execution returns from a trap.

## mtvec

The **mtvec** register contains the address of the trap handler. Whenever an exception or interrupt occurs, the processor jumps to the address stored in this register.

## mepc

The **mepc** register stores the address of the instruction that caused the trap. After the trap has been handled, execution can resume from this address using the `mret` instruction.

## mcause

The **mcause** register records the reason for the trap. It identifies whether the trap was caused by an interrupt or an exception and provides a code describing the specific cause.

## mtval

The **mtval** register stores additional information about the trap, such as the faulting memory address or the illegal instruction value, depending on the type of exception.

---

# Trap Handling Flow

A **trap** is any event that transfers control from normal program execution to a privileged trap handler. Traps include both **exceptions** (synchronous events) and **interrupts** (asynchronous events).

The trap handling process follows these steps:

1. A program executes normally in User Mode or Supervisor Mode.
2. An exception or interrupt occurs.
3. The processor saves the address of the interrupted instruction in `mepc`.
4. The cause of the trap is recorded in `mcause`.
5. Additional fault information is stored in `mtval` if required.
6. The processor updates `mstatus` and switches to Machine Mode.
7. The Program Counter (PC) is loaded from `mtvec`, transferring control to the trap handler.
8. The trap handler services the interrupt or exception.
9. The `mret` instruction restores the previous privilege level and resumes execution from the address stored in `mepc`.

---

# Types of Traps

### Exceptions
Exceptions occur because of the currently executing instruction. Common examples include:

- Illegal instruction
- Divide by zero (if implemented)
- Environment call (`ecall`)
- Load or store access faults
- Misaligned memory access

### Interrupts
Interrupts occur asynchronously from external events. Common examples include:

- Machine timer interrupt
- Machine software interrupt
- Machine external interrupt

Interrupts can occur at any time and are handled according to their priority and enable settings.

---

# Importance of the Privileged Architecture

The privileged architecture provides the foundation for operating systems and embedded firmware. It enables secure execution by separating user applications from system software, supports exception and interrupt handling, protects hardware resources, and allows multiple applications to execute safely. Features such as privilege levels, CSRs, and trap handling make RISC-V suitable for embedded systems, real-time applications, and general-purpose operating systems such as Linux.

---

# Conclusion

The RISC-V Privileged Architecture extends the base instruction set by providing privilege levels, Control and Status Registers (CSRs), and a structured trap handling mechanism. Machine Mode manages hardware and system control, Supervisor Mode runs operating systems, and User Mode executes applications. Together, these features ensure secure, reliable, and efficient execution of software on RISC-V processors.