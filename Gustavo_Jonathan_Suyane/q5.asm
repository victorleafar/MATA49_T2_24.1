bits 64

section   .data
    input_text: db "Digite o valor para calcular o collatz: ", 0
    format_in: db "%d", 0
    format_out: db "%d", 10, 0

section .bss
    buffer resq 1

%macro DIVIDE_BY_2 0
    ; Limpa registradores
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx

    ; Opera a divisão e salva em r8
    mov rax, r8
    mov rcx, 2
    div rcx
    mov r8, rax
%endmacro

%macro MULTIPLY_BY_3_ADD_1 0
    ; Limpa registradores
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx

    ; Multiplica por 3 e adiciona 1
    imul r8, 3
    add r8, 1
%endmacro

%macro PRINT_COME_BACK_LOOP 0
    mov [buffer], r8 ; Salva resposta no buffer
    
    ; Imprime valor obtido
    mov rdi, format_out
    mov rsi, r8
    call printf

    jmp loop ; Pula para loop
%endmacro

%macro CLEAN_REGISTERS 0
    ; Limpa registradores (Float point expection)
    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx
%endmacro

section .text
    global  main
    extern scanf, printf
    
main:
    sub rsp, 8 ; Ajusta pilha
    
read_value:
    ; Imprime texto de input
    mov rdi, input_text
    call printf
    
    ; Recolhe o input
    mov rdi, format_in
    mov rsi, buffer
    call scanf
    
loop:
    CLEAN_REGISTERS
    mov r8, [buffer] ; Trás da memória para o registrador
    
    cmp r8, 1 ; Checa se é 1
    je end ; Se for pule para o fim
    
    CLEAN_REGISTERS
    
    ; Realiza checagem se é par (resto de 2 igual a 0)
    mov rax, r8
    mov rcx, 2
    div rcx
    cmp rdx, 0
    
    je even ; Se for pule para even
    jmp odd ; Se não for pule para odd

odd:
    MULTIPLY_BY_3_ADD_1 ; Chama macro de multiplicação
    PRINT_COME_BACK_LOOP

even:
    DIVIDE_BY_2 ; Chama macro de divisão
    PRINT_COME_BACK_LOOP

end:
    add rsp, 8 ; Ajusta pilha

    ; Encerra com código 0
    mov       rax, 60
    xor       rdi, rdi
    syscall
