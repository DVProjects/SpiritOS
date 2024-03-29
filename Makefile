I686:=/usr/local/i686elfgcc/bin/i686-elf-
MODULES:=built/empty.bin built/boot.module built/kernel.module 
GCC_FLAGS:=-ffreestanding -m32 -g -c
ASM_LIBS:=src/include/asm/
KERNEL_LIBS:=src/include/kernel/
GCC_LIBS:=src/include/gcc/

run: SpiritOS.bin
	qemu-system-i386 -monitor stdio $<

SpiritOS.bin: $(MODULES)
	cat "built/boot.module" "built/kernel.module" > "built/short.bin"
	cat "built/short.bin" "built/empty.bin" > $@
	
built/empty.bin: src/empty.asm
	nasm $< -f bin -o $@

built/boot.module: src/bootloader/*.asm $(ASM_LIBS)*.inc
	nasm -I $(ASM_LIBS) "src/bootloader/stage1.asm" -f bin -o $@

built/kernel.module: built/libgcc.o src/kernel/*
	nasm "src/kernel/kernelEntry.asm" -f elf -o "built/kernelEntry.o"
	$(I686)gcc -I $(KERNEL_LIBS) -I $(GCC_LIBS) $(GCC_FLAGS) "src/kernel/kernel.c" -o "built/kernel.o"
	$(I686)ld -o "built/kernel.module" -Ttext 0x8000 "built/kernelEntry.o" "built/kernel.o" "built/libgcc.o" --oformat binary

built/libgcc.o: $(GCC_LIBS)*
	$(I686)gcc -I $(GCC_LIBS) $(GCC_FLAGS) $(GCC_LIBS)*/*.c -o "built/libgcc.o"

dump:
	objdump -D -mi386 -b binary "SpiritOS.bin" > "dump.txt"

clean:
	rm built/*
	rm "SpiritOS.bin"
