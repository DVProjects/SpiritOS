stage2:
	mov si, BOOT_STAGE2
	call BIOSprintS
	hlt

BOOT_STAGE2:db "Loaded 2nd stage...",0xD,0xA,0
times 512 db 0
