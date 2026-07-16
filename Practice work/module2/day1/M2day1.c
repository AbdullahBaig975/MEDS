#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

void print_binary(uint32_t num) {
    for (int i = 31; i >= 0; i--) {
        printf("%u", (num >> i) & 1);
        if (i % 4 == 0 && i != 0) {
            printf(" ");
        }
    }
    printf("\n");
}

int main() {
    uint32_t num;
    printf("Enter a 32-bit unsigned integer (in hexadecimal): ");
    scanf("%x", &num);
    

    printf("Original number: 0x%X\n", num);
    printf("Number in signed decimal : %d\n", (int32_t)num);
    printf("Number in unsigned decimal : %u\n", num);
    printf("Binary representation: ");
    print_binary(num);
    return 0;
}








