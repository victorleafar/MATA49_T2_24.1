;Equipe_16.
;Filipe dos Santos Freitas, João Gabriel Zeba de Souza.

;Questão16 - Escreva um programa em Assembly que receba um número inteiro N e verifique se é um número de Armstrong (um número é um número de Armstrong se a soma dos seus dígitos elevados ;ao número de dígitos é igual ao próprio número). Imprima uma mensagem indicando se N é um número de Armstrong ou não.

section .data
    num dq 1             ; número para verificar
    fmt db "%d", 0
    prompt db "Digite um número a seguir: ", 0
    result_0 db "NÃO é número de amstrong!", 10, 0
    result_1 db "É número de amstrong!", 10, 0

section .bss

    count resq 1         ; contador de dígitos
    sum resq 1           ; soma dos dígitos elevados

section .text
    global main
    extern printf, scanf

    ; macro para potenciação
    %macro POW 3
        mov rdx, %1      ; base para multiplicação
        mov rcx, %2
        mov rbx, 1       ; resultado inicializado em 1

    .pow_loop:
        imul rbx, rdx    ; multiplica resultado (rbx) pela base (rdx)
        dec rcx          ; decrementa o expoente
        test rcx, rcx
        jnz .pow_loop    ; repete até que o expoente seja 0

        mov %3, rbx      ; armazena o resultado no registrador de resultado
    %endmacro

    main:
        push rbp
        mov rbp, rsp

        ; mensagem de prompt
        mov rdi, prompt
        call printf
        mov rdi, fmt
        mov rsi, num
        call scanf

        ; inicializa a soma e a contagem
        mov qword [sum], 0
        mov qword [count], 0

        ; realiza a contagem de dígitos
        mov rax, [num]
        mov rcx, 10
        digits_counting:
            xor rdx, rdx           ; zera rdx antes da divisão
            div rcx                ; divide rax por 10 (resultado em rax, resto em rdx)

            inc qword [count]      ; incrementa a contagem de dígitos

            test rax, rax          ; verifica se o quociente é zero
            jnz digits_counting    ; se não for zero, repete

        xor rax, rax
        xor rbx, rbx
        xor rcx, rcx
        xor rdx, rdx
        mov rax, [num]
        calculate_sum:
            cmp rax, 0
            je check_armstrong
            xor rdx, rdx
            mov rcx, 10
            div rcx

            xor rcx, rcx
            mov rcx, [count]
            POW rdx, rcx, rbx
            add qword [sum], rbx
            jmp calculate_sum

        check_armstrong:
            xor rax, rax
            xor rbx, rbx
            mov rax, [sum]
            mov rbx, [num]
            cmp rax, rbx
            jne not_armstrong

            ; se for um número de Armstrong
            mov rdi, result_1
            call printf
            jmp end_program

        not_armstrong:
            ; se não for um número de Armstrong
            mov rdi, result_0
            call printf

        end_program:
            leave
            ret
