# Lecture Notes: Hardware Fundamentals & Combinational Logic
---

## 1. Hardware Fundamentals: Transistors and Gates

Modern digital design relies on the abstraction of physical materials into logical switches.

### **Transistors as Switches**
*   **Abstraction:** Instead of treating transistors as analog amplifiers, we treat them as binary switches.
*   **N-type (NMOS):** Conducts when the gate is **High** (Logic 1).
*   **P-type (PMOS):** Conducts when the gate is **Low** (Logic 0).
*   **CMOS Logic:** Complementary Metal-Oxide-Semiconductor design uses both NMOS and PMOS. This structure is preferred because it minimizes power consumption (current only flows during switching).



### **Moore’s Law**
*   **Observation:** The number of transistors on a microchip doubles approximately every two years.
*   **Implications:** While density increases, engineers face mounting challenges in **heat management**, **power leakage**, and the literal physical limits of atomic-scale manufacturing.

---

## 2. Combinational Logic and Boolean Algebra

### **Combinational vs. Sequential**
*   **Combinational Logic:** Memoryless. The output $Y$ is strictly a function of the current inputs $X$. 
    *   *Formula:* $Y = f(X)$
*   **Sequential Logic:** Incorporates **Memory**. The output depends on current inputs and the "State" (previous history).

### **Boolean Representation (Canonical Forms)**
Functions are derived from Truth Tables using two primary methods:
1.  **Sum of Products (SOP):** Created by ORing the **Minterms** (rows where output is 1).
2.  **Product of Sums (POS):** Created by ANDing the **Maxterms** (rows where output is 0).

> **Optimization Goal:** While canonical forms are mathematically "unique signatures," they are often inefficient. We use Boolean Algebra (and later, K-Maps) to reduce gate count, which directly lowers cost and power.

---

## 3. Functional Building Blocks

These are the "standard cells" used to construct complex processors.

### **Decoders**
*   **Function:** Activates a specific output line based on a binary input pattern.
*   **Example (2-to-4):** 2 input lines can select 1 of $2^2=4$ unique outputs.
*   **Use Case:** Critical for **Memory Address Decoding** (choosing which memory cell to read).



### **Multiplexers (MUX)**
*   **Function:** A data selector. It routes one of $N$ inputs to a single output based on "Select" lines.
*   **Control:** A 4-to-1 MUX requires 2 select bits ($S_1, S_0$) to choose the data path.

### **Binary Adders**
*   **Full Adder:** Computes the sum of two bits plus a **Carry-In** ($C_{in}$), producing a Sum ($S$) and a **Carry-Out** ($C_{out}$).
*   **Ripple Carry Adder (RCA):** Created by chaining $N$ full adders.
    *   **The Latency Problem:** In an RCA, the $n^{th}$ bit cannot calculate its sum until the $(n-1)^{th}$ bit provides the carry. This creates a "ripple" delay that limits clock speed.



---

## 4. Programmable Logic
*   **Programmable Logic Array (PLA):** A flexible hardware structure with programmable AND and OR planes.
*   **Look-Up Tables (LUT):** Instead of using physical gates for every function, modern **FPGAs** use LUTs (essentially small memories) to store the truth table of a function. This allows the hardware to be "reprogrammed" by simply changing the values in the table.