section .data
    prompt1 db "Digite o primeiro numero: ", 0
    prompt2 db "Digite o segundo numero: ", 0
    prompt_op db "Escolha a operacao (1: +, 2: -, 3: *, 4: /): ", 0
    result_msg db "Resultado: %d", 10, 0
    format db "%d", 0  ;

section .bss
    num1 resd 1
    num2 resd 1
    oper resd 1
    result resd 1

section .text
    extern printf, scanf
    global main

main:
    ; Set the stack frame
    push rbp
    mov rbp, rsp

    ; Mostrar o prompt e ler o primeiro número
    mov rdi, prompt1
    call printf
    mov rsi, num1
    mov rdi, format
    call scanf

    ; Mostrar o prompt e ler o segundo número
    mov rdi, prompt2
    call printf
    mov rsi, num2
    mov rdi, format
    call scanf

    ; Mostrar o prompt e ler a operação
    mov rdi, prompt_op
    call printf
    mov rsi, oper
    mov rdi, format
    call scanf

    ; Realizar a operação
    mov eax, [oper]
    cmp eax, 1
    je add_numbers
    cmp eax, 2
    je sub_numbers
    cmp eax, 3
    je mul_numbers
    cmp eax, 4
    je div_numbers

    ; Exibir resultado
    mov rdi, result_msg
    mov rsi, [result]
    mov rax, 0
    call printf

    ; Sair do programa
    mov rax, 60
    xor rdi, rdi
    syscall

add_numbers:
    mov eax, [num1]
    add eax, [num2]
    mov [result], eax
    jmp print_result

sub_numbers:
    mov eax, [num1]
    sub eax, [num2]
    mov [result], eax
    jmp print_result

mul_numbers:
    mov eax, [num1]
    imul eax, [num2]
    mov [result], eax
    jmp print_result

div_numbers:
    mov eax, [num1]
    cdq                ; Sign extend EAX into EDX:EAX for division
    idiv dword [num2]  ; Signed division of EDX:EAX by the value at num2
    mov [result], eax
    jmp print_result

print_result:
    mov rdi, result_msg
    mov rsi, [result]
    mov rax, 0
    call printf
    jmp _exit

_exit:
    pop rbp
    ret

section .note.GNU-stack
