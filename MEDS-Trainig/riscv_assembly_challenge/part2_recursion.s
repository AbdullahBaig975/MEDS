# #include <stdio.h>

# void merge(int arr[], int left, int mid, int right)
# {
#     int n1 = mid - left + 1;
#     int n2 = right - mid;

#     int L[n1], R[n2];

#     // Copy data into temporary arrays
#     for (int i = 0; i < n1; i++)
#         L[i] = arr[left + i];

#     for (int j = 0; j < n2; j++)
#         R[j] = arr[mid + 1 + j];

#     int i = 0;
#     int j = 0;
#     int k = left;

#     // Merge the two sorted arrays
#     while (i < n1 && j < n2)
#     {
#         if (L[i] <= R[j])
#         {
#             arr[k] = L[i];
#             i++;
#         }
#         else
#         {
#             arr[k] = R[j];
#             j++;
#         }
#         k++;
#     }

#     // Copy remaining elements of L[]
#     while (i < n1)
#     {
#         arr[k] = L[i];
#         i++;
#         k++;
#     }

#     // Copy remaining elements of R[]
#     while (j < n2)
#     {
#         arr[k] = R[j];
#         j++;
#         k++;
#     }
# }

# void mergeSort(int arr[], int left, int right)
# {
#     if (left < right)
#     {
#         int mid = left + (right - left) / 2;

#         mergeSort(arr, left, mid);
#         mergeSort(arr, mid + 1, right);

#         merge(arr, left, mid, right);
#     }
# }

# void printArray(int arr[], int n)
# {
#     for (int i = 0; i < n; i++)
#         printf("%d ", arr[i]);
#     printf("\n");
# }

# merge(arr, left, mid, right)
#
# a0 = arr
# a1 = left
# a2 = mid
# a3 = right

.data

# -------- Test Case 1 --------
arr1:   .word 380, 127, 19, 73, 1, 2, 100
size1:  .word 7

# -------- Test Case 2 --------
arr2:   .word 1, 2, 3, 4, 5, 6 
size2:  .word 6

# -------- Test Case 3 --------
arr3:   .word 104, 135, 2,77 ,45 , 44, 67, 81, 1, 3
size3:  .word 10

# Temporary buffer for merge()
temp:   .space 400

msg1:   .asciiz "Original Array: "
msg2:   .asciiz "Sorted Array: "

.globl main
.text

merge:

    #-------------------------------
    # Save registers
    #-------------------------------
    addi sp, sp, -36

    sw ra, 32(sp)
    sw s0, 28(sp)
    sw s1, 24(sp)
    sw s2, 20(sp)
    sw s3, 16(sp)
    sw s4, 12(sp)
    sw s5, 8(sp)
    sw s6, 4(sp)

    mv s0, a0          # arr
    mv s1, a1          # left
    mv s2, a2          # mid
    mv s3, a3          # right

    la s4, temp        # temp buffer

    # i = left
    # j = mid + 1
    # k = left

    mv s5, s1          # i

    addi s6, s2, 1     # j

    mv t0, s1          # k

# while(i <= mid && j <= right)

    merge_loop:

        bgt s5, s2, copy_right

        bgt s6, s3, copy_left

        # Load arr[i]

        slli t1, s5, 2

        add t1, s0, t1

        lw t2, 0(t1)

        # Load arr[j]

        slli t3, s6, 2

        add t3, s0, t3

        lw t4, 0(t3)

        # if(arr[i] <= arr[j])

        ble t2, t4, take_left

    # temp[k] = arr[j]

        slli t5, t0, 2

        add t5, s4, t5

        sw t4, 0(t5)

        addi s6, s6, 1

        addi t0, t0, 1

        j merge_loop

    # temp[k] = arr[i]

    take_left:

        slli t5, t0, 2

        add t5, s4, t5

        sw t2, 0(t5)

        addi s5, s5, 1

        addi t0, t0, 1

        j merge_loop

    # Copy remaining elements from left half

    copy_left:

        bgt s5, s2, copy_right

    copy_left_loop:

        bgt s5, s2, copy_right

        # temp[k] = arr[i]

        slli t1, s5, 2
        add  t1, s0, t1
        lw   t2, 0(t1)

        slli t3, t0, 2
        add  t3, s4, t3
        sw   t2, 0(t3)

        addi s5, s5, 1
        addi t0, t0, 1

        j copy_left_loop

    # Copy remaining elements from right half

    copy_right:

        bgt s6, s3, copy_back

    copy_right_loop:

        bgt s6, s3, copy_back

        # temp[k] = arr[j]

        slli t1, s6, 2
        add  t1, s0, t1
        lw   t2, 0(t1)

        slli t3, t0, 2
        add  t3, s4, t3
        sw   t2, 0(t3)

        addi s6, s6, 1
        addi t0, t0, 1

        j copy_right_loop

    # Copy temp[left..right] back into arr[left..right]

    copy_back:

        mv t0, s1          # index = left

    copy_back_loop:

        bgt t0, s3, merge_done

        # arr[index] = temp[index]

        slli t1, t0, 2

        add t2, s4, t1
        lw  t3, 0(t2)

        add t4, s0, t1
        sw  t3, 0(t4)

        addi t0, t0, 1

        j copy_back_loop

    # Restore registers and return

    merge_done:

        lw s6, 4(sp)
        lw s5, 8(sp)
        lw s4, 12(sp)
        lw s3, 16(sp)
        lw s2, 20(sp)
        lw s1, 24(sp)
        lw s0, 28(sp)
        lw ra, 32(sp)

        addi sp, sp, 36

        ret

# mergeSort(arr, left, right)
#
# Arguments:
#   a0 = address of array
#   a1 = left index
#   a2 = right index
#
# Calls:
#   mergeSort(arr, left, mid)
#   mergeSort(arr, mid+1, right)
#   merge(arr, left, mid, right)

mergeSort:

    # Create stack frame
    addi sp, sp, -32

    sw ra, 28(sp)
    sw s0, 24(sp)
    sw s1, 20(sp)
    sw s2, 16(sp)
    sw s3, 12(sp)

   
    # Save arguments
   
    mv s0, a0          # array pointer
    mv s1, a1          # left
    mv s2, a2          # right

  
    # Base case:
    # if(left >= right)
    #     return;
   
    bge s1, s2, mergeSort_return

    # mid = left + (right-left)/2

    sub t0, s2, s1     # t0 = right - left

    srai t0, t0, 1     # t0 = (right-left)/2

    add s3, s1, t0     # s3 = mid

    # mergeSort(arr, left, mid)
  
    mv a0, s0
    mv a1, s1
    mv a2, s3

    call mergeSort

    # mergeSort(arr, mid+1, right)
   
    mv a0, s0

    addi a1, s3, 1

    mv a2, s2

    call mergeSort

    # merge(arr, left, mid, right)
    mv a0, s0
    mv a1, s1
    mv a2, s3
    mv a3, s2

    call merge

# Restore registers and return

    mergeSort_return:

        lw s3, 12(sp)
        lw s2, 16(sp)
        lw s1, 20(sp)
        lw s0, 24(sp)
        lw ra, 28(sp)

        addi sp, sp, 32

        ret

# printArray(arr, size)
#
# a0 = array address
# a1 = number of elements

printArray:

    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)

    mv s0, a0          # array pointer
    mv s1, a1          # size

    li t0, 0

    print_loop:

        bge t0, s1, print_done

        slli t1, t0, 2
        add t1, s0, t1
        lw t2, 0(t1)

        # Print integer
        li a0, 1
        mv a1, t2
        ecall

        # Print space
        li a0, 11
        li a1, ' '
        ecall

        addi t0, t0, 1
        j print_loop

    print_done:

        # Print newline
        li a0, 11
        li a1, '\n'
        ecall

        lw s1, 4(sp)
        lw s0, 8(sp)
        lw ra, 12(sp)

        addi sp, sp, 16

        ret
main:
    li a0, 4
    la a1, msg1
    ecall

    la a0, arr1
    lw a1, size1
    call printArray

# Sort Test Case 1

    la a0, arr1          # array address
    li a1, 0             # left = 0
    lw t0, size1
    addi a2, t0, -1      # right = size-1

    call mergeSort
    li a0, 4
    la a1, msg2
    ecall

    la a0, arr1
    lw a1, size1
    call printArray

# Sort Test Case 2

    li a0, 4
    la a1, msg1
    ecall

    la a0, arr2
    lw a1, size1
    call printArray

    la a0, arr2
    li a1, 0
    lw t0, size2
    addi a2, t0, -1

    call mergeSort
    li a0, 4
    la a1, msg2
    ecall

    la a0, arr2
    lw a1, size1
    call printArray

# Sort Test Case 3
    li a0, 4
    la a1, msg1
    ecall

    la a0, arr3
    lw a1, size1
    call printArray

    la a0, arr3
    li a1, 0
    lw t0, size3
    addi a2, t0, -1

    call mergeSort

    li a0, 4
    la a1, msg2
    ecall

    la a0, arr3
    lw a1, size1
    call printArray
# Exit Program

    li a0, 10
    ecall