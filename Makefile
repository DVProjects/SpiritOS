ASM_LIBS:=src/include/asm/
I386:=/usr/local/i686elfgcc/bin/i686-elf-

all: run

run: build
	qemu-system-i386 -monitor stdio "SpiritOS.bin"

build:
	nasm -I $(ASM_LIBS) "src/bootloader/stage1.asm" -f bin -o "built/boot_module.bin"
	
	nasm "src/kernel/empty.asm" -f bin -o "built/empty.bin"
	
	nasm "src/kernel/kernelEntry.asm" -f elf -o "built/kernelEntry.o"
	$(I386)gcc -ffreestanding -m32 -g -c "src/kernel/kernel.c" -o "built/kernel.o"
	$(I386)ld -o "built/kernel_module.bin" -Ttext 0x8000 "built/kernelEntry.o" "built/kernel.o" --oformat binary
	
	cat "built/boot_module.bin" "built/kernel_module.bin" > "built/short.bin"
	cat "built/short.bin" "built/empty.bin" > "SpiritOS.bin"

dump:
	objdump -D -mi386 -b binary "SpiritOS.bin" > "dump.txt"
	nvim "dump.txt"

clean:
	rm built/*.o
	rm built/*.bin
	rm "SpiritOS.bin"
	rm *.txt
