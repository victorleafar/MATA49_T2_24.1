/* Questao 8 - Trabalho final Programaçåo de software Basico

Grupo: 
Antonio Augusto Menezes de Oliveira
Joao Victor de Araujo Santana Bomfim
Victor Rafael Martinez Carmona
*/ 

section .data
    prompt_len db "Tamanho do vetor: ", 0
    prompt_values db "Insira os valores do vetor: ", 0
    input_num db "%d", 0
    crescent_msg db "Vetor ordenado (crescente): ", 0xA, 0
    decrescent_msg db "Vetor ordenado (decrescente): ", 0xA, 0

section .bss
    n resq 1               
    vetor resd 100         

section .text
    global main
    extern printf, scanf

main:
    ; Imprimir o prompt para o tamanho do vetor
    mov rdi, prompt_len     
    xor rax, rax           
    call printf

    ; Ler o tamanho do vetor
    mov rsi, n               
    mov rdi, input_num       
    xor rax, rax             
    call scanf

    ; Verificar se o tamanho do vetor é válido (n > 0 e n <= 100)
    mov rax, [n]
    cmp rax, 0
    jle exit_program
    cmp rax, 100
    jg exit_program

    ; Imprimir o prompt para os valores do vetor
    mov rdi, prompt_values  
    xor rax, rax           
    call printf

    ; Ler os elementos do vetor
    xor rcx, rcx             
read_loop:
    lea rsi, [vetor + rcx*4] 
    mov rdi, input_num       
    xor rax, rax             
    call scanf
    add rcx, 1               
    cmp rcx, rax             
    jl read_loop

    ; Ordenar o vetor em ordem crescente
    mov rdi, [n]             
    call sort_ascending

    ; Exibir o vetor ordenado (crescente)
    mov rdi, crescent_msg
    xor rax, rax             
    call printf
    call print_array

    ; Ordenar o vetor em ordem decrescente
    mov rdi, [n]            
    call sort_descending

    ; Exibir o vetor ordenado (decrescente)
    mov rdi, decrescent_msg
    xor rax, rax           
    call printf
    call print_array

exit_program:
    ; Sair do programa
    mov rax, 60              
    xor rdi, rdi             
    syscall

; Função para imprimir o vetor
print_array:
    xor rcx, rcx            
print_array_loop:
    lea rsi, [vetor + rcx*4] 
    mov rax, [rsi]          
    mov rdi, input_num      
    xor rax, rax             
    call printf
    add rcx, 1              
    cmp rcx, [n]            
    jl print_array_loop
    ret

; Função para ordenar em ordem crescente (Bubble Sort)
sort_ascending:
    mov rbx, [n]            
    dec rbx                 
sort_outer_loop:
    xor rcx, rcx          
sort_inner_loop:
    lea rsi, [vetor + rcx*4] 
    mov rax, [rsi]          
    mov rdx, [rsi + 4]      
    cmp rax, rdx            
    jle no_swap           
    mov [rsi], rdx          
    mov [rsi + 4], rax
no_swap:
    add rcx, 1              
    cmp rcx, rbx            
    jl sort_inner_loop
    dec rbx                 
    jnz sort_outer_loop     
    ret

; Função para ordenar em ordem decrescente (Bubble Sort)
sort_descending:
    mov rbx, [n]            
    dec rbx                 
sort_outer_loop_desc:
    xor rcx, rcx            
sort_inner_loop_desc:
    lea rsi, [vetor + rcx*4] 
    mov rax, [rsi]          
    mov rdx, [rsi + 4]     
    cmp rax, rdx            
    jge no_swap_desc        
    mov [rsi], rdx          
    mov [rsi + 4], rax
no_swap_desc:
    add rcx, 1              
    cmp rcx, rbx           
    jl sort_inner_loop_desc
    dec rbx                 
    jnz sort_outer_loop_desc 
    ret
