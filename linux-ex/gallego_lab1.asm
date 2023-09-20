; Chester Ken Gallego

%include "asm_io.inc"

; Initialized data
segment .data
    problem db 'When the smallest of three consecutive odd integers is added to four times the largest, it produces a result 729 more than four times the middle integer. Find the numbers and check your answer.', 0
    answer db 'Answer: ', 0
    odd1msg db 'The first odd number is ', 0
    odd2msg db 'The second odd number is ', 0
    odd3msg db 'The third odd number is ', 0

; Uninitialized data
segment .bss
    odd1 resd 1
    odd2 resd 1
    odd3 resd 1

; Code
segment .text
    global asm_main

asm_main:
    ; Setup
    enter 0,0
    pusha

    ; Display the problem
    mov eax, problem
    call print_string
    call print_nl
    call print_nl

    ; Solve for the answer
    ; Let x be the first odd number
    ; Let y = x + 2 be the second odd number
    ; Let z = x + 4 be the third odd number
    ; x + 4z = 4y + 729
    ; x + 4(x + 4) = 4(x + 2) + 729
    ; x + 4(x + 4) - 4(x + 2) = 729
    ; x + 4x + 16 - 4x - 8 = 729
    ; x + 8 = 729
    ; x = 729 - 8
    ; x = 721
    ; y = x + 2 = 723
    ; z = x + 4 = 725
    mov eax, 729
    sub eax, 8
    mov [odd1], eax
    mov eax, [odd1]
    add eax, 2
    mov [odd2], eax
    mov eax, [odd1]
    add eax, 4
    mov [odd3], eax

    ; Display the answer
    mov eax, answer
    call print_string
    call print_nl

    ; Display the first odd number
    mov eax, odd1msg
    call print_string
    mov eax, [odd1]
    call print_int
    call print_nl

    ; Display the second odd number
    mov eax, odd2msg
    call print_string
    mov eax, [odd2]
    call print_int
    call print_nl

    ; Display the third odd number
    mov eax, odd3msg
    call print_string
    mov eax, [odd3]
    call print_int
    call print_nl

    ; Cleanup
    popa
    mov eax,0
    leave
    ret
