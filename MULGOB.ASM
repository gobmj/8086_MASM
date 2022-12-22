data segment
        num1 db ?
        num2 db ?
        sum db ?
        carry db ?
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
        CMP AL,09H
        JLE SKIP
        SUB AL,07H
        SKIP:MOV CL,04H
        ROL AL,CL
        MOV num1,AL
        MOV AH,01H
        INT 21H
        SUB AL,30H
        CMP AL,09H
        JLE SKIP1
        SUB AL,07H
        SKIP1:ADD num1,AL

        LEA DX,msg2
        MOV AH,09H
        INT 21H
        MOV AH,01H
        INT 21H
        SUB AL,30H
        CMP AL,09H
        JLE SKIP2
        SUB AL,07H
        SKIP2:MOV CL,04H
        ROL AL,CL
        MOV num2,AL
        MOV AH,01H
        INT 21H
        SUB AL,30H
        CMP AL,09H
        JLE SKIP3
        SUB AL,07H
        SKIP3:ADD num2,AL
        
        MOV carry,00H
        MOV AL,num1
        ADD AL,num2
        DAA
        JC SKIP4
        INC carry
        SKIP4:MOV sum,AL
        LEA DX,msg3
        MOV AH,09H
        INT 21H
        AND AL,0f0H
        ROL AL,CL
        ADD AL,30H
        CMP AL,39H
        JLE SKIP5
        ADD AL,07H
        SKIP5:MOV DL,AL
        MOV AH,02H
        INT 21H
        MOV AL,sum
        AND AL,0fH
        ADD AL,30H
        CMP AL,39H
        JLE SKIP6
        ADD AL,07H
        SKIP6:MOV DL,AL
        MOV AH,02H
        INT 21H
        MOV AH,4CH
        INT 21H

code ends
end START
