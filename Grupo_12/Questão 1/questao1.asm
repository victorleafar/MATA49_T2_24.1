bits 64

global  _start

section .text
    global main
    extern scanf, printf

    main:
      push rbp
      mov rbp, rsp

      ; Mensagem inicial
      mov rdi, mensagemInicial
      call printf
      
      ; Solicita ao usuário escolher entre raio ou diâmetro
      mov rdi, mensagemEscolha
      call printf

      ; Recebe a escolha do usuário (1 para raio, 2 para diâmetro)
      mov rdi, scanInt
      lea rsi, [escolha]
      call scanf

      ; Verifica a escolha e coleta o valor apropriado
      mov eax, [escolha]
      cmp eax, 1
      je coleta_raio
      cmp eax, 2
      je coleta_diametro
      jmp invalido

    coleta_raio:
      ; Coleta o valor do raio
      mov rdi, mensagemRaio
      call printf
      mov rdi, scanFloat
      lea rsi, [valor]
      call scanf
      jmp calcula_area

    coleta_diametro:
      ; Coleta o valor do diâmetro e divide por 2 para obter o raio
      mov rdi, mensagemDiametro
      call printf
      mov rdi, scanFloat
      lea rsi, [valor]
      call scanf
      movq xmm0, [valor]
      divsd xmm0, [dois]
      movq [valor], xmm0
      jmp calcula_area

    calcula_area:
      ; Calcula a área: área = π * raio²
      movq xmm0, [valor]
      mulsd xmm0, xmm0          ; raio²
      mulsd xmm0, [pi]          ; π * raio²
      movq [area], xmm0

      ; Exibe o resultado
      mov rdi, mensagemArea
      mov rax, 1
      mov rsi, [area]
      call printf
      jmp fim

    invalido:
      ; Mensagem de erro para escolha inválida
      mov rdi, mensagemErro
      call printf
      jmp fim

    fim:
      leave
      ret

section .data
  ; Mensagens
  mensagemInicial db "Calculadora de Área do Círculo", 10, 0
  mensagemEscolha db "Escolha uma opção: 1 - Raio, 2 - Diâmetro: ", 0
  mensagemRaio db "Digite o valor do raio: ", 0
  mensagemDiametro db "Digite o valor do diâmetro: ", 0
  mensagemArea db "A área do círculo é: %.2lf", 10, 0
  mensagemErro db "Escolha inválida! Por favor, reinicie o programa.", 10, 0

  ; Variáveis
  scanInt db "%d", 0
  scanFloat db "%lf", 0
  pi dq 3.141592653589793
  dois dq 2.0

section .bss
  valor resq 1
  area resq 1
  escolha resd 1
