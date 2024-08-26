section .data
    question1 db "Digite a posição inicial do intervalo: ", 0
    question2 db "Digite a posição final do intervalo: ", 0
    error_msg db "Intervalo inválido, a posição final deve ser maior que a inicial.", 10, 0
    result_msg db "Posição %d: %d", 10, 0
    scanf_fmt db "%d", 0

section .bss
    n1 resd 1            ; Posição inicial do intervalo
    n2 resd 1            ; Posição final do intervalo
    fib resd 1           ; Valor atual de Fibonacci
    prev resd 1          ; Valor anterior de Fibonacci
    temp resd 1          ; Variável temporária
    count resd 1         ; Contador para a posição atual na sequência

section .text
    global main
    extern printf, scanf

main:
    ; Setup do stack frame
    push rbp
    mov rbp, rsp

    ; Solicita a posição inicial do intervalo
    mov rdi, question1
    xor rax, rax
    call printf
    mov rdi, scanf_fmt
    mov rsi, n1
    xor rax, rax
    call scanf

    ; Solicita a posição final do intervalo
    mov rdi, question2
    xor rax, rax
    call printf
    mov rdi, scanf_fmt
    mov rsi, n2
    xor rax, rax
    call scanf

    ; Verifica se o intervalo é válido
    mov eax, [n1]
    mov ebx, [n2]
    cmp eax, ebx
    jge invalid_interval

    ; Inicializa a sequência de Fibonacci e o contador
    mov dword [fib], 1    ; fib = 1 (Posições 1 e 2 são 1)
    mov dword [prev], 1   ; prev = 1 (Para a posição 2)
    mov dword [count], 1  ; count = 1 (primeira posição)

fibonacci_loop:
    ; Verifica se o contador está dentro do intervalo [A, B]
    mov eax, [count]
    cmp eax, [n2]
    ja end_fibonacci_loop ; Se o contador for maior que n2, sair do loop

    ; Imprime os valores predefinidos para as posições 1 e 2, somente se dentro do intervalo
    cmp eax, 1
    je check_print
    cmp eax, 2
    je check_print

    ; Calcula o próximo número de Fibonacci (para posições >= 3)
    mov eax, [fib]
    add eax, [prev]
    mov [temp], eax       ; temp = fib + prev
    mov eax, [fib]
    mov [prev], eax       ; prev = fib
    mov eax, [temp]
    mov [fib], eax        ; fib = temp

check_print:
    ; Verifica se o contador está dentro do intervalo e imprime
    mov eax, [count]
    cmp eax, [n1]
    jl skip_print         ; Se o contador for menor que n1, não imprime

    ; Imprime o valor de Fibonacci e a posição atual
    mov rdi, result_msg
    mov esi, [count]      ; Posição atual
    mov edx, [fib]        ; Valor de Fibonacci na posição atual
    xor rax, rax
    call printf

skip_print:
    ; Incrementa o contador e continua o loop
    inc dword [count]
    jmp fibonacci_loop

invalid_interval:
    ; Imprime a mensagem de intervalo inválido
    mov rdi, error_msg
    xor rax, rax
    call printf

end_fibonacci_loop:
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
