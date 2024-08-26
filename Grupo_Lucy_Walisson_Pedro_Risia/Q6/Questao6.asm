section .data
    ; ---------------------- DEFINE FORMATOS ----------------------
    fmt_int db "%d", 0
    fmt_str db "%s", 0

    ; ---------------------- DEFINE MENSAGENS ----------------------
    msg_pedir_n db "Insira a quantidade de nomes: ", 0
    msg_pedir_nome db "Insira o nome %d: ", 0
    msg_nomes_ordenados db "Nomes ordenados por tamanho:", 10, 0
    msg_exibir_nome db "[%d] %s", 10, 0

    ; ----------------------- SALTO DE LINHO -----------------------
    salta_linha db 10, 0

section .bss
    ; ------------------------ RESERVA BYTES ------------------------
    num resd 1                  
    nomes resb 10000            
    temp_nome resb 100          

section .text
    extern printf, scanf
    global main

main:
    ; ---------------------- CONFIGURA STACK FRAME ----------------------
    push rbp
    mov rbp, rsp           

    ; ------------------ PEDE O VALOR DE "N" AO USUÁRIO ------------------
    mov rdi, fmt_str
    mov rsi, msg_pedir_n
    xor eax, eax
    call printf

    ; ------------------------- LÊ O VALOR DE "N" -------------------------
    mov rdi, fmt_int
    mov rsi, num
    xor eax, eax
    call scanf

    ; ---------------- INICIALIZA O CONTADOR DE NOMES LIDOS ----------------
    xor r12, r12                ; r12 = contador de nomes lidos

    ; ------------------- INICIALIZA O PONTEIRO DA PILHA -------------------
    mov r13, nomes              ; r13 = ponteiro para o próximo slot de nome

; ---------------------- FUNÇÃO PARA LEITURA DOS NOMES ----------------------
.ler_nomes:
    ; ------------------ VERIFICA SE O CONTADOR É MENOR QUE N ------------------
    mov eax, [num]
    cmp r12d, eax               ; Compara contador com número total de nomes
    jge .ordenacao          ; Se igual ou maior, termina a leitura

    ; ------------------------ PEDE O NOME AO USUÁRIO ------------------------
    mov rdi, msg_pedir_nome
    mov esi, r12d
    inc esi                     
    xor eax, eax
    call printf

    ; ------------------------- LÊ O NOME E ARMAZENA EM R13 -------------------------
    mov rdi, fmt_str
    mov rsi, r13               
    xor eax, eax
    call scanf

    ; ------- INCREMENTA R13 PARA APONTAR PARA A PRÓXIMA POSIÇÃO NA PILHA -------
    add r13, 100                ; Avança para o próximo slot de 100 bytes
    inc r12                     ; Incrementa o contador de nomes

    ; ----------------------------- VOLTA A ".LER_NOMES" -----------------------------
    jmp .ler_nomes

; ---------- APÓS LER TODOS OS NOMES, INICIA A ORDENAÇÃO (BUBBLE SORT) ----------
.ordenacao:
    ; ----------------------------- CONTADOR DA PASSAGEM 1 -----------------------------
    xor r12, r12                ; i = 0

; ----------------------------- INÍCIO DA PASSAGEM 1 -----------------------------
.primeira_passagem:
    ; ------------------ VERIFICA SE R12d É MAIOR OU IGUAL A NUM ------------------
    mov eax, [num]
    cmp r12d, eax          
    jge .fim_ordenacao        

    ; ------------------------- CONTADOR DA PASSAGEM 2 ----------------------------
    xor r13, r13                ; r13 = índice interno (j)
    
; ----------------------------- INÍCIO DA PASSAGEM 2 -----------------------------
.segunda_passagem:
    ; ------------ VERIFICA SE R13d É MAIOR OU IGUAL A (NUM - 1 - R12d) ------------
    mov eax, [num]
    sub eax, 1
    sub eax, r12d
    cmp r13d, eax              
    jge .fim_segunda_passagem        

    ; --------------------------- BUSCA O PRIMEIRO NOME ---------------------------
    mov rsi, nomes
    mov rax, r13
    imul rax, 100
    add rsi, rax
    
    ; --------------------- CALCULA O TAMANHO DO PRIMEIRO NOME ---------------------
    call strlen
    mov r14, rax             

    ; --------------------------- BUSCA O SEGUNDO NOME ---------------------------
    mov rsi, nomes
    mov rax, r13
    inc rax
    imul rax, 100
    add rsi, rax               
    
    ; --------------------- CALCULA O TAMANHO DO SEGUNDO NOME ---------------------
    call strlen
    mov r15, rax               

    ; ----------------------- COMPARA OS TAMANHOS DOS NOMES -----------------------
    cmp r14, r15
    
    ; SE O TAMANHO DO PRIMEIRO NOME FOR MENOR QUE O SEGUNDO, ELE PERMANECE NA MESMA POSIÇÃO 
    jle .menor              

    ; ----------------------- COMPARA OS TAMANHOS DOS NOMES -----------------------
    mov rcx, 100             
    
    ; ----------------------- BUSCA O PRIMEIRO NOME -----------------------
    mov rsi, nomes
    mov rax, r13
    imul rax, 100
    add rsi, rax

    ; ------------------- COPIA O PRIMEIRO NOME NO "TEMP_NOME" -------------------
    mov rdi, temp_nome
    call copiar_nome

    ; ------------------- COPIA O SEGUNDO NOME NA POSIÇÃO DO PRIMEIRO -------------------
    mov rsi, nomes
    mov rax, r13
    inc rax
    imul rax, 100
    add rsi, rax
    mov rdi, nomes
    mov rax, r13
    imul rax, 100
    add rdi, rax
    call copiar_nome

    ; ------- COPIA O "TEMP_NOME" (PRIMEIRO NOME) NA POSIÇÃO DO SEGUNDO NOME -----------
    mov rsi, temp_nome
    mov rdi, nomes
    mov rax, r13
    inc rax
    imul rax, 100
    add rdi, rax
    call copiar_nome

; ------- INCREMENTA O CONTADOR DA PASSAGEM 2 E SEGUE PARA A PRÓXIMA ITERAÇÃO -------
.menor:
    inc r13                 
    jmp .segunda_passagem

; ------- INCREMENTA O CONTADOR DA PASSAGEM 1 E SEGUE PARA A PRÓXIMA ITERAÇÃO -------
.fim_segunda_passagem:
    inc r12                   
    jmp .primeira_passagem

; ---------------------------- FIM DO BUBBLE SORT ----------------------------
.fim_ordenacao:
    ; --------------------- MENSAGEM PARA EXIBIR OS NOMES ---------------------
    mov rdi, fmt_str
    mov rsi, msg_nomes_ordenados
    xor eax, eax
    call printf
    ; ----------------------------- REINICIA O CONTADOR -----------------------------
    xor r12, r12                ; Reinicia contador para exibição

; --------------------- EXIBE OS NOMES ---------------------
.exibir_nomes:
    ; ----------------- VERIFICA SE O R12d É MAIOR OU IGUAL A NUM -----------------
    mov eax, [num]
    cmp r12d, eax             
    jge .fim                    

    ; ----------------- INCREMENTA ESI PARA EXIBIR A POSIÇÃO DOS NOMES -----------------
    mov rdi, msg_exibir_nome
    mov esi, r12d
    inc esi
    ; ----------------- CALCULA A POSIÇÃO DO NOME -----------------
    mov rdx, nomes
    mov rax, r12
    imul rax, 100
    add rdx, rax
    ; ----------------- REALIZA A IMPRESSÃO DO NOME -----------------
    mov eax, eax
    call printf

    ; ----------------- SEGUE PARA A PRÓXIMA ITERAÇÃO -----------------
    inc r12                    
    jmp .exibir_nomes

.fim:
    ; ----------------- FINALIZA A EXECUÇÃO DO CÓDIGO -----------------
    mov rsp, rbp
    pop rbp
    xor eax, eax
    ret

; ----------------- CALCULA O TAMANHO DA STRING -----------------
strlen:
    xor eax, eax                
.loop:
    cmp byte [rsi + rax], 0     
    je .done                    
    inc eax                     
    jmp .loop
.done:
    ret

; ----------------- COPIA OS NOMES DE UMA POSIÇÃO PARA OUTRA -----------------
copiar_nome:
    push rcx
    push rsi
    push rdi
    
; PERCORRE BYTE A BYTE DA POSIÇÃO ATUAL E DA POSIÇÃO DE DESTINO, MOVENDO OS CARACTERES
.loop_copia:
    mov al, [rsi]               
    mov [rdi], al               
    inc rsi
    inc rdi
    dec rcx                     
    jnz .loop_copia             
    pop rdi
    pop rsi
    pop rcx
    ret
