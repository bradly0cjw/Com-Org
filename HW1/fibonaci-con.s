    .text
main:
    li $s0, 0
loop:
    li $v0, 5
    syscall
    beq $v0, 0, exit
    add $a0 ,$v0, $0
    jal fibo
    li $s0, 1
    syscall
    j loop
fibo:
    # addi $sp, $sp, -8
    # sw $ra, 4($sp)
    # sw $a0, 0($sp)
    # addi $a0, $a0 ,-1
    # beq $a0 0 L1
    # jal fibo
    # add $s0 ,$s0, $v0
    # addi $a0, $a0 ,-1
    # beq $a0 0 L1
    # jal fibo
    # add $s0 ,$s0, $v0
    # add $s0 ,$v0, $v1
    # lw $a0, 0($sp)
    # lw $ra, 4($sp)
    # addi $sp, $sp, 8
    # jr $ra
    leq $t1, $a0, 1
    beq $t1, 1, L1
    
L1:
    li $t1,0
    sw $t1,0($sp)
    addi $sp, $sp, -4
    li $t1,1
    sw $t1,4($sp)
    # li $t1 0
    # add $s0 ,$s0, $t1
    # jr $ra
exit:
    li $v0 10
    syscall