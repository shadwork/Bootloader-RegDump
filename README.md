# Bootloader-RegDump
PC bootsector for floppy image, dump 16bit segment registers to screen, create to help explore old PC-Boot diskette

**Compile with [flat assembler](https://flatassembler.net/)**

fasm boot.asm

**You can set up mode inside boot.asm file:**

_configure BOOTSEC with_
* 1 for boot sector
* 0 for old DOS COM file
 
_set up floppy image size with BOOTSIZE_

* avalaible values 320,360,1200 for 5.25 drive and 720,1440 for 3.5 devices

**After run you get register dump in form of table**

>Register map on start  
ds: 0x0192  
ds: 0x0192  
es: 0x0192  
ss: 0x0192  
sp: 0xFFFE