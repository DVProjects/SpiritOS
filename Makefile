ASM_LIBS:=src/include/asm/

all: run

run: build
	qemu-system-i386 -m 16M "SpiritOS.bin"

build:
	nasm -I $(ASM_LIBS) "src/bootloader/stage1.asm" -f bin -o "built/boot_module.bin"
	cat built/*.bin > "SpiritOS.bin"

dump:
	hexdump "SpiritOS.bin"

clean:
	rm built/*.bin
	rm "SpiritOS.bin"
	rm built/*.o
