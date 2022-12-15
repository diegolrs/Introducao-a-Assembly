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

.data
    original_fileHandle dd 0H
    original_fileName db "original.txt", 0H
    original_readCount dd 0
    
    copy_fileHandle dd 0H
    copy_fileName db "copy.txt", 0H
    copy_writeCount dd 0

    read_buffer_size dd 1
    original_fileBuffer db 0H

.code
start:
    ; Abre arquivo original em depois solicita modo leitura
    invoke CreateFile, addr original_fileName, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    mov original_fileHandle, eax    

    ; Abre arquivo cópia em modo escrever
    invoke CreateFile, addr copy_fileName, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    mov copy_fileHandle, eax

    
    _Copy_Loop:
        ;Ler original
        invoke ReadFile, original_fileHandle, addr original_fileBuffer, read_buffer_size, addr original_readCount, NULL 

        ;Verifica EOF
        cmp original_readCount, 0
        je _Exit_Program
        
        ;Escreve buffer lido no arquivo cópia
        invoke WriteFile, copy_fileHandle, addr original_fileBuffer, read_buffer_size, addr copy_writeCount, NULL ; Escreve buffer_size bytes do arquivo 

        jne _Copy_Loop
        
    _Exit_Program:
        ; Fecha os arquivos
        invoke CloseHandle, original_fileHandle
        invoke CloseHandle, copy_fileHandle
end start