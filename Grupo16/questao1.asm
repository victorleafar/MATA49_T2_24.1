;Equipe_16.
;Filipe dos Santos Freitas, João Gabriel Zeba de Souza.

;Questão1 - Escreva um programa em Assembly que calcule a área do círculo, o programa deve permitir ao usuário escolher se a entrada é o raio ou o diâmetro. Obs.: Utilizar ponto flutuante.


section .data
    selecao dq 0

    input db "%d", 0
    fmt db "%lf", 0
    prompt db "CALCULE A ÁREA. Vai digitar raio [1] ou diâmetro [2]?: ", 0
    prompt2 db "Digite o valor: ", 0
    final db "ÁREA do círculo: %.2f", 10, 0

    pi dq 3.14159265359
    valor dq 0.0
    dois dq 2.0
    area dq 0.0

section .text
    global main
    extern printf, scanf

    %macro area 2
        mulsd xmm0, xmm0
        mulsd xmm0, xmm1
        movsd [area], xmm0
    %endm

    main:
        push rbp
        mov rbp, rsp

        ; imprime primeira mensagem 
        mov rdi, prompt
        call printf
        mov rdi, input
        mov rsi, selecao
        call scanf

        ; imprime segunda mensagem 
        mov rdi, prompt2
        call printf
        mov rdi, fmt
        mov rsi, valor
        call scanf

        ; comparar com a seleção e ir para a subrotina correta
        mov rax, [selecao]
        cmp rax, 2
        je diametro_calculo

    raio_calculo:
        ; se raio -> area = (pi * r^2)
        movsd xmm0, [valor] ; xmm0 = r
        movsd xmm1, [pi]    ; xmm1 = pi
        area xmm0, xmm1
        jmp mostrar_area

    diametro_calculo:
        ; se diâmetro -> area = (pi * (d/2)^2)
        movsd xmm0, [valor] ; xmm0 = d
        movsd xmm1, [pi]    ; xmm1 = pi
        movsd xmm2, [dois]  ; xmm2 = 2
        divsd xmm0, xmm2    ; xmm2 = d/2
        area xmm0, xmm1

    mostrar_area:
        ; mostrar a área
        movsd xmm0, [area]
        mov rdi, final
        mov rax, 1          ; para impressão de ponto flutuante
        call printf

        leave
        ret
