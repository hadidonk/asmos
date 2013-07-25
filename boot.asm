bits 16
org 0x7C00
start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ah, 0x0E
    mov al, 0x21
    int 0x10

reset:
    mov ah, 0
    mov dl, 0
    int 0x13
    jc  reset
    
    mov bx, 0x1000
    mov es, bx
    mov bx, 0x0000

read:
    mov ah, 0x02
    mov al, 0x10 ;no. sectors (512 b)
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, 0x0
    int 0x13
    jc read
    
    mov ax, 0x2401 ;A20
    int 0x15

    mov ax,0x13 ;320x200@8b/p video mode
    int 0x10

    xor ax, ax
    mov ss, ax
    mov sp, start
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    cld
    mov edi, 0x9000
    jmp SwitchToLongMode
    
    cli
    hlt

%include "enterlong.asm"

    times 510-($-$$) db 0
    dw 0xAA55
