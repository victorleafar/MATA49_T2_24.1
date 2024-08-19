; Alunos:
; Adalberto Manoel do Bomfim Neto
; Gabriel Moreira Ferreira
; Heverton Silva dos Reis
; José Raimundo Alves dos Santos Júnior

bits 64

global  _start

section .data
  fmt dq "%lf"
  fmt2 dq "%d"
  medida dq 0
  escolha dq 0
  pi dq 3.141592

  divisor dq 4.0

  p_escolha: db "Digite 1 para raio e 2 para diâmetro:", 0x0A, 0
  p_raio: db "Informe o raio:", 0x0A, 0
  p_diametro: db "Informe o diâmetro:", 0x0A, 0
  msg_invalida: db "Escolha inválida",0
  resultado: db "A área do círculo é "

%macro ler 2; 
  mov rdi,%1
  mov rsi,%2
  call scanf
%endmacro

section .text
  global main
  extern printf, scanf

main:
  push rbp
  mov rbp, rsp

  mov rdi, p_escolha
  call printf

  ler fmt2, escolha;

  mov rax, [escolha]
  cmp rax, 1
  je raio
  cmp rax, 2
  je diametro
  jmp opcao_invalida

  raio:
    mov rdi, p_raio
    call printf
    ler fmt, medida;

    mov rdi, resultado
    call printf

    movq  xmm0, [medida]
    mulsd xmm0, [medida]
    mulsd xmm0, [pi]

    mov rdi, fmt
    call printf
    jmp exit

  diametro:
    mov rdi, p_diametro
    call printf
    ler fmt, medida;

    mov rdi, resultado
    call printf

    movq  xmm0, [medida]
    mulsd xmm0, [medida]
    mulsd xmm0, [pi]
    divsd xmm0, [divisor]

    mov rdi, fmt
    call printf
    jmp exit

  opcao_invalida:
    mov rdi, msg_invalida
    call printf

  exit:
    leave
    ret