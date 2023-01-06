data segment
        num1 DB ?
        num2 DB ?
        product DW ?
        msg1 DB 10,13,"Enter the First Number: $"
        msg2 DB 10,13,"Enter the Second Number: $"
	msg3 DB 10,13,"The Product is $"
data ends
code segment
        assume cs:code,ds:data
        start:
        MOV ax,data
        MOV ds,ax
        LEA dx,msg1
        MOV ah,09H
        INT 21H
        CALL input
        MOV num1,al
	MOV ah,09H
        LEA dx,msg2
	INT 21H
        CALL input
        MOV num2,al

	MOV al,num1
	MUL num2
	MOV product,ax
	MOV ah,09H
        LEA dx,msg3
        INT 21H

	LEA si,product
	CALL output
	MOV ah,4CH
	INT 21H

input proc near
	MOV ah,01H
	INT 21H
	SUB al,30H
	CMP al,09H
	JLE skip
	SUB al,07H
 	SKIP:mov cl,04H
	ROL al,cl
	MOV ch,al

	MOV ah,01H
	INT 21H
	SUB al,30H
	CMP al,09H
	JLE skip2
	SUB al,07H
	SKIP2:add al,ch
	RET
input endp
output proc near
	MOV ax,[si]
	AND ah,0f0H
	MOV cl,04H
	ROL ah,cl
	ADD ah,30H
	CMP ah,39H;changed...
	JLE skip4
	ADD ah,07H
	skip4:mov dl,ah
	MOV ah,02H
	INT 21H

	MOV ax,[si]
	AND ah,0fH;testing...
	ADD ah,30H
	CMP ah,39H;changed...
	JLE skip5
	ADD ah,07H
	skip5: mov dl,ah
	MOV ah,02H
	INT 21H

	MOV ax,[si]
	AND al,0f0H
	MOV cl,04H
	ROL al,cl
	ADD al,30H
	CMP al,39H
	JLE skip6
	ADD al,07H
	skip6: mov dl,al
	MOV ah,02H
	INT 21H

	MOV ax,[si]
	AND al,0fH
	ADD al,30H
	CMP al,39H
	JLE skip7
	ADD al,07H
	skip7:mov dl,al
	MOV ah,02H
	INT 21H
	RET
output endp
code ends
end start
