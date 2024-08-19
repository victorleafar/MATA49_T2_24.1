; Dupla: Felipe Ma, Igor Nunes

bits 64

section .data
    firstMessage: db "Digite 0 para usar o RAIO ou 1 para usar o DIÂMETRO: ", 0
    radiusMessage: db "Insira o RAIO: ", 0
    diameterMessage: db "Insira o DIÂMETRO: ", 0
    notFoundMessage: db "Opção inválida", 10, 0
    formatFloat: db "%lf", 0
    formatInt: db "%d", 0
    result: db "A área do círculo é: %f", 10, 0
    choice: db 10
    radius: dq 0.0
    diameter: dq 0.0
    pi: dq 3.141592
    divider: dq 2.0
    area: dq 0.0

section .text
	global main
	extern printf, scanf
	
	main:
        ; Set the stack frame
        push rbp
	    mov rbp, rsp

        ; Print the first message
        mov rdi, firstMessage
        mov rax, 0
        call printf
        
        ; Read the first height
        mov rdi, formatInt
        mov rsi, choice
        call scanf

        ; Check if the user wants to use the radius or the diameter
        cmp byte [choice], 0
        je .radius
        cmp byte [choice], 1
        je .diameter
        jmp .notFound

    .result:
        ; Print result
        mov rdi, result
        movq xmm0, [area]
        call printf
    
        ; Exit
    .exit:
        ; Reset the stack frame
        pop rbp
        ret

    .radius:
        ; Print the second message
        mov rdi, radiusMessage
        mov rax, 0
        call printf
        
        ; Read the radius
        mov rdi, formatFloat
        mov rsi, radius
        call scanf

        ; Calculate the area
        movq xmm0, [radius]
        movq xmm1, [radius]
        movq xmm2, [pi]
        mulsd xmm0, xmm1
        mulsd xmm0, xmm2
        movq [area], xmm0

        jmp .result

    .diameter:
        ; Print the second message
        mov rdi, diameterMessage
        mov rax, 0
        call printf
        
        ; Read the diameter
        mov rdi, formatFloat
        mov rsi, diameter
        call scanf

        ; Calculate the area
        movq xmm0, [diameter]
        movq xmm1, [divider]
        movq xmm2, [pi]
        divsd xmm0, xmm1
        movq xmm1, xmm0
        mulsd xmm0, xmm1
        mulsd xmm0, xmm2
        movq [area], xmm0

        jmp .result

    .notFound:
        ; Print the error message
        mov rdi, notFoundMessage
        mov rax, 0
        call printf

        jmp .exit