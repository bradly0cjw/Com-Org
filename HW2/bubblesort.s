sort:    addi $sp,$sp, -20      # make room on stack for 5 registers
         sw $ra, 16($sp)        # save $ra on stack
         sw $s3, 12($sp)         # save $s3 on stack
         sw $s2, 8($sp)         # save $s2 on stack
         sw $s1, 4($sp)         # save $s1 on stack
         sw $s0, 0($sp)         # save $s0 on stack
         move $s2, $a0           # save $a0 into $s2
         move $s3, $a1           # save $a1 into $s3
         move $s0, $zero         # i = 0
         addi $s3, $s3, -1       # $s3 = n-1
for1tst: slt  $t0, $s0, $s3      # $t0 = 0 if $s0 ≥ $s3 (i ≥ n-1)
         beq  $t0, $zero, exit1  # go to exit1 if $s0 ≥ $s3 (i ≥ n-1)
         move $s1, $zero         # j = 0
         sub  $t5, $s3, $s0      # $t5 = n-i–1
for2tst: slt  $t0, $s1, $t5      # $t0 = 1 if $s1 < $t5 (j < n-i-1)
         bne  $t0, $zero, exit2  # go to exit2 if $s1 < 0 (j < 0)
         sll  $t1, $s1, 2        # $t1 = j * 4
         add  $t2, $s2, $t1      # $t2 = v + (j * 4)
         lw   $t3, 0($t2)        # $t3 = v[j]
         lw   $t4, 4($t2)        # $t4 = v[j + 1]
         slt  $t0, $t4, $t3      # $t0 = 0 if $t4 ≥ $t3
         beq  $t0, $zero, exit2  # go to exit2 if $t4 ≥ $t3
         move $a0, $s2           # 1st param of swap is v (old $a0)
         move $a1, $s1           # 2nd param of swap is j
         jal  swap               # call swap procedure
         addi $s1, $s1, 1        # j++
         j    for2tst            # jump to test of inner loop
exit2:   addi $s0, $s0, 1        # i++
         j    for1tst            # jump to test of outer loop
swap:    sll $t1, $a1, 2   # $t1 = k * 4
         add $t1, $a0, $t1 # $t1 = v+(k*4)(address of v[k])
         lw $t0, 0($t1)    # $t0 (temp) = v[k]
         lw $t2, 4($t1)    # $t2 = v[k+1]
         sw $t2, 0($t1)    # v[k] = $t2 (v[k+1])
         sw $t0, 4($t1)    # v[k+1] = $t0 (temp)
         jr $ra            # return to calling routine
exit1:   lw $s0, 0($sp)  # restore $s0 from stack
         lw $s1, 4($sp)         # restore $s1 from stack
         lw $s2, 8($sp)         # restore $s2 from stack
         lw $s3,12($sp)         # restore $s3 from stack
         lw $ra,16($sp)         # restore $ra from stack
         addi $sp,$sp, 20       # restore stack pointer
         jr $ra                 # return to calling routine
