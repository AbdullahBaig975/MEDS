Here is the Markdown source code for the notes above. You can copy and paste this directly into any Markdown editor (like Obsidian, VS Code, or GitHub).

```markdown
# Lecture Notes: Introduction to Digital Logic Design

This lecture serves as the foundational entry point into the world of **Digital Systems**, contrasting them with analog counterparts and establishing the core logic that governs modern computing hardware.

---

## 1. Digital vs. Analog Systems
The lecture begins by distinguishing how information is represented and processed in the physical world versus the computational world.

### **Analog Systems**
*   **Definition:** Systems that process signals that are continuous in time and amplitude.
*   **Characteristics:**
    *   Infinite precision (theoretically).
    *   Highly susceptible to **noise** and interference.
    *   Difficult to store and reproduce without loss of quality.
*   **Example:** A traditional mercury thermometer or a vinyl record.

### **Digital Systems**
*   **Definition:** Systems that represent information using discrete values (typically binary).
*   **Characteristics:**
    *   **Noise Immunity:** Since digital signals operate on thresholds, small amounts of noise do not change a "0" to a "1".
    *   **Scalability:** Digital circuits can be easily integrated into complex systems (VLSI).
    *   **Programmability:** The behavior of the hardware can be defined by software or hardware description languages.

---

## 2. The Binary Foundation
At the heart of digital logic is the **Bit** (Binary Digit). The lecture deep-dives into why we use binary instead of decimal.

*   **Reliability:** It is electronically simpler to distinguish between two states (ON/OFF, High Voltage/Low Voltage) than ten discrete levels.
*   **Voltage Thresholds:** 
    *   **Logic 1 (High):** Usually represents a range near the supply voltage ($V_{CC}$).
    *   **Logic 0 (Low):** Usually represents a range near Ground ($GND$).
    *   **Forbidden Zone:** The undefined region between High and Low where the signal is unreliable.

---

## 3. Levels of Abstraction in Digital Design
To manage the complexity of designing modern processors, engineers use a hierarchical approach:

1.  **System Level:** The overall architecture (CPUs, Memory, I/O).
2.  **Register Transfer Level (RTL):** Describing how data flows between registers (this is where languages like **SystemVerilog** are primarily used).
3.  **Logic Level:** The world of Gates (AND, OR, NOT) and Boolean equations.
4.  **Circuit Level:** Transistors, resistors, and capacitors.
5.  **Physical Level:** The actual silicon layout on a chip.

---

## 4. Basic Logic Operations
The "Deep Dive" into logic starts with the primary operators that form the basis of all computation:

| Operator | Symbol | Description | Boolean Expression |
| :--- | :---: | :--- | :---: |
| **AND** | $\cdot$ | Output is 1 only if **all** inputs are 1. | $Y = A \cdot B$ |
| **OR** | $+$ | Output is 1 if **at least one** input is 1. | $Y = A + B$ |
| **NOT** | $'$ or $\overline{A}$ | Output is the inverse of the input. | $Y = \overline{A}$ |

---

## 5. Why Digital Logic Design (DLD) Matters
The lecture concludes by emphasizing that DLD is the bridge between physics and computer science. 
*   **Optimization:** Learning how to minimize Boolean expressions to use fewer gates (reducing power and cost).
*   **Timing:** Understanding that signals take time to travel (propagation delay), which limits the speed of a processor.

---

> **Key Takeaway:** Digital design is the art of using discrete logic to build complex, reliable systems. While the physical world is analog, the digital domain provides the stability needed for modern technology.
```