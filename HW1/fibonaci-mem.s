    .data
input:
    .word 5
    .word 10
    .word 15
    .word 4
    .word 3
    .word 0    
space:  
    .asciiz " "
return: 
    .asciiz "\n"
    .text
    la $s0, input
main:
    li $t1, 0
    li $t2, 1
    lw $t0, 0($s0)
    beq $t0, 0, exit
loop:
    beq $t0, 0, end
    add $a0, $t1, $0
    li $v0, 1
    syscall
    beq $t0, 1, skip
    la $a0, space
    li $v0, 4
    syscall
skip:
    add $t3, $t1, $t2
    add $t1, $t2, $0
    add $t2, $t3, $0
    subi $t0, $t0, 1
    j loop
end:
    la $a0, return
    li $v0, 4
    syscall
    addi $s0, $s0, 4
    j main
exit:
    li $v0 10
    syscall
