; Felipe Neiva

section .data
    fmt_scanf db "%lf", 0
    fmt_printf db "%s", 10, 0
    msg_equilatero db "O triangulo é equilatero", 0
    msg_isosceles db "O triangulo é isosceles", 0
    msg_escaleno db "O triangulo é escaleno", 0

section .bss
    l1 resq 1
    l2 resq 1
    l3 resq 1

section .text
    extern printf, scanf
    global main

main:
    push rbp
    mov rbp, rsp

    ; Receber o valor de l1
    mov rdi, fmt_scanf
    lea rsi, [l1]
    call scanf

    ; Receber o valor de l2
    mov rdi, fmt_scanf
    lea rsi, [l2]
    call scanf

    ; Receber o valor de l3
    mov rdi, fmt_scanf
    lea rsi, [l3]
    call scanf

    ; Comparação dos lados para determinar o tipo de triângulo
    mov rax, [l1]
    mov rbx, [l2]
    mov rcx, [l3]

    ; Verifica se todos os lados são iguais (Equilátero)
    cmp rax, rbx
    jne check_isosceles
    cmp rax, rcx
    jne check_isosceles

    ; Se os três lados forem iguais, o triângulo é Equilátero
    lea rdi, [msg_equilatero]
    call printf
    jmp end

check_isosceles:
    ; Verifica se pelo menos dois lados são iguais (Isósceles)
    cmp rax, rbx
    je isosceles
    cmp rax, rcx
    je isosceles
    cmp rbx, rcx
    je isosceles

    ; Se nenhum lado for igual, o triângulo é Escaleno
    lea rdi, [msg_escaleno]
    call printf
    jmp end

isosceles:
    ; Triângulo é Isósceles
    lea rdi, [msg_isosceles]
    call printf
    
end:
    leave
    ret
