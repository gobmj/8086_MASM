data segment
    str1 db 20 dup("$")
    str2 db 20 dup("$")
    msg1 db 10,13,"Enter First String: $"
    msg2 db 10,13,"Enter Second String: $"
    msg3 db 10,13,"The Concatenated String: $"
data ends

assume cs:code,ds:data

code segment 
start:

    MOV dx,data
    MOV ds,dx

    LEA dx,msg1
    MOV ah,09H
    INT 21H

    LEA si,STR1
    LOOP: MOV ah,01h
    INT 21H
    CMP al,13
    JE SKIP
    MOV [si],al
    INC si
    JMP LOOP

    SKIP: MOV ah,09H
    LEA dx,msg2
    INT 21H

    LEA si,STR2
    LOOP1: mov ah,01h
    INT 21H
    CMP al,13
    JE SKIP1
    MOV [si],al
    INC si
    JMP LOOP1

    SKIP1:CALL concat

    MOV ah,4ch
    INT 21H

concat proc near

    LEA si,str1
    LEA di,str2
    MOV al,'$'

    LOOP2: CMP al,[si]
        JZ LOOP3
        INC si
        JMP LOOP2
    LOOP3: CMP al,[di]
        JZ EXIT
        MOV bl,[di]
        MOV [si],bl
        INC si
        INC di
        JMP LOOP3
 	 
    EXIT:MOV [di],al
    LEA dx,msg3
    MOV ah,09H
    INT 21H
    LEA dx,str1
    MOV ah,09H
    INT 21H
    RET
   concat endp

code ends
end start
