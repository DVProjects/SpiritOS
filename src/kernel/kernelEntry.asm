section .text
    [bits 32]
    [extern kernel]
    xor eax, eax
    mov ebx, eax
    mov ecx, eax
    mov edx, eax
    mov esi, eax
    mov edi, eax

    call kernel
    jmp $
