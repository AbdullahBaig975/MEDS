# Lecture Notes: Timing & Verification

This lecture explores the physical limitations of digital circuits, shifting focus from abstract truth tables to the real-world constraints of hardware performance.

---

## 1. Combinational Circuit Timing

Timing in combinational logic is defined by how long it takes for electrical signals to propagate through gates and wires.

### Key Delay Definitions
*   **Propagation Delay ($t_{pd}$):** The maximum time required for the output to fully settle after an input change. This defines the "slowest" path.
*   **Contamination Delay ($t_{cd}$):** The minimum time before an output begins to change after an input change. This defines the "fastest" path.



### Constraints and Environmental Factors
*   **Critical Paths:** The longest timing path in a circuit. It determines the maximum possible clock frequency ($f_{max}$).
*   **Environmental Impact:** Delays are not static; they fluctuate based on:
    *   **Supply Voltage:** Lower voltage generally increases delay.
    *   **Temperature:** Higher temperatures typically slow down electron mobility.
    *   **Physical Layout:** Wire capacitance and resistance (RC delay) play a massive role in modern sub-micron designs.

### Glitches (Hazards)
Glitches occur when signals traveling through paths of different lengths arrive at a gate at different times, causing a temporary "flicker" or unintended signal change. While they don't always break logic, they cause **wasted dynamic power**.

---

## 2. Sequential Circuit Timing

In sequential circuits, timing is centered around the **Clock** and the stability of data at the input of Flip-Flops.

### Flip-Flop Constraints
To avoid **metastability** (where a flip-flop enters an undefined state between 0 and 1), two windows must be respected:
1.  **Setup Time ($t_{setup}$):** The interval before the clock edge where data must be stable.
2.  **Hold Time ($t_{hold}$):** The interval after the clock edge where data must remain stable.



### Clock Skew and Violations
**Clock Skew** occurs when the clock signal reaches different flip-flops at different times due to wire length variations.
*   **Setup Time Violations:** Occur when the logic is too slow. 
    *   *Fix:* Lower the clock frequency or optimize the logic path.
*   **Hold Time Violations:** Occur when the logic is too fast (data changes before it's captured). 
    *   *Fix:* **Cannot** be fixed by slowing the clock. Requires adding physical buffers to delay the signal.

---

## 3. Circuit Verification

Verification ensures the design is both functionally correct and physically viable.

### The Verification Hierarchy
*   **Functional Verification:** Using HDL simulators to ensure the logic matches the intended behavior.
*   **Test Benches:** 
    *   **Manual Test Benches:** Simple, user-defined inputs.
    *   **Automated Test Benches:** Use a **Golden Model** (a bug-free reference, often written in a high-level language like C or Python) to automatically compare results against the Device Under Test (DUT).

### Timing Verification
Post-synthesis tools analyze the design after it has been mapped to specific hardware (like an FPGA). 
*   If the design fails to meet the target frequency, engineers must "re-balance" logic—breaking long combinational paths into smaller pieces using registers (pipelining).

> **Design Principle:** Always **optimize for the common case** while ensuring that complex, rare scenarios do not cause the system to fail or significantly degrade performance.