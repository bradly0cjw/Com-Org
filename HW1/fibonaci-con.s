    .data
space:  
    .asciiz " "
return: 
    .asciiz "\n"
    .text
main:
    li $t1, 0
    li $t2, 1
    li $v0, 5
    syscall
    add $t0, $v0, $0
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
    j main
exit:
    li $v0 10
    syscall
