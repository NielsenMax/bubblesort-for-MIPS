.data
LL: .word 20    #Lenght of the list
LS: .word 2, 3, 4, 6, 7, 8, 4, 3, 5, 11, 44, 22, 5, 43, 6, 78, 14, 2, 1, 0  #list
MSGGREET: .asciiz "Welcome!\n The list loaded in memory contains the following numbers: "
MSGESPACIO: .asciiz " "
MSGFINAL: .asciiz "\n The list sorted is:"


.text
main: 
lw $t0, LL($0)  #Load the LL value in t0
la $t1, LS

li $v0, 4
la $a0, MSGGREET
syscall
FORGREET:
beq $t0, 0, ENDFORGREET 
li $v0, 1
lw $a0, 0($t1)
syscall
li $v0, 4
la $a0, MSGESPACIO
syscall
addi $t1, $t1, 4
addi $t0, $t0, -1
j FORGREET
ENDFORGREET:

lw $a0, LL($0)
la $a1, LS
jal BUBBLESORT

la $t1, LS
lw $t0, LL($0)

li $v0, 4
la $a0, MSGFINAL
syscall

FORPRINTING:
beq $t0, 0, ENDFORPRINTING 
li $v0, 1
lw $a0, 0($t1)
syscall
li $v0, 4
la $a0, MSGESPACIO
syscall
addi $t1, $t1, 4
addi $t0, $t0, -1
j FORPRINTING
ENDFORPRINTING:

li $v0, 10
syscall

BUBBLESORT:

li $s0, 0       #i
li $s1, 0       #j

FOR:
beq $a0, $s0, ENDFOR
la $a1, LS      #Load the LS address in a1
li $s1, 0
FORS:
li $s6, -1
mul $s3, $s0, $s6            #load the oposite of s0 in s3
add $s3, $a0, $s3          #load n-i in s3
beq $s3, $s1, ENDFORS
lw $t2, 0($a1)
lw $t3, 4($a1)
bgt $t2, $t3, INTERCAMBIAR

SIG:
addi $a1, $a1, 4
addi $s1, $s1, 1
j FORS

INTERCAMBIAR:
sw $t3, 0($a1)
sw $t2, 4($a1)
j SIG

ENDFORS:
addi $s0, $s0, 1
j FOR

ENDFOR:
la $v0, LS
jr $ra
