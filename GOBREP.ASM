data segment
    str1 db 20 dup("$")
    str2 db 20 dup("$")
    str3 db 20 dup("$")
    msg1 db 10,13,"Enter First String: $"
    msg2 db 10,13,"Enter character to be Changed: $"
    msg3 db 10,13,"Enter the replacement Character: $"
    msg4 db 10,13,"The Replaced String: $"
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
    LOOP1: MOV ah,01h
    INT 21H
    CMP al,13
    JE SKIP
    MOV [si],al
    INC si
    JMP LOOP1

    SKIP: MOV ah,09H
    LEA dx,msg2
    INT 21H

    LEA si,STR2
    LOOP2: mov ah,01h
    INT 21H
    CMP al,13
    JE SKIP1
    MOV [si],al
    INC si
    JMP LOOP2

	SKIP1: MOV ah,09H
    LEA dx,msg3
    INT 21H
	
	LEA si,STR3
    LOOP3: mov ah,01h
    INT 21H
    CMP al,13
    JE SKIP3
    MOV [si],al
    INC si
    JMP LOOP3
	
    SKIP3:CALL replace

    MOV ah,4ch
    INT 21H

replace proc near

    LEA si,str1
    MOV cl,str2
    MOV ch,str3
    MOV al,'$'

    LOOP4: CMP cl,[si]
    	JZ EXIT
        JE SKIP4
        INC si
        SKIP4: MOV [si],ch
        INC si
        JMP LOOP4
 	 
    EXIT:MOV [si],al
    LEA dx,msg4
    MOV ah,09H
    INT 21H
    LEA dx,str1
    MOV ah,09H
    INT 21H
    RET
   replace endp

code ends
end start
