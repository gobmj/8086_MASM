data segment
        num1 db ?
        num2 db ?
        sum db ?
        msg1 db 10,13,"Enter the 1st number$"
        msg2 db 10,13,"Enter the 2nd number$"
        msg3 db 10,13,"Sum is$"

data ends
code segment
ASSUME cs:code,ds:data

START:
        MOV AX,data
        MOV DS,AX
        LEA DX,msg1
        MOV AH,09H
        INT 21H
        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV num1,AL
        ROL CL,num1
        MOV AH,01H
        INT 21H
        ADD AL,CL
        MOV num1,AL

        LEA DX,msg2
        MOV AH,09H
        INT 21H
        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV num2,AL

        MOV AL,NUM1
        ADD AL,NUM2
        MOV AH,0
        AAA
        ADD AH,30H
        ADD AL,30H
        MOV BX,AX

        LEA DX,msg3
        MOV AH,09H
        INT 21H
        MOV AH,02H
        MOV DL,BH
        INT 21H
        MOV AH,02H
        MOV DL,BL
        INT 21H
        MOV AH,4CH
        INT 21H

code ends
end START



