# Lecture Notes: Advanced Combinational & Sequential Logic



---

## Part 1: Completing Combinational Logic

Before moving to memory, the lecture explores the final components required for system-level communication and optimization.

### **Tri-State Buffers (High Impedance)**
Unlike standard logic gates that always output a 0 or 1, a Tri-State Buffer has three possible output states:
1.  **Logic 1** (High)
2.  **Logic 0** (Low)
3.  **High-Z** (High Impedance / Floating)

*   **Function:** When the "Enable" signal is inactive, the output is effectively disconnected from the circuit.
*   **Application:** Essential for **Bus Systems**. Multiple devices can be connected to the same wire; as long as only one device is enabled (not in High-Z), they can share the communication path without electrical contention.

### **EDA and Optimization**
**Electronic Design Automation (EDA)** tools automate the simplification of Boolean functions.
*   **Uniting Theorem:** $A \cdot B + A \cdot \overline{B} = A$. This is the mathematical basis for most minimization.
*   **Design Constraints:** Optimization isn't just for "neatness"—it directly reduces **Area** (cost), **Power Consumption**, and **Propagation Delay** (latency).

### **Priority Circuits**
*   **Logic:** Used when multiple inputs might be active simultaneously, but the system must respond to the one with the highest "priority."
*   **Use Case:** Interrupt handling in microprocessors and managing shared bus access.

---

## Part 2: Introduction to Sequential Logic

Sequential logic introduces the concept of **Time** and **Memory**. The output is now a function of both current inputs and the **Current State**.

### **Storage Fundamentals & Metastability**
*   **Cross-Coupled Inverters:** The simplest form of memory. By feeding the output of one inverter back into the input of another (positive feedback), the circuit "locks" into a stable state.
*   **Metastability:** A critical engineering challenge. If a circuit is pushed into a state where it is neither 0 nor 1, it may "teeter" in between. Designing for reliability means ensuring the circuit settles into a valid logic level before the next clock cycle.

### **The Gated D-Latch**
To control *when* a value is stored, we add a control signal.
*   **D (Data):** The value to be stored.
*   **WE (Write Enable):** When High, the latch is "transparent" (Output = Input). When Low, the output is "latched" (frozen), ignoring any changes on the D input.

### **Memory Arrays and Registers**
Scaling storage requires organization:
*   **Register:** A group of latches/flip-flops acting as a single unit (e.g., an 8-bit register).
*   **Memory Array:** Combining registers with **Decoders** (to select the address) and **Multiplexers** (to read the data out).

---

## Part 3: Synchronous Design & FSMs

### **Finite State Machines (FSM)**
FSMs are the "brains" of digital control. They model how a system moves through a sequence of operations.
*   **Analogies:** 
    *   *Combination Lock:* Needs a specific sequence of inputs to change state from "Locked" to "Open."
    *   *Traffic Light:* Transitions through states (Green $\rightarrow$ Yellow $\rightarrow$ Red) based on timers or sensor inputs.

### **The D Flip-Flop (DFF)**
The DFF is the building block of **Synchronous Design**.
*   **Edge-Triggering:** Unlike a latch (which is level-sensitive), a DFF only captures data on the **Rising Edge** (or falling edge) of a **Clock signal**.
*   **Stability:** This ensures that all state changes in a massive processor happen at the exact same moment, preventing "race conditions" where signals arrive at different times and cause errors.

---

> **Summary:** The shift from Latches to Flip-Flops and the introduction of a Global Clock allows engineers to build complex, predictable systems like CPUs where billions of transistors stay perfectly in sync.