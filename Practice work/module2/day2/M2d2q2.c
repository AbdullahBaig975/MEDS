#include <stdio.h>
#include <stdint.h>
void write_reg(uint32_t *regs, uint8_t rd, uint32_t value){
    if(rd>=31) return ;
    if(rd == 0){
        return ;}

    regs[rd] = value; 
}

uint32_t read_reg(const uint32_t *regs, uint8_t rs){
    if(rs >= 31) 
        return 0;
    else 
        return regs[rs];
}

int main(){
    uint32_t arr[32] = {0};
    write_reg(arr, 5, 0xAD12345A);
    printf("The value is 0x%X (Expected = AD12345A)\n" ,read_reg(arr,5));

    write_reg(arr, 17, 0xAD17645A);
    printf("The value is 0x%X (Expected = AD17645A)\n" ,read_reg(arr,17));

    write_reg(arr, 50, 0xAD12345A);
    printf("The value is 0x%X (Expected = error)\n" ,read_reg(arr,50));


}