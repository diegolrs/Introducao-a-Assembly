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
;Escreva um programa que implemente a seguinte senten�a da linguagem Java:
;a = b + c + 100;
;As vari�veis a, b e c s�o valores inteiros armazenados na mem�ria. O conte�do das vari�veis b e c
;dever�o ser inicializados com valores definidos por voc�.
;---------------------

.data
    _var_a dd 42
    _var_b dd 37

.code
start:
    XOR EAX, EAX ;EAX = 0
    ADD EAX, _var_a
    ADD EAX, _var_b
    ADD EAX, 100

    PUSH EAX
    printf("Resultado da soma: %d\n", EAX) ; printf faz uso do eax e ebx, por isso eh preciso salvar na pilha antes
    POP EAX

    invoke ExitProcess, 0
end start
