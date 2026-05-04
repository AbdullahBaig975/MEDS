# Lecture Notes: FSMs, FPGA Architecture, and Verilog Fundamentals

This lecture provides an in-depth examination of **Finite State Machines (FSMs)**, essential lab logistics, the underlying architecture of **FPGAs**, and the fundamentals of using **Verilog** for hardware design.

---

## 1. Finite State Machines (FSMs)

### Traffic Light Controller Case Study
The design of a traffic light controller serves as a practical implementation of a **Moore FSM**. 
*   **Key Emphasis:** The lecture highlights **Quality of Service (QoS)** and fairness in system scheduling to prevent bottlenecks and ensure efficient traffic flow.



### State Encoding Techniques
The choice of encoding significantly impacts the design's complexity and performance:

| Encoding Type | Description | Pros/Cons |
| :--- | :--- | :--- |
| **Binary Encoding** | Uses the minimum number of flip-flops ($log_2$ of the state count). | Prioritizes area efficiency. |
| **One-Hot Encoding** | Assigns one dedicated flip-flop per state. | Simplifies output logic; increases hardware footprint. |
| **Output Encoding** | State bits are mapped directly to output values (for Moore machines). | Eliminates complex output combinational logic. |

### Moore vs. Mealy Architectures
*   **Moore Machines:** Outputs are strictly defined by the **current state**. They are highly stable and resistant to input-induced glitches.
*   **Mealy Machines:** Outputs depend on both the **current state and external inputs**. They often require fewer states but are susceptible to glitches and more complex combinational logic paths.

---

## 2. Lab Logistics and FPGA Architecture

### Course Labs
*   **Hardware:** 10 hands-on labs using the **Basys 3** FPGA board.
*   **Objective:** The curriculum culminates in the design and implementation of a functional **32-bit MIPS microprocessor**.

### What is an FPGA?
An FPGA (Field-Programmable Gate Array) is a reconfigurable hardware substrate. 
*   **Fabric:** Uses **Look-Up Tables (LUTs)** and switch boxes to route logic.
*   **Function:** Allows developers to implement custom digital circuits on programmable hardware.



### Applications
FPGAs are industry standards for high-performance computing, including:
*   Genomics and weather prediction.
*   **Experimental Memory Research:** Use of tools like **DRAM Bender** to research reliability issues such as *RowHammer* and *RowPress*.

### CAD Design Flow
The design process is automated through **Xilinx Vivado**, which manages:
1. Synthesis and Simulation
2. Placement and Routing
3. Bitstream Generation

---

## 3. Introduction to Verilog

### Managing Complexity
With modern processors exceeding **100 billion transistors**, manual design is impossible. **Hardware Description Languages (HDLs)** like Verilog provide the necessary abstraction to manage this scale.

### Design Methodology
The course advocates for a **hierarchical design approach**:
*   **Top-down:** Architectural planning.
*   **Bottom-up:** Individual module implementation.

### Verilog Syntax
The **module** is the fundamental building block. Key concepts include:
*   **Keywords:** Utilizing `module` and `endmodule`.
*   **Port Declaration:** Defining inputs and outputs clearly.
*   **Signal Representation:** Standard conventions for multi-bit signals to ensure robust and readable hardware modeling.
# Sequential Circuits, FPGAs, and Verilog Fundamentals

## 1. Sequential Circuits & FSM Design

Unlike combinational logic, **sequential circuits** rely on internal memory to maintain state. Their outputs are determined by both current inputs and historical values.

### Storage Elements
The **D Flip-Flop** is the fundamental, edge-triggered component of sequential logic. 
*   **Function:** It captures input data ($D$) only on the rising edge of the clock ($CLK$).
*   **Purpose:** Ensures system state remains stable and synchronized across clock cycles.



### FSM Architecture
A Finite State Machine (FSM) consists of three primary components: a **state register**, **next-state logic**, and **output logic**.

| Feature | Moore Machine | Mealy Machine |
| :--- | :--- | :--- |
| **Output Logic** | Depends solely on the **current state**. | Depends on **current state AND inputs**. |
| **Stability** | Generally safer; outputs change only on clock edges. | Can be faster but prone to glitches from input changes. |



### Case Study: Smart Traffic Light
A traffic light controller demonstrates mapping real-world logic into a formal **state transition diagram**. This process involves:
*   Defining a **Reset State** (e.g., all directions Red).
*   Selecting **Encoding Schemes**:
    *   **Binary Encoding:** Minimizes the number of flip-flops ($log_2$ of states).
    *   **One-Hot Encoding:** One flip-flop per state; simplifies combinational logic.
    *   **Output Encoding:** Direct mapping of state bits to output signals.

---

## 2. Lab Logistics and FPGA Technology

### Course Progression
Students follow a structured design flow using the **Basys 3** board:
1.  Basic Logic Gates & ALUs.
2.  Control Units and Memory.
3.  **Final Goal:** A fully functional **32-bit MIPS microprocessor**.

### FPGA (Field Programmable Gate Array)
FPGAs are reconfigurable hardware substrates used for rapid prototyping and hardware acceleration.
*   **Research Applications:** Used in genomics, DNA sequencing, and memory studies (e.g., the **DRAM Bender** infrastructure for testing RowHammer vulnerabilities).
*   **The Workflow:** Students use the **Vivado Design Suite** to navigate the CAD flow:
    > **Synthesis** $\rightarrow$ **Placement** $\rightarrow$ **Routing** $\rightarrow$ **Bitstream Generation**



---

## 3. Introduction to Verilog

### Why HDLs?
With modern ICs containing billions of transistors, manual schematic entry is impossible. **Verilog** allows designers to:
*   Describe complex hardware structures.
*   Model **concurrent parallel processes**, which standard sequential languages (like C or Python) cannot naturally represent.

### Modeling and Syntax
Verilog uses a **module-based hierarchy**, where designs are built as interconnected blocks.

*   **Modules:** The basic building block defined by `module` and `endmodule`.
*   **Ports:** Explicitly defining `input` and `output` signals.
*   **Range Notation:** Using bus notation (e.g., `[31:0]`) to handle multi-bit signals and arrays effectively.

```verilog
// Example of a basic module structure
module TrafficLight (
    input wire clk,
    input wire reset,
    output reg [2:0] light_signal // 3-bit signal for Red, Yellow, Green
);
    // Logic goes here
endmodule