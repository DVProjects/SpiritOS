all: build

run: build
	qemu-system-i386 "SpiritOS.bin"

build:
	nasm "src/bootloader/boot.asm" -f bin -o "built/boot_module.bin"
	cat built/*.bin > "SpiritOS.bin"

clean:
	rm built/*.o
	rm built/*.bin
	rm "SpiritOS.bin"
