# ENCODING_WORKSHEET.md

## Part 3: Manual Instruction Encoding

---

# 1. R-Type

### Instruction
```assembly
add x5, x6, x7
```

### Fields

| Field | Value |
|-------|-------|
| funct7 | 0000000 |
| rs2 | 00111 (x7) |
| rs1 | 00110 (x6) |
| funct3 | 000 |
| rd | 00101 (x5) |
| opcode | 0110011 |

### Binary

```
0000000 00111 00110 000 00101 0110011
```

### Grouped into Hex

```
0000 0000 0111 0011 0000 0010 1011 0011
```

### Machine Code

```
0x007302B3
```

---

# 2. I-Type

### Instruction

```assembly
addi x5, x6, 10
```

### Immediate

```
10 = 000000001010
```

### Fields

| Field | Value |
|-------|-------|
| imm[11:0] | 000000001010 |
| rs1 | 00110 (x6) |
| funct3 | 000 |
| rd | 00101 (x5) |
| opcode | 0010011 |

### Binary

```
000000001010 00110 000 00101 0010011
```

### Grouped into Hex

```
0000 0000 1010 0011 0000 0010 1001 0011
```

### Machine Code

```
0x00A30293
```

---

# 3. S-Type

### Instruction

```assembly
sw x5, 8(x6)
```

### Immediate

```
8 = 000000001000
```

Split:

```
imm[11:5] = 0000000
imm[4:0]  = 01000
```

### Fields

| Field | Value |
|-------|-------|
| imm[11:5] | 0000000 |
| rs2 | 00101 (x5) |
| rs1 | 00110 (x6) |
| funct3 | 010 |
| imm[4:0] | 01000 |
| opcode | 0100011 |

### Binary

```
0000000 00101 00110 010 01000 0100011
```

### Grouped into Hex

```
0000 0000 0101 0011 0010 0100 0010 0011
```

### Machine Code

```
0x00532423
```

---

# 4. B-Type

### Instruction

```assembly
beq x5, x6, 16
```

### Immediate

```
16 = 000000010000
```

Split:

```
imm[12]   = 0
imm[10:5] = 000000
imm[4:1]  = 1000
imm[11]   = 0
```

### Fields

| Field | Value |
|-------|-------|
| imm[12] | 0 |
| imm[10:5] | 000000 |
| rs2 | 00110 (x6) |
| rs1 | 00101 (x5) |
| funct3 | 000 |
| imm[4:1] | 1000 |
| imm[11] | 0 |
| opcode | 1100011 |

### Binary

```
0 000000 00110 00101 000 1000 0 1100011
```

### Grouped into Hex

```
0000 0000 0110 0010 1000 1000 0110 0011
```

### Machine Code

```
0x00628863
```

---

# 5. U-Type

### Instruction

```assembly
lui x5, 0x12345
```

### Fields

| Field | Value |
|-------|-------|
| imm[31:12] | 00010010001101000101 |
| rd | 00101 (x5) |
| opcode | 0110111 |

### Binary

```
00010010001101000101 00101 0110111
```

### Grouped into Hex

```
0001 0010 0011 0100 0101 0010 1011 0111
```

### Machine Code

```
0x123452B7
```

---

# 6. J-Type

### Instruction

```assembly
jal x5, 20
```

### Immediate

```
20 = 0000000000010100
```

Split:

```
imm[20]    = 0
imm[10:1]  = 0000001010
imm[11]    = 0
imm[19:12] = 00000000
```

### Fields

| Field | Value |
|-------|-------|
| imm[20] | 0 |
| imm[10:1] | 0000001010 |
| imm[11] | 0 |
| imm[19:12] | 00000000 |
| rd | 00101 (x5) |
| opcode | 1101111 |

### Binary

```
0 0000001010 0 00000000 00101 1101111
```

### Grouped into Hex

```
0000 0001 0100 0000 0000 0010 1110 1111
```

### Machine Code

```
0x014002EF
```

---

## Final Encoded Instructions

| Format | Instruction | Machine Code |
|---------|-------------|--------------|
| R | `add x5, x6, x7` | `0x007302B3` |
| I | `addi x5, x6, 10` | `0x00A30293` |
| S | `sw x5, 8(x6)` | `0x00532423` |
| B | `beq x5, x6, 16` | `0x00628863` |
| U | `lui x5, 0x12345` | `0x123452B7` |
| J | `jal x5, 20` | `0x014002EF` |