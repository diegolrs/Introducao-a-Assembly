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
;Escreva um programa que leia duas constantes numéricas inteiras e imprima o maior dentre os dois
;números informados. Se os valores forem iguais, o programa pode 
;imprimir qualquer uma das variáveis.
;---------------------
.data
    _num1 dd 120
    _num2 dd 87

.code
start:
    _COMPARANDO:
        ;CMP _num1, _num2 ; nao eh possivel fazer mais de um acesso a memoria em uma unica instrucao em arquitetura intel
        MOV EAX, _num1
        CMP EAX, _num2
        JB _IMPRIME_NUM2

        PUSH EAX
        printf("Maior numero %d", EAX)
        POP EAX 
        JMP _END_PROGRAM
        
    _IMPRIME_NUM2:
        MOV EAX, _num2
        PUSH EAX
        printf("Maior numero %d", EAX)
        POP EAX
    _END_PROGRAM:
        invoke ExitProcess, 0
end start