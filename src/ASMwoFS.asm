;others
.org 0x8000528	;Make the game wait for a VBlank with a BIOS function to reduce battery consumption on real GBA (Credits: MisterMan)
	bne WaitEnd
	ldr r2,=3002B64h
	ldrh r0,[r2]
	cmp r0,0h
	bne WaitEnd
	swi 5h
WaitEnd:
	ldr r1,=3002BC5h
	ldrb r0,[r1]
	cmp r0,0h
	bne 8000468h
	bl 809BE6Ch
	b 8000468h
	.halfword 0x0000
	
.org 0x8000560
	.pool
	
.org 0x8002E6C	;Prevents the button combo from showing build date
	beq 8002EBCh
	
.org 0x8002E98
	mov r0,0h
;;;;;;;

;Makes the game save which save file was last one loaded (PSS)
.org 0x80031DC
	push r4-r6,r14
	ldr r0,=3002340h
	ldr r2,=089Ah
	add r1,r0,r2
	ldrb r0,[r1]
	sub r0,1h
	strb r0,[r1]
	mov r0,0h
	ldsb r0,[r1,r0]
	cmp r0,0h
	blt BranchPSS1
	b ReturnPSS1
BranchPSS1:
	mov r0,1h
	strb r0,[r1]
	mov r6,0h
BranchPSS2:
	lsl r0,r6,10h
	asr r0,r0,0Fh
	ldr r3,=2013000h
	add r0,r0,r3
	ldrh r2,[r0]
	mov r3,0h
	ldsh r1,[r0,r3]
	mov r0,1Fh
	add r5,r1,0h
	and r5,r0
	add r0,r5,0h
	cmp r0,0h
	beq BranchPSS3
	sub r0,4h
	lsl r0,r0,10h
	lsr r5,r0,10h
	cmp r0,0h
	bge BranchPSS3
	mov r5,0h
BranchPSS3:
	mov r0,0F8h
	lsl r0,r0,2h
	add r4,r0,0h
	and r4,r2
	add r0,r4,0h
	cmp r0,0h
	beq BranchPSS4
	sub r0,80h
	lsl r0,r0,10h
	lsr r4,r0,10h
	cmp r0,0h
	bge BranchPSS4
	mov r4,0h
BranchPSS4:
	mov r0,0F8h
	lsl r0,r0,7h
	add r3,r0,0h
	and r3,r2
	add r0,r3,0h
	cmp r0,0h
	beq BranchPSS5
	ldr r1,=0FFFFF000h
	add r0,r0,r1
	lsl r0,r0,10h
	lsr r3,r0,10h
	cmp r0,0h
	bge BranchPSS5
	mov r3,0h
BranchPSS5:
	lsl r1,r6,10h
	asr r1,r1,10h
	lsl r2,r1,1h
	ldr r0,=2013000h
	add r2,r2,r0
	add r0,r4,0h
	orr r0,r5
	orr r0,r3
	strh r0,[r2]
	add r1,1h
	lsl r1,r1,10h
	lsr r6,r1,10h
	mov r0,80h
	lsl r0,r0,12h
	cmp r1,r0
	bne BranchPSS2
	ldr r2,=3002340h
	ldr r1,=89Bh
	add r0,r2,r1
	mov r1,1h
	strb r1,[r0]
	ldr r3,=0886h
	add r0,r2,r3
	ldrb r0,[r0]
	cmp r0,25h
	beq BranchPSS6
	cmp r0,30h
	beq BranchPSS6
	cmp r0,32h
	beq BranchPSS6
	cmp r0,33h
	beq BranchPSS6
	cmp r0,36h
	beq BranchPSS6
	ldr r1,=089Dh
	add r0,r2,r1
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	cmp r0,0h
	bne BranchPSS6
	mov r0,8h
	bl 809BFACh
BranchPSS6:
	ldr r4,=3002340h
	ldr r2,=089Dh
	add r0,r4,r2
	ldrb r1,[r0]
	add r1,1h
	strb r1,[r0]
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	cmp r0,8h
	bne ReturnPSS1
	bl 80014F4h
	ldr r3,=089Ah
	add r1,r4,r3
	mov r0,0h
	strb r0,[r1]
	ldr r0,=3002340h
	ldr r1,=0886h
	add r0,r0,r1
	ldrb r1,[r0]
	add r1,1h
	strb r1,[r0]
	ldrb r0,[r0]
	cmp r0,21h
	bls BranchPSS7
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r2,=0654h
	add r0,r0,r2
	mov r1,0h
	strb r1,[r0]
BranchPSS7:
	bl 8072544h
	bl 8079F84h
ReturnPSS1:
	pop r4-r6
	pop r0
	bx r0
	.pool
	
FreeSpacePSS1:
	add r1,r4,r0
	ldrb r0,[r4,16h]
	strb r0,[r1]
	sub r1,60h
	mov r0,3h
	bx r14

FreeSpacePSS2:
	ldrb r2,[r0,1h]
	strb r2,[r4,15h]
	ldrb r2,[r0]
	strb r2,[r4,16h]
	ldr r0,[r4,20h]
	strh r1,[r0,4h]
	bx r14
	.word 0x00000000
	.word 0x00000000
	.halfword 0x0000
	
.org 0x800377E
	bl FreeSpacePSS3
	
.org 0x8003D0E	;Makes Mario/Luigi Start! not appear on Top Secret Area (like Yoshis House)
	beq 8003D50h
	cmp r0,65h
	beq 8003D50h
	ldr r4,=3002340h
	mov r0,83h
	lsl r0,r0,4h
	add r1,r4,r0
	mov r0,80h
	lsl r0,r0,5h
	strh r0,[r1]
	b 8003D3Eh
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix time up not showing when game over
.org 0x800484E
	bl FreeSpaceFGO
	add r0,r1,0h
	add r0,0E2h
	strh r2,[r0]
	mov r5,0Ch
	ldr r3,[r4,20h]
	ldr r4,=011Fh
	mov r2,0h
StartLoopGameOver:
	lsl r1,r5,18h
	asr r1,r1,18h
	add r0,r3,r4
	add r0,r0,r1
	strb r2,[r0]
	mov r5,96h
	lsl r5,r5,1h
	add r0,r3,r5
	add r0,r0,r1
	strb r2,[r0]
	sub r1,1h
	lsl r1,r1,18h
	lsr r5,r1,18h
	cmp r1,0h
	bge StartLoopGameOver
	
.org 0x80048B4
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix all bgs in the enemy roll credits use the same sky color (Credits: MisterMan)
.org 0x8005098
	ldr r2,=3002340h
	ldr r5,=08C4h

.org 0x80050A4
	ldr r1,=1C58h
	
.org 0x80050B2
	ldr r3,=1C5Ch
	add r2,r2,r3
	ldr r0,[r2]
	ldrb r0,[r0,1Eh]
	cmp r0,0Bh
	bhi NoBGColor
	ldr r1,=SkyColors
	ldrb r0,[r1,r0]
	lsl r0,r0,1h
	ldr r2,=80D6584h
	add r0,r2,r0
	ldrh r0,[r0]
	b StoreBGColor
SkyColors:
	.byte	0x00, 0x01, 0x02, 0x06, 0x01, 0x03, 0x08, 0x07
	.byte	0x04, 0x05, 0x01, 0x03
	.pool

.org 0x80050F0
StoreBGColor:
	ldr r1,=2012C00h
	strh r0,[r1]
NoBGColor:
	ldr r4,=3002340h
	ldr r2,=8C8h

.org 0x8005100
	ldr r5,=1C58h

.org 0x800510A
	ldr r0,=08CCh
	add r1,r4,r0
	ldr r0,=0FF80h

.org 0x8005116
	ldr r1,=0FE80h
	strh r1,[r0]
	ldr r1,=08C4h
	add r0,r4,r1
	ldr r5,=08D4h

.org 0x8005126
	ldr r1,=08D8h

.org 0x800514E
	ldr r2,=0FFBFh

.org 0x8005156
	ldr r1,=4000008h
	ldrh r0,[r1]
	ldr r2,=0FFBFh

.org 0x8005178
	ldr r3,=0CE8h

.org 0x8005194
	.pool
	.word 0x00000000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Set highscore to 0 when starting a new file and make each star in smw worth 2 000 000 points
;and in cmb 200 000 points (HST);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.org 0x8007796
	ldr r0,=3002340h
	mov r1,20h
	bl 8005540h
	mov r1,0h
	ldr r4,=3002340h
	ldr r3,=80D5B78h

.org 0x80077BC
	ldr r1,=3002340h
	mov r0,0h
	str r0,[r1,0Ch]		;SMW Highscore
	str r0,[r1,10h]		;MB Highscore
	strb r0,[r1,14h]	;MB Highest Phase
	strb r0,[r1,15h]	;SMW Language Slot
	strb r0,[r1,16h]	;SMW Savefile Slot
	pop r4
	pop r0
	bx r0
	.pool
	.word 0x00000000
	.word 0x00000000
	.halfword 0x0000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of Perma SaveSlot (PSS)
.org 0x800816C
	push r4,r5,r14
	bl 800735Ch
	ldr r4,=3002340h
	ldr r1,=0888h
	add r0,r4,r1
	ldrb r1,[r0,7h]
	cmp r1,0h
	bne ReturnPSS2
	bl FreeSpacePSS2
	bl 80078CCh
	mov r0,80h
	lsl r0,r0,12h
	ldr r1,[r4,20h]
	mov r2,0F4h
	bl FreeSpaceRCS1	;800555Ch Orig.
	bl 8007BF0h
	ldr r1,=2000004h
	strh r0,[r1]
	bl 8007C18h
	ldr r0,=0888h
	add r5,r4,r0
	mov r0,0h
	ldsb r0,[r5,r0]
	add r0,1h
	ldr r1,=08A1h
	add r4,r4,r1
	add r0,r0,r4
	ldrb r0,[r0]
	cmp r0,3h
	bhi ReturnPSS2
	bl 8007CDCh
	mov r0,0h
	ldsb r0,[r5,r0]
	add r0,1h
	add r0,r0,r4
	ldrb r0,[r0]
	cmp r0,3h
	bhi ReturnPSS2
	bl 8008058h
	bl 800811Ch

ReturnPSS2:
	pop r4,r5
	pop r0
	bx r0
	.pool
	
.org 0x8008368
	bl FreeSpacePSS5
	cmp r0,r2
	bne 8008396h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix bug when pressing direction button and select button at the same time when on the overworld
;and porting is unlockd; Give direction buttons wrap around in some menus;;;;;;;;;;;;;;;;;;;;;;;
;Make select button work like b button instead of direction button in menus (FBI);;;;;;;;;;;;;;;
;Also contains parts of Perma SaveSlot (PSS) and others;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also fixes bug when star runs out with less the 100 secs left;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.org 0x8008930
	mov r1,30h

.org 0x80093D2	;Fix pallete used by spat out Volcano Lotus / Lakitu getting partially overwritten (Credits: MisterMan)
	mov	r3,0h

.org 0x800A69E	;Fix bug when star runs out with less then 100 secs left
	bne 800A6B8h

.org 0x800A6AC
	bne 800A6B8h

;others
.org 0x800A7E6	;Cleans up point overflow check
	ble NoPointOverflow
	str r0,[r2,68h]
NoPointOverflow:
	nop
	
.org 0x800A900
	.word 0x000F423F
;;;;;;;

.org 0x800D5C2
	mov r1,9h
	
.org 0x800D5F8
	mov r1,6h

.org 0x800D604	;(PSS)
	bl FreeSpacePSS4

.org 0x800D920
	mov r1,80h

.org 0x800DC30
	mov r1,6h
	
.org 0x800DCF4
	mov r1,6h
	
.org 0x800DED0
	mov r1,30h
	
.org 0x800DF18
	mov r1,6h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 3 of Perma SaveSlot (PSS);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains parts of Fix Button Input (FBI) and Fix Intro (FIN)
.org 0x800E01A
	beq DownPSS0

.org 0x800E024
	b DownPSS0

.org 0x800E034
	ldr r5,=3002340h
	ldr r1,=1C58h
	add r0,r5,r1
	ldr r0,[r0]
	ldr r2,=113Ch
	add r0,r0,r2
	ldrb r0,[r0]
	cmp r0,5h
	bls DownPSS0
	mov r0,0h
	bl 800D408h   
	mov r0,1h
	bl 800D408h
	ldr r1,=80DD280h
	ldr r2,=889h
	add r0,r5,r2
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	lsl r0,r0,2h
	add r0,r0,r1
	ldr r0,[r0]
	bl 8001734h
	ldr r1,=842h
	add r0,r5,r1
	strh r4,[r0]
	mov r2,84h
	lsl r2,r2,4h
	add r0,r5,r2
	strh r4,[r0]
	mov r0,0h
	bl  809BE9Ch
	ldr r0,=886h
	add r1,r5,r0
	mov r0,15h
	strb r0,[r1]
DownPSS0:
	pop r4,r5
	pop r0
	bx r0
	.pool
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFIN:
	add r4,r0,0h
	add r4,4Ah
	mov r2,0h
	strh r2,[r4]
	bx r14
	.halfword 0x0000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org 0x800E2D2	;(FBI)
	mov r1,6h

.org 0x800E2DE
	bl FreeSpacePSS4

.org 0x800E2F8	;(FBI)
	mov r1,80h

.org 0x800E3BC
	bl FreeSpacePSS1
	
.org 0x800E3E4
	.halfword 0x0888

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fixes weird player pose during the credits when holding up after rescuing Peach (PUP)
.org 0x80137EE
	add r1,r2,r0
	bl FreeSpacePUP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Make Star Blocks, Yoshi Egg Blocks and Coin Chain Blocks respawn when reenter the current area
;and Moons and hidden 1ups respawn when reenter the current level (MBR);;;;;;;;;;;;;;;;;;;;;;;;
.org 0x8018898	
	push r4-r7,r14
	ldr r2,=3002340h
	ldr r3,=1C58h
	add r1,r2,r3
	ldr r1,[r1]
	ldr r3,=11A4h
	add r1,r1,r3
	ldrb r4,[r1]
	lsl r0,r0,18h
	lsr r6,r0,18h
	add r0,r4,0h
	sub r0,18h
	lsl r0,r0,18h
	lsr r0,r0,18h
	cmp r0,4h
	bhi DownMBR4
	ldr r1,[r2,20h]
	mov r3,87h
	lsl r3,r3,1h
	cmp r0,0h
	beq DownMBR1
	add r3,1h
DownMBR1:
	add r0,r1,r3
	ldrb r1,[r0]
	cmp r1,0h
	beq DownMBR4
	ldr r2,[r2,20h]
	add r1,r2,0h
	add r1,0A0h
	ldrh r0,[r1]
	lsr r0,r0,3h
	lsl r0,r0,18h
	lsr r5,r0,18h
	ldrb r1,[r1]
	mov r0,7h
	add r4,r1,0h
	and r4,r0
	cmp r6,8h
	bne DownMBR2
	mov r0,96h
	lsl r0,r0,1h
	add r1,r2,r0
	b DownMBR3
DownMBR2:
	ldr r0,=11Fh
	add r1,r2,r0
DownMBR3:
	add r1,r1,r5
	ldr r0,=80E69D8h
	add r0,r4,r0
	ldrb r1,[r1]
	ldrb r0,[r0]
	and r1,r0
	cmp r1,0h
	beq DownMBR4
	b 8018A12h
DownMBR4:
	ldr r0,=3002340h
	ldr r1,=1C58h
	add r0,r0,r1
	ldr r0,[r0]
	ldr r3,=1171h
	add r0,r0,r3
	ldrb r5,[r0]
	add r0,r5,0
	bl 8015814h
	add r4,r6,0h
	cmp r4,12h
	bls DownMBR5
	add r0,r5,0
	bl 80157ECh
DownMBR5:
	ldr r0,=80E6FD0h
	add r0,r4,r0
	ldrb r7,[r0]
	cmp r4,1h
	beq DownMBR6
	cmp r4,7h
	beq DownMBR6
	cmp r4,1Bh
	bne 8018A00h
	mov r0,0Fh
	and r0,r5
	cmp r0,1h
	beq DownMBR6
	cmp r0,4h
	beq DownMBR6
	cmp r0,7h
	beq DownMBR6
	cmp r0,0Ah
	beq DownMBR6
	cmp r0,0Dh
	bne 8018A00h
DownMBR6:
	ldr r2,=80E6FB6h
	ldr r1,=3002340h
	ldr r0,[r1,20h]
	ldr r3,=113h
	add r0,r0,r3
	ldrb r0,[r0]
	lsl r0,r0,1h
	add r0,r0,r2
	ldrh r0,[r0]
	ldr r3,=2013880h
	add r2,r0,r3
	ldr r3,=1C5Ch
	add r0,r1,r3
	ldr r0,[r0]
	add r0,5Ah
	ldrb r0,[r0]
	lsl r0,r0,1Ah
	lsr r3,r0,18h
	ldr r0,=1C58h
	add r1,r1,r0
	ldr r0,[r1]
	ldr r1,=1181h
	add r0,r0,r1
	ldrb r0,[r0]
	mov r1,10h
	and r0,r1
	cmp r0,0h
	beq DownMBR7
	mov r0,2h
	orr r3,r0
DownMBR7:
	mov r0,8h
	and r0,r5
	cmp r0,0h
	beq DownMBR8
	mov r0,1h
	orr r3,r0
DownMBR8:
	add r3,r2,r3
	ldr r2,=80E69D8h
	ldr r0,=3002340h
	ldr r1,=1C58h
	add r0,r0,r1
	ldr r6,[r0]
	ldr r1,=1171h
	add r0,r6,r1
	ldrb r1,[r0]
	mov r0,7h
	and r1,r0
	add r1,r1,r2
	ldrb r0,[r3]
	ldrb r1,[r1]
	and r0,r1
	cmp r0,0h
	bne 80189F4h
	ldr r3,=1184h
	add r0,r6,r3
	b 8018A0Ch
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;others
.org 0x801F10C	;cleans up set yoshi flag when enter a level while riding a yoshi function
	add r0,0E3h
	
.org 0x801F112
	cmp r1,0h
	beq NoYoshi
	mov r1,1h
NoYoshi:
	ldr r0,[r4,20h]
	add r0,0E2h
	strb r1,[r0]
;;;;;;;;

;Part of MoonRespawn (MRS)
.org 0x801F16C
	add r2,r4,r7
	ldr r0,[r2]

.org 0x801F176
	ldr r0,[r2]

.org 0x801F17C
	bl FreeSpaceMRS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;others
.org 0x801EA30	;Prevent the midpoint from getting set when it was not activated in the level before
	ldr r1,=3002340h
	ldr r2,=1C5Ch
	
.org 0x801EA40
	cmp r0,0h
	blt ContinueCheckPointCheck
	cmp r0,0h
	bgt 801EA94h
	ldr r3,=0887h
	add r2,r1,r3
	mov r0,7h
	strb r0,[r2]
	b 801EACAh
	.pool
	
ContinueCheckPointCheck:
	ldr r3,=3002340h
	ldr r1,[r3,20h]
	mov r2,8Ah
	lsl r2,r2,1h
	add r0,r1,r2
	ldrb r0,[r0]
	cmp r0,0h
	beq CheckpointSetStatus
	add r0,r7,r5
	ldrb r0,[r0]
	ldr r1,[r3,20h]
	add r1,6h
	add r1,r1,r0
	ldrb r0,[r1]
	mov r2,40h
	orr r0,r2
	strb r0,[r1]
CheckpointSetStatus:
	ldr r2,=0887h
	add r1,r3,r2
	mov r0,7h
	strb r0,[r1]
	b 801EACAh
	.pool

.org 0x8020BFE	;Part of fix bug when pressing select + A, Start or a directional button at the same frame on the overworld
	mov r1,0h

.org 0x8020E04	;makes sure, that the player id is valid when changing the player
	ldrb r0,[r1]
	mov r2,1h
	and r0,r2
	eor r0,r2
	strb r0,[r1]
	ldr r0,=887h
	add r1,r4,r0
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]
	bl 801DCD8h
	lsl r0,r0,18h
	cmp r0,0h
	beq 8020E7Ch
	ldr r0,[r4,20h]
	add r0,0A0h
	ldrh r1,[r0]
	cmp r1,0Ah
	beq ContinueOther
	cmp r1,3Ch
	beq ContinueOther
	cmp r1,11h
	beq ContinueOther
	cmp r1,18h
	bne 8020E64h
ContinueOther:

.org 0x8020E60
	.pool
;;;;;;;

;Fix bug when pressing select + A, Start or a directional button at the same frame on the overworld
.org 0x8021508
	ldr r2,=3002340h
	ldr r3,=0856h

.org 0x8021518
	ldr r4,=1C5Ch

.org 0x802152C
	ldr r1,=00FF00FFh

.org 0x8021534
	mov r0,0Bh
	strb r0,[r5]
	add r3,30h
	add r1,r2,r3
	mov r0,3Ah
	b 802164Ah
	.pool
	
.org 0x80215B2
	beq 8021604h
	b 80216D0h
	.halfword 0x0000
	
.org 0x8022076
	b 80220A6h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;others
.org 0x8022570	;Makes "R" Speechbubble blink faster
	mov r0,2h
	
.org 0x80225A0
	.word 0x00000000
	
.org 0x8022E38	;shortens loop for overworld actions to prevent star world warps from appering after takeing normal exits of star world 2+3
	mov r4,29h

.org 0x802724C	;Reduces max speed of fast bg scrolling in forrest secret and cheese bridge yoshi wings area
	lsl r0,r0,1h
;;;;;;;

;Various tweaks for the levellist (LLT);;;;;;;;;;;;
;Also contains parts of Perma SaveSlot (PSS);;;;;;;
;and MoonRespawn (MRS) and Star Block Respawn (SBR)
.org 0x802839C
	mov r0,0Ah
	
.org 0x802897E
	add r0,r0,r3
	bl FreeSpaceLLT1
	
.org 0x802898C
	b 80289C0h
	.halfword 0x0000

.org 0x8028EA4
	ldr r2,=6008000h
	mov r0,89h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,40h
	strh r0,[r1]
	mov r0,8Ah
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,41h
	strh r0,[r1]
	mov r0,8Bh
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,42h
	strh r0,[r1]
	mov r0,8Ch
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,43h
	strh r0,[r1]
	mov r0,92h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,3Ah
	strh r0,[r1]
	mov r0,93h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,3Bh
	strh r0,[r1]
	mov r0,94h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,3Ch
	strh r0,[r1]
	mov r0,95h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,3Dh
	strh r0,[r1]
	ldr r3,=3002340h
	ldr r0,[r3,20h]
	add r0,0D5h
	ldrb r0,[r0]
	cmp r0,60h
	bne DownLLT0
	ldr r1,[r3,20h]
	add r1,0E6h
	ldrb r0,[r1]
	ldrb r1,[r1,1h]
	cmp r0,r1
	bcc Luigi
	mov r0,89h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,0D0h
	strh r0,[r1]
	mov r0,8Ah
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,0D1h
	strh r0,[r1]
	mov r0,8Bh
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,0D2h
	strh r0,[r1]
	mov r0,8Ch
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,0D3h
	strh r0,[r1]
	ldr r1,[r3,20h]
	add r1,0E6h
	ldrb r0,[r1]
	ldrb r1,[r1,1h]
	cmp r0,r1
	bhi DownLLT0
Luigi:
	mov r0,92h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,0D4h
	strh r0,[r1]
	mov r0,93h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,0D5h
	strh r0,[r1]
	mov r0,94h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,0D6h
	strh r0,[r1]
	mov r0,95h
	lsl r0,r0,1h
	add r1,r2,r0
	mov r0,0D7h
	strh r0,[r1]
DownLLT0:
	bx r14
	.pool
	
FreeSpaceLLT1:
	ldrb r0,[r0,6h]
	ldrb r2,[r2,1h]
	mov r1,60h
	and r2,r1
	cmp r2,60h
	beq ReturnLLT
	mov r1,20h
	and r1,r0
	cmp r1,0h
	bne ReturnLLT
	mov r0,r1
ReturnLLT:
	bx r14
	
FreeSpaceLLT2:
	mov r2,0EBh
	lsl r2,r2,5h
	add r0,r7,r2
	add r1,r1,r0
	mov r0,1Fh
	add r2,r6,0
	and r2,r0
	mov r0,1h
	lsl r0,r2
	ldr r1,[r1]
	and r0,r1
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceMRS:
	ldr r0,[r2]
	strh r6,[r0,16h]
	ldr r0,[r4,20h]
	mov r3,87h
	lsl r3,r3,1h
	add r1,r0,r3
	mov r0,0h
	strb r0,[r1]
	add r1,1h
	strb r0,[r1]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceSBR:
	mov r4,8Eh
	lsl r4,r4,1h
	add r1,r0,r4
	ldrb r0,[r1]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.word 0x00000000
	
.org 0x8029234
	push r4-r7,r14
	mov r7,r8
	push r7
	ldr r1,=3002340h
	ldr r0,=1D8Bh
	add r2,r1,r0
	ldrb r0,[r2]
	add r0,1h
	strb r0,[r2]
	ldr r2,=1D54h
	add r0,r1,r2
	ldrb r3,[r0]
	lsl r2,r3,1h
	ldr r4,=1D6Ch
	add r1,r1,r4
	add r1,r2,r1
	ldr r0,=81054C8h
	add r2,r2,r0
	ldrh r0,[r1]
	ldrh r2,[r2]
	cmp r0,r2
	bne BelowLLT2
	ldr r1,=813C6C4h
	lsl r0,r3,2h
	add r0,r0,r1
	ldr r4,[r0]
	ldrh r1,[r4,6h]
	ldr r0,=0FFFFh
	cmp r1,r0
	beq BelowLLT2
	add r5,r0,0
BelowLLT1:
	add r0,r4,0
	bl 8029898h
	add r4,8h
	ldrh r0,[r4,6h]
	cmp r0,r5
	bne BelowLLT1
BelowLLT2:
	mov r6,0h
	ldr r7,=3002340h
	ldr r0,=30040CBh
	mov r8,r0
	ldr r3,=1D54h
	add r1,r7,r3
	ldr r0,=813C550h
	lsl r2,r6,2h
	add r0,r2,r0
	ldrb r0,[r0,1h]
	lsl r0,r0,1Ch
	ldrb r1,[r1]
	lsr r0,r0,1Ch
	cmp r1,r0
	bne 802938Ah
	ldr r1,=813C540h
	ldr r4,=889h
	add r0,r7,r4
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	lsl r0,r0,2h
	add r0,r0,r1
	ldr r0,[r0]
	add r0,r2,r0
	ldr r4,[r0]
	cmp r4,0h
	beq 8029392h
	asr r1,r6,5h
	lsl r1,r1,2h
	bl FreeSpaceLLT2
	cmp r0,0h
	bne BelowLLT3
	ldr r2,[r7,20h]
	add r0,r2,r0
	add r0,37h
	mov r1,80h
	ldrb r0,[r0]
	and r0,r1
	cmp r0,0h
	bne 80292FCh
	b 802938Ah
BelowLLT3:
	
.org 0x80292E4
	mov r1,10h
	
.org 0x802930C
	mov r1,10h

.org 0x8029340
	.pool

.org 0x80293CC
	mov r1,10h

.org 0x8029468
	mov r1,10h
	
.org 0x80294B4
	ldr r3,=1D50h
	add r0,r5,r3
	ldrb r0,[r0]
	lsl r0,r0,3h
	add r0,r0,r5
	ldr r4,=8E8h
	add r0,r0,r4
	mov r1,0A0h
	strb r1,[r0]
	add r6,1h
	cmp r6,73h
	bgt DownLLT01
	b 8029398h
DownLLT01:
	ldr r1,=3002340h
	ldr r2,=1D51h
	add r0,r1,r2
	ldrb r0,[r0]
	cmp r0,0h
	bne DownLLT02
	b 802988Ah
DownLLT02:
	ldr r3,=1D55h
	add r0,r1,r3
	ldrb r3,[r0]
	lsl r2,r3,1h
	ldr r4,=1D6Ch
	add r0,r1,r4
	add r0,r2,r0
	ldr r1,=81054C8h
	add r2,r2,r1
	ldrh r0,[r0]
	ldrh r2,[r2]
	cmp r0,r2
	bne DownLLT04
	ldr r1,=813C6C4h
	lsl r0,r3,2h
	add r0,r0,r1
	ldr r4,[r0]
	ldrh r1,[r4,6h]
	ldr r0,=0FFFFh
	cmp r1,r0
	beq DownLLT04
	add r5,r0,0
DownLLT03:
	add r0,r4,0
	bl 8029974h
	add r4,8h
	ldrh r0,[r4,6h]
	cmp r0,r5
	bne DownLLT03
DownLLT04:
	mov r6,0h
	ldr r7,=3002340h
	ldr r0,=30040CBh
	mov r8,r0
	ldr r3,=1D55h
	add r1,r7,r3
	ldr r0,=813C550h
	lsl r2,r6,2h
	add r0,r2,r0
	ldrb r0,[r0,1h]
	lsl r0,r0,1Ch
	ldrb r1,[r1]
	lsr r0,r0,1Ch
	cmp r1,r0
	beq DownLLT05
	b 802968Eh
DownLLT05:
	ldr r1,=813C540h
	ldr r4,=889h
	add r0,r7,r4
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	lsl r0,r0,2h
	add r0,r0,r1
	ldr r0,[r0]
	add r0,r2,r0
	ldr r4,[r0]
	cmp r4,0h
	bne DownLLT06
	b 8029696h
DownLLT06:
	asr r1,r6,5h
	lsl r1,r1,2h
	bl FreeSpaceLLT2
	cmp r0,0h
	bne DownLLT07
	ldr r2,[r7,20h]
	add r0,r2,r0
	add r0,37h
	mov r1,80h
	ldrb r0,[r0]
	and r0,r1
	cmp r0,0h
	bne DownLLT10
	b 802968Eh
DownLLT07:
	ldr r0,[r7,20h]
	add r0,0A0h
	ldrh r0,[r0]
	cmp r6,r0
	bne DownLLT08
	mov r1,r8
	ldrb r0,[r1]
	mov r1,10h
	and r0,r1
	cmp r0,0h
	bne DownLLT10
DownLLT08:
	ldr r5,=0FFFFh
DownLLT09:
	add r0,r4,0
	bl 8029974h
	add r4,8h
	ldrh r0,[r4,6h]
	cmp r0,r5
	bne DownLLT09
DownLLT10:
	ldr r0,=3002340h
	ldr r0,[r0,20h]
	add r0,0A0h
	ldrh r0,[r0]
	cmp r6,r0
	bne DownLLT11
	mov r2,r8
	ldrb r0,[r2]
	mov r1,10h
	and r0,r1
	cmp r0,0h
	bne 802968Eh
DownLLT11:
	add r0,r6,0
	bl 8029A60h
	ldr r1,=3002340h
	ldr r3,=1D51h
	add r0,r1,r3
	ldrb r0,[r0]
	cmp r0,2h
	bne 8029614h
	ldr r4,=1D50h
	add r0,r1,r4
	ldrb r2,[r0]
	lsl r2,r2,3h
	add r2,r2,r1
	ldr r0,=8EAh
	add r2,r2,r0
	ldrh r3,[r2]
	lsl r1,r3,17h
	mov r4,88h
	lsl r4,r4,18h
	add r1,r1,r4
	b 8029638h
	.pool
	
.org 0x80296D6
	mov r1,10h
	
.org 0x80297CE
	mov r1,10h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of LevelList Tweaks (LLT)
.org 0x802A784
	cmp r0,0Ah

.org 0x802A7C4
	cmp r0,14h

.org 0x802A800
	cmp r0,1Eh
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;others
.org 0x802B7D0	;Fixes limit of goal coins
	cmp r2,0Ah
	bls 802B7D6h
	mov r2,0Bh
	
.org 0x802B824	;Increases reward for enemies on the goal only by 1 level per step
	add r0,1h
	
.org 0x802BD58	;Fix palette of disco shell
	add r2,r4,0
	add r2,2Bh
	ldrb r0,[r2]
	
.org 0x802BD7A
	add r2,0Ah
	ldrb r0,[r2]
	add r0,2h
	cmp r0,0Ah
	bls DownDiscoShell
	mov r0,4h
DownDiscoShell:

.org 0x802DD0C	;Fixes a bug that caused several sprites not sinking before despawn in lava
	ldrb r0,[r5]

.org 0x802F2FA	;Makes sure that Mario is not riding a Yoshi and no sprite is in yoshis mouth, when Yoshi despawns
	ldr r2,=3007A48h
	ldr r0,[r2]
	ldr r3,=0694h
	add r0,r0,r3

.org 0x802F308
	add r3,1h
	add r0,r0,r3

.org 0x802F320
	ldr r0,=3002340h
	ldr r1,=1C58h
	add r0,r0,r1
	ldr r0,[r0]
	ldr r1,=1194h
	
.org 0x802F334
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0E34h

.org 0x802F350
	bls DownCheckMessage

.org 0x802F366
	b DownDespawnSprite
	.pool
DownCheckMessage:
	mov r0,r4
	add r0,5Ch
	ldrh r0,[r0]
	bl 8030D90h
DownDespawnSprite:
	mov r0,0h
	strb r0,[r4,1Ch]
	ldrb r1,[r4,1Ah]
	cmp r1,35h
	bne DownOthers
	strb r0,[r4,1Bh]
	ldr r1,=3007A48h
	ldr r0,[r1]
	ldr r1,=06C6h
	add r0,r0,r1
	mov r1,0FFh
	strb r1,[r0]
	add r4,37h
	strb r1,[r4]
DownOthers:
	pop r4
	pop r0
	bx r0
	.pool
	
.org 0x802FBA0	;Prevents sprites that chase/aim at Mario/Luigi from chasing/aiming at a point above Mario/Luigi
	mov r0,0h
	ldsh r1,[r2,r0]
	add r1,10h
	cmp r1,0h
	blt 802FBB8h
	
.org 0x802FBD4
	mov r0,0h
	ldsh r1,[r2,r0]
	add r1,10h
	cmp r1,0h
	blt 802FBECh
	
.org 0x80307C4	;Make every enemy give up to a 5up when killed by stomping
	push r4-r6,r14
	mov r5,r0
	ldr r3,=3002340h
	ldr r0,=1D4Ch
	add r6,r3,r0
	ldrh r1,[r6]
	add r1,1h
	strh r1,[r6]
	ldrh r4,[r6]
	cmp r4,7h
	bhi DownStomping1Ups1
	ldr r2,=08C4h
	add r1,r3,r2
	ldrh r0,[r5,10h]
	ldrh r1,[r1]
	sub r0,r0,r1
	sub r2,9Ch
	add r1,r3,r2
	strh r0,[r1]
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r3,=0F33h
	add r2,r0,r3
	ldr r1,=8109424h
	mov r0,7h
	and r0,r4
	add r1,r0,r1
	ldrb r0,[r2]
	ldrb r3,[r1]
	cmp r0,r3
	bcc DownEnemyStomping
	mov r0,r3
	strb r0,[r2]
	b DownEnemyStomping
	.pool
	
DownStomping1Ups1:
	ldr r2,=3002340h
	ldr r0,=08C4h
	add r1,r2,r0
	ldrh r0,[r5,10h]
	ldrh r1,[r1]
	sub r0,r0,r1
	ldr r1,=0828h
	add r2,r2,r1
	strh r0,[r2]
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r2,=0F33h
	add r1,r0,r2
	ldrb r0,[r1]
	cmp r0,2h
	bls DownStomping1Ups2
	mov r0,3h
	strb r0,[r1]
DownStomping1Ups2:
	sub r3,r4,7h
	cmp r4,0Ah
	bls Stomping5up
	mov r4,0Bh
	strh r4,[r6]
	mov r3,5h
Stomping5up:
	ldr r0,=3002340h
	ldr r1,=1C58h
	add r0,r0,r1
	ldr r0,[r0]
	ldr r1,=1158h
	add r0,r0,r1
	ldrb r0,[r0]
	ldr r1,=3007A48h
	ldr r1,[r1]
	cmp r0,0h
	beq DownOtherFlagStomping
	mov r2,0D8h
	lsl r2,r2,3h
	b StoreValueStomping
	.pool
	
DownOtherFlagStomping:
	ldr r2,=06BEh
StoreValueStomping:
	add r1,r1,r2
	ldrh r0,[r1]
	add r0,r0,r3
	strh r0,[r1]
DownEnemyStomping:
	lsl r1,r4,18h
	lsr r1,r1,18h
	add r0,r5,0h
	bl 803E430h
	pop r4-r6
	pop r0
	bx r0
	.pool
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000

.org 0x8030D98	;Prevent Bravo Mario/luigi Message from overwritting a reward pop-up
	bls EndOfFctMessage
	mov r0,0FAh
	lsl r0,r0,2h
	cmp r6,r0
	bls DownNotMaxLifes
	ldr r6,=03E7h

DownNotMaxLifes:
	ldr r1,=3007A48h
	ldr r1,[r1]
	ldr r0,=174h
	add r5,r0,r1
	mov r1,0h
	mov r0,17h
	strb r0,[r5,14h]
	add r0,0E9h
	strh r0,[r5,8h]
	lsl r0,r0,10h
	str r0,[r5]
	mov r0,20h
	strh r0,[r5,0Ah]
	mov r2,0Ah
	ldsh r0,[r5,r2]
	lsl r0,r0,10h
	str r0,[r5,4h]
	ldr r0,=0FFFE8000h
	str r0,[r5,0Ch]
	str r1,[r5,10h]
	add r0,r6,0h
	mov r1,0Ah
	bl 809EBC0h
	lsl r0,r0,18h
	lsr r7,r0,18h
	cmp r6,63h
	bls DownMessage1
	add r0,r6,0h
	mov r1,64h 
	bl 809EBBCh
	lsl r0,r0,18h
	lsr r4,r0,18h
	add r0,r6,0h
	mov r1,0Ah
	bl 809EBBCh
	lsl r1,r4,2h
	add r1,r1,r4
	lsl r1,r1,1h
	sub r0,r0,r1
	b DownMessage2
	.pool

DownMessage1:
	mov r4,0h
	add r0,r6,0h
	mov r1,0Ah
	bl 809EBBCh

DownMessage2:
	lsl r0,r0,18h
	lsr r0,r0,18h
	lsl r0,r0,4h
	orr r0,r7
	lsl r1,r4,8h
	orr r0,r1
	strh r0,[r5,16h]
	ldr r2,=3002340h
	ldr r3,=1C70h
	add r0,r2,r3
	ldr r3,=0828h
	add r1,r2,r3
	ldrh r0,[r0]
	strh r0,[r1]
	ldr r0,[r2,20h]
	add r0,0DCh
	ldrb r0,[r0]
	add r3,4h
	add r2,r2,r3
	strh r0,[r2]
	mov r0,9Dh
	bl 809C1C4h

EndOfFctMessage:
	pop r4-r7
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFGO:
	ldr r0,=1C58h
	add r5,r4,r0
	ldr r1,[r5]
	ldr r0,=1199h
	add r1,r1,r0
	ldrb r0,[r1]
	cmp r0,12h
	beq GameOverDisplayed
	mov r0,14h
	bl 809BF40h
	ldr r1,[r5]
	ldr r3,=1199h
	add r2,r1,r3
	mov r0,12h
	strb r0,[r2]
	ldr r1,[r5]
	ldr r3,=119Ah
	add r2,r1,r3
	mov r0,0C0h
	strb r0,[r2]
	ldr r1,[r5]
	ldr r3,=119Bh
	add r2,r1,r3
	mov r0,0FFh
	strb r0,[r2]
	ldr r1,=886h
	add r1,r4,r1
	mov r0,26h
	strb r0,[r1]
	pop r4-r7
	pop r0
	bx r0
	.pool
	
GameOverDisplayed:
	ldr r1,[r4,20h]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFMO:
	push r14
	ldr r1,=3007A48h
	ldr r1,[r1]
	ldr r0,=0174h
	add r0,r1,r0
	ldrb r1,[r0,14h]
	cmp r1,17h
	bne NoBravoMessage
	bl 803DBC0h
NoBravoMessage:
	bl 803E13Ch
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceRDF:
	mov r2,0h
	strb r2,[r3]
	add r1,1h
	add r3,r0,r1
	strb r2,[r3]
	add r1,52h
	add r3,r0,r1
	strb r2,[r3]
	add r1,1Ah
	add r3,r0,r1
	strb r2,[r3]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.word 0x00000000
	.word 0x00000000

.org 0x80316D0	;Fix ducking flag is not considered when touching ghosts
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0EB4h
	
.org 0x80316DC
	ldr r0,=3002340h
	ldr r4,=1C90h

.org 0x80316EC
	ldr r0,=3007A48h

.org 0x80316F4
	ldr r3,=0EB8h
	
.org 0x80316FA
	ldr r3,=3002340h
	ldr r0,[r3,20h]
	add r0,0E0h
	ldrb r0,[r0]
	cmp r0,0h
	beq SmallPlayer
	ldr r1,=1C62h
	add r0,r3,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne SmallPlayer
	mov r1,20h
	b SetPlayerHeightGhosts
	.pool
SmallPlayer:
	mov r1,14h
SetPlayerHeightGhosts:
	ldr r4,=0EBCh
	add r0,r2,r4
	strh r1,[r0]
	
.org 0x803176C
	.pool

.org 0x803229C	;Fix block check routine doesn't handle 16bit values properly (1)
	push r4-r6,r14
	mov r5,r0
	ldr r0,=3002340h
	ldr r1,=1C58h
	add r4,r0,r1
	ldr r1,[r4]
	ldr r2,=3007A48h
	ldr r0,[r2]
	ldr r6,=0EC8h
	add r0,r0,r6
	add r1,30h
	ldrh r0,[r0]
	strh r0,[r1]
	ldr r1,[r4]
	ldr r0,[r2]
	add r6,2h
	add r0,r0,r6
	add r1,2Ch
	ldrh r0,[r0]
	strh r0,[r1]
	ldr r2,[r2]
	ldr r1,=0ECDh
	add r0,r2,r1
	ldrb r3,[r0]
	cmp r3,3h
	bne Down16Bit1
	ldr r0,[r4]
	add r6,92h
	add r1,r2,r6
	ldrh r0,[r0,30h]
	strh r0,[r1]
	ldr r0,[r4]
	ldr r4,=0F5Eh
	add r1,r2,r4
	ldrh r0,[r0,2Ch]
	strh r0,[r1]

Down16Bit1:
	mov r2,r5
	add r2,2Bh
	ldr r0,=810A8CCh
	add r0,r3,r0
	ldrb r1,[r2]
	ldrb r0,[r0]
	orr r1,r0
	strb r1,[r2]
	pop r4-r6
	pop r0
	bx r0
	.pool
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000

.org 0x803233E	;Despawn sprites faster after they sank in lava
	mov r1,2h

;Fix certain sprites don't sink in normal level lava
.org 0x80328A8
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldrh r0,[r0]
	sub r0,59h
	cmp r0,2h
	bls ContinueDown
	cmp r0,0A6h
	bne DownOne
ContinueDown:
	ldr r0,=3002340h
	ldr r1,=1C58h
	add r0,r0,r1
	ldr r0,[r0]
	ldrb r0,[r0,6h]
	cmp r0,0Eh
	beq CheckSpriteYoshi
	cmp r0,3h
	bne DownOne
CheckSpriteYoshi:
	ldrb r0,[r2,1Ah]
	cmp r0,35h
	beq 80328F4h
	cmp r0,61h
	beq DownOne
	add r0,r2,0
	add r0,41h
	ldrb r0,[r0]
	mov r1,2h
	and r0,r1
	cmp r0,0h
	beq 80328F4h
	b 80328FAh
DownOne:
	mov r0,1h
	b 80328FCh
.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org 0x8033EAC	;Allow to get up to a 5up for throwing a shell etc. into multiple other enemies
	ldr r2,=3002340h
	ldr r0,=08C4h
	add r1,r2,r0
	ldrh r0,[r4,10h]
	ldrh r1,[r1]
	sub r0,r0,r1
	ldr r1,=0828h
	add r2,r2,r1
	strh r0,[r2]
	ldrh r0,[r4,3Ah]
	cmp r0,7h
	bhi DownThrownA1
	
.org 0x8033EE8
	b DownThrownA4
	.pool
	
.org 0x8033F04
DownThrownA1:
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r2,=0F33h
	add r1,r0,r2
	ldrb r0,[r1]
	cmp r0,2h
	bls DownThrownA2
	mov r0,3h
	strb r0,[r1]	
DownThrownA2:
	ldrh r0,[r4,3Ah]
	sub r3,r0,7h
	cmp r0,0Ah
	bls DownThrownA3
	mov r0,0Bh
	strh r0,[r4,3Ah]
	mov r3,5h
DownThrownA3:
	lsl r0,r0,18h
	lsr r2,r0,18h
	mov r1,r4
	add r1,5Ch
	ldrh r0,[r1]
	add r0,r0,r3
	strh r0,[r1]
DownThrownA4:
	ldrb r0,[r4,1Ah]
	cmp r0,53h
	bne 8033F64h
	mov r0,r4
	add r0,57h
	ldrb r0,[r0]
	cmp r0,0h
	beq 8033F64h
	mov r0,r5
	mov r1,1h
	bl 803E430h
	b 8033F6Ch
	.pool
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000

.org 0x80340B6	;Prevents shellless koopas from hopping into anything that's not a shell
	cmp r0,0Ch
	
.org 0x8034332	;Allow to get up to a 5up for throwing a shell etc. into multiple other enemies
	ldr r0,=0FFFD0000h
	str r0,[r5,0Ch]
	ldrh r0,[r4,3Ah]
	add r0,1h
	strh r0,[r4,3Ah]
	ldr r2,=3002340h
	ldr r0,=08C4h
	add r1,r2,r0
	ldrh r0,[r4,10h]
	ldrh r1,[r1]
	sub r0,r0,r1
	ldr r1,=0828h
	add r2,r2,r1
	strh r0,[r2]
	ldrh r0,[r4,3Ah]
	cmp r0,7h
	bhi DownThrownB1
	
.org 0x803436C
	bcc DownThrownB4
	mov r0,r2
	strb r0,[r3]
	b DownThrownB4
	.pool
	
.org 0x8034390
DownThrownB1:
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r2,=0F33h
	add r1,r0,r2
	ldrb r0,[r1]
	cmp r0,2h
	bls DownThrownB2
	mov r0,3h
	strb r0,[r1]	
DownThrownB2:
	ldrh r0,[r4,3Ah]
	sub r2,r0,7h
	cmp r0,0Ah
	bls DownThrownB3
	mov r0,0Bh
	strh r0,[r4,3Ah]
	mov r2,5h
DownThrownB3:
	mov r1,r4
	add r1,5Ch
	ldrh r0,[r1]
	add r0,r0,r2
	strh r0,[r1]
DownThrownB4:
	ldrb r0,[r4,1Ah]
	cmp r0,53h
	bne 80343F0h
	mov r0,r4
	add r0,57h
	ldrb r0,[r0]
	cmp r0,0h
	beq 80343F0h
	mov r0,r5
	mov r1,1h
	bl 803E430h
	b 80343FCh
	.pool
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	
.org 0x803426A	;Make sprites interact with lightswitch like they interact with flying ?-Block
	ldrb r0,[r5,1Ah]
	cmp r0,0C8h
	beq DownLightSwitch
	sub r0,83h
	cmp r0,1h
	bhi 803429Ch
DownLightSwitch:
	mov r0,r4
	bl 802FCECh
	mov r0,0h
	str r0,[r4,0Ch]
	mov r0,r5
	bl 8033DA4h
	b 803441Ah
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000

.org 0x8034468
	cmp r0,0C8h
	beq 80344A0h
	mov r2,r0
	sub r2,83h
	cmp r2,1h
	bhi 80344B2h
	
.org 0x8034502
	mov r6,0h
	ldrb r0,[r4,1Ah]
	cmp r0,0C8h
	beq ActivateBlock1
	sub r0,83h
	cmp r0,1h
	bhi KillSprite1
ActivateBlock1:
	mov r0,r4
	bl 8033DA4h
	b CheckSprite2
KillSprite1:
	mov r0,2h
	strb r0,[r4,1Ch]
	ldr r0,=0FFFD0000h
	str r0,[r4,0Ch]
	add r6,1h
CheckSprite2:
	ldrb r0,[r5,1Ah]
	cmp r0,80h
	beq EndOfSpriteCheck
	cmp r0,0C8h
	beq ActivateBlock2
	sub r0,83h
	cmp r0,1h
	bhi KillSprite2
ActivateBlock2:
	mov r0,r5
	bl 8033DA4h
	b EndOfSpriteCheck
KillSprite2:	
	mov r0,2h
	strb r0,[r5,1Ch]
	ldr r0,=0FFFD0000h
	str r0,[r5,0Ch]
	add r6,1h
EndOfSpriteCheck:
	mov r0,r4
	bl 8033E58h
	cmp r6,0h
	beq OneSpriteKilled
	mov r1,1h
	cmp r6,2h
	bne OneSpriteKilled
	mov r1,3h
OneSpriteKilled:
	mov r0,r4
	bl 803E430h
NoSpriteKilled:
	mov r1,80h
	lsl r1,r1,9h
	ldr r0,[r4,8h]
	cmp r0,0h
	blt SpriteDirection
	neg r1,r1
SpriteDirection:
	neg r0,r1
	str r1,[r4,8h]
	str r0,[r5,8h]
	pop r4-r6
	pop r0
	bx r0
	.pool
	
.org 0x803516A	;Fixes a bug that causes big sprites to lose their interaction with the Player if too big parts of their sprite is horizonztally offscreen
	bne DoPlayerInteraction
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0ED5h
	add r0,r0,r1
	ldr r1,=3002340h
	ldr r3,=893h
	
.org 0x8035184
	cmp r0,0h
	bne ReturnNoInteraction
DoPlayerInteraction:
	ldr r0,=3002340h
	ldr r1,=0CE8h
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,99h
	beq ReturnNoInteraction
	mov r0,r2
	bl 8035104h
	lsl r0,r0,18h
	lsr r0,r0,18h
	b ReturnYesInteraction
	.pool

ReturnNoInteraction:
	mov r0,0h
ReturnYesInteraction:
	pop r1
	bx r1
	.word 0x00000000
	.word 0x00000000
	
.org 0x80351CC	;Make every enemy give up to a 5up when killed with a star
	ldr r2,=3007A48h
	ldr r1,[r2]
	ldr r0,=69Fh

.org 0x80351DA
	ldr r0,=3002340h
	ldr r1,=1C58h

.org 0x80351E2
	ldr r3,=1158h

.org 0x80351EE
	ldr r1,=06CAh

.org 0x80351F6
	ldr r0,=3007A48h
	ldr r1,[r0]
	ldr r3,=69Fh
	add r2,r1,r3
	ldrb r0,[r2]
	sub r3,r0,7h
	cmp r0,0Ah
	bls DownStar5up
	mov r0,0Bh
	strb r0,[r2]
	mov r3,5h
DownStar5up:
	cmp r0,7h
	bls 803524Ah
	ldr r0,=3002340h
	ldr r2,=1C58h
	add r0,r0,r2
	ldr r0,[r0]
	ldr r2,=1158h
	add r0,r0,r2
	ldrb r0,[r0]
	cmp r0,0h
	beq 8035240h
	mov r2,0D8h
	lsl r2,r2,3h
	b 8035242h
	.pool
	
.org 0x8035246
	add r0,r0,r3
	
;Fix looping sound when hitting a solid sprite from below
.org 0x803539A	;Fix momentum when standing or jumping/falling on a solid block
	mov r0,0h

.org 0x803546E
	ldr r1,=3002340h
	ldr r4,=1C62h
	add r0,r1,r4

.org 0x8035486
	ldr r0,=3002340h
	sub r4,4h
	
.org 0x803548E
	ldr r1,=10FAh

.org 0x80354A0
	ldr r2,=3002340h
	ldr r3,=1C74h

.org 0x80354AC
	ldr r0,=3007A48h
	
.org 0x80354B0
	ldr r3,=0EB4h
	
.org 0x80354BC
	ldr r1,=1C6Ch
	add r0,r2,r1
	mov r3,0h
	ldsh r0,[r0,r3]

.org 0x80354CA
	add r1,1h
	add r0,r2,r1
	mov r3,0h
	strb r3,[r0]
	ldr r3,=1C94h
	add r1,r2,r3
	ldrh r1,[r1]
	sub r3,18h
	add r0,r2,r3
	ldrh r0,[r0]
	cmp r1,r0
	bcc CheckSpriteId
	ldr r3,=1C66h
	add r2,r2,r3
	ldrb r0,[r2]
	mov r1,4h
	and r0,r1
	cmp r0,0h
	bne CheckSpriteId
	b 80356F6h
	.pool
	.halfword 0x0000
	
CheckSpriteId:
	ldrb r0,[r5,1Ah]
	cmp r0,82h
	bls 803553Ah
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org 0x80357F4	;Fix a bug that causes the game to softlock if obtaining a feather offscreen during autoscroll
	ldr r2,=3002340h
	mov r0,0E3h 
	lsl r0,r0,5h
	add r1,r2,r0
	mov r0,3h
	strb r0,[r1]
	ldr r3,=1CECh
	add r1,r2,r3
	mov r0,18h
	strb r0,[r1]
	ldr r1,=1C75h
	add r0,r2,r1
	sub r3,r1,4h
	add r1,r2,r3
	ldrb r0,[r0]
	ldrb r1,[r1]
	orr r0,r1
	cmp r0,0h
	bne 80358A4h
	
.org 0x80358A8
	.pool
	
.org 0x8035A60	;Give the player the same timer when they can obtain an item as grab it with yoshi
	ldrb r1,[r6,1Fh]
	cmp r1,0h
	beq 8035A6Eh
	ldrb r1,[r6,1Bh]
	cmp r1,0h
	
.org 0x8035A74
	cmp r0,6h
	bls DownTimerUp
	b 8035B9Eh
DownTimerUp:
	strb r1,[r6,1Ch]
	
.org 0x8035AA6	;Make silver coins give up to 5ups per coin
	b DownSilverCoins

.org 0x8035AB0
	ldr r0,=3007A48h
	ldr r1,[r0]
	ldr r2,=684h

.org 0x8035AC0
	sub r2,r5,7h
	cmp r5,0Ah
	bls NoSilverCoinLimit
	mov r5,0Bh
	strb r5,[r1]
	mov r2,5h
NoSilverCoinLimit:
	cmp r5,7h
	bls 8035ADCh
	ldr r0,=3007A48h
	ldr r1,[r0]
	ldr r0,=6C2h
	add r1,r1,r0
	ldrh r0,[r1]
	add r0,r0,r2
	strh r0,[r1]
DownSilverCoins:
	add r0,r6,0
	add r1,r5,0
	bl 803E430h
	mov r5,3h
	ldr r0,=3007A48h
	mov r3,0BCh
	lsl r3,r3,2h
	ldr r2,[r0]
	lsl r0,r5,4h
	add r0,r0,r3
	add r1,r0,r2
	ldrb r0,[r1,0Ch]
	cmp r0,0h
	beq 8035B18h
	sub r0,r5,1
	lsl r0,r0,18h
	lsr r5,r0,18h
	cmp r5,0FFh
	bne 8035AEEh
	b 8035B9Eh
	.pool
	.word 0x00000000

.org 0x8035DBC
	mov r1,1h
;;;;;;;

;Fix fireballs sometimes don't sink in normal level lava
.org 0x8036A1A
	ldrh r1,[r0]
	cmp r1,10h

.org 0x8036A44
	mov r0,r1
	sub r0,59h
	cmp r0,2h
	bls 80369A0h
	cmp r0,0A6h
	beq 80369A0h
	cmp r1,6Dh
	bls 8036AF6h	
	cmp r1,0D7h
	bls DownFBL
	mov r0,0Fh
	and r0,r4
	cmp r0,5h
	bgt 80369A0h
	ldrh r0,[r5,12h]
	sub r0,2h
	strh r0,[r5,12h]
	b 8036960h
DownFBL:
	cmp r1,0D1h
	bhi 80369A0h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix several glitches whith sprites carried through a pipe
.org 0x8037696
	mov r2,7Fh

.org 0x80376FE
	ldr r3,=3007A48h
	ldr r1,[r3]
	ldr r2,=0EB4h
	add r0,r1,r2
	mov r4,0h
	ldsh r2,[r0,r4]
	b 80377B0h
	.pool
	.fill 0x9C
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Decrease time between life counter updates if you get multiple 1ups at once;;;;;;;;;;;
;Also contains part of the fix for Bravo Mario/Luigi message overwrites a reward pop-up
.org 0x8037A64
	bne 8037A88h

.org 0x8037A6E
	beq 8037AC6h
	mov r0,0h
	strb r0,[r1]
	b 8037AC6h
	.halfword 0x0000

.org 0x8037A88
	ldr r0,=3002340h
	ldr r1,=1C58h
	add r0,r0,r1
	ldr r2,[r0]
	ldr r3,=10F0h
	add r1,r2,r3
	ldrh r0,[r1]
	sub r0,1h
	strh r0,[r1]
	ldr r3,=10F2h
	add r1,r2,r3
	ldrb r0,[r1]
	cmp r0,0h
	bne SkipPlaySound
	mov r0,1h
	strb r0,[r1]
	ldr r4,=3002B68h
	mov r0,7h
	add r1,r4,0h
	bl 809C1C4h
SkipPlaySound:
	ldr r4,=3002340h
	ldr r1,[r4,20h]
	add r1,9Ch
	ldrh r0,[r1]
	add r0,1h
	strh r0,[r1]
	ldr r1,[r4,20h]
	add r1,9Ch
	
.org 0x8037AEE
	.pool
	
.org 0x8037B64	;Part of Fix Bravo Mario/Luigi Message from overwritng a reward pop-up
	bl FreeSpaceFMO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix ?-Block sprite slot routine
.org 0x8037D48	;Prevent sprite in yoshis mouth from beeing overwritten
	bne DownNotKeyBlock
	ldr r0,=3002340h
	ldr r3,=1C58h

.org 0x8037D5A
	cmp r0,0h
	beq SearchSpriteSlot
	cmp r0,30h
	beq SearchSpriteSlot
	b 8037E20h
DownNotKeyBlock:
	cmp r4,0Ah
	beq SearchSpriteSlot
	cmp r4,10h
	beq SearchSpriteSlot
	cmp r4,8h
	bne CheckIf0Ch
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r5,=0EDEh
	add r0,r0,r5
	ldrb r0,[r0]
	cmp r0,0h
	beq 8037E20h
	b SearchSpriteSlot
	.pool
	
CheckIf0Ch:
	cmp r4,0Ch
	bne 8037E20h
	
SearchSpriteSlot:
	bl 802FD78h
	lsl r0,r0,18h
	asr r3,r0,18h
	cmp r3,0h
	bge 8037E92h
	ldr r0,=3007A48h
	ldr r2,[r0]
	ldr r0,=0F27h
	add r4,r2,r0
	mov r3,9h

SpriteLoop1Start:
	ldrb r0,[r4]
	cmp r0,r3
	beq SpriteLoop1Continue
	mov r0,64h
	mul r0,r3
	ldr r5,=06CCh
	add r0,r0,r5
	add r1,r0,r2
	add r0,r1,0
	add r0,44h
	ldrb r0,[r0]
	mov r5,4h
	and r0,r5
	cmp r0,0h
	bne SpriteLoop1Continue
	ldrh r0,[r1,2Eh]
	cmp r0,0h
	bne 8037E92h

SpriteLoop1Continue:
	sub r3,1h
	cmp r3,0h
	bge SpriteLoop1Start
	mov r3,9h

SpriteLoop2Start:
	ldrb r0,[r4]
	cmp r0,r3
	beq SpriteLoop2Continue
	mov r0,64h
	mul r0,r3
	ldr r5,=06CCh
	add r0,r0,r5
	add r1,r0,r2
	add r0,r1,0
	add r0,44h
	ldrb r0,[r0]
	mov r5,4h
	and r0,r5
	cmp r0,0h
	beq 8037E92h

SpriteLoop2Continue:
	sub r3,1h
	cmp r3,0h
	bge SpriteLoop2Start
	mov r3,9h
	ldrb r0,[r4]
	cmp r0,r3
	beq SpriteInYoshisMouth
	mov r0,64h
	mul r0,r3
	ldr r5,=06CCh
	add r1,r0,r2
	ldrb r0,[r1,1Ah]
	cmp r0,0F8h
	bls 8037E92h

SpriteInYoshisMouth:
	sub r3,1h
	b 8037E92h
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Coin chain blocks respawn
.org 0x8037FB2
	ldr r1,=3002340h
	ldr r0,=1D0Eh
	add r1,r1,r0
	ldrb r0,[r1]
	cmp r0,0FFh
	bne 8037FE4h
	mov r0,0h
	strb r0,[r1]
	b 8037FE4h

.org 0x8037FC8
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;

;Repoint sprite status table to make space for 1 more entry to prevent glitchy sprite spawn
.org 0x80380F8
	.word SpriteTableStatus
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Prevent coin sound from getting triggerd to often when you get multiple coins in a row
.org 0x803B30E	;Give 100 points for a coin from a ?-Block instead of 10
	mov r0,5h

.org 0x803BBA0
	push r4,r14
	
.org 0x803BBA6
	ldr r2,=3007A48h
	ldr r4,[r2]
	ldr r0,=0F24h
	add r1,r4,r0
	ldrb r2,[r1]
	add r0,r2,1h
	strb r0,[r1]
	cmp r2,0h
	bne NoCoinSound
	ldr r1,=0F32h
	add r0,r4,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne NoCoinSound
	ldr r1,=3002340h
	ldr r2,=0828h
	add r1,r1,r2
	strh r3,[r1]
	mov r0,4h
	bl 809C1C4h
NoCoinSound:
	ldr r1,=0F32h
	add r0,r4,r1
	mov r1,0h
	strb r1,[r0]
	ldr r0,=3002340h
	ldr r0,[r0,20h]
	mov r2,8Eh
	lsl r2,r2,1h
	add r1,r0,r2
	mov r0,0h
	ldsb r0,[r1,r0]
	cmp r0,0h
	beq DownCounter
	ldrb r0,[r1]
	sub r0,1h
	strb r0,[r1]
DownCounter:
	pop r4
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Increases limit for cape trick with enemies to 5up
.org 0x803CF24
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0ECCh

.org 0x803CF3C
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0ECCh
	add r0,r0,r1

.org 0x803CF4C
	bne DoCapeTrickStuff

.org 0x803CF52
	b CallRewardFct
DoCapeTrickStuff:
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0ECCh
	add r0,r0,r1
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	cmp r0,1h
	bne 803CFB6h
	ldr r1,=810A0ECh
	ldrb r0,[r4,1Ah]
	add r0,r0,r1
	ldrb r0,[r0]
	mov r1,10h
	and r0,r1
	cmp r0,0h
	beq 803CFB6h
	add r0,r4,0
	add r0,5Eh
	ldrh r2,[r0]
	add r1,r2,1h
	mov r3,1h
	cmp r2,7h
	bls DoCapeStuff
	mov r3,2h
	cmp r2,8h
	bls DoCapeStuff
	add r1,r2,0h
	mov r3,3h
	cmp r2,0Ah
	bls DoCapeStuff
	mov r3,5h
DoCapeStuff:
	add r2,r2,r3
	strh r2,[r0]
	cmp r1,0Ah
	bls TooLowCape
	mov r1,0Bh
TooLowCape:
	add r0,r4,0h
CallRewardFct:
	bl 803E430h
	b 803CFE0h
	.pool
	
.org 0x803CFDA
	mov r1,1h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org 0x803D23E	;Fix block check routine doesn't handle 16bit values properly (2)
	ldr r3,=0EB4h

.org 0x803D244
	ldr r1,=1C58h

.org 0x803D24E
	strh r0,[r1]

.org 0x803D266
	bne Down16Bit2
	b Down16Bit3
	.word 0x00000000
	.word 0x00000000
Down16Bit2:
	ldr r1,=0EB4h
	add r0,r2,r1
	mov r1,0h
	ldsh r0,[r0,r1]
	lsl r0,r0,10h
	lsr r0,r0,18h
	ldr r3,=0EBAh
	
.org 0x803D286
	ldr r0,=0EB4h
	
.org 0x803D292
	ldr r2,=0EBAh
	
.org 0x803D298
	ldr r2,=1174h

.org 0x803D2A8
	ldr r0,=1CACh
	add r2,r4,r0
	ldr r0,=810B9EEh
	add r0,r5,r0
	mov r1,0h
	ldsb r1,[r0,r1]
	ldrh r2,[r2]
	add r1,r1,r2
	ldr r2,[r6]
	ldr r3,=0EB6h
	add r0,r2,r3
	strh r1,[r0]
	ldr r0,[r7]
	add r0,30h
	strh r1,[r0]
	lsl r1,r1,10h
	lsr r1,r1,18h
	ldr r5,=0EB8h
	add r0,r2,r5
	strh r1,[r0]
	add r1,r2,r3
	ldrb r0,[r1]
	strh r0,[r1]
	add r0,r2,r5
	mov r3,0h
	ldsh r0,[r0,r3]
	cmp r0,1h
	ble 803D2F4h
	b 803D526h
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.halfword 0x0000

.org 0x803D348
	.pool

.org 0x803D3B8
	.word 0x00000000
	.word 0x00000000
Down16Bit3:
	ldr r4,=3007A48h
	ldr r2,[r4]
	ldr r6,=3002340h
	ldr r0,=1C58h
	add r7,r6,r0
	ldr r3,=0EB4h
	add r0,r2,r3
	mov r3,0h
	ldsh r0,[r0,r3]
	lsl r0,r0,10h
	lsr r0,r0,18h
	ldr r1,=0EB8h
	
.org 0x803D3DE
	ldr r0,=0EB4h
	
.org 0x803D3EA
	ldr r1,=0EB8h
	
.org 0x803D3F8
	ldr r0,=1CACh
	add r2,r6,r0
	ldr r0,=810B9EEh
	add r0,r5,r0
	mov r1,0h
	ldsb r1,[r0,r1]
	ldrh r2,[r2]
	add r1,r1,r2
	ldr r2,[r4]
	ldr r3,=0EB6h
	add r0,r2,r3
	strh r1,[r0]
	ldr r0,[r7]
	add r0,30h
	strh r1,[r0]
	lsl r1,r1,10h
	lsr r1,r1,18h
	ldr r5,=0EBAh
	add r2,r2,r5
	strh r1,[r2]
	ldr r2,[r4]
	add r3,r2,r3
	ldrb r0,[r3]
	strh r0,[r3]
	add r4,r2,r5
	ldr r0,[r7]
	ldr r5,=1174h
	add r0,r0,r5
	mov r5,0h
	ldsh r1,[r4,r5]
	ldrb r0,[r0]
	cmp r1,r0
	bge 803D526h
	mov r1,0h
	ldsh r0,[r3,r1]
	asr r0,r0,4h
	ldr r5,=0EB4h
	add r3,r2,r5
	ldrh r1,[r3]
	orr r0,r1
	strh r0,[r3]
	ldrb r6,[r4]
	ldr r1,=0ECDh
	add r0,r2,r1
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	cmp r0,0h
	bne 803D4BCh
	ldr r0,=8119FD8h
	lsl r2,r6,2h
	add r0,r2,r0
	mov r4,0h
	ldsh r3,[r3,r4]
	ldr r0,[r0]
	add r4,r3,r0
	ldr r0,[r7]
	add r0,2Dh
	ldrb r1,[r0]
	lsl r1,r1,8h
	add r4,r4,r1
	ldr r0,=811A058h
	b 803D4E4h
	.pool
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000

;Prevent Bravo Mario/Luigi message OAM from overwriting reward pop-ups on screen
.org 0x803DBE6
	b EndOfAllLoopsMessageOAM

.org 0x803DBEC
	mov r5,6h
	ldrh r0,[r6,16h]
	cmp r0,0FFh
	bls TwoDigitLifeMessage
	mov r5,7h

TwoDigitLifeMessage:
	sub r7,r5,1h
	mov r4,0Bh

LifeMessageLoop1:
	ldr r0,=3007A48h
	ldr r1,[r0]
	lsl r0,r4,3h
	sub r0,r0,r4
	lsl r0,r0,2h
	add r1,r1,r0
	mov r3,0A1h
	lsl r3,r3,3h
	add r1,r1,r3
	ldrb r0,[r1]
	cmp r0,0h
	bne NoSpaceMessageLoop1
	ldr r3,=810BAD8h
	cmp r5,r7
	bhi DownFirstGraphic1
	lsl r0,r5,2h
	add r3,r3,r0
DownFirstGraphic1:	
	ldr r0,=813A84Ch
	add r0,r4,r0
	ldrb r1,[r0]
	lsl r2,r7,18h
	ldr r3,[r3]
	add r0,r6,0
	lsr r2,r2,18h
	bl 809F040h
	sub r5,1h

NoSpaceMessageLoop1:
	cmp r5,0h
	beq EndOfAllLoopsMessageOAM
	sub r4,1h
	cmp r4,0h
	bge LifeMessageLoop1
	mov r4,0Dh

LifeMessageLoop2:
	ldr r0,=3007A48h
	ldr r0,[r0]
	lsl r1,r4,5h
	add r0,r0,r1
	mov r1,0D2h
	lsl r1,r1,2h
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne NoSpaceMessageLoop2
	ldr r3,=810BAD8h
	cmp r5,r7
	bhi DownFirstGraphic2
	lsl r0,r5,2h
	add r3,r3,r0

DownFirstGraphic2:
	ldr r0,=813A85Ch
	add r0,r4,r0
	ldrb r1,[r0]
	lsl r2,r7,18h
	ldr r3,[r3]
	add r0,r6,0
	lsr r2,r2,18h
	bl 809F040h
	sub r5,1h

NoSpaceMessageLoop2:
	cmp r5,0h
	beq EndOfAllLoopsMessageOAM
	sub r4,1h
	cmp r4,0h
	bge LifeMessageLoop2
	mov r4,7h

LifeMessageLoop3:
	ldr r0,=3007A48h
	ldr r1,[r0]
	lsl r0,r4,3h
	sub r0,r0,r4
	lsl r0,r0,2h
	add r1,r1,r0
	mov r2,0B8h
	lsl r2,r2,1h
	add r1,r1,r2
	ldrb r0,[r1]
	cmp r0,0h
	bne NoSpaceMessageLoop3
	ldr r3,=810BAD8h
	cmp r5,r7
	bhi DownFirstGraphic3
	lsl r0,r5,2h
	add r3,r3,r0

DownFirstGraphic3:
	ldr r0,=813A871h
	add r0,r4,r0
	ldrb r1,[r0]
	lsl r2,r7,18h
	ldr r3,[r3]
	add r0,r6,0
	lsr r2,r2,18h
	bl 809F040h
	sub r5,1h

NoSpaceMessageLoop3:
	cmp r5,0h
	beq EndOfAllLoopsMessageOAM
	sub r4,1h
	cmp r4,0h
	bge LifeMessageLoop3

EndOfAllLoopsMessageOAM:
	pop r4-r7
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpacePUP:
	mov r0,8h
	strb r0,[r1]
	mov r1,0E5h
	lsl r1,r1,5h
	add r0,r2,r1
	mov r1,0h
	strb r1,[r0]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Prevent 1up sound from getting triggerd to often when you get multiple coins in a row
.org 0x803DEB0
	ldr r3,[r3]
	
.org 0x803DEB4
	add r1,r3,r2
	
.org 0x803DEC4
	strh r0,[r1]
	ldr r1,=10F2h
	add r0,r3,r1
	cmp r4,0h
	bne No1upSound
	strb r4,[r0]
No1upSound:

.org 0x803DEEC
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix chucks and koopalings use the same counter for fireballs and stomp hits;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Makes boos, boo blocks and big boos track the Players y-position accurately;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Prevents ninjis from clipping into the ceiling;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains a fix for a bug that causes the reminders of a block destroyed by a chuck use the wrong palette
;Also contains a fix for a bug that causes chucks to destroy the ceiling in certain cases;;;;;;;;;;;;;;;;;;;;;
;Also contains a fix for whistelin' chuck summons super koopas underwater;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains a fix of exploding bobomb death animation;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains a fix for thwomps always falling when vertically offscreen;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Fixes a bug that causes kamek's magic to turn stone into a sprite;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also makes it so you can get up to a 5up when defeating wiggler with a star;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains a fix for the priority of the smasher;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.org 0x803E7C4	;chucks fireballs 
	add r1,3h

.org 0x803E7CA
	cmp r0,0Eh
	
.org 0x803E804	;Make chucks give the player 2000p (+3 coins) when killing him with fire balls
	mov r1,5h

.org 0x804024C	;big boos
	mov r1,30h

.org 0x80408C8	;boos
	mov r1,0h
	
.org 0x8040A5C	;boo blocks
	mov r1,0h
	
.org 0x8041DC8	;Prevent ninjis from clipping through the ceiling
	mov r1,0Ch
	
.org 0x804282A	;chucks stomp
	add r1,5h

.org 0x8042830
	cmp r0,0Eh
	
.org 0x80428D4	;Fixes the palette of the reminders of a block destroyed by a chuck and prevents chucks from destroying the ceiling in certain cases
	push r4-r7,r14
	add r0,2Bh
	ldrb r0,[r0]
	mov r1,4h
	and r0,r1
	cmp r0,0h
	beq DownChuckDestroyNo
	ldr r6,=3002340h
	ldr r0,=1C58h
	add r5,r6,r0
	ldr r1,[r5]
	add r1,30h
	ldrh r7,[r1]
	sub r1,4h
	ldrh r4,[r1]
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0674h
	add r0,r0,r1
	ldrh r2,[r0]
	mov r0,0h
	cmp r2,1Eh
	beq TurnBlockDestroyed1
	mov r0,0FFh
TurnBlockDestroyed1:
	bl 802F044h
	ldr r1,=1D4Ah
	add r6,r6,r1
	mov r0,2h
	strb r0,[r6]
	bl 800EEC8h
	sub r4,10h
	mov r0,r7
	mov r1,r4
	bl 8032478h
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldrb r2,[r0]
	ldr r1,=0674h
	add r0,r0,r1
	strh r2,[r0]
	ldrh r2,[r0]
	cmp r2,2Eh
	beq ChuckDestroyMoreBlocks
	cmp r2,1Eh
	bne ChuckDestroyedBlocks
ChuckDestroyMoreBlocks:
	ldr r1,[r5]
	add r1,30h
	strh r7,[r1]
	sub r1,4h
	strh r4,[r1]
	mov r0,0h
	cmp r2,1Eh
	beq TurnBlockDestroyed2
	mov r0,0FFh
TurnBlockDestroyed2:
	bl 802F044h
	mov r0,2h
	strb r0,[r6]
	bl 800EEC8h
ChuckDestroyedBlocks:
	mov r0,1h
	b DownChuckDestroyYes
	.pool

DownChuckDestroyNo:
	mov r0,0h

DownChuckDestroyYes:
	pop r4-r7
	pop r1
	bx r1
	
.org 0x8043494	;Fix whistlin' chucks summons super koopas underwater
	ldr r2,=3002340h
	ldr r1,=0894h

.org 0x80434A4
	ldr r3,=08C4h

.org 0x80434BC
	ldr r0,=3002340h
	ldr r1,=0894h
	
.org 0x80434D4
	ldr r0,=3002340h
	ldr r3,=0894h

.org 0x80434E4
	ldr r0,=810C696h

.org 0x80434EC
	ldr r0,=3007A48h
	ldr r2,[r0]
	ldr r0,[r4]
	ldr r1,[r4,8h]
	sub r0,r0,r1
	asr r0,r0,10h
	mov r1,10h
	and r0,r1
	cmp r0,0h
	beq WakeUpFish
	mov r3,0D2h
	lsl r3,r3,3h
	b SetWhistleChuckValues
	.pool
WakeUpFish:
	ldr r3,=06A9h
SetWhistleChuckValues:
	add r0,r2,r3
	mov r1,9h
	strb r1,[r0]
	pop r4
	pop r0
	bx r0
	.pool
	
.org 0x8043674
	ldrb r0,[r4,1Bh]
	lsl r0,r0,1Ch
	lsr r0,r0,1Ah
	
.org 0x80452F8	;Fix exploding bobomb death animation
	mov r0,80h
	
.org 0x804572A	;Increase limit to 5up
	b 8045834h
	
.org 0x8045830
	.word 0x00000000
	mov r0,2h
	strb r0,[r4,1Ch]
	ldr r0,=0FFFD0000h
	str r0,[r4,0Ch]
	add r0,r4,0h
	bl 802FB18h
	ldr r1,=810CC3Ch
	lsl r0,r0,18h
	lsr r0,r0,16h
	add r0,r0,r1
	ldr r0,[r0]
	str r0,[r4,8h]
	ldr r5,=3007A48h
	ldr r1,[r5]
	ldr r3,=069Fh
	add r6,r1,r3
	ldrb r0,[r6]
	add r0,1h
	strb r0,[r6]
	ldrb r0,[r6]
	sub r3,r0,7h
	cmp r0,0Ah
	bls NotAt5ups1
	mov r0,0Bh
	strb r0,[r6]
	mov r3,5h
NotAt5ups1:
	cmp r0,7h
	bls NotAt5ups2
	ldr r1,[r5]
	mov r0,0D8h
	lsl r0,r0,3h
	add r1,r1,r0
	ldrh r0,[r1]
	add r0,r0,r3
	strh r0,[r1]
NotAt5ups2:
	ldrb r1,[r6]

.org 0x80458C4
	.pool
	
.org 0x804A1AE	;Prevent thwomps from always falling when vertially offscreen
	ble 804A210h

.org 0x804A1F4
	add r0,28h

.org 0x80501C4	;Fixed kamek's wand having a higher sprite priority than its body (Credits: MisterMan)
	.halfword 0x0939

.org 0x80506B6	;Fix kamek's magic turns stone into sprites
	bhi 805074Ah

.org 0x80506EC
	blt 80506F6h
	
.org 0x80506F2
	bhi 80506F6h
	
.org 0x8052F3E	;Fix lakitu's / lishin' lakitu's incorrect head positioning (Credits: MisterMan)
	bne 8052F54h
	
.org 0x8052F44
	mov r1,0h

.org 0x8052F58
	mov r1,2h
	
.org 0x8055A6A	;Fix priority of smasher
	mov r0,0Ch
	
.org 0x8058838	;Prevent wiggler stomp counter from overflowing
	ldrh r2,[r0]
	sub r3,r2,7h
	cmp r2,0Ah
	bls NotAtTheLimit
	mov r2,0Bh
	strh r2,[r0]
	mov r3,5h
NotAtTheLimit:
	cmp r2,7h
	bls NoNeedToCountLives
	b CountLives

.org 0x805888C
CountLives:
	ldr r0,=3007A48h
	ldr r1,[r0]
	ldr r5,=06BEh
	add r1,r1,r5
	ldrh r0,[r1]
	add r0,r0,r3
	strh r0,[r1]
NoNeedToCountLives:
	ldr r0,=3002340h
	ldr r5,=1D4Ch
	add r0,r0,r5
	ldrb r1,[r0]
	add r0,r4,0
	bl 803E430h
	add r1,r4,0
	add r1,22h
	mov r0,40h
	strb r0,[r1]
	ldrb r0,[r4,1Fh]
	add r0,1h
	strb r0,[r4,1Fh]
	add r0,r4,0
	bl 8058670h
	b 8058A4Eh
	.pool
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	
.org 0x8058936	;Make wiggler give up to 5ups if defeated with a star
	ldr r0,=0FFFD0000h
	str r0,[r4,0Ch]
	ldr r2,=3007A48h
	ldr r1,[r2]
	ldr r5,=069Fh

.org 0x805894E
	sub r2,r0,7h
	cmp r0,0Ah
	bls Wiggler5upLimit
	mov r0,0Bh
	strb r0,[r1]
	mov r2,5h
Wiggler5upLimit:
	cmp r0,7h
	bls 805898Ah
	b WigglerWriteLimit
	.pool
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.halfword 0x0000
WigglerWriteLimit:
	ldr r0,=3007A48h
	ldr r1,[r0]
	
.org 0x8058986
	add r0,r0,r2

.org 0x80589DC
	.pool
	
.org 0x805CBB0	;Reset Yoshicolor when reseting Yoshi
	strh r1,[r0]
	
.org 0x805CCC4	;Reset Yoshicolor when reseting Yoshi
	strh r1,[r0]
	
.org 0x805D124	;Make silver coins give up to 5ups per coin (when eaten by yoshi)
	ldr r1,=3002340h
	ldr r0,=8C4h

.org 0x805D144
	beq NotAt5ups3
	mov r4,1h
	b GiveUpsCoinsEaten
	.pool
NotAt5ups3:
	ldr r2,=3007A48h
	ldr r1,[r2]
	ldr r0,=0684h
	add r1,r1,r0
	ldrb r4,[r1]
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]
	sub r3,r4,7h
	cmp r4,0Ah
	bls NotAt5ups4
	mov r4,0Bh
	strb r4,[r2]
	mov r3,5h
NotAt5ups4:
	cmp r4,7h
	bls DownDontGiveUps
	ldr r0,=3007A48h
	ldr r1,[r0]
	ldr r2,=06C2h
	add r1,r1,r2
	ldrh r0,[r1]
	add r0,r0,r3
	strh r0,[r1]
DownDontGiveUps:
	add r0,r5,0h
	bl 80486A8h
GiveUpsCoinsEaten:
	add r0,r5,0
	add r1,r4,0
	bl 803E430h
	mov r2,3h
	ldr r0,=3007A48h
	mov r4,0BCh
	lsl r4,r4,2h
	ldr r3,[r0]
StartLoopCoinsEaten:
	lsl r0,r2,18h
	asr r0,r0,14h
	add r0,r0,r4
	add r1,r0,r3
	ldrb r0,[r1,0Ch]
	cmp r0,0h
	beq 805D1D4h
	lsl r0,r2,18h
	mov r1,0FFh
	lsl r1,r1,18h
	add r0,r0,r1
	lsr r2,r0,18h
	cmp r0,0h
	bge StartLoopCoinsEaten
	b 805D25Eh
	.pool
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	
;Prevents updating some Yoshi stuff when the sprite	in Yoshis sprite slot is no longer a Yoshi
;Also contains code that resets the Yoshicolor when reseting the riding a Yoshi flag;;;;;;;;;;
;Also contains a fix for the collision with certain invincible sprites while riding Yoshi;;;;;
;Also prevents Yoshi from standing on sprites that have not a normal status;;;;;;;;;;;;;;;;;;;
.org 0x805E8B0	;Prevent using the riding Yoshi flag before it was updated
	ldr r3,=3002340h
	ldr r1,=1CD6h

.org 0x805E8BC
	ldr r4,=0854h

.org 0x805E8CC
	ldr r0,=1D4Eh

.org 0x805E8E6
	ldrb r0,[r1,1Bh]
	cmp r0,1h
	bne UpdateYoshiAnimation
	ldr r3,=3002340h
	ldr r4,=1C58h
	add r0,r3,r4
	ldr r1,[r0]
	ldr r4,=114Ah
	add r0,r1,r4
	ldrb r0,[r0]
	cmp r0,1h
	bne UpdateYoshiAnimation
	ldr r1,=893h
	add r0,r3,r1
	ldrb r0,[r0]
	mov r1,8h
	and r0,r1
	lsl r0,r0,18h
	lsr r0,r0,1Bh
	mov r2,r0
	add r2,8h
UpdateYoshiAnimation:
	mov r0,r12
	add r0,36h
	strb r2,[r0]
	pop r4
	pop r0
	bx r0
	.pool
	.word 0x00000000

.org 0x805EABE	;Prevent Yoshi updating when Yoshi is despawned
	ldr r5,=3007A48h
	ldr r6,[r5]
	ldr r2,=0689h
	add r0,r6,r2
	ldrb r3,[r0]
	cmp r3,0h
	beq DownNoYoshi3
	ldr r7,=3002340h
	ldr r0,[r7,20h]
	add r0,0E2h
	mov r1,0h
	strh r1,[r0]
	sub r2,1Dh
	add r0,r6,r2
	strb r1,[r0]
	ldr r2,=1C58h
	add r0,r7,r2
	ldr r0,[r0]
	ldr r2,=10FAh
	add r0,r0,r2
	strb r1,[r0]
	ldr r2,=0F26h
	add r0,r6,r2
	strb r1,[r0]
	add r2,1h
	add r0,r6,r2
	mov r1,0FFh
	strb r1,[r0]
	sub r2,52h
	add r5,r6,r2
	ldrb r4,[r5]
	sub r3,1h
	strb r3,[r5]
	ldrb r1,[r5]
	mov r0,64h
	mul r0,r1
	ldr r1,=06CCh
	add r0,r0,r1
	add r6,r6,r0
	ldrb r0,[r6,1Ah]
	cmp r0,35h
	bne DownNoYoshi2
	add r0,r6,0h
	bl 805EA08h
	ldr r1,=1C58h
	add r0,r7,r1
	ldr r0,[r0]
	ldr r2,=1190h
	add r0,r0,r2
	ldrb r0,[r0]
	cmp r0,0h
	beq DownNoYoshi2
	add r1,6Ah
	add r0,r7,r1
	ldrb r0,[r0]
	cmp r0,0h
	beq DownNoYoshi2
	add r1,r6,0
	add r1,25h
	ldrb r0,[r1]
	cmp r0,0h
	beq DownNoYoshi2
	ldrb r0,[r1]
	sub r0,1h
	strb r0,[r1]
DownNoYoshi2:
	strb r4,[r5]
DownNoYoshi3:
	pop r4-r7
	pop r0
	bx r0
	.pool
	
.org 0x805EF16	;Fixes collision with certain invincible sprites when riding yoshi
	mov r0,r2
	add r0,41h
	ldrb r0,[r0]
	mov r1,82h
	and r0,r1
	cmp r0,82h
	beq SpriteDoesNotHurt
	mov r0,0h
SpriteDoesNotHurt:
	mov r1,r2
	add r1,32h
	ldrb r3,[r1]
	orr r0,r3
	add r1,0Ah
	ldrb r1,[r1]
	orr r0,r1
	
.org 0x805FBA6	;Prevents Yoshi from standing on sprites that have not a normal status
	cmp r0,8h
	bne 805FC40h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.org 0x8062BF4	;Fixed the smoke for the chainsaws and rope machines spawning in an incorrect Y position (Credits: MisterMan)
	sub	r0,0Eh
	
.org 0x8064FF8	;koopaling stomp
	add r0,4h

.org 0x8064FFE
	cmp r0,0Bh
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;others
.org 0x8066CC4	;Prevent Lemmy and Wendy from giving points after stomping on them
	bgt StompedKoopalingOrPuppet

.org 0x8066CD4
	.word 0x00000000
	.word 0x00000000
StompedKoopalingOrPuppet:
	mov r0,r4
	bl 803056Ch

.org 0x8067E60	;Reduce y-speed of item on goal to prevent it from despawn
	.word 0xFFFE0000
	
.org 0x8067E86	;Makes goal coin points start at level 4
	add r1,r0,r4
	mov r2,4h
	strb r2,[r1]

.org 0x8067E92
	strh r4,[r1]
	
.org 0x806D3D6	;Fix Player floating if they fell from Iggy's / Larry's tilting platform while sliding (Credits: MisterMan)
	blt DownNotAirborne
	
.org 0x806D3E6
	b DownNotAirborne

.org 0x806D3FC
	ldr r2,=3002340h
	ldr r1,=1C66h

.org 0x806D408
	ldr r1,=1C61h

.org 0x806D412
	bne DownNotAirborne
	mov r0,24h
	strb r0,[r3]
DownNotAirborne:
	pop r0
	bx r0
	.pool
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
;;;;;;;

;Part of StarBlockRespawn (SBR)
.org 0x806E07C
	bl FreeSpaceSBR
	lsl r0,r0,18h
	asr r0,r0,18h
	cmp r0,0h
	bne 806E112h
	mov r0,1Eh
	strb r0,[r1]
	b 806E114h

.org 0x806E420	;Prevent Mario/Luigi from getting a mushroom from a midpoint that doesn't work
	beq 806E43Ch
	
.org 0x806E4F6
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;others
.org 0x806E676	;Make yoshi coins give up to a 5up
	cmp r2,0Fh
	bls 806E67Ch
	mov r2,10h
	
.org 0x806E920	;Reset ducking flag and terminate gliding when climbing
	ldr r1,=1C61h
	add r3,r0,r1
	bl FreeSpaceRDF

.org 0x806E994
	.pool
	
.org 0x8071164	;Prevent the midpoint from geting activated when dying after the level ended
	push r4-r6,r14
	lsl r1,r1,18h
	lsr r5,r1,18h
	ldr r6,=3002340h
	ldr r1,=1C5Ch
	add r4,r6,r1
	ldr r1,[r4]
	add r1,2Bh
	strb r0,[r1]
	ldr r2,=89Eh
	add r0,r6,r2
	ldrb r0,[r0]
	cmp r0,0h
	beq Checkpoint4
	mov r2,7h
	ldr r0,[r6,20h]
	add r0,0A0h
	ldrh r0,[r0]
	cmp r0,13h
	bne Checkpoint1
	ldr r1,[r4]
	add r1,2Bh
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]

Checkpoint1:
	ldr r0,[r6,20h]
	add r0,0A0h
	ldrh r0,[r0]
	cmp r0,31h
	beq Checkpoint2
	cmp r2,0h
	blt Checkpoint4
	ldr r0,[r6,20h]
	add r0,0A0h
	ldrh r1,[r0]
	ldr r3,=811A2A8h

Checkpoint_Loop:
	add r0,r3,r2
	ldrb r0,[r0]
	cmp r1,r0
	beq Checkpoint2
	sub r2,1h
	cmp r2,0h
	bge Checkpoint_Loop
	b Checkpoint4
.pool

Checkpoint2:
	cmp r2,7h
	beq Checkpoint3
	lsl r0,r2,1h
	ldr r1,[r6,20h]
	add r1,0A2h
	add r1,r1,r0
	ldrh r0,[r1]
	add r0,1h
	strh r0,[r1]

Checkpoint3:
	add r1,r2,1
	ldr r2,=089Eh
	add r0,r6,r2
	strb r1,[r0]
	mov r5,28h

Checkpoint4:
	ldr r2,=886h
	add r0,r6,r2
	strb r5,[r0]
	ldr r2,=1C5Ch
	add r0,r6,r2
	ldr r2,[r0]
	ldrb r0,[r2,1Eh]
	add r0,1h
	strb r0,[r2,1Eh]
	ldr r0,[r6,20h]
	ldr r2,=115h
	add r1,r0,r2
	ldrb r3,[r1]
	cmp r3,0h
	bne Checkpoint5
	mov r0,1h
	strb r0,[r1]
	ldr r0,[r6,20h]
	sub r2,1h
	add r1,r0,r2
	strb r3,[r1]
	
Checkpoint5:
	bl 800CC64h
	bl 8070B08h
	pop r4-r6
	pop r0
	bx  r0
.pool

.org 0x807135C	;Reserve item drops only if select was pressed
	bhi 80713B0h
	
.org 0x80713AC
	.word 0x00000000
;;;;;;;

;Fix Crash when pressing button at the wrong time during intro
.org 0x8072E50
	ldrb r1,[r0,14h]
	cmp r1,0Eh
	beq 8072E66h
	bl FreeSpaceFIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Remove delay before beeing able to press A or Start in the mode select screen (only present in non-japanese versions)
.org 0x8073408
	mov r0,0h

.org 0x8073546
	ldr r0,=3002340h
	ldr r1,=0856h
	
.org 0x8073552
	ldr r0,=3007A38h

.org 0x807355C
	ldr r0,=3007A38h

.org 0x8073568
	beq DownSetNotZero
	mov r0,0h
	strh r0,[r1]
DownSetNotZero:
	ldr r4,=03002340h
	ldr r2,=0856h
	add r0,r4,r2
	ldrh r0,[r0]
	mov r1,0C0h
	and r0,r1
	cmp r0,0h
	beq 80735ACh
	ldr r0,=0828h
	add r1,r4,r0
	mov r0,0h
	bl 809C1C4h
	ldr r1,=0888h
	add r2,r4,r1
	ldrb r1,[r2]
	mov r0,1h
	bic r0,r1
	strb r0,[r2]
	b 8073684h
	.pool

.org 0x80740EA
	mov r0,0h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of Highscore Tweaks (HST);;;;;;;;;;;;;
.org 0x807A050
	blt DownHST1
	
.org 0x807A05A
	b DownHST2

.org 0x807A084
	.word 0x00989676
	.halfword 0x0000
DownHST1:	;7A08A
	ldr r1,=1E8480h
	ldr r0,[r3]
	bl 809EBBCh
	mov r1,r4
	add r1,9Ch
	str r0,[r1]
	b DownHST2
	.pool
DownHST2:	;7A0A0
	ldr r4,=3002330h
	ldr r2,[r4]
	add r2,0F0h
	ldr r1,[r2]
	ldr r0,=0F4236h
	cmp r1,r0
	blt DownHST3
	ldr r1,[r4]
	mov r7,86h
	lsl r7,r7,1h
	add r1,r1,r7
	mov r0,5h
	str r0,[r1]
	b DownHST4
	.pool
	.halfword 0x0000
DownHST3:	;7A0C6
	ldr r1,=30D40h
	ldr r0,[r2]
	bl 809EBBCh
	ldr r1,[r4]
	mov r7,86h
	lsl r7,r7,1h
	add r1,r1,r7
	str r0,[r1]
	b DownHST4
	.pool
	.halfword 0x0000
DownHST4:	;7A0E2
	ldr r2,=3002330h
	
.org 0x807A194
	.word 0x00000000
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of FixButtonInputs (FBI);;;;;;;;;;;;;;;;;;;;;;;
;Also contains parts of Perma SaveSlot (PSS) and others
.org 0x807A444
	.word 0x00000000
	.halfword 0x0000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpacePSS3:
	push r14
	mov r0,3h
	strb r0,[r1]
	bl 8008308h
	pop r0
	bx r0
FreeSpacePSS4:
	push r14
	mov r0,6h
	strb r0,[r1]
	bl 8008308h
	pop r0
	bx r0
FreeSpacePSS5:
	push r14
	ldrb r1,[r5]
	strb r1,[r0]
	bl 8008058h
	mov r0,0h
	ldsb r0,[r4,r0]
	ldrb r2,[r6,16h]
	pop r1
	bx r1	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BeginFuncFBI:
	push r4-r7,r14
	ldr r2,=3002340h
	ldr r1,=856h
	add r0,r2,r1
	ldrh r1,[r0]
	mov r0,0C0h
	and r0,r1
	cmp r0,0h
	bne 807A48Eh
	b 807A6A4h
	
.org 0x807A548
	.word 0x00000000
	.pool
	
.org 0x807A7F0
	mov r1,6h
	
.org 0x807A7F0
	mov r1,6h
	
.org 0x807B81E
	mov r1,0C0h
	
.org 0x807C30C
	mov r1,6h
	
.org 0x807C838
	mov r1,6h

.org 0x8080B26
	bne ButtonCheck1
	
.org 0x8080B48
	.word 0x00000000
	.halfword 0x0000
ButtonCheck1:
	ldr r0,=3002340h
	ldr r1,=856h
	add r0,r0,r1
	ldrh r2,[r0]
	mov r1,9h
	and r2,r1
	cmp r2,0h
	beq 8080BA0h
	
.org 0x8080BA8
	.pool

.org 0x8080D00
	bls ButtonCheck2
	
.org 0x8080D1C
	.word 0x00000000
	.halfword 0x0000
ButtonCheck2:
	ldr r0,=3002340h
	ldr r1,=856h
	add r0,r0,r1
	ldrh r2,[r0]
	mov r1,9h
	and r2,r1
	cmp r2,0h
	beq 8080D74h

.org 0x8080D7A
	.pool
	
.org 0x8080EFC
	mov r1,6h
	
.org 0x8083E76
	mov r0,0C0h

.org 0x8083E82
	mov r0,0C0h
	and r0,r1
	cmp r0,0h
	
.org 0x8088694
	mov r1,6h

.org 0x8088842
	mov r1,6h
	
.org 0x8089220
	mov r1,0C0h
	
.org 0x80893D8
	mov r1,6h
	
.org 0x8089868
	mov r1,6h

;others
.org 0x809C208	;Makes sound play immediately, even if another sound is already playing
	cmp r0,1h
	bls 809C26Ch

.org 0x80D5194	;Deletes Button Combo for showing build date
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	
.org 0x80D5C14	;Replace old level default value table with a sprite table
SpriteTableStatus:
	.byte 0x09, 0x08, 0x08, 0x09
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	
.org 0x80D6A7A	;Fixes color of yellow yoshi in ow
	.halfword 0x197D, 0x1AFF

.org 0x80D6A82	;Fixes color of blue yoshi in ow
	.halfword 0x7DCE
	
.org 0x80DE69E	;Fix issue with level mode 1Eh and 1Fh
	.byte 0x05, 0x06
	
.org 0x80E21D2	;Fix typo in wendys german defeat text
	.halfword 0x111B, 0x111F
	.halfword 0x1104, 0x1148
	.halfword 0x114D, 0x111F
	.halfword 0x1155, 0x1144
	.halfword 0x1151, 0x1152
	.halfword 0x1154, 0x114D
	.halfword 0x114A, 0x1144
	.halfword 0x114D, 0x1144
	.halfword 0x1152
	
.org 0x80E7AE6	;Restored Bill Blaster's unused right bottom tile (Credits: MisterMan)
	.byte	0x1B ,0x40	
	
.org 0x80EE1B2	;Fix tiling error in intro level
	.byte 0x1A
	
.org 0x80EF1C2	;Removes time limit in top secret area
	.byte 0x00
	
.org 0x80EF1E4	;Fix Donut ghosthouse has wrong bg color	
	.byte 0x60
	
.org 0x80F9999	;Fix a tile above Vanilla Dome's entrance being mirrored incorrectly in the world map (Credits: MisterMan)
	.byte	0x64

.org 0x80FA330	;Swap the dark rooms in front and back door to make the font door one have the checkpoint (Credits: MisterMan)
	.word	0x080F6D1C
	
.org 0x80FA5EC
	.word	0x080F3737
	
.org 0x80FBE7D
	.byte	0x62, 0x02
	
.org 0x80FD19A
	.halfword	0x01BD

.org 0x80FD8A0	;Fix Forest of Illusion 2's background being positioned incorrectly after a checkpoint (Credits: MisterMan)
	.byte	0x60
	
.org 0x80FD93D	;Swap the dark rooms in front and back door to make the font door one have the checkpoint (Credits: MisterMan)
	.byte	0x62	
	
.org 0x80FE727	;Fix bottom part of one of Yoshi's left facing sprites always uses Red Yoshi's palette regardless of the Yoshi's palette (Credits: MisterMan)
	.byte	0x22, 0x62, 0x22, 0x63, 0x22	
	
.org 0x80FE77F	;Fix one of Yoshi's idle inside water sprites is not mirrored (Credits: MisterMan)
	.byte	0x64	
	
.org 0x8101B2B	;Prevent star world warps from appearing after takeing the normal exit of star world 2+3
	.byte 0x55, 0x58, 0x5D, 0x00, 0x00

.org 0x8101B76	;Fix vanilla secret overworld pipe tile
	.byte 0xAA

.org 0x8101BAA	;Prevent star world warps from appearing after takeing the normal exit of star world 2+3
	.halfword 0x01F0, 0x0304, 0x0227, 0x0000, 0x0000

.org 0x8101C08
	.halfword 0x0000, 0x0000

.org 0x8101C60
	.halfword 0x0000, 0x0000
	
.org 0x8101DA6	;Prevent star world warps from appearing after takeing the normal exit of star world 1+4
	.halfword 0x0000

.org 0x8101DB8
	.halfword 0x0000
	
;overworld unlock path tweaks
.org 0x81027B0	;events
	.halfword 0x0900, 0x23CC	;0x000
	.halfword 0x0904, 0x238C	;0x001
	.halfword 0x0908, 0x234E	;0x002
	.halfword 0x090C, 0x230E	;0x003
	.halfword 0x0910, 0x22D0	;0x004
	.halfword 0x0914, 0x2290	;0x005
	.halfword 0x018C, 0x2202	;0x006
	.halfword 0x01B0, 0x2202	;0x007
	.halfword 0x01D4, 0x2202	;0x008
	.halfword 0x0A44, 0x21C6	;0x009
	.halfword 0x0A48, 0x2044	;0x00A
	.halfword 0x0A4C, 0x2186	;0x00B
	.halfword 0x0A48, 0x2004	;0x00C
	.halfword 0x0900, 0x23E4	;0x00D
	.halfword 0x0938, 0x23A4	;0x00E
	.halfword 0x0928, 0x2324	;0x00F
	.halfword 0x0918, 0x2326	;0x010
	.halfword 0x091C, 0x2328	;0x011
	.halfword 0x0920, 0x22EC	;0x012
	.halfword 0x0924, 0x22AC	;0x013
	.halfword 0x0B0C, 0x222C	;0x014
	.halfword 0x0B10, 0x21EC	;0x015
	.halfword 0x0930, 0x216C	;0x016
	.halfword 0x0934, 0x2168	;0x017
	.halfword 0x0938, 0x20E4	;0x018
	.halfword 0x0938, 0x20A4	;0x019
	.halfword 0x093C, 0x1090	;0x01A
	.halfword 0x0940, 0x104C	;0x01B
	.halfword 0x0944, 0x100C	;0x01C
	.halfword 0x0938, 0x078C	;0x01D
	.halfword 0x0938, 0x070C	;0x01E
	.halfword 0x0928, 0x068C	;0x01F
	.halfword 0x0948, 0x1014	;0x020
	.halfword 0x094C, 0x0794	;0x021
	.halfword 0x0950, 0x0754	;0x022
	.halfword 0x0938, 0x060C	;0x023
	.halfword 0x0904, 0x058C	;0x024
	.halfword 0x0954, 0x050E	;0x025
	.halfword 0x09E8, 0x0648	;0x026
	.halfword 0x09E8, 0x06C8	;0x027
	.halfword 0x0998, 0x0688	;0x028
	.halfword 0x09EC, 0x0512	;0x029
	.halfword 0x09F0, 0x04D2	;0x02A
	.halfword 0x09F4, 0x0492	;0x02B
	.halfword 0x0000, 0x04D8	;0x02C
	.halfword 0x0024, 0x0498	;0x02D
	.halfword 0x0048, 0x03D8	;0x02E
	.halfword 0x006C, 0x0356	;0x02F
	.halfword 0x0090, 0x0356	;0x030
	.halfword 0x00B4, 0x0356	;0x031
	.halfword 0x0510, 0x0518	;0x032
	.halfword 0x0928, 0x0524	;0x033
	.halfword 0x0B38, 0x0714	;0x034
	.halfword 0x0960, 0x0528	;0x035
	.halfword 0x0964, 0x056A	;0x036
	.halfword 0x0968, 0x05AC	;0x037
	.halfword 0x096C, 0x062C	;0x038
	.halfword 0x0970, 0x0630	;0x039
	.halfword 0x0974, 0x05B2	;0x03A
	.halfword 0x0978, 0x0532	;0x03B
	.halfword 0x0168, 0x07FC	;0x03C
	.halfword 0x0A50, 0x0FC0	;0x03D
	.halfword 0x00D8, 0x077C	;0x03E
	.halfword 0x00FC, 0x077C	;0x03F
	.halfword 0x0120, 0x077C	;0x040
	.halfword 0x0144, 0x077C	;0x041
	.halfword 0x0950, 0x06D4	;0x042
	.halfword 0x094C, 0x0694	;0x043
	.halfword 0x097C, 0x0614	;0x044
	.halfword 0x0980, 0x0594	;0x045
	.halfword 0x0984, 0x0718	;0x046
	.halfword 0x0988, 0x071A	;0x047
	.halfword 0x0948, 0x079C	;0x048
	.halfword 0x098C, 0x101C	;0x049
	.halfword 0x0990, 0x1060	;0x04A
	.halfword 0x0994, 0x1064	;0x04B
	.halfword 0x0938, 0x10DC	;0x04C
	.halfword 0x0998, 0x2884	;0x04D
	.halfword 0x09A4, 0x3118	;0x04E
	.halfword 0x0984, 0x311C	;0x04F
	.halfword 0x09A8, 0x30E0	;0x050
	.halfword 0x094C, 0x3060	;0x051
	.halfword 0x09A0, 0x30CA	;0x052
	.halfword 0x09A0, 0x310E	;0x053
	.halfword 0x09B0, 0x3110	;0x054
	.halfword 0x09B4, 0x30CC	;0x055
	.halfword 0x09B8, 0x308C	;0x056
	.halfword 0x09BC, 0x300C	;0x057
	.halfword 0x09BC, 0x278C	;0x058
	.halfword 0x09BC, 0x27A0	;0x059
	.halfword 0x09BC, 0x2720	;0x05A
	.halfword 0x09AC, 0x26A0	;0x05B
	.halfword 0x0928, 0x2620	;0x05C
	.halfword 0x0A00, 0x3064	;0x05D
	.halfword 0x0A04, 0x30A8	;0x05E
	.halfword 0x0A08, 0x3128	;0x05F
	.halfword 0x0918, 0x2622	;0x060
	.halfword 0x0998, 0x2626	;0x061
	.halfword 0x09C0, 0x262A	;0x062
	.halfword 0x09C4, 0x266C	;0x063
	.halfword 0x09C8, 0x2670	;0x064
	.halfword 0x09CC, 0x26B0	;0x065
	.halfword 0x0928, 0x2730	;0x066
	.halfword 0x09D0, 0x2770	;0x067
	.halfword 0x0938, 0x27B0	;0x068
	.halfword 0x0928, 0x3030	;0x069
	.halfword 0x0938, 0x30B0	;0x06A
	.halfword 0x0938, 0x30F0	;0x06B
	.halfword 0x09D4, 0x31B0	;0x06C
	.halfword 0x09D8, 0x322E	;0x06D
	.halfword 0x0998, 0x322A	;0x06E
	.halfword 0x09E0, 0x26CC	;0x06F
	.halfword 0x09BC, 0x268C	;0x070
	.halfword 0x09E4, 0x260C	;0x071
	.halfword 0x09DC, 0x2704	;0x072
	.halfword 0x09DC, 0x26C0	;0x073
	.halfword 0x09DC, 0x2740	;0x074
	.halfword 0x0998, 0x01B4	;0x075
	.halfword 0x0B0C, 0x01B8	;0x076
	.halfword 0x0B30, 0x0988	;0x077
	.halfword 0x0B34, 0x09A0	;0x078
	.halfword 0x0A10, 0x098A	;0x079
	.halfword 0x0A10, 0x099E	;0x07A
	.halfword 0x0A0C, 0x098C	;0x07B
	.halfword 0x0A0C, 0x099C	;0x07C
	.halfword 0x0A10, 0x098E	;0x07D
	.halfword 0x0A10, 0x099A	;0x07E
	.halfword 0x0A0C, 0x0990	;0x07F
	.halfword 0x0A0C, 0x0998	;0x080
	.halfword 0x0A10, 0x0992	;0x081
	.halfword 0x0A10, 0x0996	;0x082
	.halfword 0x0A14, 0x09A4	;0x083
	.halfword 0x03A8, 0x0830	;0x084
	.halfword 0x0A18, 0x09AC	;0x085
	.halfword 0x0A1C, 0x09F0	;0x086
	.halfword 0x099C, 0x0A70	;0x087
	.halfword 0x0A20, 0x0AF0	;0x088
	.halfword 0x0A20, 0x0B70	;0x089
	.halfword 0x0A20, 0x0BF0	;0x08A
	.halfword 0x0A24, 0x0C70	;0x08B
	.halfword 0x0938, 0x0CF0	;0x08C
	.halfword 0x0A28, 0x0D30	;0x08D
	.halfword 0x0A2C, 0x0A98	;0x08E
	.halfword 0x0A30, 0x0A9C	;0x08F
	.halfword 0x0B14, 0x0B10	;0x090
	.halfword 0x0B18, 0x0B90	;0x091
	.halfword 0x0A34, 0x0B1C	;0x092
	.halfword 0x0A38, 0x0B5E	;0x093
	.halfword 0x0A3C, 0x0B62	;0x094
	.halfword 0x0A40, 0x0B66	;0x095
	.halfword 0x0A20, 0x0AE8	;0x096
	.halfword 0x099C, 0x0A68	;0x097
	.halfword 0x0A7C, 0x33A4	;0x098
	.halfword 0x0A7C, 0x33E8	;0x099
	.halfword 0x0A7C, 0x3468	;0x09A
	.halfword 0x0918, 0x33A2	;0x09B
	.halfword 0x09C0, 0x33A4	;0x09C
	.halfword 0x0930, 0x33E8	;0x09D
	.halfword 0x0A54, 0x3428	;0x09E
	.halfword 0x0938, 0x34A8	;0x09F
	.halfword 0x0A7C, 0x3398	;0x0A0
	.halfword 0x0A7C, 0x339C	;0x0A1
	.halfword 0x0A58, 0x339E	;0x0A2
	.halfword 0x0998, 0x339C	;0x0A3
	.halfword 0x0928, 0x3398	;0x0A4
	.halfword 0x0A7C, 0x3626	;0x0A5
	.halfword 0x0A7C, 0x3620	;0x0A6
	.halfword 0x0A5C, 0x3568	;0x0A7
	.halfword 0x0914, 0x35A8	;0x0A8
	.halfword 0x09D8, 0x3626	;0x0A9
	.halfword 0x091C, 0x3624	;0x0AA
	.halfword 0x0928, 0x3620	;0x0AB
	.halfword 0x0A7C, 0x352C	;0x0AC
	.halfword 0x0A7C, 0x3530	;0x0AD
;	.halfword 0x0A60, 0x352A	;0x0AE
	.halfword 0x0998, 0x352C	;0x0AF - 0x0AE
;	.halfword 0x0998, 0x352E	;0x0B0
;	.halfword 0x0998, 0x3530	;0x0B1
	.halfword 0x0A7C, 0x35DA	;0x0B2 - 0x0AF
	.halfword 0x0A7C, 0x3498	;0x0B3 - 0x0B0
	.halfword 0x0A7C, 0x3418	;0x0B4 - 0x0B1
	.halfword 0x0A58, 0x361E	;0x0B5 - 0x0B2
	.halfword 0x093C, 0x361C	;0x0B6 - 0x0B3
	.halfword 0x0A64, 0x35D8	;0x0B7 - 0x0B4
	.halfword 0x0944, 0x3598	;0x0B8 - 0x0B5
	.halfword 0x0928, 0x3518	;0x0B9 - 0x0B6
	.halfword 0x0938, 0x3498	;0x0BA - 0x0B7
	.halfword 0x0938, 0x3418	;0x0BB - 0x0B8
	.halfword 0x0928, 0x3398	;0x0BC - 0x0B9
	.halfword 0x0A7C, 0x36A0	;0x0BD - 0x0BA
	.halfword 0x0A7C, 0x3760	;0x0BE - 0x0BB
	.halfword 0x09D0, 0x3660	;0x0BF - 0x0BC
	.halfword 0x0938, 0x36E0	;0x0C0 - 0x0BD
	.halfword 0x0938, 0x3760	;0x0C1 - 0x0BE
	.halfword 0x0A7C, 0x339C	;0x0C2 - 0x0BF
	.halfword 0x0918, 0x339A	;0x0C3 - 0x0C0
	.halfword 0x0998, 0x339C	;0x0C4 - 0x0C1
	.halfword 0x0A7C, 0x3510	;0x0C5 - 0x0C2
	.halfword 0x0A58, 0x3396	;0x0C6 - 0x0C3
	.halfword 0x0A6C, 0x3392	;0x0C7 - 0x0C4
	.halfword 0x0A70, 0x33D0	;0x0C8 - 0x0C5
	.halfword 0x0A74, 0x3410	;0x0C9 - 0x0C6
	.halfword 0x0938, 0x3490	;0x0CA - 0x0C7
	.halfword 0x0928, 0x3510	;0x0CB - 0x0C8
	.halfword 0x0A7C, 0x351C	;0x0CC - 0x0C9
	.halfword 0x0A7C, 0x3522	;0x0CD - 0x0CA
	.halfword 0x0998, 0x3514	;0x0CE - 0x0CB
	.halfword 0x0928, 0x3518	;0x0CF - 0x0CC
	.halfword 0x0998, 0x351C	;0x0D0 - 0x0CD
	.halfword 0x0998, 0x3520	;0x0D1 - 0x0CE
	.halfword 0x0998, 0x3524	;0x0D2 - 0x0CF
	.halfword 0x0A7C, 0x3610	;0x0D3 - 0x0D0
	.halfword 0x09D0, 0x3550	;0x0D4 - 0x0D1
	.halfword 0x0938, 0x3590	;0x0D5 - 0x0D2
	.halfword 0x0928, 0x3610	;0x0D6 - 0x0D3
	.halfword 0x0A7C, 0x3690	;0x0D7 - 0x0D4
	.halfword 0x0A7C, 0x370E	;0x0D8 - 0x0D5
	.halfword 0x0A7C, 0x370A	;0x0D9 - 0x0D6
	.halfword 0x0A7C, 0x3702	;0x0DA - 0x0D7
	.halfword 0x09D0, 0x3650	;0x0DB - 0x0D8
	.halfword 0x0A78, 0x36D0	;0x0DC - 0x0D9
	.halfword 0x091C, 0x370C	;0x0DD - 0x0DA
	.halfword 0x0998, 0x3708	;0x0DE - 0x0DB
	.halfword 0x0998, 0x3704	;0x0DF - 0x0DC
	.halfword 0x0998, 0x3700	;0x0E0 - 0x0DD
	.halfword 0x0A90, 0x1812	;0x0E1 - 0x0DE
	.halfword 0x0A94, 0x2BAA	;0x0E2 - 0x0DF
	.halfword 0x0A98, 0x2BA8	;0x0E3 - 0x0E0
	.halfword 0x0A9C, 0x2BA4	;0x0E4 - 0x0E1
	.halfword 0x0A94, 0x2BA2	;0x0E5 - 0x0E2
	.halfword 0x0A98, 0x2BA0	;0x0E6 - 0x0E3
	.halfword 0x0AA0, 0x2B64	;0x0E7 - 0x0E4
	.halfword 0x0AA4, 0x2B9A	;0x0E8 - 0x0E5
	.halfword 0x0A98, 0x2B98	;0x0E9 - 0x0E6
	.halfword 0x0A98, 0x2B96	;0x0EA - 0x0E7
	.halfword 0x0A98, 0x2B94	;0x0EB - 0x0E8
	.halfword 0x0A9C, 0x2B90	;0x0EC - 0x0E9
	.halfword 0x0AA0, 0x2B5C	;0x0ED - 0x0EA
	.halfword 0x0AA0, 0x2B50	;0x0EE - 0x0EB
	.halfword 0x0AA8, 0x2B10	;0x0EF - 0x0EC
	.halfword 0x0A9C, 0x2A90	;0x0F0 - 0x0ED
	.halfword 0x0AAC, 0x2A92	;0x0F1 - 0x0EE
	.halfword 0x0A98, 0x2A94	;0x0F2 - 0x0EF
	.halfword 0x0A98, 0x2A96	;0x0F3 - 0x0F0
	.halfword 0x0A98, 0x2A98	;0x0F4 - 0x0F1
	.halfword 0x0AA0, 0x2A50	;0x0F5 - 0x0F2
	.halfword 0x0AA8, 0x2A10	;0x0F6 - 0x0F3
	.halfword 0x0B3C, 0x2990	;0x0F7 - 0x0F4
	.halfword 0x0B40, 0x2994	;0x0F8 - 0x0F5
	.halfword 0x0B40, 0x2998	;0x0F9 - 0x0F6
	.halfword 0x0AA0, 0x2A5C	;0x0FA - 0x0F7
	.halfword 0x0AA8, 0x2A1C	;0x0FB - 0x0F8
	.halfword 0x0AA8, 0x29DC	;0x0FC - 0x0F9
	.halfword 0x0AA0, 0x2A64	;0x0FD - 0x0FA
	.halfword 0x0AA8, 0x2A24	;0x0FE - 0x0FB
	.halfword 0x0AA8, 0x29E4	;0x0FF - 0x0FC
	.halfword 0x0AB0, 0x1D90	;0x100 - 0x0FD
	.halfword 0x09A0, 0x1D8C	;0x101 - 0x0FE
	.halfword 0x0AB0, 0x1E56	;0x102 - 0x0FF
	.halfword 0x0AB4, 0x1E5A	;0x103 - 0x100
	.halfword 0x0AB8, 0x1D5C	;0x104 - 0x101
	.halfword 0x09A0, 0x1D18	;0x105 - 0x102
	.halfword 0x0ABC, 0x1C90	;0x106 - 0x103
	.halfword 0x0ABC, 0x1C0C	;0x107 - 0x104
	.halfword 0x09A0, 0x1E0C	;0x108 - 0x105
	.halfword 0x0AC0, 0x1E8A	;0x109 - 0x106
	.halfword 0x0AC0, 0x1E86	;0x10A - 0x107
	.halfword 0x0ABC, 0x1E04	;0x10B - 0x108
	.halfword 0x09A0, 0x1D84	;0x10C - 0x109
	.halfword 0x0AB8, 0x1CC6	;0x10D - 0x10A
	.halfword 0x0AB0, 0x1D0C	;0x10E - 0x10B
	.halfword 0x09A0, 0x1D88	;0x10F - 0x10C
	.halfword 0x09A0, 0x1D84	;0x110 - 0x10D
	.halfword 0x0AB4, 0x1D80	;0x111 - 0x10E
	.halfword 0x09A0, 0x163C	;0x112 - 0x10F
	.halfword 0x09A0, 0x16BC	;0x113 - 0x110
	.halfword 0x09A0, 0x16B8	;0x114 - 0x111
	.halfword 0x09A0, 0x16B4	;0x115 - 0x112
	.halfword 0x09A0, 0x1630	;0x116 - 0x113
	.halfword 0x0AA8, 0x1570	;0x117 - 0x114
	.halfword 0x0AC4, 0x1530	;0x118 - 0x115
	.halfword 0x0AD8, 0x13B8	;0x119 - 0x116
	.halfword 0x094C, 0x14B0	;0x11A - 0x117
	.halfword 0x0AC8, 0x1432	;0x11B - 0x118
	.halfword 0x0ACC, 0x13F4	;0x11C - 0x119
	.halfword 0x0AD0, 0x13B8	;0x11D - 0x11A
	.halfword 0x0AD4, 0x12B8	;0x11E - 0x11B
	.halfword 0x01F8, 0x11F4	;0x11F - 0x11C
	.halfword 0x021C, 0x11F4	;0x120 - 0x11D
	.halfword 0x0240, 0x11F4	;0x121 - 0x11E
	.halfword 0x0264, 0x11F4	;0x122 - 0x11F
	.halfword 0x0288, 0x11F4	;0x123 - 0x120
	.halfword 0x02AC, 0x11F4	;0x124 - 0x121
	.halfword 0x02D0, 0x11F4	;0x125 - 0x122
	.halfword 0x02F4, 0x11F4	;0x126 - 0x123
	.halfword 0x0318, 0x11F4	;0x127 - 0x124
	.halfword 0x033C, 0x11B4	;0x128 - 0x125
;	.halfword 0x0360, 0x11B4	;0x129
;	.halfword 0x033C, 0x11B4	;0x12A
	.halfword 0x0ADC, 0x3D10	;0x12B - 0x126
	.halfword 0x0AE0, 0x3CCE	;0x12C - 0x127
	.halfword 0x0AE4, 0x3C8C	;0x12D - 0x128
	.halfword 0x0AE8, 0x3C48	;0x12E - 0x129
	.halfword 0x0AEC, 0x3C14	;0x12F - 0x12A
	.halfword 0x0AF0, 0x3BD6	;0x130 - 0x12B
	.halfword 0x0AF4, 0x3B98	;0x131 - 0x12C
	.halfword 0x0AF8, 0x3B5A	;0x132 - 0x12D
	.halfword 0x0918, 0x3C26	;0x133 - 0x12E
	.halfword 0x0998, 0x3C28	;0x134 - 0x12F
	.halfword 0x0998, 0x3C2A	;0x135 - 0x130
	.halfword 0x0998, 0x3C2C	;0x136 - 0x131
	.halfword 0x096C, 0x3D28	;0x137 - 0x132
	.halfword 0x0AFC, 0x3D68	;0x138 - 0x133
	.halfword 0x0B00, 0x3DAA	;0x139 - 0x134
	.halfword 0x0AE4, 0x3DEC	;0x13A - 0x135
	.halfword 0x0AE4, 0x3E2E	;0x13B - 0x136
	.halfword 0x0ADC, 0x3EB0	;0x13C - 0x137
	.halfword 0x0B3C, 0x2990	;0x13D - 0x138
	.halfword 0x0B40, 0x2994	;0x13E - 0x139
	.halfword 0x0B40, 0x2998	;0x13F - 0x13A
	.halfword 0x0B04, 0x3D9C	;0x140 - 0x13B
	.halfword 0x0B08, 0x3DD8	;0x141 - 0x13C
	.halfword 0x0B08, 0x3E14	;0x142 - 0x13D
	.halfword 0x0B08, 0x3E50	;0x143 - 0x13E
	.halfword 0x0B08, 0x3E8C	;0x144 - 0x13F
	.halfword 0x096C, 0x3E88	;0x145 - 0x140
	.halfword 0x0144, 0x077C	;0x146 - 0x141
	.halfword 0x0938, 0x19E0	;0x147 - 0x142
	.halfword 0x0B1C, 0x1A20	;0x148 - 0x143
	.halfword 0x03CC, 0x1ADC	;0x149 - 0x144
	.halfword 0x03F0, 0x1ADC	;0x14A - 0x145
	.halfword 0x0414, 0x1ADC	;0x14B - 0x146
	.halfword 0x0438, 0x1B9C	;0x14C - 0x147
	.halfword 0x045C, 0x1B9C	;0x14D - 0x148
	.halfword 0x0480, 0x1B5C	;0x14E - 0x149
	.halfword 0x04A4, 0x1B1C	;0x14F - 0x14A
	.halfword 0x04C8, 0x1ADC	;0x150 - 0x14B
	.halfword 0x04EC, 0x1A9C	;0x151 - 0x14C
	.halfword 0x0A58, 0x1B1E	;0x152 - 0x14D
	.halfword 0x0B20, 0x1B1C	;0x153 - 0x14E
	.halfword 0x0B24, 0x1B1A	;0x154 - 0x14F
	.halfword 0x0B28, 0x1B18	;0x155 - 0x150
	.halfword 0x09A0, 0x1B94	;0x156 - 0x151
	.halfword 0x09A0, 0x1C14	;0x157 - 0x152
	.halfword 0x09A0, 0x1C94	;0x158 - 0x153
	.halfword 0x0AC0, 0x1D14	;0x159 - 0x154
	.halfword 0x0B2C, 0x1D56	;0x15A - 0x155
	.halfword 0x09A0, 0x1DD4	;0x15B - 0x156
	.halfword 0x0998, 0x3990	;0x15C - 0x157
	.halfword 0x0998, 0x3994	;0x15D - 0x158
	.halfword 0x0928, 0x3998	;0x15E - 0x159
	.halfword 0x0998, 0x399C	;0x15F - 0x15A
	.halfword 0x0998, 0x39A0	;0x160 - 0x15B
	.halfword 0x0928, 0x39A4	;0x161 - 0x15C
	.halfword 0x0998, 0x39A8	;0x162 - 0x15D
	.halfword 0x0998, 0x39AC	;0x163 - 0x15E
	.halfword 0x0928, 0x39B0	;0x164 - 0x15F
	.halfword 0x0998, 0x39B4	;0x165 - 0x160
	.halfword 0x0998, 0x38B4	;0x166 - 0x161
	.halfword 0x0928, 0x38B0	;0x167 - 0x162
	.halfword 0x0998, 0x38AC	;0x168 - 0x163
	.halfword 0x0998, 0x38A8	;0x169 - 0x164
	.halfword 0x0928, 0x38A4	;0x16A - 0x165
	.halfword 0x0998, 0x38A0	;0x16B - 0x166
	.halfword 0x0998, 0x389C	;0x16C - 0x167
	.halfword 0x0928, 0x3898	;0x16D - 0x168
	.halfword 0x0998, 0x3894	;0x16E - 0x169
	.halfword 0x0998, 0x3890	;0x16F - 0x16A
	.halfword 0x0928, 0x388C	;0x170 - 0x16B
	.halfword 0x0998, 0x3888	;0x171 - 0x16C
	.halfword 0x0928, 0x3884	;0x172 - 0x16D
	.halfword 0x0000, 0x0000	;0x16E
	.halfword 0x0000, 0x0000	;0x16F
	.halfword 0x0000, 0x0000	;0x170
	.halfword 0x0000, 0x0000	;0x171
	.halfword 0x0000, 0x0000	;0x172

.org 0x8102D7C	;event numbers
	.halfword 0x0000, 0x0000, 0x000D, 0x000D	;0x00-0x03
	.halfword 0x0010, 0x0015, 0x0018, 0x001A	;0x04-0x07
	.halfword 0x0020, 0x0023, 0x0026, 0x0029	;0x08-0x0B
	.halfword 0x002C, 0x0035, 0x0039, 0x003A	;0x0C-0x0F
	.halfword 0x0042, 0x0046, 0x004A, 0x004C	;0x10-0x13
	.halfword 0x004D, 0x004E, 0x0052, 0x0059	;0x14-0x17
	.halfword 0x005D, 0x0060, 0x0067, 0x006A	;0x18-0x1B
	.halfword 0x006C, 0x006F, 0x0072, 0x0075	;0x1C-0x1F
	.halfword 0x0077, 0x0077, 0x0083, 0x0083	;0x20-0x23
	.halfword 0x0084, 0x008E, 0x0090, 0x0092	;0x24-0x27
	.halfword 0x0098, 0x0098, 0x0098, 0x00A0	;0x28-0x2B
	.halfword 0x00A5, 0x00AC, 0x00AF, 0x00BA	;0x00B2, 0x00BD	;0x2C-0x2F
	.halfword 0x00BF, 0x00C2, 0x00C9, 0x00D0	;0x00C2, 0x00C5, 0x00CC, 0x00D3	;0x30-0x33
	.halfword 0x00D4, 0x00DE, 0x00DF, 0x00DF	;0x00D7, 0x00E1, 0x00E2, 0x00E2	;0x34-0x37
	.halfword 0x00DF, 0x00E2, 0x00E4, 0x00E5	;0x00E2, 0x00E5, 0x00E7, 0x00E8	;0x38-0x3B
	.halfword 0x00EA, 0x00EB, 0x00EE, 0x00F2	;0x00ED, 0x00EE, 0x00F1, 0x00F5	;0x3C-0x3F
	.halfword 0x00F7, 0x00FA, 0x00FD, 0x00FD	;0x00FA, 0x00FD, 0x0100, 0x0100	;0x40-0x43
	.halfword 0x00FD, 0x00FD, 0x00FD, 0x00FF	;0x0100, 0x0100, 0x0100, 0x0102	;0x44-0x47
	.halfword 0x0105, 0x010C, 0x010F, 0x0111	;0x0108, 0x010F, 0x0112, 0x0114	;0x48-0x4B
	.halfword 0x0113, 0x0114, 0x011B, 0x0126	;0x0116, 0x0117, 0x011E, 0x012B	;0x4C-0x4F
	.halfword 0x0126, 0x0126, 0x0126, 0x012A	;0x012B, 0x012B, 0x012B, 0x012F	;0x50-0x53
	.halfword 0x012A, 0x012A, 0x012E, 0x012E	;0x012F, 0x012F, 0x0133, 0x0133	;0x54-0x57
	.halfword 0x012E, 0x0132, 0x0132, 0x0132	;0x0133, 0x0137, 0x0137, 0x0137	;0x58-0x5B
	.halfword 0x013B, 0x013B, 0x0141, 0x0141	;0x0140, 0x0140, 0x0146, 0x0146	;0x5C-0x5F
	.halfword 0x0141, 0x0142, 0x014D, 0x0151	;0x0146, 0x0147, 0x0152, 0x0156	;0x60-0x63
	.halfword 0x0157, 0x0157, 0x015A, 0x015D	;0x015C, 0x015C, 0x015F, 0x0162	;0x64-0x67
	.halfword 0x0160, 0x0163, 0x0166, 0x0169	;0x0165, 0x0168, 0x016B, 0x016E	;0x68-0x6B
	.halfword 0x016C, 0x016E, 0x016E, 0x016E	;0x0171, 0x0173, 0x0173, 0x0173	;0x6C-0x6F
	.halfword 0x016E, 0x016E, 0x016E, 0x016E	;0x0173, 0x0173, 0x0173, 0x0173	;0x70-0x73
	.halfword 0x016E, 0x016E, 0x016E, 0x016E	;0x0173, 0x0173, 0x0173, 0x0173	;0x74-0x77
	.halfword 0x016E, 0x0000	;0x0173, 0x0000	;0x78-0x79

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.org 0x81052C9	;Fix misplaced tile in doorhole animation
	.byte 0x49
	
.org 0x81054F0	;Fix tiling error in level list
	.halfword 0x0087

;several sprite property fixes;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.org 0x8109C00 +34h	;Fix boss flame death animation
	.byte 0x80

.org 0x8109C00 +0AEh	;Fix fishin' boo death animation
	.byte 0x80

.org 0x8109C00 +0B3h	;Fix bowser statue flame death animation
	.byte 0x80

.org 0x8109C00 +0C6h	;Fix spotlight properties
	.byte 0x00
;----------------------------------------------------------
.org 0x8109CD2 +45h	;Fix top of directional coin
	.byte 0x0C

.org 0x8109CD2 +0C6h	;Fix spotlight properties
	.byte 0x00
;----------------------------------------------------------
.org 0x8109DA4 +55h	;Fix several sprites fireball immunity
	.byte 0xF3, 0xF3, 0xF3, 0xF3, 0xF3, 0xF3, 0xF1, 0xF1 
	.byte 0xFB, 0xFB, 0xF3, 0xF3, 0xF3, 0xF1, 0xF1, 0xB3
	.byte 0xB3, 0xB3, 0xB3, 0xB3, 0xF3, 0xF0, 0xF3
	
.org 0x8109DA4 +0A3h
	.byte 0xF3
;----------------------------------------------------------
.org 0x8109E76 +0Eh	;Make keyhole not use default player interaction
	.byte 0x82

.org 0x8109E76 +33h	;Fix normal fireball property
	.byte 0x03

.org 0x8109E76 +45h	;Fix top of directional coin chain
	.byte 0xA2

.org 0x8109E76 +46h	;Prevent chucks from triggering the item routine
	.byte 0xB9

.org 0x8109E76 +53h	;Make throw blocks invincible to prevent auto destroy with star
	.byte 0x0A, 0x82

.org 0x8109E76 +67h	;Make fuzzies defeatable
	.byte 0x23, 0x21

.org 0x8109E76 +6Dh	;Prevent invisible blocks from triggering the item routine
	.byte 0xA2

.org 0x8109E76 +8Ah	;Prevent several sprites from using the default interaction with the player
	.byte 0x82, 0x82, 0x82, 0x82

.org 0x8109E76 +91h	;Prevent chucks from triggering the item routine
	.byte 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9, 0xB9

.org 0x8109E76 +9Dh	;Fix sprite in a bubble glitch and make ball 'n' chain invincible
	.byte 0x80, 0x02

.org 0x8109E76 +0A1h	;Make bowsers ball invincible
	.byte 0x02

.org 0x8109E76 +0A5h	;Fix fuzzy/hothead property
	.byte 0x21, 0x21
	
.org 0x8109E76 +0B2h	;Make falling spike invincible
	.byte 0x02

.org 0x8109E76 +0B4h	;Fix bottom grinder property
	.byte 0x23

.org 0x8109E76 +0B6h	;Fix splash of reflecting fireball
	.byte 0x03

.org 0x8109E76 +0BCh	;Make bowser statue invincible
	.byte 0xA2
	
.org 0x8109E76 +0C6h	;Prevent spotlight from triggering the item routine
	.byte 0xBF
;----------------------------------------------------------
.org 0x8109F48 +08h	;Prevent green para koopa from changing direction when touched like other para koopas
	.byte 0x52
	
.org 0x8109F48 +2Bh	;Turn sumo brother's lightning into coin when goal passed
	.byte 0x19

.org 0x8109F48 +4Ah	;Turn ? goal sphere into coins when goal passed
	.byte 0x09

.org 0x8109F48 +52h	;Turn throw block and moving hole in ghost house into coins when goal passed
	.byte 0x09, 0x00

.org 0x8109F48 +65h	;Turn several enemies into coins when goal passed
	.byte 0x1D, 0x1D, 0x19, 0x14
	
.org 0x8109F48 +6Dh	;Prevent invisible solid block from spawning a new sprite and turning into a coin when goal passed
	.byte 0x39
	
.org 0x8109F48 +74h	;Turn power ups into coins when goal passed
	.byte 0x08, 0x08, 0x08, 0x08, 0x08, 0x09
	
.org 0x8109F48 +7Dh	;Turn power ups into coins when goal passed
	.byte 0x09, 0x08, 0x08, 0x1A, 0x08

.org 0x8109F48 +83h	;Turn flying blocks into coins when goals passed
	.byte 0x11, 0x11
	
.org 0x8109F48 +87h	;Turn lakitu's cloud into a coin when goal passed
	.byte 0x09

.org 0x8109F48 +09Ch	;Prevent amazing flying hammer bro plattform from changing direction if touched
	.byte 0x99

.org 0x8109F48 +0A6h	;Make iggy's ball projectile inedible
	.byte 0x15, 0x11

.org 0x8109F48 +0A9h	;Prevent reznor from turning into a coin on the goal and make him inedible
	.byte 0x39

.org 0x8109F48 +0B1h	;Prevent snake block from turning into a coin on the goal
	.byte 0x3D

.org 0x8109F48 +0B6h	;Prevent yoshi from eating reflecting fireball, prevents carrot lifts and timed lifts from turning into a coin on the goal
	.byte 0x19, 0x39, 0x39, 0x19, 0x3D
	
.org 0x8109F48 +0BBh	;Prevent moving castle block from turning into a coin on the goal
	.byte 0x39
	
.org 0x8109F48 +0C0h	;Prevent sinking gray plattform from turning into a coin on the goal
	.byte 0xB9

.org 0x8109F48 +0C6h	;Prevent spotlight from staying in yoshis mouth and spawning a new sprite
	.byte 0xB9, 0x39, 0x31
;----------------------------------------------------------
.org 0x810A01A +0Ch	;Fix yellow para koopa properties
	.byte 0xB0

.org 0x810A01A +35h	;Make it harder for yoshi to glitch in walls
	.byte 0xC6

.org 0x810A01A +43h	;Fix dolphin tail visible when being vertically offscreen
	.byte 0x25
	
.org 0x810A01A +49h	;Make growing/shrinking pipe invincible
	.byte 0x44

.org 0x810A01A +64h	;Make several sprites which are no plattforms not passable from the ground and make fuzzies beatable by sliding
	.byte 0x44, 0x44, 0x44, 0x44, 0x00

.org 0x810A01A +080h	;Make key invincible
	.byte 0xC4

.org 0x810A01A +083h	;Make flying blocks invincible
	.byte 0x44, 0x44

.org 0x810A01A +087h	;Make several sprites invincible
	.byte 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x46, 0x44
	.byte 0x05

.org 0x810A01A +09Ch	;Make amazing flying hammer brother plattform invincible
	.byte 0x44

.org 0x810A01A +0A1h	;Make bowsers ball invincible and prevent mecha koopas from getting stuck in walls
	.byte 0x44, 0x80
	
.org 0x810A01A +0A8h	;Make blargg and invincible
	.byte 0x04, 0x44

.org 0x810A01A +0B1h	;Make several sprites invincible
	.byte 0x44, 0x04, 0x04, 0x04, 0x00, 0x04, 0x45, 0x45
	.byte 0x44, 0x45, 0x44, 0x04
	
.org 0x810A01A +0C0h	;Make sinking gray platform in lava disapear on goal like other platforms
	.byte 0x45

.org 0x810A01A +0C4h	;Fix spotlight properties and make grey plattforms and big boo boss invincible
	.byte 0x45, 0x45, 0x46
;----------------------------------------------------------
.org 0x810A0EC +05Bh	;Make several sprites solid for yoshi
	.byte 0x01, 0x01, 0x01, 0x01

.org 0x810A0EC +06Dh	;Make invisible solid block solid for yoshi
	.byte 0x01

.org 0x810A0EC +087h	;Prevent yoshi from falling thrugh lakitus cloud
	.byte 0x05

.org 0x810A0EC +0B1h	;Make snake block solid for yoshi
	.byte 0x01

.org 0x810A0EC +0C8h	;Make red ?-Block solid for yoshi
	.byte 0x01
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
.org 0x810A154	;Fix sprite of fuzzy when spit out by yoshi	
	.byte 0x08
	
.org 0x810A820	;Fill empty slot with empty function to prevent out of bounds reading
	.word 0x08030EF9
	
.org 0x810B040	;Repoint sprite status table to make space for 1 more entry to prevent glitchy sprite spawn
	.halfword 0x0004
	.byte 0x00

.org 0x810B080
	.word SpriteTableStatus
	
.org 0x810CA95	;Fixes incorrect shoulder tile of diggin chucks
	.byte 0x0C
	
.org 0x8110208	;Fix sprite of fuzzy when spit out by yoshi
	.halfword 0x1C8

.org 0x81103A0
	.byte 0x02
	
.org 0x8117062	;Fixes Wendys incorrect bow tiles during her left right watching animaton
	.byte 0x08
	
.org 0x8117068
	.byte 0x08
	
.org 0x81171AA
	.halfword 0x012F, 0x012E
	
.org 0x81171B6
	.halfword 0x012E, 0x012F
	
.org 0x8117773	;Make all carriable items drop powerups when carried through the goal
	.byte 0xF0, 0x74, 0x74, 0x77, 0x75, 0x76, 0xE0, 0xF0
	.byte 0x74, 0x74, 0x77, 0x75, 0x76, 0xE0, 0xF0
	
.org 0x811A452	;Fix splash height when jumping out of water
	.halfword 0x0000
	
.org 0x811A456
	.halfword 0x0008
	
.org 0x813A76C +1Fh	;Fix Kamek allocating an incorrect number of sprites in OAM (Credits: MisterMan)
	.byte 0x03
;;;;;;;

.org 0x813BA88
	.word BeginFuncFBI+1
	
.org 0x8199EE0	;Fix palette of wendys castle in intro
	.halfword 0x6BDF
	
.org 0x8208524
	.halfword 0x5BF6
	
.org 0x822421C	;Fix vanilla secret overworld pipe tile
	.byte 0x71

.org 0x822425C
	.byte 0x71, 0x40
	
.org 0x823C317	;Fix the SMW orchesta hit sample being off-key (Credits: MisterMan)
	.byte	0x34
	
.org 0x8330CEE	;Fix the lead channel in the "Bowser Battle Phase 1" music track starting too early (Credits: MisterMan)
	.byte	0x81, 0x50
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;