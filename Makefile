default:
	nasm -f bin boot.asm -o boot
	nasm -f bin os.asm -o os
	cat boot os > loader
	dd if=/dev/zero of=boot.img bs=1 count=1474560
	dd if=loader of=boot.img conv=notrunc
