; Edilton Damasceno
; Kelmer Passos
; Mikelly Correia
; Ruan Cardoso

section .data
    raio_ou_diametro: db "Digite 0, caso deseje informar o raio do círculo, ou digite 1, caso deseje informar o diâmetro:", 0
    raio: db "Informe o raio:", 0
    diametro: db "Informe o diâmetro:", 0
    formato: db "%lf", 0
    formatoE: db "%ld", 0
    resultado: db "A área do círculo é: %lf", 0
    pi_value: dq 3.14
    two: dq 2.0

section .bss
    escolha: resb 1
    value_raio: resq 1
    value_diametro: resq 1
    area: resq 1

section .text
    global main
    extern printf, scanf

main:

    push rbp
    mov rbp, rsp

    ;------------------- DEFINE MACRO -----------------
    %macro areaR 0
        movsd xmm0, [value_raio]  
        mulsd xmm0, xmm0           ; xmm0 = raio * raio
        movsd xmm1, [pi_value]     
        mulsd xmm0, xmm1           ; xmm0 = PI * raio^2
        movsd [area], xmm0         ; Armazena o resultado em area
    %endmacro

    %macro areaD 0
        movsd xmm0, [value_diametro] 
        divsd xmm0, [two]            ; xmm0 = diâmetro / 2
        mulsd xmm0, xmm0             ; xmm0 = (diâmetro/2) * (diâmetro/2)
        movsd xmm1, [pi_value]      
        mulsd xmm0, xmm1             ; xmm0 = PI * (diâmetro/2)^2
        movsd [area], xmm0           
    %endmacro

    ;------------------ PERGUNTA SE INFORMARÁ O RAIO OU O DIÂMETRO --------------

    mov rdi, raio_ou_diametro
    mov rax, 0
    call printf

    mov rdi, formatoE
    lea rsi, [escolha]
    mov rax, 0
    call scanf

    mov rax, [escolha]
    cmp rax, 1
    je pedeDiametro
    cmp rax, 0
    je pedeRaio


    ;------------------ SOLICITA O DIÂMETRO --------------
    pedeDiametro:
        mov rdi, diametro
        mov rax, 0
        call printf

        mov rdi, formato
        lea rsi, [value_diametro]
        mov rax, 0
        call scanf

        areaD    ;Chama a nossa macro que cálcula 
                 ;a área com o diâmetro informado pelo usuário
        jmp imprimeArea 
    
    ;------------------ SOLICITA O RAIO --------------
    pedeRaio:
        mov rdi, raio
        mov rax, 0
        call printf

        mov rdi, formato
        lea rsi, [value_raio]
        mov rax, 0
        call scanf

        areaR     ;Chama a nossa macro que cálcula
                  ; a área com o raio já informado pelo usuário

    

    imprimeArea:
        mov rdi, resultado
        mov rax, 1             
        movsd xmm0, [area]       
        call printf

    fim:
        leave
        ret
