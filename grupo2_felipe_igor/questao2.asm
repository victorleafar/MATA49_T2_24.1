; Dupla: Felipe Ma, Igor Nunes

bits 64

section .data
    msg db "Digite um número: ", 0
    len equ $ - msg
    result_msg db "O fatorial é: ", 0
    len_msg equ $ - result_msg

section .bss
    input resb 20
    num resq 1
    result resq 1
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start


_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 20
    syscall

    mov rsi, input          
    call _string_to_int      
    mov [num], rax   

    mov rcx, [num]
    mov rax, 1       

_Loop:
    ; Se 0 pular para _continuar, se n continuar a calcular fatorial
    cmp rcx, 0    

    je _continue 
    
    imul rax, rcx
    dec rcx
    jmp _Loop

    

_continue:
    mov [result], rax

    mov rax, 1             
    mov rdi, 1             
    mov rsi, result_msg    
    mov rdx, len_msg            
    syscall

    mov rax, [result]

    ; Imprimir resultado dps da result_msg
    call _printRAX

    mov rax, 60     
    xor rdi, rdi    
    syscall


_string_to_int:
    xor rax, rax            
    xor rbx, rbx            
    xor rcx, rcx            
    xor rdx, rdx            
_convert_loop:
    movzx rdx, byte [rsi + rcx] 
    cmp rdx, 10             
    je _done_convert        
    sub rdx, '0'            
    imul rax, rax, 10       
    add rax, rdx            
    inc rcx                 
    jmp _convert_loop       
_done_convert:
    ret      


_printRAX:
    mov rcx, digitSpace
    mov rbx, 10
    mov [rcx], rbx
    inc rcx
    mov [digitSpacePos], rcx

_printRAXLoop:
    mov rdx, 0
    mov rbx, 10
    div rbx
    push rax
    add rdx, 48

    mov rcx, [digitSpacePos]
    mov [rcx], dl
    inc rcx
    mov [digitSpacePos], rcx

    pop rax
    cmp rax, 0
    jne _printRAXLoop

_printRAXLoop2:
    mov rcx, [digitSpacePos]

    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall

    mov rcx, [digitSpacePos]
    dec rcx
    mov [digitSpacePos], rcx

    cmp rcx, digitSpace
    jge _printRAXLoop2

    ret