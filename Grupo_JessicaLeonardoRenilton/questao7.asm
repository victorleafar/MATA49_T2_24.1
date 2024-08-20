; Jéssica Correia
; Leonardo Goes
; Renilton Almeida

bits 64

section .data
    item1 dq 0.0
    item2 dq 1.0
    PERGUNTAR_N1 db "Informe o primeiro número: ",0
    PERGUNTAR_N2 db "Informe o segundo número: ",0
    msg_final db "Fim", 0
    LER_NUM db "%lf",0 
    ESCREVER_ITEM_FIBONACCI db "item_fibonacci: %lf ",10

section .bss
    n1 resd 1
    n2 resd 1

section .text
global main
extern scanf, printf
    main:     
        push rbp
        mov rbp, rsp      

        mov rdi, PERGUNTAR_N2
        call printf
        mov rdi, LER_NUM
        mov rsi, n2
        call scanf        

        mov rax, 0
        mov rdi, PERGUNTAR_N1
        call printf
        mov rdi, LER_NUM
        mov rsi, n1
        call scanf

        mov r13, [n1]
        mov r14, [n2]
        mov r15, qword[item2]

    .loop:                     
          cmp r15, r14  
          jg .fim

          cmp r15, r13 
          jl .calcular     

            mov rdi, ESCREVER_ITEM_FIBONACCI
            movq xmm0, [item2]
            call printf  

            jmp .calcular
    .calcular:
            movq xmm3, [item2]
            movq xmm1, [item1]
            movq xmm2, [item2]
            addsd xmm1, xmm2

            movq [item2], xmm1
            movq [item1], xmm3
            mov r15, [item2]    
        jmp .loop
    .fim:
        mov rdi, msg_final
        call printf

    leave
    mov rax, 0
    ret