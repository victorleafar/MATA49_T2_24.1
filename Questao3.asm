; Edilton Damasceno
; Kelmer Passos
; Mikelly Correia
; Ruan Cardoso

section .data
    numero: db "Informe um número: ", 0
    msg_primo: db "O número informado é PRIMO!", 0xA, 0
    msg_naoPrimo: db "O número informado NÃO é PRIMO!", 0xA, 0
    formato: db "%d", 0

section .bss
    value: resq 1
    raiz: resq 1

section .text
    global main
    extern printf, scanf, sqrt

main:

    push rbp
    mov rbp, rsp

    ;------------------- DEFINE MACRO -----------------

    %macro DIVIDE_RESTO 2
    xor rdx, rdx       ; Limpa rdx para a divisão
    mov rax, %1        ; Coloca o numerador em rax
    div %2             ; Divide rax pelo divisor (rbx), resultado vai para rax, resto vai para rdx
    %endmacro

    ;------------------ SOLICITA O NÚMERO --------------
    mov rdi, numero
    mov rax, 0
    call printf

    mov rdi, formato
    lea rsi, [value]
    mov rax, 0
    call scanf

    ;---------------------- CALCULO -----------------------

    mov rax, [value]
    cmp rax, 1  ;1 não é primo
    jle naoPrimo 

    ; Calcula a raiz quadrada do número
    cvtsi2sd xmm0, rax ; Converte inteiro para float
    call sqrt ;fazer a macro
    cvttsd2si rax, xmm0 ; Converte o resultado de volta para inteiro
    mov [raiz], rax

    ; Inicialmente o divisor será 2 porque é o menor número primo
    mov rbx, 2     ; Nosso divisor

    comparaDivisor:
        cmp rbx, [raiz]
        jg primo    ; Se o divisor ultrapassar a raiz quadrada, o número é primo

        ; Chama a nossa macro para calcular o resto da divisão
        DIVIDE_RESTO [value], rbx
        cmp rdx, 0 
        je naoPrimo    ; Se o resto for igual a zero ele não é primo

        inc rbx
        jmp comparaDivisor

    naoPrimo:
        mov rdi, msg_naoPrimo
        xor rax, rax
        call printf
        jmp fim

    primo:
        mov rdi, msg_primo
        xor rax, rax
        call printf
        jmp fim

    fim:
        leave
        ret
