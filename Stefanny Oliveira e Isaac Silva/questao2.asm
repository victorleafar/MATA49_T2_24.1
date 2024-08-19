;Stefanny Oliveira
;Isaac Silva

;https://replit.com/@stefannyoliveira/Trabalho-Final#q2.asm

section .data
    solicita_numero db "Digite um numero:", 10, 0        ; String que solicita ao usuário para inserir um número
    formato1 db "%s", 0       ; Formato de string para printf
    formato2 db "%d", 0          ; Formato de número inteiro para scanf
    formato3 db "O fatorial do seu numero é %d", 10, 0   ; String de saída para mostrar o resultado do fatorial
    numero db 0        ; Espaço para armazenar o número inserido pelo usuário

section .text
global main
extern printf, scanf

calcula_fatorial:
    mov rax, [numero]   ; Carrega o valor do número em rax (que será usado para armazenar o resultado do fatorial)
    mov rdi, [numero]      ; Carrega o valor do número em rdi (que será usado para a multiplicação)
.loop:
    cmp rdi, 1 ; Compara rdi com 1
    je .end      ; Se rdi for igual a 1, sai do loop (termina o cálculo)
    sub rdi, 1      ; Subtrai 1 de rdi
    mul rdi         ; Multiplica rax (resultado parcial) por rdi (fator atual)
    jmp .loop    ; Repete o loop
.end:
    ret   ; Retorna ao chamador (o resultado estará em rax)

main:
    push rbp      ; Salva o valor de rbp na pilha
    mov rbp, rsp           ; Configura rbp para apontar para o topo da pilha

    mov rdi, formato1      ; Carrega o endereço de formato1 em rdi para ser usado como argumento do printf
    mov rsi, solicita_numero ; Carrega o endereço da string solicita_numero em rsi
    call printf   ; Chama printf para mostrar a mensagem "Digite um numero:"

    mov rdi, formato2      ; Carrega o endereço de formato2 em rdi para ser usado como argumento do scanf
    mov rsi, numero     ; Carrega o endereço da variável numero em rsi (onde scanf armazenará a entrada do usuário)
    call scanf       ; Chama scanf para ler o número digitado pelo usuário e armazená-lo em 'numero'

    call calcula_fatorial  ; Chama a função que calcula o fatorial do número

    mov rdi, formato3      ; Carrega o endereço de formato3 em rdi para ser usado como argumento do printf
    mov rsi, rax   ; Carrega o resultado do fatorial (armazenado em rax) em rsi
    call printf        ; Chama printf para mostrar o resultado do fatorial

    leave        ; Restaura o valor anterior de rbp e ajusta o ponteiro de pilha rsp
    ret       ; Retorna ao sistema operacional (finaliza o programa)
