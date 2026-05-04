# Lecture Notes: HDL, Verilog Syntax, and Timing/Verification

This session, led by Prof. Onur Mutlu, transitions from abstract logic to the physical realities of hardware design, focusing on **Verilog** implementation and the critical constraints of **Timing and Verification**.

---

## 1. Hardware Description Languages (HDL) & Verilog

### Why use HDLs?
Standard software languages (like C++ or Java) are executed sequentially. Hardware is inherently **concurrent**—thousands of signals change at the same time. HDLs are specifically designed to model this parallel behavior.

### Design Methodology
*   **Top-Down:** Partitioning complex systems into manageable sub-modules.
*   **Bottom-Up:** Building and testing primitives before integrating them into larger hierarchies.

### Verilog Syntax & Key Concepts
*   **Bit Manipulation:** Uses **bit slicing** (selecting specific wires from a bus) and **concatenation** `{ }` to combine multiple signals into one bus.
*   **Implementation Styles:**
    *   **Structural:** Connecting gates like a physical schematic.
    *   **Behavioral:** Describing what the hardware *does* using logic operators and `assign` statements.
*   **Number Representation:** Follows the format `[size]'[base][value]`. 
    *   *Example:* `8'hFF` represents an 8-bit hexadecimal value of 255.
*   **Parameterization:** Using `parameter` allows you to create reusable modules where bit-widths can be adjusted without rewriting code.

---

## 2. Sequential Logic in Verilog

### Always Blocks
The `always` block is the standard construct for describing logic that triggers on specific events (like a clock edge).
*   **Register Declaration:** Any signal assigned within an `always` block must be declared as a `reg` type.
*   **Blocking (=) vs. Non-blocking (<=):**
    *   **Non-blocking (`<=`):** **Required for sequential logic.** It ensures all registers update simultaneously at the clock edge, mimicking real hardware.
    *   **Blocking (`=`):** Typically reserved for combinational logic within an `always` block.



### The "Latch Trap"
A common error occurs when a designer fails to define an output for every possible input combination (e.g., a missing `else` in an `if` statement). The compiler assumes the value must be "remembered," causing it to infer a **latch**. Latches are generally avoided in synchronous FPGA design as they lead to unpredictable timing.

---

## 3. Timing and Verification

### Introduction to Timing
A design that works on paper (truth tables) may fail in the real world. Hardware is subject to **Propagation Delays**: the time it takes for a signal to travel through gates and wires.
*   **Setup Time:** The time a signal must be stable *before* the clock edge.
*   **Hold Time:** The time a signal must remain stable *after* the clock edge.



### The Engineering "Iron Triangle"
Every design decision requires a trade-off between four pillars:
1.  **Area:** Physical space on the chip (Cost).
2.  **Speed:** Throughput and frequency.
3.  **Power:** Energy consumption (Heat and battery life).
4.  **Design Time:** The "Time-to-Market" pressure.

### Verification
Verification is often the most expensive phase of development. Because modern chips have billions of transistors, **exhaustive testing is impossible**. Designers must use rigorous validation methodologies and intelligent sampling to ensure the hardware is "functionally correct" before fabrication.