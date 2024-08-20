; Jéssica Correia
; Leonardo Goes
; Renilton Almeida

section .data
    primeira_mensagem: db "Escreva uma palavra", 10
primeira_mensagem_len: equ $ - primeira_mensagem

    segunda_mensagem: db "Não eh palindromo", 10
    segunda_mensagem_len: equ $ - segunda_mensagem

    terceria_mensagem: db "Eh palindromo", 10
    terceira_mensagem_len equ $ - terceria_mensagem

section .bss
    palavra: resb 100

section .text
global _start
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, primeira_mensagem
    mov rdx, primeira_mensagem_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, palavra
    mov rdx, 100
    syscall

    mov r10,rax
    dec r10
    mov byte [palavra + r10],'0'
    dec r10

    mov rcx, 0
    call .verificar

  
    mov rax, 1
    mov rdi, 1
    mov rsi, terceria_mensagem
    mov rdx, terceira_mensagem_len
    syscall


    mov rax, 60
    xor rdi, rdi
    syscall

.verificar:

  mov al, byte [palavra + rcx]
  mov dl, byte [palavra + r10]
  cmp al,dl
  jne .nao_eh_palindromo
  inc rcx
  dec r10  
  cmp rcx,r10
  jl .verificar
  ret
  


  .nao_eh_palindromo:

    mov rax, 1
    mov rdi, 1
    mov rsi, segunda_mensagem
    mov rdx, segunda_mensagem_len
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
