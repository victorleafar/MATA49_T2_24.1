bits 64

global  _start

section .text
    global main
    extern scanf, printf

    main:
      push rbp
      mov rbp, rsp

    ; ------------ Mensagens Iniciais ------------
      mov rdi, mensagemInicial
      call printf
      
      mov rdi, novaLinha
      call printf
    
    ; ----------------- Print/Scan - Ponto 1 ------------------
    ; Exibe a mensagem solicitando a coordenada X e Y
    ; Lê o valor inserido pelo usuário e armazena na variável
      mov rdi, mensagemL1_X
      call printf

      mov rdi, scan
      lea rsi, [Lado1_X]
      call scanf
      
      mov rdi, mensagemL1_Y
      call printf
      
      mov rdi, scan
      lea rsi, [Lado1_Y]
      call scanf

      mov rdi, novaLinha
      call printf
    
    ; ---------------- Print/Scan - Ponto 2 ------------------
    ; Exibe a mensagem solicitando a coordenada X e Y
    ; Lê o valor inserido pelo usuário e armazena na variável
      mov rdi, mensagemL2_X
      call printf
      
      mov rdi, scan
      lea rsi, [Lado2_X]
      call scanf

      mov rdi, mensagemL2_Y
      call printf

      mov rdi, scan
      lea rsi, [Lado2_Y]
      call scanf

      mov rdi, novaLinha
      call printf
    
    ; ---------------- Print/Scan - Ponto 3 ------------------
    ; Exibe a mensagem solicitando a coordenada X e Y
    ; Lê o valor inserido pelo usuário e armazena na variável
      mov rdi, mensagemL3_X
      call printf
 
      mov rdi, scan
      lea rsi, [Lado3_X]
      call scanf

      mov rdi, mensagemL3_Y
      call printf

      mov rdi, scan
      lea rsi, [Lado3_Y]
      call scanf

      mov rdi, novaLinha
      call printf

    
    ; ------------- Chamada Funçoes -------------
      ;call .calcula_Lados          
      ;call .verifica_Triangulo

      

    ; ----------------- Função - Calcula Lados ----------------
    .calcula_Lados:
    ; Esta função calcula o comprimento dos três lados do triângulo utilizando as coordenadas 
    ; dos pontos.
    
    ; ---------------- Lado 1 -----------------
      movq xmm0,[Lado2_X]
      movq xmm2,[Lado1_X]
      subsd xmm0, xmm2              ; Subtrai as coordenadas X
      mulsd xmm0, xmm0              ; Eleva ao quadrado

      movq xmm1,[Lado2_Y]
      movq xmm2,[Lado1_Y]
      subsd xmm1, xmm2              ; Subtrai as coordenadas Y
      mulsd xmm1, xmm1              ; Eleva ao quadrado

      addsd xmm0, xmm1              ; Soma os quadrados das diferenças
      sqrtsd xmm0, xmm0             ; Raiz quadrada para obter a distância entre dois pontos
      movq [Lado1], xmm0            ; Salva valor do Lado na variável

      mov rdi, mensagemLado1        ; Imprime Valor do lado
      mov rax, 1
      call printf
      
      ; ----------------- Lado 2 ------------------
      movq xmm0, [Lado3_X]
      movq xmm2, [Lado2_X]
      subsd xmm0, xmm2              ; Subtrai as coordenadas X
      mulsd xmm0, xmm0              ; Eleva ao quadrado

      movq xmm1, [Lado3_Y]
      movq xmm2, [Lado2_Y]
      subsd xmm1, xmm2              ; Subtrai as coordenadas Y
      mulsd xmm1, xmm1              ; Eleva ao quadrado

      addsd xmm0, xmm1              ; Soma os quadrados das diferenças
      sqrtsd xmm0, xmm0             ; Raiz quadrada para obter a distância entre dois pontos
      movq [Lado2], xmm0            ; Salva valor do Lado na variável

      mov rdi, mensagemLado2        ; Imprime Valor do lado
      mov rax, 1
      call printf
      
      ; ----------------- Lado 3 ------------------
      movq xmm0, [Lado3_X]
      movq xmm2, [Lado1_X]
      subsd xmm0, xmm2              ; Subtrai as coordenadas X
      mulsd xmm0, xmm0              ; Eleva ao quadrado

      movq xmm1, [Lado3_Y]
      movq xmm2, [Lado1_Y]
      subsd xmm1, xmm2              ; Subtrai as coordenadas Y
      mulsd xmm1, xmm1              ; Eleva ao quadrado

      addsd xmm0, xmm1              ; Soma os quadrados das diferenças
      sqrtsd xmm0, xmm0             ; Raiz quadrada para obter a distância entre dois pontos
      movq [Lado3], xmm0            ; Salva valor do Lado na variável

      mov rdi, mensagemLado3        ; Imprime Valor do lado
      mov rax, 1
      call printf
    

    ; ----------------- Função 1 ----------------
    .verifica_Triangulo:
    ; Compara os comprimentos dos lados para determinar o tipo de triângulo
    
    ; ------------ Comparação Lado1 - Lado2 -------------
      movq xmm0, [Lado1]
      movq xmm1, [Lado2]
      ucomisd xmm0, xmm1            ; Compara dois lados
      jne not_Equal1                ; Pula p/ not_Equal1 caso NÃO IGUAL
      
    ; ------------ Comparação Lado1 - Lado3 -------------
      movq xmm0, [Lado1]
      movq xmm1, [Lado3]
      ucomisd xmm0, xmm1            ; Compara dois lados
      jne Isosceles                 ; Pula p/ Isosceles caso NÃO IGUAL
      je Equilatero                 ; Pula p/ Equilátero caso IGUAL
  
      not_Equal1:
      ; ------------ Comparação Lado1 - Lado3 -------------
        movq xmm0, [Lado1]
        movq xmm1, [Lado3]
        ucomisd xmm0, xmm1           ; Compara dois lados
        jne not_Equal2               ; Pula p/ not_Equal1 caso NÃO IGUAL
        je Isosceles                 ; Pula p/ Isosceles caso IGUAL

      not_Equal2:
      ; ------------ Comparação Lado2 - Lado3 -------------
        movq xmm0, [Lado2]
        movq xmm1, [Lado3]
        ucomisd xmm0, xmm1           ; Compara dois lados
        jne Escaleno                 ; Pula p/ Escaleno caso NÃO IGUAL
        je Isosceles                 ; Pula p/ Isosceles caso IGUAL
        
      Escaleno:
        mov rdi, mensagemEscaleno    ; Imprime mensagem --> Triângulo Escalêno
        jmp fim
    
      Isosceles:
        mov rdi, mensagemIsosceles    ; Imprime mensagem --> Triângulo Isósceles
        jmp fim

      Equilatero:
        mov rdi, mensagemEquilatero   ; Imprime mensagem --> Triângulo Equilátero
        jmp fim

      fim:
        call printf
        jmp .saida
        

    .saida:
      leave
      ret


section .data
  ; ---------------- Mensagens -------------------
  mensagemInicial:   db "Classificação de Triângulos", 10, 0
  mensagemL1_X:      db "Digite a Coordenada X do 1º Ponto: ", 0
  mensagemL1_Y:      db "Digite a Coordenada Y do 1º Ponto: ", 0
  mensagemL2_X:      db "Digite a Coordenada X do 2º Ponto: ", 0
  mensagemL2_Y:      db "Digite a Coordenada Y do 2º Ponto: ", 0
  mensagemL3_X:      db "Digite a Coordenada X do 3º Ponto: ", 0
  mensagemL3_Y:      db "Digite a Coordenada Y do 3º Ponto: ", 0
  mensagemLado1:     db "Tamanho do Lado 1: %.2lf u", 10, 0
  mensagemLado2:     db "Tamanho do Lado 2: %.2lf u", 10, 0
  mensagemLado3:     db "Tamanho do Lado 3: %.2lf u", 10, 0
  mensagemEquilatero: db "O triângulo é Equilátero", 10, 0
  mensagemIsosceles:  db "O triângulo é Isósceles", 10, 0
  mensagemEscaleno:   db "O triângulo é Escaleno", 10, 0
  novaLinha:         db "---------------------------------------------", 10, 0

  ; --------------- Coleta Scanf -----------------
  scan:       dq "%lf"

  ; ---------------- Variáveis -------------------
  Lado1_X:         dq  0.0
  Lado1_Y:         dq  0.0
  Lado2_X:         dq  0.0
  Lado2_Y:         dq  0.0
  Lado3_X:         dq  0.0
  Lado3_Y:         dq  0.0

  Lado1:           dq  0.0
  Lado2:           dq  0.0
  Lado3:           dq  0.0
