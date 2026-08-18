bits 32

section .text
    global _main

_main:
	; get cpu vendor id (like "GenuineIntel")
	mov eax, 0
	cpuid

	mov edi, vendor_buffer	;target buffer for vendor name
	mov [edi], ebx		;first 4 chars
	mov [edi+4], edx	;next 4 chars (note: edx comes before ecx)
	mov [edi+8], ecx	;last 4 chars

	; get full cpu brand string
	mov edi, cpu_buffer	; switch edi to the main CPU brand buffer

	; call 0x80000002 (bytes 0-15)
	mov eax, 0x80000002
	cpuid
	mov [edi], eax
	mov [edi+4], ebx
	mov [edi+8], ecx
	mov [edi+12], edx
	add edi, 16

	; call 0x80000003
	mov eax, 0x80000003
	cpuid
	mov [edi], eax
    	mov [edi+4], ebx
    	mov [edi+8], ecx
    	mov [edi+12], edx
    	add edi, 16

	; call 0x80000004
    	mov eax, 0x80000004
    	cpuid
    	mov [edi], eax
    	mov [edi+4], ebx
    	mov [edi+8], ecx
    	mov [edi+12], edx

	; print vendor
	mov eax, 0x00100836
	push vendor_buffer
	call eax
	add esp, 4

	; print newline
	mov eax, 0x00100836
	push newline
	call eax
	add esp, 4

	; print CPU brand
	mov eax, 0x00100836
	push cpu_buffer
	call eax
	add esp, 4

	; print newline AGAIN because the Program returned thing >:(
	mov eax, 0x00100836
	push newline
	call eax
	add esp, 4

	; return or exec syscall
	; atp buffers are fully populated with hardware specs
	ret			; return to caller / exit _main

section .data
; pre-alloc buffers with null-terminators for C string compability (e.g., kprint)
vendor_buffer db "------------", 0
newline db 10, 0
cpu_buffer    db "------------------------------------------------", 0
