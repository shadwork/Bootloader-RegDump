; clear screen or at least set video mode
SET_MODE:       mov     al, 02h
                mov     ah, 00h
                int     10h
                ret

; Show register in  
; DI - in, pointer to hint string
; AX - in, value to show
SHOW_REG:       push    ax
                call    PRINT_STR 
                pop     ax

                mov     di,buffer_word
                call    WORD_TO_HEX

                mov     di,buffer_print
                call    PRINT_STR
                ret

; helpful utils from asmworld.ru http://asmworld.ru/uchebnyj-kurs/022-vyvod-chisel-na-konsol/

; Print '$' terminated string 
; DI - in, pointer to string
PRINT_STR:      push    ax
                mov     ah,9
                xchg    dx,di
                int     21h
                xchg    dx,di
                pop     ax
                ret

; Print endline
PRINT_ENDL:     push    di
                mov     di,end_line
                call    PRINT_STR
                pop     di
                ret


;Word to hex
; AX - in, word to convert
; DI - out, four byte string buffer
; not reg safe ;)
WORD_TO_HEX:    xchg ah,al
                call BYTE_TO_HEX
                xchg ah,al
                call BYTE_TO_HEX
                ret

; Byte to hex
; AL - in, byte to convert
; DI - out, two byte string buffer
; not reg safe too ;)
BYTE_TO_HEX:    push    ax
                mov     ah,al               
                shr     al,4
                call    TO_HEX_DIGIT
                mov     [di],al
                inc     di
                mov     al,ah
                and     al,0Fh
                call    TO_HEX_DIGIT
                mov     [di],al
                inc     di
                pop     ax
                ret

; one hex to digit
; AL - in, digit to convert (0-15)
; AL - out, hex string ('0'-'F')
TO_HEX_DIGIT:   add     al,'0'
                cmp     al,'9'
                jle     TO_HEX_D_RET
                add     al,7
TO_HEX_D_RET:   ret