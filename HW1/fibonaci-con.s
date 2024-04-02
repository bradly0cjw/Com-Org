    .text
main:
    li $t1, 0
    li $t2, 1
    li $v0, 5
    li $s1, 32
    syscall
    add $t0, $v0, $0
loop:
    beq $t0, 0, exit
    add $a0, $t1, $0
    li $v0, 1
    syscall
    beq $t0, 1, skip
    add $a0, $s1, $0
    li $v0, 11
    syscall
skip:
    add $t3, $t1, $t2
    add $t1, $t2, $0
    add $t2, $t3, $0
    subi $t0, $t0, 1
    j loop
exit:
    li $v0 10
    syscall
