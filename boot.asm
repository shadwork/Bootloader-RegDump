; 1 for bootsector and 0 for testing as DOS com file
BOOTSEC         =       0
; diskette image size, support 320,360,1200 and 720,1440
BOOTSIZE        =       320

if BOOTSEC=0
                BOOTSIZE=0
end if

use16

if BOOTSEC
                org     07C00h
else
                org     100h
end if

		jmp   START
		nop
		
START:	        cli
                push sp
                push ss
                push es                
                push ds
                push cs                

                call SET_MODE

                mov     di, text_inf
                call    PRINT_STR       
                call    PRINT_ENDL

                pop     ax
                mov     di, text_cs
                call    SHOW_REG
                call    PRINT_ENDL
                pop     ax
                mov     di, text_ds
                call    SHOW_REG
                call    PRINT_ENDL
                pop     ax
                mov     di, text_es
                call    SHOW_REG
                call    PRINT_ENDL
                pop     ax
                mov     di, text_ss
                call    SHOW_REG
                call    PRINT_ENDL
                pop     ax
                mov     di, text_sp
                call    SHOW_REG

                sti
if BOOTSEC
DEADEND:        jmp DEADEND
else
                mov     ax,4C00h
                int     21h
end if

                include 'text.asm'

text_inf        db      'Register map on start','$'
text_sp         db      'sp: ','$'
text_ss         db      'ss: ','$'
text_es         db      'es: ','$'
text_ds         db      'ds: ','$'
text_cs         db      'ds: ','$'
end_line        db      13,10,'$'
buffer_print    db      '0x'
buffer_word     db      ' ',' ',' ',' ','$'

if BOOTSEC
                ;boot sector must ends with 0x55AAh signature
                rb      7C00h+512-2-$
                db      0x55,0xAA
end if

; boot disk image size (8*40*2-1)*512 (SectorPerTrack*Track*Side-1)*SectorSize
if BOOTSIZE=0                                
else if         BOOTSIZE=320
                db      (8*40*2-1)*512         dup 0
else if         BOOTSIZE=360
                db      (9*40*2-1)*512         dup 0
else if         BOOTSIZE=1200
                db      (15*80*2-1)*512        dup 0                
else if         BOOTSIZE=720
                db      (9*80*2-1)*512         dup 0                                
else if         BOOTSIZE=1440
                db      (18*80*2-1)*512        dup 0                                
end if 