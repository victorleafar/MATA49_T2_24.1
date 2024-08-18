; MATA49 - T02 - Atividade Final
; Gabriel Sanches Prado 
; Igor Teixeira Passos Falcão
; Vilson Sampaio de Vasconcelos Neto
; nasm -f elf64 questao11.asm && gcc -o questao11 questao11.o -no-pie && ./questao11

global main
extern printf, scanf

section .data
    msg_eq:           db "Equilatéro", 10, 0
    msg_is:           db "Isosceles", 10, 0
    msg_es:           db "Escaleno", 10, 0
    l1Message:        db "Informe o lado 1 do triângulo: ", 0
    l2Message:        db "Informe o lado 2 do triângulo: ", 0
    l3Message:        db "Informe o lado 3 do triângulo: ", 0
    format:           db "%d", 0

section .bss
    l1:           resb 8
    l2:           resb 8
    l3:           resb 8

section .text     
  main: 
    push      rbp
    mov       rbp, rsp

    ; printing l1 message
    mov       rdi, qword l1Message
    call      printf

    ; reading l1
    mov       rdi, format
    mov       rsi, l1
    call      scanf

    ; printing l2 message
    mov       rdi, qword l2Message
    call      printf

    ; reading l2
    mov       rdi, format
    mov       rsi, l2
    call      scanf

    ; printing l3 message
    mov       rdi, qword l3Message
    call      printf

    ; reading l3
    mov       rdi, format
    mov       rsi, l3
    call      scanf
    
    mov       eax, [l1]
    mov       ebx, [l2]
    mov       ecx, [l3]

    cmp       eax, ebx
    je        check_isosceles
    jne       check_escaleno

    
    check_escaleno:
      cmp     eax, ecx
      je      print_isosceles
      cmp     ebx, ecx
      je      print_isosceles
      jmp     print_escaleno
      
    check_isosceles:
      cmp     eax, ecx
      je      print_equilatero
      jne     print_isosceles

    print_equilatero:
      mov     rdi, msg_eq
      call    printf
      
      jmp     exit
    
    print_isosceles:
      mov     rdi, msg_is
      call    printf
      
      jmp     exit
      
    print_escaleno:
      mov     rdi, msg_es
      call    printf
      
      jmp     exit

    exit:
      pop     rbp
      mov     rax, 0
      ret
