; Alunos:
; Adalberto Manoel do Bomfim Neto
; Gabriel Moreira Ferreira
; Heverton Silva dos Reis
; José Raimundo Alves dos Santos Júnior

section .data
    msg_prompt: db "Digite a quantidade de valores (N): ", 0
    msg_valor:  db "Digite um valor: ", 0
    msg_output: db "A soma dos dois maiores valores = %ld", 10, 0  ; Mensagem para imprimir a soma dos dois maiores
    format_int: db "%ld", 0

section .bss
    buffer_entrada: resq 1  ; Buffer para armazenar a quantidade N (64 bits)
    inteiro: resq 1         ; Buffer para armazenar um valor inteiro (64 bits)
    valores: resq 20        ; Buffer para armazenar até 20 valores (64 bits cada)
    maior1: resq 1          ; Buffer para armazenar o maior valor
    maior2: resq 1          ; Buffer para armazenar o segundo maior valor

section .text
    global main
    extern scanf, printf

main:
    ; Salva o estado dos registradores de base
    push rbp
    mov  rbp, rsp

    ; Exibe a mensagem "Digite a quantidade de valores (N): "
    lea  rdi, [msg_prompt]
    call printf

    ; Lê o valor de N e armazena em buffer_entrada
    lea  rsi, [buffer_entrada]
    lea  rdi, [format_int]
    call scanf

    ; Inicialização do contador (i = 0)
    xor  rbx, rbx            ; rbx será usado como contador (i)

loop_leitura:
    ; Verifica a condição (i < N)
    mov  rax, [buffer_entrada]
    cmp  rbx, rax            ; Compara o contador rbx com o valor de N
    jge  sair_loop           ; Se rbx >= N, sai do loop

    ; Prompt para o usuário inserir o valor
    lea  rdi, [msg_valor]
    call printf

    ; Lê o valor e armazena em inteiro (64 bits)
    lea  rsi, [inteiro]
    lea  rdi, [format_int]
    call scanf

    ; Move o valor lido (64 bits) para o buffer de valores
    mov  rax, [inteiro]      ; Carrega o valor de 64 bits de inteiro
    mov  [valores + rbx * 8], rax  ; Armazena o valor em valores[i] (64 bits)

    ; Incrementa o contador (i++)
    inc  rbx
    jmp  loop_leitura           ; Continua o loop

sair_loop:

    ; Inicializa maior1 e maior2 com valores mínimos
    mov qword [maior1], 0
    mov qword [maior2], 0

    ; Loop para encontrar os dois maiores valores
    xor  rbx, rbx            ; Reinicializa o contador (i)

encontrar_maiores:
    ; Verifica a condição (i < N)
    mov  rax, [buffer_entrada]
    cmp  rbx, rax            ; Compara o contador rbx com o valor de N
    jge  calc_soma            ; Se rbx >= N, vai para a soma

    ; Carrega o valor atual de valores[i]
    mov  rax, [valores + rbx * 8]

    ; Verifica se o valor atual é maior que o maior1
    cmp  rax, [maior1]
    jle  verificar_segundo        ; Se não for maior, verifica se é maior que maior2
    ; Atualiza maior1 e maior2
    mov  rdx, [maior1]       ; O antigo maior1 se torna o maior2
    mov  [maior2], rdx
    mov  [maior1], rax       ; Atualiza maior1 com o novo maior valor
    jmp  prox_valor

verificar_segundo:
    ; Verifica se o valor atual é maior que maior2
    cmp  rax, [maior2]
    jle  prox_valor          ; Se não for maior, continua para o próximo valor
    ; Atualiza maior2
    mov  [maior2], rax       ; Atualiza maior2 com o novo segundo maior valor

prox_valor:
    ; Incrementa o contador (i++)
    inc  rbx
    jmp  encontrar_maiores    ; Continua o loop

calc_soma:
    ; Calcula a soma dos dois maiores valores
    mov  rax, [maior1]
    add  rax, [maior2]

    ; Imprime a soma dos dois maiores valores
    mov  rsi, rax            ; Move a soma para rsi para ser usada em printf
    lea  rdi, [msg_output]
    call printf

    ; Saída normal do programa
    leave
    ret