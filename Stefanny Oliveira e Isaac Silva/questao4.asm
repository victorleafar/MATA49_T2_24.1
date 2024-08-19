;Stefanny Oliveira
;Isaac Silva

;https://replit.com/@stefannyoliveira/Trabalho-Final#q4.asm

section .data
    formato_entrada: db "%d", 0
    formato_saida:   db "%d ", 0  
    vetor:           times 100 resd 0   
    
    mensagem:        db "Digite o tamanho do vetor:", 10, 0
    

section .bss
    espaço_vetor resd 1 
    tamanho resd 1

section .text
    global main
    extern scanf
    extern printf

main:
    push rbp
    mov rbp, rsp

    
    mov rdi, mensagem
    call printf

    
    mov rdi, formato_entrada
    mov rsi, tamanho
    call scanf

    
    mov rbx, 0

.loop:
    cmp rbx, [tamanho]
    je .end_loop 
    
   
    mov rdi, formato_entrada
    mov rsi, espaço_vetor
    call scanf
    
    ; Armazena o valor lido em vetor
    mov rax, [espaço_vetor]
    mov [vetor + rbx*4], rax  
    
    inc rbx
    jmp .loop

.end_loop:
   
    mov rbx, [tamanho]
    dec rbx  
    
.reverse_loop:
    test rbx, rbx
    js .end 
    
   
    mov rdi, formato_saida
    mov rsi, [vetor + rbx*4]  
    call printf
    
    dec rbx
    jmp .reverse_loop

.end:
    leave
    ret
