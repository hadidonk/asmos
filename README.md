OS written entirely from scratch

64bit

run with qemu as follows:

    qemu-system-x86_64 -fda boot.img

boot.asm:
*   initial bootsector/loader.
*    skips first sector then reads 10 (8192 bytes) to 0x10000
*    enables A20
*    enables 320x200 8bits/pixel video mode
*    16 bit

enterlong.asm:
*   enters long mode from real, skipping protected
*   included into boot.asm
*   sets up IDT and GDT
*   jmps to 0x10000
*   16/64 bit

os.asm:
*   rest of the code
*   can currently be up to 8kb without edit to boot.asm
*   64 bit
