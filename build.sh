nasm -I src/include/asm "src/boot/boot.asm" -f bin -o "build/boot.bin" 
nasm -I src/include/asm "src/kernel/kernelEntry.asm" -f bin -o "build/kernel.bin"
nasm "src/include/asm/fileTable.asm" -f bin -o "build/fileTable.bin"
cat "build/boot.bin" "build/fileTable.bin" "build/kernel.bin" > "OS.bin"

