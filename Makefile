ASM_LIBS:=src/include/asm/

all: run

run: build
	qemu-system-i386 "SpiritOS.bin"

build:
	nasm -I $(ASM_LIBS) "src/bootloader/boot.asm" -f bin -o "built/boot_module.bin"
	cat built/*.bin > "SpiritOS.bin"

clean:
	rm built/*.bin
	rm "SpiritOS.bin"
	rm built/*.o
