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

;---------------------
;Escreva um programa que leia uma constante numérica inteira e, em seguida, 
;escreva na tela se o número é par ou ímpar.
;---------------------

.data
    _constant dd 247

.code
start:
    ; O registrador EDX precisa estar zerado quando efetuar uma divisao, pois ele opera en 64 bits,
    ; mesmo que o processador seja de 32 bits. Zerando EDX os bits faltantes sao completados com zero
    XOR EDX, EDX ; EDX = 0

    MOV EAX, _constant
    MOV EBX, 2
    PUSH EAX
    DIV EBX ; EAX/EBX. Apos a operacao, EAX recebe o resultado e EDX o resto da divisao
    POP EAX

    CMP EDX, 0
    JE _EH_PAR
    printf("O Numero %d eh impar", EAX)
    JMP _END_PROGRAM

    _EH_PAR:
        printf("O Numero %d eh Par", EAX)
    
    _END_PROGRAM:
        invoke ExitProcess, 0
end start