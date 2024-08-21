section .data

    msg_option db "Escolha a opcao (1 - Raio, 2 - Diametro):", 0
    msg_radius db "Digite o raio: ", 0
    msg_invalid_option db "Opção invalida", 0
    msg_diameter db "Digite o diametro: ", 0
    msg_area db "A area do circulo e: %f", 10, 0
    format_int db "%d", 0
    format_float db "%lf", 0  ; "%lf" para double
    pi dq 3.141592653589793

section .bss
    option resd 1
    input_float resq 1  ; Espaço para double
    area resq 1  ; Espaço para double

section .text
    extern printf, scanf, exit
    global _start

_start:
    ; Exibe a mensagem de opção
    mov rdi, msg_option
    call printf

    ; Lê a opção do usuário
    mov rdi, format_int
    mov rsi, option
    call scanf

    ; Carrega a opção
    mov eax, [option]
    
    ; Verifica se a opção é 1 ou 2
    cmp eax, 1
    je read_radius
    cmp eax, 2
    je read_diameter
    
    ;caso não seja uma opção valida faz o print e sai do programa
    mov rdi, msg_invalid_option
    call printf

    jmp exit_fn

read_radius:
    ; Exibe a mensagem de entrada do raio
    mov rdi, msg_radius
    call printf

    ; Lê o valor do raio
    mov rdi, format_float
    mov rsi, input_float
    call scanf
    jmp calculate_area

read_diameter:
    ; Exibe a mensagem de entrada do diâmetro
    mov rdi, msg_diameter
    call printf

    ; Lê o valor do diâmetro
    mov rdi, format_float
    mov rsi, input_float
    call scanf

     ; Divide o diâmetro por 2 para obter o raio
    fld qword [input_float]  ; Carrega o diâmetro
    fld1                     ; Carrega o valor 1.0
    fld1                     ; Carrega o valor 1.0 novamente para divisão
    fadd                     ; 1 + 1 = 2 (prepara o divisor)
    fdiv                     ; (diâmetro / 2) = raio
    fstp qword [input_float] ; Armazena o raio em input_float

calculate_area:
    ; Calcula a área: pi * raio^2
    fld qword [input_float]
    fmul st0, st0          ; raio^2
    fld qword [pi]
    fmul st0, st1          ; pi * raio^2
    fstp qword [area]

    ; Exibe a área
    movsd xmm0, [area]
    mov rdi, msg_area
    call printf

exit_fn:
    ; Sair do programa
    mov rdi, 0
    call exit
