; Chester Ken Gallego

%include "asm_io.inc"

; Initialized data
segment .data
    prompt db "Enter the two numbers: ", 0
    output1 db "The greatest common divisor of ", 0
    output2 db " and ", 0
    output3 db " is ", 0

; Uninitialized data
segment .bss
    input1 resd 1
    input2 resd 1

; Code
segment .text
    global asm_main

asm_main:
    ; Setup
    enter 0,0
    pusha

    ; Ask the user for the two numbers
    mov eax, prompt
    call print_string
    call read_int
    mov [input1], eax
    call read_int
    mov [input2], eax

    ; If the first number is zero, the greatest common divisor is the second number
    mov eax, [input1]
    mov ebx, [input2]
    cmp eax, 0
    je end

    ; If the second number is zero, the greatest common divisor is the first number
    mov eax, [input2]
    mov ebx, [input1]
    cmp eax, 0
    je end

    ; If the first number is greater than or equal to the second number, divide the first number by the second number
    mov eax, [input1]
    mov ebx, [input2]
    cmp eax, ebx
    jge divide

    ; Else, swap the two numbers and divide the first number by the second number
    mov ecx, eax
    mov eax, ebx
    mov ebx, ecx
    jmp divide

divide:
    ; Divide the two numbers
    mov edx, 0
    div ebx
    cmp edx, 0

    ; If the remainder is 0, the second number is the greatest common divisor
    je end

    ; Else, set the first number to the second number and the second number to the remainder
    mov eax, ebx
    mov ebx, edx
    jmp divide

end:
    ; Display the greatest common divisor
    mov eax, output1
    call print_string

    mov eax, [input1]
    call print_int

    mov eax, output2
    call print_string

    mov eax, [input2]
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
