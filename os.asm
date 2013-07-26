bits 64
osstart:
    mov edi, 0xb8000
    mov rcx, 500
    mov rax, 0x0020002000200020
    rep stosq ;black out screen
    hlt 
