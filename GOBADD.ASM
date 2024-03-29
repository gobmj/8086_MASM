data segment
        num1 DB ?
        num2 DB ?
        sum DB ?
        carry DB 00H
        msg1 DB 10,13,"Enter number 1: $"
        msg2 DB 10,13,"Enter number 2: $"
	msg3 DB 10,13,"The result is $"
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
	ADD al,num2
	DAA
	JNC skip3
	INC carry
	skip3:MOV sum,al	
	
	MOV ah,09H
        LEA dx,msg3
        INT 21H	
	
	MOV al,carry
	ADD al,30H
	CMP al,39H
	JLE skip8
	ADD al,07H
	skip8:MOV dl,al
	MOV ah,02H
	INT 21H

	LEA si,sum
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
 	skip:MOV cl,04H
	ROL al,cl
	MOV ch,al

	MOV ah,01H
	INT 21H
	SUB al,30H
	CMP al,09H
	JLE skip2
	SUB al,07H
	skip2:ADD al,ch
	RET
input endp

output proc near
	MOV al,[si]
	AND al,0f0H
	MOV cl,04H
	ROL al,cl
	ADD al,30H
	CMP al,39H
	JLE skip4
	ADD al,07H
	skip4:MOV dl,al
	MOV ah,02H
	INT 21H

	MOV al,[si]
	AND al,0fH
	ADD al,30H
	CMP al,39H
	JLE skip5
	ADD al,07H
	skip5:MOV dl,al
	MOV ah,02H
	INT 21H
	RET
output endp
  
code ends
end start
