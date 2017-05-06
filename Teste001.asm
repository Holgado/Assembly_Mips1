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

main:		la $t0, NUM			#Não usar
		lw $t0, 0($t0)			#Não usar
		li $t2, 0			#Não usar
		li $t3, 44			#Não usar
		li $t5, 0 
		la $t1, CPF
		
		la $t1, SIZE  			# Carregando para ser empilhado
		la $t4, ponto
		la $t6, traco
		la $t7, nova_linha
				
loop:		beq $t2, $t0, end
		mul $a0, $t2, $t3
		
		addiu $sp, $sp, -16		#Empilha caracteres a serem imprimidos
		sw $t7, 0($sp)         		#nova_linha
		sw $t6, 4($sp)			#traco
		sw $t4, 8($sp)			#ponto
		sw $t1, 12($sp)			#SIZE = 11
		
		
		jal imprime_cpf   		#Passa $ao como argumento
		
		addiu $t2, $t2, 1
		j loop

imprime_cpf:
		lw $t1, 12($sp)		#t1 vale 11
		lw $t1, 0 ($t1)
		li $t4, 0		#Indice do imprime_cpf soma de 4 em 4
		li $t5, 0		#Contador de digitos 
		li $t6, 1
		li $s0, 8
		move $a0, $k1		
loop1:		beq $t5, $t1, voltamain
		xori $t8, $t5, 2
		xori $t9, $t5, 5
		xor  $t7, $t8, $t9	#Ve se t5 é igual a 2 ou 5 se V t7 recebe 1
		beq $t7, $t6, print_um_ponto
		beq $t5, $s0, print_um_traco
		addu $a0, $k1, $t4	
		addiu $t4, $t4, 4
		addiu $t5, $t5, 1
		li $v0, 1
		syscall			#Imprime o digito no qual é apontado por $t4
		j loop1
voltamain:
		addiu $sp, $sp, 16 	#Realoca espaço da memória
		li $v0, 4
		lw $a0, 0($sp)      	#Nova linha
		syscall
		jr $ra
print_um_ponto:
		li $v0, 1
		lw $a0, 8($sp)
		syscall
		j loop1
print_um_traco:
		li $v0, 1
		lw $a0, 4($sp)
		syscall
		j loop1
end:
	li $v0, 10
	syscall
	
		
