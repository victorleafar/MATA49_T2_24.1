; Alunos:
; Adalberto Manoel do Bomfim Neto
; Gabriel Moreira Ferreira
; Heverton Silva dos Reis
; José Raimundo Alves dos Santos Júnior

section .data
    num1 dq 0
    num2 dq 0
    operation dq 0
    fmt db "%d", 0
    msg_num_1 db "Informe o primeiro numero: ", 0
    msg_num_2 db "Informe o segundo numero: ", 0
    msg_operation db "Escolha a operacao (1: Adição, 2: Subtração, 3: Multiplicação, 4: Divisão): ", 0
    msg_result db "O resultado é: ", 0
    msg_invalida db "Operação inválida",0

section .text
    global main
    extern printf, scanf

main:
    push rbp
    mov rbp, rsp

    ; Solicitar o primeiro número
    mov rdi, msg_num_1
    call printf
    mov rdi, fmt
    lea rsi, [num1]
    call scanf

    ; Solicitar o segundo número
    mov rdi, msg_num_2
    call printf
    mov rdi, fmt
    lea rsi, [num2]
    call scanf

    ; Solicitar a operação
    mov rdi, msg_operation
    call printf
    mov rdi, fmt
    lea rsi, [operation]
    call scanf

    ; Exibir mensagem de resultado
    mov rdi, msg_result
    call printf

    ; Realizar a operação escolhida
    mov rax, [operation]
    cmp rax, 1
    je addition
    cmp rax, 2
    je subtraction
    cmp rax, 3
    je multiplication
    cmp rax, 4
    je division
    jmp invalid_operation

addition:
    mov rax, [num1]
    add rax, [num2]
    jmp print_result

subtraction:
    mov rax, [num1]
    sub rax, [num2]
    jmp print_result

multiplication:
    mov rax, [num1]
    imul rax, [num2]
    jmp print_result

division:
    mov rax, [num1]
    xor rdx, rdx  ; limpar rdx antes da divisão
    div qword [num2]
    jmp print_result

invalid_operation:
    mov rdi, msg_invalida
    call printf
    jmp exit

print_result:
    mov rsi, rax
    mov rdi, fmt
    call printf

; Sair do programa
exit:
    leave
    ret