;Stefanny Oliveira
;Isaac Silva

section .data
    solicita_numero db "Digite um numero:", 10, 0
    formato1 db "%s", 0
    formato2 db "%d", 0
    formato3 db "O fatorial do seu numero eh %d", 10
    numero db 0

section .text
global main
extern printf, scanf

calcula_fatorial:
    mov rax, [numero]
    mov rdi, [numero]
    .loop:
        cmp rdi, 1
        je .end
        sub rdi, 1
        mul rdi
        jmp .loop
    .end:
        ret
main:
    push rbp
    mov rbp, rsp

    mov rdi, formato1
    mov rsi, solicita_numero
    call printf

    mov rdi, formato2
    mov rsi, numero
    call scanf

    call calcula_fatorial
    
    mov rdi, formato3
    mov rsi, rax
    call printf

    leave
    ret