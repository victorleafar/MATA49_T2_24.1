/* Questao 11 - Trabalho final Programaçåo de software Basico

Grupo: 
Antonio Augusto Menezes de Oliveira
Joao Victor de Araujo Santana Bomfim
Victor Rafael Martinez Carmona
*/ 

//Codigo

bits 64

section .data
    msg_input db "Digite o lado %d: ", 0
    msg_equilatero db "O triângulo é equilátero", 10, 0
    msg_isosceles db "O triângulo é isósceles", 10, 0
    msg_escaleno db "O triângulo é escaleno", 10, 0
    fmt_input db "%d", 0

section .bss
    l1 resd 1
    l2 resd 1
    l3 resd 1

section .text
    extern printf, scanf
    global _start

_start:
    ; Recebe o primeiro lado do triângulo
    mov rdi, msg_input
    mov rsi, 1
    call printf
    mov rdi, fmt_input
    mov rsi, l1
    call scanf

    ; Recebe o segundo lado do triângulo
    mov rdi, msg_input
    mov rsi, 2
    call printf
    mov rdi, fmt_input
    mov rsi, l2
    call scanf

    ; Recebe o terceiro lado do triângulo
    mov rdi, msg_input
    mov rsi, 3
    call printf
    mov rdi, fmt_input
    mov rsi, l3
    call scanf

    ; Carrega os valores dos lados
    mov eax, [l1]
    mov ebx, [l2]
    mov ecx, [l3]

    ; Verifica se é equilátero
    cmp eax, ebx
    jne check_isosceles
    cmp eax, ecx
    jne check_isosceles
    mov rdi, msg_equilatero
    call printf
    jmp end

check_isosceles:
    ; Verifica se é isósceles
    cmp eax, ebx
    je isosceles
    cmp eax, ecx
    je isosceles
    cmp ebx, ecx
    je isosceles
    jmp escaleno

isosceles:
    mov rdi, msg_isosceles
    call printf
    jmp end

escaleno:
    mov rdi, msg_escaleno
    call printf

end:
    ; Saída do programa
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; status: 0
    syscall
