; Chester Ken Gallego

%include "asm_io.inc"

; Initialized data
segment .data
    prompt1 db "Enter a year: ", 0
    output1 db " is a leap year.", 0
    output2 db " is not a leap year.", 0

; Uninitialized data
segment .bss
    input1 resd 1

; Code
segment .text
    global asm_main

asm_main:
    ; Setup
    enter 0,0
    pusha

    ; Ask the user for a year
    mov eax, prompt1
    call print_string
    call read_int
    mov [input1], eax

    ; Check if the year is divisible by 4
    mov eax, [input1]
    mov ebx, 4
    mov edx, 0
    div ebx
    cmp edx, 0
    jne not_leap_year

    ; Check if the year is divisible by 100
    mov eax, [input1]
    mov ebx, 100
    mov edx, 0
    div ebx
    cmp edx, 0
    jne leap_year

    ; Check if the year is divisible by 400
    mov eax, [input1]
    mov ebx, 400
    mov edx, 0
    div ebx
    cmp edx, 0
    jne not_leap_year

    ; Jump to leap_year if the year is divisible by 4 and 400
    jmp leap_year

leap_year:
    mov eax, [input1]
    call print_int
    mov eax, output1
    call print_string
    call print_nl
    jmp end

not_leap_year:
    mov eax, [input1]
    call print_int
    mov eax, output2
    call print_string
    call print_nl
    jmp end

end:
    ; Cleanup
    popa
    mov eax,0
    leave
    ret
