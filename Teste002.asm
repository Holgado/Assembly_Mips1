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

main:		la $t0, CPF			
		li $t2, 0			
		li $t3, 44			
		la $t5, NUM			
		lw $t5, 0($t5)		
		
		
		la $t6, SIZE  			# Carregando para ser empilhado
		la $t7, ponto
		la $t8, traco
		la $t9, nova_linha
				
loop:		beq $t2, $t5, end
		mul $a0, $t2, $t3
		
		addiu $sp, $sp, -16		
		sw $t6, 0($sp)         	
		sw $t7, 4($sp)			
		sw $t8, 8($sp)			
		sw $t9, 12($sp)			
		
		
		jal imprime_cpf   		#Passa $ao como argumento
		
		addiu $t2, $t2, 1
		j loop

imprime_cpf:	lw $t3, 0($t0)
		move $t8, $a0
		lw $t6, 0($sp)
		li $t1, 0
		li $t4, 0
loop1:		beq $t1, $t6, voltamain
		sw $t3, 0($a0)
		sw $t3, 0($t0)
		addu $a0,$t8,$t4
		lw $t3, 0($a0)			#Qual o problema ?????
		move $t3, $a0 
		
		addiu $t0,$t0,4
		addiu $t1,$t1,1
		
		li $v0, 1
		syscall
		
		j loop1
voltamain:
		li $v0, 11
		lw $a0, 12($sp)      	#Nova linha
		syscall
		addiu $sp, $sp, 16
		jr $ra
print_um_ponto:
		li $v0, 1
		lw $a0, 4($sp)
		syscall
		j loop1
print_um_traco:
		li $v0, 1
		lw $a0, 8($sp)
		syscall
		j loop1
end:
	li $v0, 10
	syscall
	
		
