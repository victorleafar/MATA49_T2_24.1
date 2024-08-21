bits 64
; Dupla: Guilherme Vitória e João Phillipe 

; Dados inicializados
section .data
    pergunta_numero:       db "Digite um número: ", 0
    resultado:             db "O fatorial de %d é: %d", 10, 0
    format:                db "%d", 0

section .bss
    numero resb 4
    factorial resq 1

; Onde Fica o Código
section .text
    global main
    extern printf, scanf

    main:
      ; Set the stack frame
      push rbp
      mov rbp, rsp

      mov rdi, pergunta_numero
      mov rax, 0
      call printf

      mov rdi, format
      mov rsi, numero
      mov rax, 0
      call scanf

      mov eax, [numero]
      mov ecx, eax
      mov rbx, 1

    calc_factorial:
      cmp ecx, 1
      jle end_factorial
      imul rbx, rbx, rcx
      dec ecx
      jmp calc_factorial

    end_factorial:
      ; Store the result in 'factorial'
      mov [factorial], rbx

      ; Print the result
      mov rdi, resultado
      mov esi, [numero]
      mov rdx, rbx
      xor rax, rax
      call printf


    exit:
        ; Reset the stack frame
        pop rbp
        ret

section .note.GNU-stack