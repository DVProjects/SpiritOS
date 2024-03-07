BIOSenableA20:
	mov     ax,0x2403
	int     0x15
	jb      .end
	cmp     ah,0x00
	jnz     .end
 
	mov     ax,0x2402
	int     0x15
	jb      .end
	cmp     ah,0x00
	jnz     .end
	 
	cmp     al,0x01
	jz      .end

	mov     ax,0x2401
	int     0x15
	jb      .end
	cmp     ah,0x00
	jnz     .end   
	.end:
		ret
