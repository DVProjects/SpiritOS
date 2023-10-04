;needs sector number to load in CL
;needs memory location to load sector in BX
diskLoad:
    ;; READ FILE TABLE INTO MEMORY FIRST
    ;; set up ES:BX memory address/segment:offset to load sector(s) into
    mov bx, 0x1000              ; load sector to memory address 0x1000 
    mov es, bx                  
    mov bx, 0x0                 ; ES:BX = 0x1000:0x0

    ;; Set up disk read
    mov dh, 0x0                 ; head 0
    mov dl, 0x0                 ; drive 0
    mov ch, 0x0                 ; cylinder 0
    mov cl, 0x02                ; starting sector to read from disk

    mov ah, 0x02                ; BIOS int 13h/ah=2 read disk sectors
    mov al, 0x01                ; # of sectors to read
    int 0x13                    ; BIOS interrupts for disk functions

    jc diskLoad               ; retry if disk read error (carry flag set/ = 1)

kernelLoad:
    ;; READ KERNEL INTO MEMORY SECOND
    ;; set up ES:BX memory address/segment:offset to load sector(s) into
    mov bx, 0x2000              ; load sector to memory address 0x2000 
    mov es, bx                  
    mov bx, 0x0                 ; ES:BX = 0x2000:0x0

    ;; Set up disk read
    mov dh, 0x0                 ; head 0
    mov dl, 0x0                 ; drive 0
    mov ch, 0x0                 ; cylinder 0
    mov cl, 0x03                ; starting sector to read from disk

    mov ah, 0x02                ; BIOS int 13h/ah=2 read disk sectors
    mov al, 0x03                ; # of sectors to read
    int 0x13                    ; BIOS interrupts for disk functions

    jc kernelLoad               ; retry if disk read error (carry flag set/ = 1)

    ;; reset segment registers for RAM
    mov ax, 0x2000
    mov ds, ax                  ; data segment
    mov es, ax                  ; extra segment
    mov fs, ax                  ; ""
    mov gs, ax                  ; ""
    mov ss, ax                  ; stack segment

    jmp 0x2000:0x0              ; never return from this!dd
