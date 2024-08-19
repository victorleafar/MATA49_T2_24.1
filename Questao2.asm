; Edilton Damasceno
; Kelmer Passos
; Mikelly Correia
; Ruan Cardoso

section .data
    msg: db "Digite um numero para saber o seu fatorial: ", 0
    fmt dq "%d"
    msg_fmt dq "Fatorial: %ld", 10, 0
    
section .bss
    resultado: resq 1
    num: resq 1

    section .text
        global main
        extern printf, scanf
        
        main:
        push rbp
        mov rbp, rsp
        
        mov rdi, msg
        mov rax, 0
        call printf
        
        mov rdi, fmt
        mov rsi, num
        mov rax, 0
        call scanf
        
        ; --- Loop de contagem ---
        mov rcx, [num] ; Define o contador (rcx) para o valor escolhido
        mov rax, 1 ; Inicializa a variável de contagem (rax) em 1
    
        loop_start:
        mul rcx
        dec rcx ; Decrementa o contador
        jnz loop_start ; Salta de volta para loop_start se rcx não for zero

        mov [resultado], rax    
    
        ; Resultado
        mov rdi, msg_fmt
        mov rsi, [resultado]
        mov rax, 0
        call printf

        leave
        ret