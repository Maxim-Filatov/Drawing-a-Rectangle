; Построение прямоугольника на экране монитора
.286
.model tiny
.code

org 100h  

start:
			mov ax, 4F02h
			mov bx, 101h  	 	; video mode 640*480, 256 colors
			int 10h
	
			mov cx, word ptr [x1]
			mov si, word ptr [x2]
			mov di, word ptr [y2]

			mov dx, word ptr [y1]
			mov al, 0Eh					; yellow color
			call drawHorizontalLine
			
			mov dx, word ptr [y2]
			mov al, 09h					; light blue color
			call drawHorizontalLine
	
			mov dx, word ptr [y1]
			mov al, 0Ah					; light green color
			call drawVerticalLine
			
			mov cx, word ptr [x2]
			mov al, 0Ch					; light red color
			call drawVerticalLine

			mov ah, 01h	  		; ожидание нажатия на любую клавишу
			int 21h

			mov ax, 3h 	  		; text regime
			int 10h

			ret

; отображение точки
putPixel	proc near
			pusha
			; mov ax, 0C0Eh			; отобразить жёлтую точку 
			mov ah, 0Ch				; отобразить точку
			xor bh, bh
			int 10h					; отобразить точку линии (registers destroyed: AX, SP, BP, SI, DI)
			popa					; восстановить все регистры
			retn
putPixel	endp


; построение горизонтальной линии
drawHorizontalLine proc near
			push cx
@@nextHDot:	call putPixel
			inc cx
			cmp cx, si
			jbe @@nextHDot
			pop cx
			retn
drawHorizontalLine endp

; построение вертикальной линии
drawVerticalLine proc near
			push dx
@@nextVDot:	call putPixel
			inc dx
			cmp dx, di
			jbe @@nextVDot
			pop dx
			retn
drawVerticalLine endp

; задание констант
  x1 dw 60
  x2 dw 200
  y1 dw 40
  y2 dw 400 

end start
