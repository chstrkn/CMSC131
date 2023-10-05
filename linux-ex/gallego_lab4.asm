; Chester Ken Gallego

%include "asm_io.inc"

; Initialized data
segment .data
    prompt1 db "Enter a number: ", 0
    prompt2 db "Enter the number of places to shift: ", 0
    output1 db " << ", 0'
    output2 db " >> ", 0
    output3 db " is ", 0

; Uninitialized data
segment .bss
    number resd 1
    shift resd 1

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
    mov [number], eax

    ; Ask the user for the number of places to shift
    mov eax, prompt2
    call print_string
    call read_int
    mov [shift], eax

    ; Shift the number to the left
    mov cl, [shift]
    mov eax, [number]
    shl eax, cl
    mov ebx, eax

    ; Print the result of the shift left
    mov eax, [number]
    call print_int
    mov eax, output1
    call print_string
    mov eax, [shift]
    call print_int
    mov eax, output3
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    ; Shift the number to the right
    mov cl, [shift]
    mov eax, [number]
    shr eax, cl
    mov ebx, eax

    ; Print the result of the shift right
    mov eax, [number]
    call print_int
    mov eax, output2
    call print_string
    mov eax, [shift]
    call print_int
    mov eax, output3
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    ; Cleanup
    popa
    mov eax,0
    leave
    ret
