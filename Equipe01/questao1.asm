; MATA49 - T02 - Atividade Final
; Gabriel Sanches Prado 
; Igor Teixeira Passos Falcão
; Vilson Sampaio de Vasconcelos Neto
; nasm -f elf64 questao1.asm && gcc -o questao1 questao1.o -no-pie && ./questao1

global main
extern printf, scanf

section .data
    welcomeMessage:       db "Olá! Vamos calcular a área do círculo?", 10, 0
    inputTypeMessage:     db "Para começar, a entrada trata-se do diâmetro do círculo? (1 - Sim / 2 - Não) ", 0
    radiusMessage:        dq "Informe o raio: ", 0
    diameterMessage:      dq "Informe o diâmetro: ", 0
    areaMessage:          dq `Área: %lf \n`, 0
    inputFormat:          dq "%lf", 0
    PI:                   dq 3.1415
    TWO:                  dq 2.0
    inputTypeFormat:      db "%ld", 0

section .bss
    inputType:        resb 10
    radius:           resb 64
    area:             resb 64

section .text  
    getArea:
        ; calc area
        movq      xmm0, [radius]
        movq      xmm1, [PI]
        mulsd     xmm0, xmm0
        mulsd     xmm0, xmm1
        movq      [area], xmm0
    
        ; printing area
        mov       rdi, qword areaMessage
        movq      xmm0, [area]
        call      printf
    
        pop       rbp
        mov       rax, 0
        ret

    getRadius:
        ; printing radius message
        mov       rdi, qword radiusMessage
        call      printf

        ; reading radius
        mov       rdi, inputFormat
        mov       rsi, radius
        call      scanf

        jmp       getArea
    
    getDiameter:
        ; printing diameter message
        mov       rdi, qword diameterMessage
        call      printf

        ; reading diameter
        mov       rdi, inputFormat
        mov       rsi, radius
        call      scanf

        ; getting radius
        movq      xmm0, [radius]
        movq      xmm1, [TWO]
        divsd     xmm0, xmm1
        movq      [radius], xmm0

        jmp       getArea
    
    main: 
        push      rbp
        mov       rbp, rsp

        ; printing welcome message
        mov       rdi, qword welcomeMessage
        call      printf

        ; printing input type message
        mov       rdi, qword inputTypeMessage
        call      printf

        ; reading input type
        mov       rdi, inputTypeFormat
        mov       rsi, inputType
        call      scanf

        ; checking input type
        mov       rax, [inputType]
        cmp       rax, 1
        je        getDiameter
        jne       getRadius