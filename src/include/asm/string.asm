stringLen:;needs string in si register
	push si
	mov dx, 0x00
	.loop:
	cmp byte [si], 0
	je .end
	inc dx
	inc si
	jmp .loop
	.end:
	pop si
	ret

stringCompare:;needs 2 strings in SI, DI
	call stringLen
	cmp cx, dx ;cx has command letters counter while dx has string len
	jne .end
	push cx
	repe cmpsb
	pop cx
	.end:
	ret
