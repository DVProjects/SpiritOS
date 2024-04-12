I686:=/usr/local/i686elfgcc/bin/i686-elf-
MODULES:=built/empty.bin built/boot.module built/kernel.module 
GCC_FLAGS:=-ffreestanding -m32 -g -c
KERNEL_HDIR:=src/include/kernel/
GCC_HDIR:=src/include/gcc/
ASM_IDIR:=src/include/asm/
GCC_OBJS:=$(patsubst %,built/%,$(foreach dir,$(wildcard $(GCC_HDIR)*/),$(foreach file,$(wildcard $(dir)*.c),$(patsubst $(dir)%.c,%.$(patsubst $(GCC_HDIR)%/,%,$(dir)).o,$(file))))) #gets full list of gcc object files, format: name.lib.o
KERNEL_OBJS:=$(patsubst $(KERNEL_HDIR)%.c,built/%.o,$(wildcard $(KERNEL_HDIR)*.c))

run: SpiritOS.bin
	qemu-system-i386 -monitor stdio $<

SpiritOS.bin: $(MODULES)
	cat "built/boot.module" "built/kernel.module" > "built/short.bin"
	cat "built/short.bin" "built/empty.bin" > $@
	
built/empty.bin: src/empty.asm
	nasm $< -f bin -o $@

built/boot.module: src/bootloader/*.asm $(ASM_IDIR)*.inc
	nasm -I $(ASM_IDIR) "src/bootloader/stage1.asm" -f bin -o $@

built/kernel.module: built/kernel_entry.o built/kernel.o $(KERNEL_OBJS) $(GCC_OBJS)
	$(I686)ld -o $@ -Ttext 0x8000 $^ --oformat binary

built/kernel.o: src/kernel/kernel.c
	$(I686)gcc -I $(KERNEL_HDIR) -I $(GCC_HDIR) $(GCC_FLAGS) $< -o $@

built/kernel_entry.o: src/kernel/kernel_entry.asm 
	nasm $< -f elf -o $@

built/%.string.o: $(GCC_HDIR)string/%.c $(GCC_HDIR)string.h
	$(I686)gcc -I $(GCC_HDIR) $(GCC_FLAGS) $< -o $@

built/%.stdlib.o: $(GCC_HDIR)stdlib/%.c $(GCC_HDIR)stdlib.h
	$(I686)gcc -I $(GCC_HDIR) -I $(KERNEL_HDIR) $(GCC_FLAGS) $< -o $@

built/%.o: $(KERNEL_HDIR)%.c $(KERNEL_HDIR)%.h
	$(I686)gcc -I $(KERNEL_HDIR) -I $(GCC_HDIR) $(GCC_FLAGS) $< -o $@
dump:
	objdump -D -mi386 -b binary "SpiritOS.bin" > "dump.txt"

clean:
	rm built/*
	rm "SpiritOS.bin"
