; Chester Ken Gallego

%include "asm_io.inc"

; Initialized data
segment .data
    prompt1 db "Enter a number: ", 0
    prompt2 db "Enter another number: ", 0
    output1 db " & ", 0
    output2 db " | ", 0
    output3 db " ^ ", 0
    output4 db " is ", 0

; Uninitialized data
segment .bss
    number1 resd 1
    number2 resd 1

; Code
segment .text
    global asm_main

asm_main:
    ; Setup
    enter 0,0
    pusha

    ; Ask the user for a number
    mov eax, prompt1
    call print_string
    call read_int
    mov [number1], eax

    ; Ask the user for another number
    mov eax, prompt2
    call print_string
    call read_int
    mov [number2], eax

    ; Perform the bitwise and operation on the two numbers
    mov eax, [number1]
    and eax, [number2]
    mov ebx, eax

    ; Print the result of the bitwise and operation
    mov eax, [number1]
    call print_int
    mov eax, output1
    call print_string
    mov eax, [number2]
    call print_int
    mov eax, output4
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    ; Perform the bitwise or operation on the two numbers
    mov eax, [number1]
    or eax, [number2]
    mov ebx, eax

    ; Print the result of the bitwise or operation
    mov eax, [number1]
    call print_int
    mov eax, output2
    call print_string
    mov eax, [number2]
    call print_int
    mov eax, output4
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    ; Perform the bitwise xor operation on the two numbers
    mov eax, [number1]
    xor eax, [number2]
    mov ebx, eax

    ; Print the result of the bitwise xor operation
    mov eax, [number1]
    call print_int
    mov eax, output3
    call print_string
    mov eax, [number2]
    call print_int
    mov eax, output4
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    ; Cleanup
    popa
    mov eax,0
    leave
    ret
