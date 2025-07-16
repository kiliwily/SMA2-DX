.gba
.open "sma2.gba","output.gba",0x8000000

.include "ASMwoFS.asm"
.include "ASMWFS.asm"

.org 0x833D520
.include "FreeSpace.asm"

.close