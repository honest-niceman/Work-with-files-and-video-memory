model small
.stack 100h
.386
.data
	path db 'vlasov.txt'
	temp db ? 
	descriptor dw 0
.code
start:	
	mov ax, @data
	mov ds, ax
	
	mov ah, 3dh
	mov al, 0
	mov dx, OFFSET path 
	int 21h

	mov descriptor, ax
	mov ah, 3Fh
	mov bx, descriptor
	mov dx, OFFSET temp
	int 21h

	mov ax, 03h
	int 10h 
	
	xor si,si
	xor di,di
	
	mov ax, 0B800h
	mov es, ax
	
	mov cx, 28
	cycle:
		mov al, temp[si]
		mov es: [di], al
		inc di
		mov ah, 010b
		mov es: [di], ah
		inc di
		inc si
		loop cycle
		
	mov ah,0
	int 16h
	mov ax, 4C00h
	int 21h
end start