.686
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm

;Escreva um programa que exiba na console os números entre 1000 e 1999 
;que divididos por 11 dão resto 5

.data
    _min_range dd 1000
    _max_range dd 1999

.code
start:
    MOV EBX, 11
    MOV EAX, _min_range

    _VERIFICA_DIVISAO:
        ;Realiza divisao por 11
        PUSH EAX
        XOR EDX, EDX; EDX = 0
        DIV EBX ; EAX/EBX
        CMP EDX, 5
        POP EAX
        
        JNE _INCREMENTAR_CONTADOR

        ;Printa numero divisivel
        
        PUSH EAX
        printf("%d ", EAX)
        POP EAX

    _INCREMENTAR_CONTADOR:
        INC EAX
        CMP EAX, _max_range
        JB _VERIFICA_DIVISAO

    invoke ExitProcess, 0

    
end start
