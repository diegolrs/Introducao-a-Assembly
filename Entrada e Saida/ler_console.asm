.686
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib 

;-------------------------------
;Escreva um programa que some 7 ao numero inserido
;-------------------------------

.data
inputString db 50 dup(0)
outputString db 50 dup(0)
inputHandle dd 0 ; Variavel para armazenar o handle de entrada
outputHandle dd 0 ; Variavel para armazenar o handle de saida
console_count dd 0 ; Variavel para armazenar caracteres lidos/escritos na console
tamanho_string dd 0 ; Variavel para armazenar tamanho de string terminada em 0
tamanho_out_string dd 0 ; Variavel para armazenar tamanho de string terminada em 0
integer1 dd 0

.code
start:
    ;CONFIGURANDO STREAMS -----
    INVOKE GetStdHandle, STD_INPUT_HANDLE
    MOV inputHandle, eax
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    MOV outputHandle, eax
    
    ;LENDO INPUT ----
    INVOKE ReadConsole, inputHandle, addr inputString, sizeof inputString, addr console_count, NULL
    INVOKE StrLen, addr inputString
    MOV tamanho_string, eax

    ;RETIRANDO CARRIAGE RETURN (CR, ENTER)
    mov esi, offset inputString; Armazenar apontador da string em esi
    proximo:
        mov al, [esi] ; Mover caracter atual para al
        inc esi ; Apontar para o proximo caracter
        cmp al, 48 ; Verificar se menor que ASCII 48 - FINALIZAR
        jl terminar
        cmp al, 58 ; Verificar se menor que ASCII 58 - CONTINUAR
        jl proximo
    terminar:
        dec esi ; Apontar para caracter anterior
        xor al, al ; 0 ou NULL
        mov [esi], al ; Inserir NULL logo apos o termino do numero

    INVOKE atodw, addr inputString
    MOV integer1, eax
    ADD integer1, 7
    MOV EAX, integer1
    INVOKE dwtoa, EAX, addr outputString
    INVOKE StrLen, addr outputString
    MOV tamanho_out_string, eax

    INVOKE WriteConsole, outputHandle, addr outputString, tamanho_out_string, addr console_count, NULL
    ;INVOKE WriteConsole, outputHandle, addr inputString, tamanho_string, addr console_count, NULL
    INVOKE ExitProcess, 0
end start