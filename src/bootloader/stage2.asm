%include "GDT.inc"
%include "testA20.inc"
%include "BIOSenableA20.inc"

KERNEL_LOC equ 0x8000

stage2:
	mov si, BOOT_STAGE2
	call BIOSprintS
	call checkA20		;call A20 activation protocol
	call BIOSprintS
	test ax, ax		;check if a20 wasnt enabled
	je .end

	BIOScls

	lgdt [GDTdescriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp CODE_SEG:main32
	.end:
		hlt

checkA20:
	mov si, A20_ACTIVE	;check if active by system default
	call testA20
	cmp ax, 0x1
	je .end

	call BIOSenableA20	;try activating using BIOS
	call testA20
	cmp ax, 0x1
	je .end
	
	in al, 0x92		;try using fast method
	or al, 2
	out 0x92, al
	call testA20
	cmp ax, 0x1
	je .end

	mov si, A20_DISABLED
	.end:
		ret

[bits 32]
main32:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	mov ebp, 0x90000		; 32 bit stack base pointer
	mov esp, ebp
	jmp KERNEL_LOC


BOOT_STAGE2:db "Loaded 2nd stage...",0xD,0xA,0
A20_ACTIVE:db "A20 line activated...",0xD,0xA,0
A20_DISABLED:db "A20 line is not activated...",0xD,0xA,0

times 1024-($-$$) db 0; fill rest of 2nd sector with 0s
