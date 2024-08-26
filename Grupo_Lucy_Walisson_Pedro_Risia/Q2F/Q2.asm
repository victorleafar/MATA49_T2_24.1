bits 64

section .data
    msg1 db "Digite um número positivo (max 20): ", 0
    num_fmt db "%lu", 0
    msg2 db "O fatorial de %lu é: %lu", 10, 0
    error_msg db "Erro: Entrada inválida. Por favor, digite um número inteiro positivo.", 10, 0
    large_input_msg db "Erro: Entrada muito grande. O máximo permitido é 20.", 10, 0

section .bss
    input resq 1

section .text
    global main
    extern printf, scanf

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov rdi, msg1
    xor rax, rax
    call printf
    
; ------- leitura do número digitado ---------------
    mov rdi, num_fmt
    mov rsi, input
    xor rax, rax
    call scanf
    
; ---- verifica se a entrada é válida, positiva e <= 20 ------
    cmp rax, 1
    jne .invalido_input     

    mov rax, [input]
    test rax, rax
    js .invalido_input       ; entrada é negativa
    cmp rax, 20
    ja .large_input          ; entrada é maior que 20
    
; ----- chamada da função fatorial com o número inserido -------
    mov rdi, rax
    call fatorial          

; ----- exibição do resultado ----------------------------------
    mov rdx, rax
    mov rsi, [input]
    mov rdi, msg2
    xor rax, rax
    call printf          

    jmp .end_program       

;------ codigo para entrada invalida ----------------------------
.invalido_input:           
    mov rdi, error_msg
    xor rax, rax
    call printf
    jmp .end_program
    
;------ codigo para entrada muito grande ------------------------
.large_input:
    mov rdi, large_input_msg
    xor rax, rax
    call printf

.end_program:
    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret

fatorial:
    push rbp
    mov rbp, rsp
    cmp rdi, 0
    jle .return_one      ; se o número for igual a 0 ou igual 1, retorna 1 
    push rdi             ; salva o valor atual na pilha    
    dec rdi              ; decrementa para a chamada recursiva  
    call fatorial        ; chamada recursiva da função com (n - 1) 
    pop rdi
    mul rdi              ; multiplica o resultado pelo valor original
    
.return_fatorial:
    mov rsp, rbp
    pop rbp
    ret
    
.return_one:
    mov rax, 1
    jmp .return_fatorial
    
section .note.GNU-stack noalloc noexec nowrite progbits
