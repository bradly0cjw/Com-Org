# Selection Sort in MIPS Assembly

    .data
array:  .space 400 # allocate space for 100 integers
space:  .asciiz " " # space string
    .text
    .globl main
main:
    # Read integers from console until 0 is encountered
    addi $s0,$zero, 0      # $t0 - size
read_loop:
    li $v0, 5      # system call for read_int
    syscall
    sw $v0, array($t1) # store integer in array
    addi $t1, $t1, 4 # increment array memory address
    addi $s0, $s0, 1 # increment number of elements
    bne $v0, $zero, read_loop # loop until 0 is encountered
    subi $s0, $s0, 1 # decrement number of elements by 1

    # Call selection sort procedure
    la $a0, array #array address
    move $a1, $s0 #numbers of elements
    addi $sp, $sp, -4 #save return address
    sw $ra, 0($sp)
    jal selection_sort #call selection sort procedure
    lw $ra, 0($sp) #restore return address
    addi $sp, $sp, 4 #restore stack pointer

    # Print sorted array

    li $t4, 0 #initialize array address
    li $t3, 0 #initialize counter
print_loop:
    # j exit
    lw $a0, array($t4)
    li $v0, 1      # system call for print_int
    syscall

    # Print a space
    li $v0, 4      # system call for print_string
    la $a0, space
    syscall

    addi $t4, $t4, 4
    addi $t3, $t3, 1
    bne $t3, $s0, print_loop
    j exit

# Selection Sort Procedure
selection_sort:
    # $a0 - base address of array
    # $a1 - number of elements in array
    # $t2 - i address
    # $t3 - j address
    # $t4 - i
    # $t5 - j
# $t6 - min_index
# $t7 - temp
# $t8 - min_val

# Save $s0
    # addi $sp , $sp , -4 
    # sw $s0, 0($sp)
    li $t4, 0 # i = 0
for_loop_i:
    beq $t4 , $a1 , exit # if i >= n then goto exit
    add $t6 ,$t4 ,$zero # min_index = i
    mul $t2,$t4,4 # $i_addr = i * 4
    add $t2,$t2,$a0 # i_addr = A + i
    lw $t8 , 0($t2) # min_val = A[i]
    add $t5, $t4, 1 # j = i + 1

    for_loop_j:
        # if j >= n then goto end_for_loop_j
        beq $t5 , $a1 , exit2
        mul $t3,$t5,4 # $t3 = j * 4
        add $t3,$t3,$a0 # $t3 = A + j
        lw $t7 , 0($t3) # $t7 = A[j]
        blt $t7 , $t8 , if_statement # if A[j] > A[min_index] then goto if_statement
        j end_for_loop_j

if_statement:
            add $t6 ,$t5 ,$zero # $t6 = j
            lw $t8 , 0($t3) # $t8 = A[j]
            
        end_for_loop_j:
            addi $t5 , $t5 , 1 # j = j + 1
            j for_loop_j # goto for_loop_j
    exit2:        
    # swap A[i] and A[min_index]
    mul $t3,$t6,4 # $t3 = min_index * 4
    add $t3,$t3,$a0 # $t3 = A + min_index
    lw $t7 , 0($t2) # $t7 = A[i]
    lw $t8 , 0($t3) # $t8 = A[min_index]
    sw $t8 , 0($t2) # A[i] = A[min_index]
    sw $t7 , 0($t3) # A[min_index] = A[i]
    addi $t4 , $t4 , 1 # i = i + 1
    blt $t4 , $a1 , for_loop_i # if i < n then goto for_loop_i
    addi $sp , $sp , 4
    jr $ra

exit:
    li $v0, 10
    syscall