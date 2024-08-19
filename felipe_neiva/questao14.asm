; Felipe Neiva

section .data
    fmt_scanf db "%d", 0                ; Formato para ler um número inteiro
    fmt_scanf_double db "%lf", 0        ; Formato para ler um número de ponto flutuante
    fmt_printf_result db "Resultado: %lf", 10, 0
    menu db "Escolha a operacao: 1-Soma, 2-Subtracao, 3-Multiplicacao, 4-Divisao", 10, 0
    invalid_option db "Opcao invalida!", 10, 0

section .bss
    num1 resq 1
    num2 resq 1
    choice resd 1
    result resq 1

section .text
    extern printf, scanf
    global main

main:
    push rbp
    mov rbp, rsp

    ; Ler o primeiro número
    mov rdi, fmt_scanf_double
    lea rsi, [num1]
    call scanf

    ; Ler o segundo número
    mov rdi, fmt_scanf_double
    lea rsi, [num2]
    call scanf

    ; Mostrar menu de opções
    mov rdi, menu
    call printf

    ; Ler a escolha do usuário
    mov rdi, fmt_scanf
    lea rsi, [choice]
    call scanf

    ; Carregar os números em registradores
    movsd xmm0, [num1]
    movsd xmm1, [num2]

    ; Verificar a escolha do usuário
    mov eax, [choice]   ; Carregar a escolha do usuário em EAX

    cmp eax, 1
    je add
    cmp eax, 2
    je sub
    cmp eax, 3
    je mul
    cmp eax, 4
    je div

    ; Se a opção for inválida, mostrar mensagem de erro e sair
    mov rdi, invalid_option
    call printf
    jmp end

add:
    addsd xmm0, xmm1
    jmp print_result

sub:
    subsd xmm0, xmm1
    jmp print_result

mul:
    mulsd xmm0, xmm1
    jmp print_result

div:
    divsd xmm0, xmm1
    jmp print_result

print_result:
    ; Armazenar o resultado
    movsd [result], xmm0

    ; Imprimir o resultado
    mov rdi, fmt_printf_result
    mov rax, 1
    movsd xmm0, [result]
    call printf
    jmp end

end:
    leave
    ret