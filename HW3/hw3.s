# GCD implementaiton with Euclidean algorithm
.data
    n1: .word 0
    n2: .word 0
.text
.globl main
main:
    # read n1 and n2 from user
    li $v0, 5
    syscall
    sw $v0, n1
    li $v0, 5
    syscall
    sw $v0, n2

    # call gcd function
    lw $a0, n1 # $a0 = n1
    lw $a1, n2 # $a1 = n2
    addi $sp, $sp, -4 # allocate space for 1 variables
    sw $ra , 0($sp) # save return address
    jal gcd # $v0 = gcd(n1, n2)
    lw $ra, 0($sp) # restore return address
    addi $sp, $sp, 4 # deallocate space for 1 variables
    move $a0, $v0 # $a0 = gcd(n1, n2)

    # print the result
    li $v0, 1
    syscall

    # exit
    li $v0, 10
    syscall

gcd:
    # if n2 is not zero, call gcd recursively
    beqz $a1, end_gcd # if(n2 == 0) goto end_gcd
    move $t0, $a0 # $t0 = n1
    move $t1, $a1 # $t1 = n2
    addi $sp, $sp, -4 # allocate space for 1 variables
    sw $ra , 0($sp) # save return address
    jal modular # $v0 = n1 % n2
    lw $ra, 0($sp) # restore return address
    addi $sp, $sp, 4 # deallocate space for 1 variables
    move $a0, $t1 # $a0 = n2
    move $a1, $v0 # $a1 = n1 % n2
    addi $sp, $sp, -4 # allocate space for 1 variables
    sw $ra , 0($sp) # save return address
    jal gcd # $v0 = gcd(n2, n1 % n2)
    lw $ra, 0($sp) # restore return address
    addi $sp, $sp, 4 # deallocate space for 1 variables
    jr $ra # return

end_gcd:
    # if n2 is zero, return n1
    move $v0, $a0 # $v0 = n1
    jr $ra # return

modular:
    # while n1 is greater than or equal to n2, subtract n2 from n1
    slt $t0, $a0, $a1 # $t0 = n1 < n2
    beqz $t0, modular_loop # if(n1 < n2) goto modular_loop
    move $v0, $a0 # $v0 = n1
    jr $ra # return

modular_loop:
    sub $a0, $a0, $a1   # n1 = n1 - n2
    j modular # goto modular