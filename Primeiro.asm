# --------------------------
# --      Trabalho 4      --
# --------------------------
# Aluno 1:Eric Friedrich	
# Aluno 2:Marcelo Holgado
# Aluno 3:Rafael Basso
# --------------------------
.data
  CPF:  .word 6 4 6 3 1 1 5 8 0 0 0 
              1 3 7 6 6 1 2 8 8 7 6 
              8 6 2 7 5 5 4 2 2 5 7 
              1 7 8 1 8 8 8 7 2 8 8 
              8 2 2 4 3 4 1 5 0 0 3 
              3 5 7 5 9 0 4 2 5 0 2 
              1 1 1 5 8 1 3 3 3 1 6 
              2 1 7 3 6 0 4 1 3 9 8 
              0 3 3 1 5 2 8 5 1 8 1 
              4 7 6 3 2 4 5 2 8 7 7 
              2 4 0 7 4 8 1 4 6 1 7 
              0 1 6 7 6 8 5 7 9 8 8 
              6 4 1 0 1 3 1 5 3 4 5 
              3 8 0 7 5 3 2 5 6 8 7
              4 1 2 2 2 4 9 3 6 8 3
  NUM:        .word 15
  SIZE:       .word 11
	ponto:      .asciiz "."
	traco:      .asciiz "-"
	nova_linha: .asciiz "\n"
	
.text                   
.globl  main

main:	li $t0, 0
	la $t1, $zero
	la $t2, $zero
	li $t3, 15
	li $t4, 44
	li $t7, 0     # Linha do cpf incrementa o cpf até 11
	lw $t5, NUM($0)
next:	beq $t0, $t3, end
	mul $t6, $t0, $t4
	addu $t6, $t6, $t7
	addiu $t6, $t6, 4
	lw $a0, 0($t6)
	lw $a1, 0($t6)
	jal dig_1          	#Passa como parametro $a0
	jal dig_2		#Passa como parametro $a1
	subi $t8, $a0, 2 	#Pega penultimo digito do CPF
	subi $t9, $a1, 1 	#Pega ultimo digito do CPF
	addiu $t0, $t0, 1
	addiu $t7, $t7, 1		
	xor $s0, $v0, $t8
	xor $s1, $v1, $t8
	beq $s0, $s1, imprime_cpf
	addiu $t0, $t0, 1
	bne $t7, 11, t7recebezero 
	addiu $t7, $t7, 1
	j next
end:	
	syscall
	j end
dig_1:




	jr $ra  	#Volta para quem chamou 
dig_2:




	jr $ra        #Volta para quem chamou  
imprime_cpf:
	la $t8, $zero	#zera $t8 para usar como coluna da matriz
	la $t9, ZISE
	lw $t9,0($t9)
	li $s2, 1
	li $s3, 8
	j loop1
loop1:
	beq $t8, $t9, volta_para_main 
	la $t2, CPF
	lb $t2, 0($t2)
	mul $v0, $a0, $t2 	#Aponta par a linha do cpf passado por $a0
	addu $v0,$v0,$t8	#Avança as colunas do cpf 
	syscall			#Imprime o numero do cpf apontado por t8  
	xori $t1, $v0, 2	#Se a posição no cpf for 2 ou 5 imprime um ponto 
	xori $s0, $v0, 5
	or $s1, $s0, $k1
	beq $s1,$s2, print_um_ponto
	beq $t8, $3, print_um_traco
	addiu	$t8,$t8,1 
	j loop1
print_um_ponto:
	la $s4, ponto
	lw $s4,0($s4)
	syscall
	j loop1
print_um_traco
	la $s4, traco
	lw $s4, 0($s4)
	syscall
	j loop1 
volta_para_main: jr $ra
	
	############################################
#Parte do main
t7recebezero:
	li $t7, 0
	j next
