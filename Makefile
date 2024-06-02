I686:=/usr/local/i686elfgcc/bin/i686-elf-
MODULES:=build/empty.bin build/boot.module build/kernel.module 
CFLAGS:=-ffreestanding -m32 -g -c
KERNEL_HDIR:=src/include/kernel/
GCC_HDIR:=src/include/gcc/
ASM_IDIR:=src/include/asm/
GCC_OBJS:=$(patsubst %,build/%,$(foreach dir,$(wildcard $(GCC_HDIR)*/),$(foreach file,$(wildcard $(dir)*.c),$(patsubst $(dir)%.c,%.$(patsubst $(GCC_HDIR)%/,%,$(dir)).o,$(file))))) #gets full list of gcc object files, format: name.lib.o
KERNEL_OBJS:=$(patsubst $(KERNEL_HDIR)%.c,build/%.o,$(wildcard $(KERNEL_HDIR)*.c))

run: SpiritOS.bin
	qemu-system-i386 -monitor stdio $<

SpiritOS.bin: $(MODULES)
	cat "build/boot.module" "build/kernel.module" > "build/short.bin"
	cat "build/short.bin" "build/empty.bin" > $@
	
build/empty.bin: src/empty.asm
	nasm $< -f bin -o $@

build/boot.module: src/bootloader/*.asm $(ASM_IDIR)*.inc
	nasm -I $(ASM_IDIR) "src/bootloader/stage1.asm" -f bin -o $@

build/kernel.module: build/kernel_entry.o build/kernel.o $(KERNEL_OBJS) $(GCC_OBJS)
	$(I686)ld -o $@ -Ttext 0x8000 $^ --oformat binary

build/kernel.o: src/kernel/kernel.c
	$(I686)gcc -I $(KERNEL_HDIR) -I $(GCC_HDIR) $(CFLAGS) $< -o $@

build/kernel_entry.o: src/kernel/kernel_entry.asm 
	nasm $< -f elf -o $@

build/%.string.o: $(GCC_HDIR)string/%.c $(GCC_HDIR)string.h
	$(I686)gcc -I $(GCC_HDIR) $(CFLAGS) $< -o $@

build/%.stdlib.o: $(GCC_HDIR)stdlib/%.c $(GCC_HDIR)stdlib.h
	$(I686)gcc -I $(GCC_HDIR) -I $(KERNEL_HDIR) $(CFLAGS) $< -o $@

build/%.stdio.o: $(GCC_HDIR)stdio/%.c $(GCC_HDIR)stdio.h
	$(I686)gcc -I $(GCC_HDIR) -I $(KERNEL_HDIR) $(CFLAGS) $< -o $@

build/%.o: $(KERNEL_HDIR)%.c $(KERNEL_HDIR)%.h
	$(I686)gcc -I $(KERNEL_HDIR) -I $(GCC_HDIR) $(CFLAGS) $< -o $@

dump:
	objdump -D -mi386 -b binary "SpiritOS.bin" > "dump.txt"

clean:
	rm build/*
	rm "SpiritOS.bin"
