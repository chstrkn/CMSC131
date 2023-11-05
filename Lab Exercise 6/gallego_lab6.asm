; Chester Ken Gallego

%include "asm_io.inc"

; Initialized data
segment .data
    prompt db "Enter a number to calculate its factorial: ", 0
    output db "! =  ", 0

; Uninitialized data
segment .bss
    number resd 1

; Code
segment .text
    global asm_main

asm_main:
    ; Setup
    enter 0,0
    pusha

    ; Ask the user for a number
    mov eax, prompt
    call print_string
    call read_int
    mov [number], eax

    ; Print the factorial of the number
    mov eax, [number]
    call print_int
    mov eax, output
    call print_string
    mov eax, [number]
    call factorial
    call print_int
    call print_nl

    ; Cleanup
    popa
    mov eax,0
    leave
    ret

; Calculates the factorial of the number in eax and stores it in eax
factorial:
    ; Initialize the result
    mov ebx, 1

    ; Initialize the loop counter
    mov ecx, 1

loop_start:
    ; Multiply the result by the loop counter and increment the counter until it equals the number
    cmp ecx, eax
    jg loop_end
    imul ebx, ecx
    inc ecx
    jmp loop_start

loop_end:
    ; Return the result
    mov eax, ebx
    ret
