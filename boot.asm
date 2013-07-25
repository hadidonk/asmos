bits 16
org 0x7C00
start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ah, 0x0E
    mov al, 0x21
    int 0x10 ;prints out ! to screen

reset:
    mov ah, 0
    mov dl, 0
    int 0x13
    jc  reset ;reset disk drives
    
    mov bx, 0x1000
    mov es, bx
    mov bx, 0x0000 ;read to 0x10000

read:
    mov ah, 0x02 ;read
    mov al, 0x10 ;no. sectors (512 b)
    mov ch, 0 ;cylinder 0
    mov cl, 2 ;sector 2 (currently are 1)
    mov dh, 0 ;head 0
    mov dl, 0x0 ;floppy 0
    int 0x13
    jc read ;read 512*10b from first floppy
    
    mov ax, 0x2401 ;A20 enable
    int 0x15

    mov ax,0x13 ;320x200@8b/p video mode
    int 0x10

    xor ax, ax
    mov ss, ax
    mov sp, start
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax ;setup registers

    cld
    mov edi, 0x9000
    jmp SwitchToLongMode
    
    cli
    hlt

%include "enterlong.asm"

    times 510-($-$$) db 0 ;pad to 512b = 1 sector
    dw 0xAA55 ;MBR signature
