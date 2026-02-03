; Multiboot 1 header — must be in first 8KB of the kernel, 4-byte aligned
section .multiboot
align 4
multiboot_header:
    dd 0x1BADB002              ; magic
    dd 0x00000003               ; flags: align modules, provide memory map
    dd -(0x1BADB002 + 0x00000003) ; checksum

; Entry point. Bootloader jumps here.
section .text
global _start
_start:
    mov esp, stack_top
    push eax                     ; multiboot magic
    push ebx                     ; multiboot info
    extern kernel_main
    call kernel_main
.hang:
    cli
    hlt
    jmp .hang

section .bss
align 16
stack_bottom:
    resb 16384                  ; 16 KB stack
stack_top:

section .note.GNU-stack noalloc noexec nowrite progbits
