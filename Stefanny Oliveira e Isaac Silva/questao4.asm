;Stefanny Oliveira
;Isaac Silva

;https://replit.com/@IsaacBorges/vector?s=app

; Seção que inicializa os dados como as strings de formato
section .data
    formato_entrada: db "%d", 0 ; Formato de entrada como inteiro
    formato_saida:   db "%d ", 0 ; Formato de saída como inteiro
    vetor:           times 100 resd 0 ; Reserva de espaço para 100 inteiros

    mensagem:        db "Digite o tamanho do vetor:", 10, 0 ; Primeira mensagem de exibição

; Seção que define variáveis usadas no programa
section .bss
    espaço_vetor resd 1 ; Armazanaum valor inteiro temporariamente
    tamanho resd 1 ; Armazena o tamanho do vetor inserido

; Definição da função principal do programa
section .text
    global main ; Função principal
    extern scanf ; Leitura de dados
    extern printf ; Impressão de dados

; FUnção principal
main:
    ;COnfiguração da pilha, salvando e apontando o ponteiro
    push rbp
    mov rbp, rsp ; Define rbp coomo o rsb

    ; Printa a mensagem para o usuário
    mov rdi, mensagem
    call printf

    ; Recebe os valores de entrada do usuário para utilizar no codigo 
    mov rdi, formato_entrada
    mov rsi, tamanho
    call scanf

    ; Incializa o contador do loop futuro
    mov rbx, 0

; Início do loop de impressão
.loop:

    ; Comparação de rbx com o tamanho, se forem iguais então leu tudo 
    cmp rbx, [tamanho]
    je .end_loop 
    
    ; Recebe os valores do vetor temporariamente
    mov rdi, formato_entrada
    mov rsi, espaço_vetor
    call scanf
    

    ; Armazena o valor lido em vetor e multiplica pelo seu valor em bytes
    mov rax, [espaço_vetor]
    mov [vetor + rbx*4], rax  

    ; Incrementa contador e volta pro inicio
    inc rbx
    jmp .loop

; Preparação para imprimir vetor
.end_loop:

    mov rbx, [tamanho]
    dec rbx  

; Impressão reversa do vetor
.reverse_loop:
    test rbx, rbx
    js .end 

; IMpressão do vetor
    mov rdi, formato_saida
    mov rsi, [vetor + rbx*4]  
    call printf

; O loop continua até que rbx seja negativo
    dec rbx
    jmp .reverse_loop

; FIm do programa
.end:
    leave
    ret
