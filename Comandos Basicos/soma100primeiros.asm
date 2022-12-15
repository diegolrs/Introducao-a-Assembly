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

;-------------------------------
;Escreva um programa que calcule a soma dos 100 primeiros números inteiros positivos. 
;O resultado deverá ser armazenado no registrador eax e também deverá ser exibido na tela
;-------------------------------

.code
start:
    MOV EAX, 100
    MOV EBX, 100

    COMPARE:
    CMP EBX, 0
    JNE SUM100
    JMP END_PROGRAM

    SUM100:
    SUB EBX, 1 
    ADD EAX, EBX

    PUSH EAX
    PUSH EBX
    printf("Valor de eax agora: %d\n", EAX) ; printf faz uso do eax e ebx, por isso eh preciso salvar na pilha antes
    POP EBX
    POP EAX
    
    JMP COMPARE

    END_PROGRAM:
    printf("A entrada de dados foi %d\n", EAX)      
    invoke ExitProcess, 0
end start
