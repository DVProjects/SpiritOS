I686:=/usr/local/i686elfgcc/bin/i686-elf-
MODULES:=built/empty.bin built/boot.module built/kernel.module 
ASM_HDIR:=src/include/asm/
KERNEL_HDIR:=src/include/kernel/
KERNEL_LIBS:= tty
KERNEL_OBJS:= $(foreach lib,$(KERNEL_LIBS),built/$(lib).o)
GCC_HDIR:=src/include/gcc/
GCC_LIBS:= string
GCC_OBJS:= $(foreach lib,$(GCC_LIBS),built/$(lib).o)
GCC_FLAGS:=-ffreestanding -m32 -g -c

run: SpiritOS.bin
	qemu-system-i386 -monitor stdio $<

SpiritOS.bin: $(MODULES)
	cat "built/boot.module" "built/kernel.module" > "built/short.bin"
	cat "built/short.bin" "built/empty.bin" > $@
	
built/empty.bin: src/empty.asm
	nasm $< -f bin -o $@

built/boot.module: src/bootloader/*.asm $(ASM_HDIR)*.inc
	nasm -I $(ASM_HDIR) "src/bootloader/stage1.asm" -f bin -o $@

built/kernel.module: built/kernel_entry.o built/kernel.o  $(KERNEL_OBJS) $(GCC_OBJS)
	$(I686)ld -o $@ -Ttext 0x8000 $^ --oformat binary

built/kernel.o: src/kernel/kernel.c
	$(I686)gcc -I $(KERNEL_HDIR) -I $(GCC_HDIR) $(GCC_FLAGS) "src/kernel/kernel.c" -o "built/kernel.o"

built/kernel_entry.o: src/kernel/kernel_entry.asm
	nasm $< -f elf -o $@


$(KERNEL_OBJS): $(KERNEL_HDIR)$(KERNEL_LIBS).c $(KERNEL_HDIR)$(KERNEL_LIBS).h
	$(I686)gcc -I $(GCC_HDIR) $(GCC_FLAGS) $< -o $@

$(GCC_OBJS):$(GCC_HDIR)$(GCC_LIBS).c $(GCC_HDIR)$(GCC_LIBS).h $(GCC_HDIR)$(GCC_LIBS)/*.c 
	$(I686)gcc $(GCC_FLAGS) $< -o $@

dump:
	objdump -D -mi386 -b binary "SpiritOS.bin" > "dump.txt"

clean:
	rm built/*
	rm "SpiritOS.bin"
