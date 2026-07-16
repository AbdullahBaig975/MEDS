#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

uint32_t extract_bits(uint32_t num, int start, int end){
   int width = end - start + 1;
    uint32_t mask = (1U << width) - 1;
    return (num >> start) & mask;
}

void parse_instruction(uint32_t num){
    printf("Original number: 0x%X\n", num);
    printf("opcode  : 0x%X\n", extract_bits(num, 0, 6));
    printf("Rd      : 0x%X\n",     extract_bits(num, 7, 11));
    printf("funct3  : 0x%X\n", extract_bits(num, 12, 14));
    printf("rs1     : 0x%X\n",    extract_bits(num, 15, 19));
    printf("rs2     : 0x%X\n",    extract_bits(num, 20,24));
    printf("funct7  : 0x%X\n", extract_bits(num, 25, 31));
}

int main(){
    uint32_t instr[5] ={
        0x00A28233, // add x4, x5, x10 (R-type)
        0x005202B3, // add x5, x4, x5  (R-type)
        0x40A30333, // sub x6, x6, x10 (R-type)
        0x005323B3, // slt x7, x6, x5  (R-type)
        0x0062F433  // and x8, x5, x6  (R-type)
    };
        for(int i=5; i>0; i--){
            parse_instruction(instr[i-1]);
            printf("\n");
        
        }
    return 0;
}
