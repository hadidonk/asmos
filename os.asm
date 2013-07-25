bits 64
osstart:
    mov edi, 0xb8000
    mov rcx, 500
    mov rax, 0x0020002000200020
    rep stosq ;black out screen

    ;edi(coord) = 0xa0000 + 320*y + x
    ;al = color http://en.wikipedia.org/wiki/File:VGA_palette_with_black_borders.svg
    mov edi, 0xa0000
pix:
    mov al, 0x01
    mov [edi], al
    inc edi
    cmp edi,0xa0000+320*200
    jz end
    jmp pix
end:
    jmp $
