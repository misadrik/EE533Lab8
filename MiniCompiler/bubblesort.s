# a silly version of bubble sort
main:
    addi a5 x0 1
    addi a4 x0 2
    addi a3 x0 3
    addi a2 x0 4
    addi a1 x0 5
    sw a5 x0 0
    sw a4 x0 1
    sw a3 x0 2
    sw a2 x0 3
    sw a1 x0 4
    addi a5 x0 5 # setting b (array size)
    addi a4 x0 4 # setting i loop (b - 1)
    addi s0 x0 0 # setting i
    j setjeqi
    nop
    nop
    nop

loopi:
    lw a1 s0 0 #ai
    lw a2 s1 0 #aj
    nop
    nop # wait to store in the register file
    blt a1 a2 swap # less than swap
    nop
    nop
    nop
    j addj

swap:
    sw a1 s1 0 
    sw a2 s0 0

addj:
   addi s1 s1 1 #no need to add nop here judge last value
   beq s1 a5 addi # b =5
   nop
   nop
   nop
   j loopi
   nop
   nop
   nop

setjeqi:
    addi s1 s0 1 #b = i b s1
    j loopi
    nop
    nop
    nop

addi:
    addi s0 s0 1 # i++
    beq s0 a4 exit
    nop
    nop
    nop
    j setjeqi #no need to wait added i come back
    nop
    nop
    nop

exit:
    j exit
    nop
    nop 
	nop