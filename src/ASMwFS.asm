;Update VRAM tiles in yoshis house credits cutscene (UVR, Credits: Mister Man)
.org 0x800076E
	bne DownVRAMUpdate

.org 0x8000780
	bhi 80007BCh
	
.org 0x8000794
DownVRAMUpdate:
	ldr r0,=3002340h
	ldr r1,=0CE8h
	add r0,r0,r1
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	cmp r0,10h
	bne 80007BCh
	bl FreeSpaceUVR
	bl 80021C4h
	b 80007C4h
	.pool
	.word 0x00000000

;Makes Mario/Luigi use palette 9 instead of 0 when on the Overworld
;to fix a graphical issue with yellow yoshi (MPM);;;;;;;;;;;;;;;;;;
.org 0x80021F8
	ldrb r6,[r0]
	cmp r6,0h

.org 0x8002202
	ldr r5,=500020Ch
	bl FreeSpaceMPM1

.org 0x80022A4
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Puts the trigger of the found all Yoshi Coins Cutscene on a better place and prevent it
;from overwritting the castle cutscene trigger; Also adds some sanity checks for the;;;;
;Yoshi Coins Counter and the Exit Counter (YCC);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.org 0x8003A9F
	.byte 0x4C
	
.org 0x8003AA1
	.byte 0x49

.org 0x8003AA2
	add r1,r4,r1
	ldrb r0,[r1]
	bl CheckTriggerCutscene
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Update the Framecounter during the "Welcome to dinosaurland" and yoshis house credit cutscene to animate the berries (UFC, Credits: Mister Man)
.org 0x80044A6	;Welcome to dinosaurland cutscene
	bl FreeSpaceUFC
	
.org 0x8004F3A	;Yoshis house credits cutscene
	bl FreeSpaceUFC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Prevents extra lifes from beeing omited when exiting the level not at a goal (ELO)
.org 0x8004704
	bl FreeSpaceELO1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Makes auto save prompt only appear, when beating a castle, a switch palace or bowser for the
;first time or after seeing the 96 exits cutscene or the found all Yoshi Coins cutscene and;;
;sets both the main entrance and the side entrance to beaten if bowser was beaten (SPR);;;;;;
.org 0x80054BE
	b 8005524h
	.word 0x00000000
	.word 0x00000000
	
.org 0x80054E8
	.word 0x00000000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Resets Checkpointflags when reloading the savefile or getting a game over (RCP)
;Also contains a expansion of the level default value table to make it possible;
;to save+back from yoshis house and top secret area (LDT);;;;;;;;;;;;;;;;;;;;;;;
.org 0x8007F36
	bl FreeSpaceRCS1	;800555Ch Orig.

.org 0x8008014
	bl FreeSpaceRCS1	;800555Ch Orig.

.org 0x800804A
	bl FreeSpaceRCS1	;800555Ch Orig.
	
.org 0x8008210	;(LDT)
	mov r3,10h

.org 0x8008214
	ldr r4,=FreeSpaceLDT

.org 0x80082F8
	.pool
	
.org 0x80082AE
	bl FreeSpaceRCS1	;800555Ch Orig.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Change Yoshi Coins in intro level in Peach Coins when they are unlocked (CYC)
.org 0x8008337
	.byte 0x4E
	
.org 0x800833A
	add r0,r6,r2
	
.org 0x8008344
	add r0,r6,r3
	strb r2,[r0]
	sub r0,1h
	strb r2,[r0]
	add r0,8h
	strb r2,[r0]
	
.org 0x800837E
	bl FreeSpaceCYC1
	
.org 0x8008390
	add r1,r6,r3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of Mario Palette Move (MPM)
.org 0x80094C6
	bl FreeSpaceMPM2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Prevent peach coin graphics from getting loaded when entering the overworld,
;starting the credits and after the 96 exit cutscene (FCR);;;;;;;;;;;;;;;;;;;
.org 0x8009110
	bl FreeSpaceFCR
	cmp r0,0FFh
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of Save Prompt (SPR)
.org 0x800CDAC
	bne NotFirstTime
	bl 800CC64h
	bl FreeSpaceSPR1
NotFirstTime:
	ldr r0,[r5,20h]
	add r0,37h
	ldrb r1,[r0]
	orr r1,r4
	mov r2,0BFh
	and r1,r2
	strb r1,[r0]
	add r0,1h
	ldrb r1,[r0]
	orr r1,r4
	and r1,r2
	strb r1,[r0]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of ChangeYoshiCoins (CYC)
.org 0x800CF78
	bl FreeSpaceCYC2
	
.org 0x800D004
	.halfword 0x0000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix the graphic of the checkpoint after taking it (CPG)
.org 0x800E872
	ldrh r3,[r0,2Ch]
	mov r0,0F8h
	lsl r0,r0,1h
	and r3,r0
	
.org 0x800E87E
	strh r3,[r0]
	ldr r1,[r6]
	ldrh r4,[r1,30h]
	lsr r4,r4,4h
	mov r0,0Fh
	and r4,r0

.org 0x800E890
	orr r4,r3

.org 0x800E898
	add r1,r1,r4

.org 0x800E8AA
	add r1,r1,r4

.org 0x800E8AE
	add r2,r5,r0
	ldrb r0,[r2]
	ldrb r5,[r1]
	strb r0,[r1]
	bl FreeSpaceCPG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix the draw priority of several sprites in the enemy roll credits (CEO)
.org 0x80150A6
	bne DownEnemyRollCredits2
	
.org 0x80150B0
	bne DownEnemyRollCredits2
	
.org 0x80150BA
	b DownEnemyRollCredits1
	
.org 0x80150C8
	cmp r0,0h
	bne DownEnemyRollCredits2
	ldr r0,[r1,20h]
	add r0,0D5h
	ldrb r0,[r0]
	cmp r0,60h
	bne DownEnemyRollCredits2
	ldrb r0,[r5,2h]
	cmp r0,0D8h
	bne DownEnemyRollCredits2
	ldrb r0,[r3,5h]
	mov r1,0Fh
	and r0,r1
	mov r1,20h
DownEnemyRollCredits1:
	orr r0,r1
	strb r0,[r3,5h]
DownEnemyRollCredits2:
	bl FreeSpaceCEO
	cmp r0,0h
	bne DownEnemyRollCredits3
	ldrb r1,[r3,5h]
	mov r0,0F3h
	and r1,r0
	mov r0,8h
	orr r1,r0
	strb r1,[r3,5h]
DownEnemyRollCredits3:
	ldrb r1,[r5,3h]
	mov r0,10h
	and r1,r0
	lsl r1,r1,18h
	lsr r1,r1,1Ch
	lsl r1,r1,6h
	ldrb r0,[r3,3h]
	mov r2,3Fh
	and r0,r2
	orr r0,r1
	strb r0,[r3,3h]
	sub r3,8h
	add r5,4h
	b 8014F70h
	.word 0x00000000
	.word 0x00000000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Make star road level show up on the level table after beeing unlocked like other levels (SRL)
.org 0x801EB7C
	ldr r1,=20144E4h

.org 0x801EB88
	ldr r0,=20144E4h
	
.org 0x801EB8E
	ldr r3,=2003000h

.org 0x801EB94
	ldr r4,=3002340h

.org 0x801EB9C
	ldr r5,=80FDBEAh
	add r1,r1,r5

.org 0x801EBA8
	ldr r1,=1C5Ch
	add r0,r4,r1
	ldr r0,[r0]
	ldrb r3,[r0,1Fh]
	bl FreeSpaceSRL
	cmp r2,0h
	beq ContinueLevelChecks
	orr r0,r1
	strb r0,[r2]
	b EndOfLevelChecks
	.pool
ContinueLevelChecks:
	cmp r3,5Bh
	beq SetLevelBowserStar5
	cmp r3,3Fh
	bne CheckDonutSecret2
SetLevelBowserStar5:
	ldr r2,[r4,20h]
	add r2,36h
	ldrb r0,[r2]
	ldrb r1,[r5,3h]
	orr r0,r1
	strb r0,[r2]
	ldr r2,[r4,20h]
	add r2,37h
	ldrb r0,[r2]
	ldrb r1,[r5,2h]
	orr r0,r1
	strb r0,[r2]
	ldr r2,[r4,20h]
	add r2,60h
	ldrb r0,[r2]
	ldrb r1,[r5,3h]
	orr r0,r1
	strb r0,[r2]
	b EndOfLevelChecks

CheckDonutSecret2:
	cmp r3,14h
	bne CheckChocoSecret
	ldr r2,[r4,20h]
	ldrb r0,[r2,0Bh]
	ldrb r1,[r5,1h]
	orr r0,r1
	strb r0,[r2,0Bh]
	b EndOfLevelChecks

CheckChocoSecret:
	cmp r3,4Fh
	bne EndOfLevelChecks
	ldr r2,[r4,20h]
	add r2,20h
	ldrb r0,[r2]
	ldrb r1,[r5,2h]
	orr r0,r1
	strb r0,[r2]

EndOfLevelChecks:
	pop r4-r6
	pop r0
	bx r0
	.word 0x00000000
	.word 0x00000000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 3 of Save Prompt (SPR);;;;;;;;;;;;;;;;;;;;;;
;Also contains parts of Yoshi Coins Cutscene (YCC)
.org 0x801EC48
	bl FreeSpaceSPR2
	cmp r0,0h
	beq 801ECB8h
	
.org 0x801ED1E
	bl FreeSpaceSPR3
	
.org 0x801EE8E	;(YCC)
	add r0,r2,1h

.org 0x8022F3A	;(YCC)
	cmp r0,60h
	beq 8022F50h
	add r0,1h
	strb r0,[r1]
	bl FreeSpaceYCC1

.org 0x8023904
	push r4,r5,r14
	ldr r0,=3002340h
	ldr r1,=1C5Ch
	add r0,r0,r1
	ldr r1,[r0]
	add r0,r1,0
	add r0,2Bh
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	cmp r0,2h
	bne DownSPR1
	ldrb r0,[r1,1Fh]
	add r0,1h
	strb r0,[r1,1Fh]
DownSPR1:
	ldr r2,=3002340h
	ldr r1,=1C5Ch
	add r0,r2,r1
	ldr r1,[r0]
	ldrb r0,[r1,1Eh]
	cmp r0,0h
	beq DownSPR3
	ldrb r0,[r1,1Fh]
	cmp r0,0FFh
	beq DownSPR3
	ldr r2,[r2,20h]
	lsr r0,r0,3h
	add r2,0B2h
	add r2,r2,r0
	ldr r3,=8101AE8h
	ldrb r1,[r1,1Fh]
	mov r0,7h
	and r1,r0
	add r1,r1,r3
	ldrb r0,[r2]
	ldrb r1,[r1]
	and r0,r1
	cmp r0,0h
	beq DownSPR3
	ldr r3,=3002340h
	ldr r0,[r3,20h]
	add r0,0EBh
	ldrb r0,[r0]
	cmp r0,2h
	beq DownSPR2
	ldr r0,=3002340h
	ldr r1,=887h
	add r2,r0,r1
	mov r1,7h
	strb r1,[r2]
	ldr r2,=1C5Ch
	add r0,r0,r2
	ldr r0,[r0]
	add r0,2Bh
	mov r1,80h
	strb r1,[r0]
	b DownSPR5
DownSPR2:
	ldr r0,=887h
	add r1,r3,r0
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]
	ldr r1,=1C5Ch
	add r0,r3,r1
	ldr r0,[r0]
	add r0,2Bh
	mov r1,0E0h
	strb r1,[r0]
	ldr r2,=89Ah
	add r1,r3,r2
	mov r0,0Fh
	strb r0,[r1]
	b DownSPR5
DownSPR3:
	ldr r4,=3002340h
	ldr r0,=1C5Ch
	add r5,r4,r0
	ldr r1,[r5]
	add r1,4Eh
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]
	ldr r0,[r5]
	ldrb r0,[r0,1Fh]
	bl 8022F94h
	ldr r1,[r5]
	lsl r2,r0,4h
	add r1,4Ch
	strb r2,[r1]
	ldr r1,[r5]
	mov r2,0Fh
	bic r0,r2
	add r1,4Dh
	strb r0,[r1]
	ldr r0,[r5]
	add r0,4Ah
	mov r1,28h
	strh r1,[r0]
	ldr r0,[r4,20h]
	add r0,0A0h
	ldrh r0,[r0]
	cmp r0,18h
	bne DownSPR4
	ldr r0,[r5]
	add r0,59h
	mov r1,0FFh
	strb r1,[r0]
DownSPR4:
	ldr r1,=3002340h
	ldr r2,=1C5Ch
	add r0,r1,r2
	ldr r0,[r0]
	add r0,4Eh
	ldrb r0,[r0]
	cmp r0,2h
	beq DownSPR5
	ldr r0,=828h
	add r1,r1,r0
	mov r0,2Dh
	bl 809C1C4h
DownSPR5:
	pop r4,r5
	pop r0
	bx r0
	.pool
	
FreeSpaceSPR1:
	ldr r0,[r5,20h]
	lsl r1,r4,1h
	add r1,11h
	add r0,r0,r1
	mov r2,2h
	strb r2,[r0]
	bx r14
	
FreeSpaceSPR2:
	ldrb r1,[r1]
	ldrb r0,[r0]
	cmp r1,r0
	beq NotSetToZero
	mov r0,0h
	cmp r2,0h
	bne ReturnSPR2
	ldr r1,[r6,20h]
	add r1,0EBh
	ldrb r1,[r1]
	cmp r1,2h
	bne ReturnSPR2
NotSetToZero:
	mov r0,1h
ReturnSPR2:
	bx r14
	.word 0x00000000
	.halfword 0x0000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of ResetCheckpoints (RCP)
.org 0x802834A	;Game Over
	add r0,0DDh
	strb r3,[r0]
	add r0,2h
	strb r3,[r0]
	add r0,1h
	strb r3,[r0]
	add r0,1h
	strb r3,[r0]
	add r0,1h
	strb r3,[r0]
	ldr r0,[r2,20h]
	str r4,[r0,68h]
	bl FreeSpaceRCS2
	bl 800E0B4h
	b 802841Ch
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix Layer 2 autoscroll wall triggers earthquake every frame when touching the ground (FLE)
.org 0x8026BBC
	ldr r2,=3002340h
	ldr r1,=1C58h
	add r4,r2,r1
	ldr r0,[r4]

.org 0x8026BCA
	ldr r1,[r4]
	add r1,0D6h
	ldr r2,=8103B16h

.org 0x8026BDE
	bne DeactivateOnOFFSwitch
	ldr r1,[r4]
	add r1,0BAh
	ldrh r0,[r1]
	cmp r0,0h
	beq 8026C40h
	mov r0,0h
	strh r0,[r1]
	bl FreeSpaceFLE
DeactivateOnOFFSwitch:
	ldr r0,=3002340h
	ldr r1,=1D05h
	add r0,r0,r1
	mov r1,0h
	strb r1,[r0]
	b 8026C40h
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Prevents out of bounds access of the enemy unstun table (EUT)
.org 0x802B024
	ldrb r0,[r5,1Ah]
	cmp r0,7h
	bhi 802B022h
	ldr r1,=3007A48h
	mov r0,64h
	mul r0,r2
	ldr r2,=06CCh
	bl FreeSpaceEUT

.org 0x802B0A4
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix out of bounds access of sprite status value (SOB) and despawn sprite that is in limbo when yoshis mouth is empty (DSL)
;Also contains code to prevent the p-balloon timer from decrementing when the game is frozen;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains code to fix the Bravo Mario/Luigi message (FBM) when stunning a thrown sprite with the cape;;;;;;;;;;;;;;;;;
.org 0x802B880	;Remove empty fct for when sprite is in yoshis mouth
	.halfword 0x0000

.org 0x802B95A	;Fix Bravo Mario/Luigi message
	mov r2,0h
	mov r1,r5
	add r1,5Eh
	ldrh r0,[r1]
	cmp r0,7h
	bls DownCheckMessage1
	sub r2,r0,7h
DownCheckMessage1:
	sub r1,2h
	ldrh r0,[r1]
	add r2,r2,r0
	lsl r0,r2,10h
	lsr r0,r0,10h
	mov r1,r5
	bl FreeSpaceFBM

.org 0x802BB02
	mov r2,0h
	mov r1,r6
	add r1,5Eh
	ldrh r0,[r1]
	cmp r0,7h
	bls DownCheckMessage2
	sub r2,r0,7h
DownCheckMessage2:
	sub r1,2h
	ldrh r0,[r1]
	add r2,r2,r0
	lsl r0,r2,10h
	lsr r0,r0,10h
	mov r1,r6
	bl FreeSpaceFBM

.org 0x802BFD0	;Prevent p-balloon timer from decrementing when the game is frozen
	push r4-r6,r14
	mov r5,r0
	ldr r3,=3002340h
	ldr r1,=1C58h
	add r0,r3,r1
	ldr r0,[r0]
	ldr r2,=1190h
	add r0,r0,r2
	ldrb r0,[r0]
	cmp r0,0h
	bne PBalloonTimerNotUpdatedOrTooHigh
	ldr r1,=0894h
	add r0,r3,r1
	ldrb r0,[r0]
	mov r6,3h
	and r0,r6
	cmp r0,0h
	bne PBalloonTimerNotUpdatedOrTooHigh
	mov r4,1h
	ldr r2,=3007A48h
	ldr r1,[r2]
	ldr r0,=0672h
	add r1,r1,r0
	ldrb r0,[r1]
	cmp r0,0h
	beq PBalloonExpires
	ldrb r0,[r1]
	sub r0,1h
	strb r0,[r1]
	ldrb r1,[r1]
	cmp r1,0h
	beq PBalloonExpires
	cmp r1,2Fh
	bhi PBalloonTimerNotUpdatedOrTooHigh
	mov r0,4h
	and r0,r1
	cmp r0,0h
	beq BPalloonSetTimer
	mov r4,9h
	mov r0,r1
	and r0,r6
	cmp r0,0h
	bne BPalloonSetTimer
	ldr r2,=08C4h
	add r1,r3,r2
	ldrh r0,[r5,10h]
	ldrh r1,[r1]
	sub r0,r0,r1
	sub r2,9Ch
	add r1,r3,r2
	strh r0,[r1]
	mov r0,5Fh
	bl 809C1C4h
BPalloonSetTimer:
	ldr r0,=3002340h
	ldr r1,=1CBAh
	add r0,r0,r1
	strb r4,[r0]
PBalloonTimerNotUpdatedOrTooHigh:
	mov r4,0h
PBalloonExpires:
	mov r0,r4
	bl FreeSpacePBF
	pop r4-r6
	pop r0
	bx r0
	.pool
	
CheckFreezeFlagController:
	push r14
	mov r2,r0
	ldr r3,=3002340h
	ldr r1,=1C58h
	add r0,r3,r1
	ldr r0,[r0]
	ldr r1,=1190h
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne GameFrozenNoInputCheck
	mov r0,r2
	bl 804FA34h
GameFrozenNoInputCheck:
	pop r0
	bx r0
	.pool
	
FreeSpaceSOB:
	ldrb r0,[r4,1Ch]
	cmp r0,0Ch
	bls NotOutOfBounds
	mov r0,0h
	strb r0,[r4,1Ch]
NotOutOfBounds:
	bx r14
	
.org 0x802C4A0	;Fix out of bounds access of sprite status value (SOB)
	bl FreeSpaceSOB
	ldrb r5,[r4,1Ch]
	cmp r5,0h
	beq 802C51Ch
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0F33h
	add r0,r0,r1
	mov r1,0FFh
	strb r1,[r0]
	ldr r1,=8108D60h
	lsl r0,r5,2h
	add r0,r0,r1
	ldr r1,[r0]
	add r0,r4,0h
	bl 809F038h
	cmp r5,8h
	bne 802C4DCh
	add r0,r4,0h
	bl 802B2F0h
	b 802C4EAh
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;Fix skull bug (FSB);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains code to update yoshi sprite slot earlier to prevent bugs from occuring (UYE)
.org 0x802C52E	;Fix skulll bug (FSB)
	ldr r2,=3007A48h
	ldr r0,=300302Ch
	str r0,[r2]
	ldr r0,[r2]
	ldr r1,=0683h
	add r0,r0,r1
	mov r3,0h
	strb r3,[r0]
	ldr r0,[r2]
	mov r1,0EEh
	lsl r1,r1,4h
	add r0,r0,r1
	strb r3,[r0]
	ldr r0,[r2]
	ldr r4,=0EDBh
	add r1,r0,r4
	sub r4,1h
	add r0,r0,r4
	ldrb r1,[r1]
	strb r1,[r0]
	ldr r0,[r2]
	add r4,1h
	add r0,r0,r4
	strb r3,[r0]
	ldr r0,[r2]
	add r4,1h
	add r1,r0,r4
	add r4,1h
	add r0,r0,r4
	ldrb r1,[r1]
	strb r1,[r0]
	ldr r0,[r2]
	sub r4,1h
	add r0,r0,r4
	strb r3,[r0]
	ldr r0,[r2]
	ldr r4,=697h
	add r0,r0,r4
	strb r3,[r0]
	ldr r0,[r2]
	ldr r1,=0686h
	add r0,r0,r1
	strb r3,[r0]
	ldr r0,[r2]
	ldr r3,=0F61h
	add r0,r0,r3
	mov r1,47h
	strb r1,[r0]
	ldr r1,[r2]
	ldr r4,=0EDAh
	add r0,r1,r4
	ldrb r0,[r0]
	cmp r0,0h
	beq 802C5CCh
	ldr r0,=0F62h
	add r1,r1,r0
	mov r0,5h
	strb r0,[r1]
	b 802C5D8h
	.pool
	
.org 0x802C5CC	;Update yoshi sprite slot earlier (UYE)
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0F62h

.org 0x802C5D8
	ldr r3,=3007A48h
	ldr r1,[r3]
	ldr r4,=0F61h

.org 0x802C5F4
	ldr r0,=3002340h

.org 0x802C60A
	ldr r3,=0F62h

.org 0x802C614
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r4,=0EDEh
	
.org 0x802C622
	ldr r0,=3002340h
	ldr r1,=1C58h

.org 0x802C62A
	ldr r2,=08EEh

.org 0x802C634
	ldr r0,=3007A48h

.org 0x802C646
	ldr r6,=3007A48h
	ldr r0,[r6]
	ldr r4,=0ED5h
	
.org 0x802C656
	ldr r0,=06CCh

.org 0x802C670
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r4,=068Fh
	add r0,r0,r4
	ldrb r0,[r0]
	cmp r0,0h
	beq DownUYE1
	bl 8032000h

DownUYE1:
	ldr r2,=3007A48h
	ldr r0,[r2]
	sub r4,9h
	add r0,r0,r4
	bl FreeSpaceUYE
	ldrb r1,[r0]
	cmp r1,0h
	bne DownUYE2
	ldr r0,=3002340h
	ldr r4,=1C58h
	add r0,r0,r4
	ldr r0,[r0]
	ldr r3,=10FAh
	add r0,r0,r3
	strb r1,[r0]
	ldr r0,[r2]
	ldr r4,=66Ch
	add r0,r0,r4
	strb r1,[r0]

DownUYE2:
	pop r4-r6
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Prevent the Player carrying an item while gliding, climbing, riding a yoshi or sliding (FIC)
.org 0x802C750
	ldr r3,=3002340h
	ldr r5,=0854h
	
.org 0x802C760
	ldr r2,=3007A48h
	ldr r2,[r2]
	ldr r0,=0EDAh
	add r1,r2,r0
	ldr r5,=1C58h
	add r0,r3,r5
	ldr r0,[r0]
	ldr r5,=10FAh
	add r0,r0,r5
	ldrb r1,[r1]
	ldrb r0,[r0]
	orr r1,r0
	bl FreeSpaceFIC1
	orr r1,r0
	cmp r1,0h
	bne 802C7BCh
	mov r0,0Bh
	strb r0,[r4,1Ch]
	ldr r5,=0EDAh
	add r0,r2,r5
	mov r1,1h
	strb r1,[r0]
	add r5,1h
	add r0,r2,r5
	strb r1,[r0]
	ldr r5,=1CEEh
	add r1,r3,r5
	mov r0,8h
	strb r0,[r1]
	b 802CA14h
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Adjust draw height of power ups and prevents out of bounds access of some item tables (ITA)
.org 0x802EC7E
	ldr r0,=3007A48h
	ldr r2,[r0]
	ldrb r0,[r3,1Ah]
	cmp r0,76h
	bne DownPowerUp1

.org 0x802ECA0
	b DownPowerUp2

.org 0x802ECB4
	.pool

.org 0x802ECC4
	.halfword 0x0000
DownPowerUp1:
	ldr r1,=810968Eh
	mov r3,r12
	bl FreeSpaceITA
	add r0,r0,r1
	ldr r1,=0EC8h
	add r2,r2,r1
	ldrb r0,[r0]
	strb r0,[r2]
DownPowerUp2:
	mov r0,r12
	add r0,34h
	ldrb r0,[r0]
	lsl r0,r0,3h
	ldr r1,=3002C28h
	add r5,r0,r1
	lsl r2,r7,17h
	lsr r2,r2,17h
	ldrh r0,[r5,2h]
	mov r1,0FEh
	lsl r1,r1,8h
	and r0,r1
	orr r0,r2
	strh r0,[r5,2h]
	add r6,1h
	strb r6,[r5]
	
.org 0x802ECFC
	bl FreeSpaceITA
	
.org 0x802EDAC
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Adjusts the spawn height of several sprites (1)
.org 0x802F4B8
	bl FreeSpaceASH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Prevents loosing yoshi when touching a ghost while beeing invincible and update sprite slot in yoshis mouth (FGS)
.org 0x8030A16	;update sprite slot in yoshis mouth
	add r5,r0,r2
	add r1,r5,0h

.org 0x8030A24
	strb r0,[r5,1Bh]
	mov r1,10h
	ldsh r0,[r5,r1]
	lsl r0,r0,10h
	str r0,[r5]
	mov r1,12h
	ldsh r0,[r5,r1]
	lsl r0,r0,10h
	str r0,[r5,4h]

.org 0x8030A38
	add r0,r5,0h
	
.org 0x8030A48
	str r0,[r5,8h]
	strb r2,[r5,1Fh]
	add r0,r5,0h
	bl FreeSpaceFGS1

.org 0x8030A58
	ldrh r2,[r5,10h]

.org 0x803166C
	ldr r2,[r0]

.org 0x8031670
	add r0,r2,r1

.org 0x803168C	;Prevent loosing yoshi when touching a ghost while beeing invincible
	bl FreeSpaceFGS2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix coins dropped by chucks when killed with fireballs don't sink in normal level lava
.org 0x80338D0
	b DoCoinCheck

.org 0x80338DC
	sub r0,59h
	cmp r0,2h
	bls 8033912h
	cmp r0,0A6h
	beq 8033912h
	ldrh r0,[r1]
	cmp r0,6Dh
	bhi 80338F4h
DoCoinCheck:
	mov r0,r4
	bl 8033634h
	b 8033912h
	
.org 0x8033928
	ldrh r0,[r0]
	lsr r0,r0,8h
	cmp r0,0h
	beq 8033958h
	ldr r0,[r5]
	ldrh r1,[r0]
	lsl r1,r1,18h
	bl FreeSpaceSCL
	cmp r0,0h
	bne 8033958h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Make turnblocks from 3-tile flying turnblock platform impassable from below like all the other turnblocks
.org 0x8035562
	ldr r3,=1CEDh
	add r0,r2,r3
	ldrb r0,[r0]
	cmp r0,0h
	beq PlayerIsNotInvincible
	cmp r4,83h
	beq PlayerIsInvincible
	cmp r4,0C1h
	bne PlayerIsNotInvincible
PlayerIsInvincible:
	b 80356F6h
PlayerIsNotInvincible:
	mov r0,r5
	bl 802FB50h
	lsl r0,r0,18h
	lsr r7,r0,18h
	cmp r4,0A9h
	bne SpriteIsNotAReznor
	add r0,r7,2h
	b PrepareXOffset
SpriteIsNotAReznor:
	cmp r4,0C1h
	bne SpriteIsNotA3TurnblockFlyingPlatform
	add r0,r7,6h
	b PrepareXOffset
	.pool

SpriteIsNotA3TurnblockFlyingPlatform:
	cmp r4,9Ch
	beq SpriteIs2TilesWide
	cmp r4,0BBh
	beq SpriteIs2TilesWide
	cmp r4,60h
	beq SpriteIs2TilesWide
	cmp r4,49h
	bne SpriteIs1TileWide
SpriteIs2TilesWide:
	add r0,r7,4h
PrepareXOffset:
	lsl r0,r0,18h
	lsr r7,r0,18h
SpriteIs1TileWide:
	ldr r0,=FreeSpaceSSI1
	lsl r1,r7,1h
	add r1,r1,r0
	ldrh r0,[r1]
	ldrh r1,[r5,10h]
	add r0,r0,r1
	lsl r0,r0,10h
	lsr r0,r0,10h
	mov r9,r0
	bl FreeSpaceSSI2
	cmp r1,0h
	beq 80356A4h
	mov r7,0h
	ldr r1,=3002340h
	ldr r0,[r1,20h]
	add r0,0E0h
	ldrb r0,[r0]
	cmp r0,0h
	beq PlayerIsNotSmallOrDucking
	ldr r2,=1C62h
	add r0,r1,r2
	ldrb r0,[r0]
	cmp r0,0h
	bne PlayerIsNotSmallOrDucking
	mov r7,0Ch
PlayerIsNotSmallOrDucking:
	ldr r0,=3002340h
	ldr r3,=1C58h
	add r0,r0,r3
	ldr r0,[r0]
	ldr r4,=10FAh
	add r0,r0,r4
	ldrb r0,[r0]
	cmp r0,0h
	beq PlayerIsNotRidingAYoshi
	mov r0,r7
	add r0,18h
	lsl r0,r0,18h
	lsr r7,r0,18h
PlayerIsNotRidingAYoshi:
	ldr r0,=3002340h
	ldr r1,=1C94h
	add r0,r0,r1
	mov r8,r0
	ldr r2,=8119E5Eh
	mov r10,r2
	add r0,r7,1
	lsl r0,r0,1h
	add r0,r10
	ldrh r1,[r0]
	mov r3,r8
	ldrh r3,[r3]
	add r1,r1,r3
	mov r0,r9
	add r0,8h
	
.org 0x8035668
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Mario\Luigi says "Just what i needed" when he collects a flower while not beeing fire mario/luigi or
;a feather while not having a cape or a mushroom when beeing small, otherwise he says "gotcha" (JWN);
;Also contains sanity checks to prevent invalid status of Mario etc.;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains code to prevent loosing yoshi when touching several sprites while beeing invincible;;;
;Also contains code to give the Player 100p when yoshi eats an enemy and gives a coin (GHP);;;;;;;;;;
;Also contains code to make yoshi swallow a null sprite immediately;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains code to update yoshi properly after he died in lava;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains a fix for 0-time glitch;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains code to prevent itembox item drops from turning into a coin at the goal (DIC);;;;;;;;;
;Also contains a fix for the palette of the reminders of a block destroyed by a chuck (FRB);;;;;;;;;;
;Also contains part 2 of fix item carry (FIC);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains code to prevent the Player from activating a secret exit with a key after dying (FSD);
;Also contains part 2 of fix skull bug (FSB);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains code to enable sprite interaction with the lightswitch (SLS);;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains code to prevent yoshi from eating sparks;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains code to prevent a yoshi from hatching from a egg when another yoshi is in the level;;;
;Also contains a fix for buggy behavior of directional coin when blue p-switch is active (DCBF);;;;;;
;Also contains code to give the right amount of points when yoshi eats a coin (RAP);;;;;;;;;;;;;;;;;;
;Also contains a fix for yoshi using his pipe animation when he is not mounted by the Player (FYA);;;
;Also contains code to prevent yoshi from falling through lakitu's cloud;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.org 0x8035656	;Prevent loosing yoshi when touching a certain sprite while beeing invincible
	ldr r2,[r0]

.org 0x803565A
	add r0,r2,r1
	
.org 0x8035662
	bl FreeSpaceFGS2
	
.org 0x80356C0
	ldr r3,=1C58h
	add r0,r2,r3
	ldr r2,[r0]
	ldr r1,=10FAh
	add r0,r2,r1

.org 0x80356D0
	bl FreeSpaceFGS2
	
.org 0x80356E0
	.pool

.org 0x8035726
	pop r0
	bx r0

FreeSpacePID:
	add r3,0E1h
	ldrb r2,[r3]
	cmp r2,4h
	bls GoodItem
	mov r2,0h
	strb r2,[r3]
GoodItem:
	bx r14

.org 0x8035766
	bl FreeSpaceMFIS
	
.org 0x80359A0
	bl FreeSpaceMFIS

.org 0x8035B40	;Fix 0-time glitch (Player touches upgrade) and prevents mushrooms from overwritting flowers/feathers in the item stock
	ldr r5,=3002340h
	ldr r3,[r5,20h]
	bl FreeSpacePII
	cmp r7,13h
	bhi 8035B9Eh
	cmp r1,9h
	beq 8035B9Eh
	ldr r0,=810AC54h
	add r2,r7,r0
	ldrb r2,[r2]
	cmp r2,0h
	beq 8035B8Ah
	ldr r0,=0828h
	add r4,r5,r0
	bl FreeSpacePMO
	cmp r0,0h
	beq 8035B6Eh

.org 0x8035B70
	add r0,r5,r1
	ldrh r0,[r0]
	strh r0,[r4]
	ldr r0,[r5,20h]
	
.org 0x8035B7E
	add r0,r5,r2
	
.org 0x8035B82
	bl FreeSpaceJWN
	
.org 0x8035B8E
	add r0,r7,r0
	
.org 0x8035BA4
	.pool
	
.org 0x8037AC2	;Prevent extra live counter overflow
	bl FreeSpacePLO
	
.org 0x8037B78	;Prevents cape spin code from running while the game is frozen and reset cape spin flag when riding a yoshi
	bl FreeSpaceCSC
	
.org 0x8037FBC	;Make directional coin restart the music on activation in case a p-switch was pressed before
	beq CheckStartMusic

.org 0x8037FD0
	lsl r1,r4
	ldrb r0,[r2]
	orr r0,r1
	strb r0,[r2]
	strb r4,[r5,1Fh]
	b 803801Ah
	.word 0x00000000
CheckStartMusic:
	bl FreeSpaceDCM

.org 0x8038004
	add r2,r2,r1
	ldrb r3,[r2]

.org 0x8038728	;Prevent point counter overflow
	bl FreeSpacePNPO1

.org 0x8038730	;Prevent special world point counter overflow
	bl FreeSpacePSPO1
	
.org 0x8038B90	;Prevent dropping invalid item
	bl FreeSpacePID
	
.org 0x8038C5E	;Prevent itembox item drop from turning into a coin at the goal
	mov r2,1h
	strb r2,[r1]
	bl FreeSpaceDIC
	ldrb r0,[r4,1Ah]
	cmp r0,77h
	bne 8038C70h
	add r1,0Eh
	strb r2,[r1]
	
.org 0x803DF08	;Prevent point counter overflow
	bl FreeSpacePNPO2
	
.org 0x803DF0E	;Prevent special world point counter overflow
	add r3,r2,r3
	ldr r2,[r3]
	ldr r0,[r2]
	bl FreeSpacePSPO2
	
.org 0x803E194	;Prevent point counter overflow
	push r4-r6,r14

.org 0x803E25C
	ldr r6,=810BA72h
	lsl r0,r0,1h
	add r0,r0,r6
	
.org 0x803E266
	bl FreeSpacePNPO2

.org 0x803E26C
	add r3,r2,r0
	ldr r2,[r3]

.org 0x803E274
	add r0,r0,r6
	
.org 0x803E27A
	bl FreeSpacePSPO2

.org 0x803E28C
	pop r4-r6

.org 0x803E298
	.pool
	
.org 0x804389E	;Adjust draw position of chucks
	add r0,r2,r0
	mov r3,0h
	ldsh r0,[r0,r3]
	
.org 0x80438AA
	bls DownChucks1
	
.org 0x80438C8
	.halfword 0x0000
DownChucks1:
	ldr r4,=0EB6h
	add r1,r2,r4
	ldr r0,=810C87Ah
	add r0,r7,r0
	ldrb r0,[r0]
	ldrb r1,[r1]
	add r0,r0,r1
	ldr r1,=0EC2h
	add r2,r2,r1
	ldrb r2,[r2]
	sub r0,r0,r2
	add r0,1h
	strb r0,[r5]
	ldr r0,=3007A48h

.org 0x8043980
	.pool

.org 0x8043A32
	cmp r0,0DFh

.org 0x8043A58
	bl FreeSpaceCDH

.org 0x8043B42
	cmp r0,0DFh

.org 0x8043B68
	bl FreeSpaceCDH
	
.org 0x8043CF2
	add r7,1h
	strb r7,[r4]
	ldrh r0,[r4,4h]
	mov r1,0FCh
	lsl r1,r1,8h
	and r0,r1
	ldr r1,=019Dh
	orr r0,r1
	strh r0,[r4,4h]
	ldrb r3,[r4,3h]
	mov r0,0DFh
	and r3,r0
	mov r0,0EFh
	and r3,r0
	strb r3,[r4,3h]
	ldrb r2,[r4,5h]
	mov r0,0Fh
	and r2,r0
	mov r0,40h
	orr r2,r0
	strb r2,[r4,5h]
	ldr r1,=810A688h
	mov r0,9Bh
	lsl r0,r0,5h
	add r0,r8
	ldr r0,[r0]
	ldr r5,=1177h
	add r0,r0,r5
	ldrb r0,[r0]
	lsr r0,r0,4h
	add r0,r0,r1
	ldrb r0,[r0]
	mov r1,3h
	and r0,r1
	lsl r0,r0,2h
	mov r1,0F3h
	and r2,r1
	orr r2,r0
	strb r2,[r4,5h]
	mov r0,3Fh
	and r3,r0
	strb r3,[r4,3h]
	ldrb r0,[r4,1h]
	mov r1,10h
	orr r0,r1
	strb r0,[r4,1h]
	b 804406Ah

.org 0x8043D70
	.pool

.org 0x8043E42
	add r2,1h
	strb r2,[r4]
	mov r7,96h
	lsl r7,r7,1h
	add r2,r5,r7
	ldrh r0,[r4,4h]
	mov r1,0FCh
	lsl r1,r1,8h
	and r0,r1
	orr r0,r2
	strh r0,[r4,4h]
	ldrb r3,[r4,3h]
	mov r0,0DFh
	and r3,r0
	
.org 0x8044098
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0EB8h

.org 0x80440B8
	ldr r0,=3007A48h
	ldr r0,[r0]
	sub r1,0Eh
	ldr r2,=0EB8h
	add r0,r0,r2
	strh r1,[r0]
	ldr r3,=3007A48h
	mov r9,r3
	ldr r7,[r3]
	ldr r4,=0EB6h
	add r2,r7,r4
	ldr r1,=810CA9Ch
	ldr r0,=0EB8h

.org 0x80440FE
	ldr r6,=3002C40h

.org 0x8044110
	ldr r0,=810CA94h

.org 0x8044118
	ldr r2,=0EB4h

.org 0x804413A
	ldr r0,=810CA9Ah
	mov r1,1h
	and r3,r1
	add r3,r3,r0
	ldrb r0,[r3]
	and r0,r1
	lsl r0,r0,4h
	mov r1,0EFh
	and r5,r1
	orr r5,r0
	strb r5,[r4,3h]
	ldrb r2,[r4,5h]
	mov r0,0Fh
	and r2,r0
	mov r0,30h
	orr r2,r0
	strb r2,[r4,5h]
	ldr r1,=810A688h
	ldr r3,=1358h
	add r6,r6,r3
	ldr r0,[r6]
	ldr r3,=1177h
	add r0,r0,r3
	ldrb r0,[r0]
	lsr r0,r0,4h
	add r0,r0,r1
	ldrb r0,[r0]
	mov r1,3h
	and r0,r1
	lsl r0,r0,2h
	mov r1,0F3h
	and r2,r1
	orr r2,r0
	strb r2,[r4,5h]
	mov r1,r9
	ldr r0,[r1]
	ldr r2,=0EB8h
	add r0,r0,r2
	ldrb r3,[r0]
	mov r0,r12
	add r0,1h
	strb r0,[r4]
	ldr r0,=810CA9Fh

.org 0x80441A6
	ldr r0,=810CAA2h

.org 0x80441AE
	mov r1,1h

.org 0x80441D0
	.pool

.org 0x804923C	;Prevent yoshi from eating sparks (FYS)
	push r14
	mov r2,r0
	bl 8049200h
	bl FreeSpaceFYS
	ldrb r0,[r2,1Fh]
	mov r1,10h
	eor r0,r1
	strb r0,[r2,1Fh]
	lsr r0,r0,2h
	strb r0,[r2,1Bh]
	pop r0
	bx r0
	
.org 0x804BC0C	;Adjust draw height of vulcano lotos
	bl FreeSpaceHVL

.org 0x804C5B8	;Prevent loosing yoshi when touching a mega mole while beeing invincible
	ldr r2,[r0]
	
.org 0x804C5BC
	add r0,r2,r1
	
.org 0x804C5C4
	bl FreeSpaceFGS2
	
.org 0x804EB44	;Prevent a (baby) yoshi from hatching from an egg if another (adult) yoshi is in the level
	bl FreeSpaceFMY

.org 0x804FB9E	;Prevent the inputs to control lakitu's cloud from updating when the game is frozen
	bl CheckFreezeFlagController

.org 0x8053F5C	;Make top of directional coin block solid if blue p-switch is active and adjust the draw height of the block if blue p-switch is not active
	ldr r2,=3002340h
	ldr r1,=1C58h
	add r0,r2,r1
	ldr r0,[r0]
	ldr r3,=1177h
	add r1,r0,r3

.org 0x8053F78
	ldr r0,=1D03h
	add r2,r2,r0
	ldrb r0,[r2]
	cmp r0,0h
	bne DownDirectionalSolidBlock
	mov r0,r4
	bl 802EDCCh
	mov r3,0h
	b CheckYoshiSolid
	.pool
	
DownDirectionalSolidBlock:
	ldrh r5,[r4,12h]
	ldrh r0,[r4,12h]
	sub r0,1h
	strh r0,[r4,12h]
	mov r0,r4
	bl 802D4A4h
	mov r0,r4
	add r0,34h
	ldrb r2,[r0]
	lsl r2,r2,3h
	ldr r0,=3002C28h
	add r2,r2,r0
	ldrh r0,[r2,4h]
	mov r1,0FCh
	lsl r1,r1,8h
	and r0,r1
	mov r1,1Eh
	orr r0,r1
	strh r0,[r2,4h]
	bl FreeSpaceDCBF
	mov r0,r4
	bl 8035324h
	strh r5,[r4,12h]
	mov r3,1h

CheckYoshiSolid:
	mov r0,r4
	add r0,44h
	ldrb r1,[r0]
	mov r2,1h
	and r1,r2
	cmp r1,r3
	beq NoChangeYoshiSolid
	ldrb r1,[r0]
	eor r1,r2
	strb r1,[r0]
NoChangeYoshiSolid:
	ldr r2,=3002340h
	ldr r3,=1C58h
	add r5,r2,r3
	ldr r0,[r5]
	ldr r3,=1177h
	add r0,r0,r3
	strb r6,[r0]
	ldr r0,[r5]
	ldr r1,=1190h
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne 80540E0h
	ldr r3,=0894h
	add r0,r2,r3
	ldrb r0,[r0]
	mov r1,3h
	and r0,r1
	cmp r0,0h
	bne NotYetTimeForSound
	ldr r2,=3007A48h
	ldr r1,[r2]
	ldr r0,=06B7h
	add r1,r1,r0
	ldrb r0,[r1]
	sub r0,1h
	strb r0,[r1]
	ldrb r0,[r1]
	cmp r0,0h
	beq 8054104h
	ldrb r0,[r1]
	cmp r0,1Dh
	bne NotYetTimeForSound
	ldr r1,=3002B68h
	mov r0,2Fh
	bl 809C1C4h
NotYetTimeForSound:
	ldrb r1,[r4,1Bh]
	ldr r2,=810E784h
	add r0,r1,r2
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	lsl r0,r0,0Ch
	str r0,[r4,8h]
	add r2,4h
	add r1,r1,r2
	mov r0,0h
	ldsb r0,[r1,r0]
	lsl r0,r0,0Ch
	str r0,[r4,0Ch]
	mov r0,r4
	bl 802F254h
	mov r0,r4
	bl 802F214h
	ldr r0,=3002340h
	ldr r2,=0854h
	add r0,r0,r2
	ldrh r0,[r0]
	lsr r0,r0,4h
	mov r1,0Fh
	and r1,r0
	cmp r1,0h
	beq DownDCB
	ldr r2,=810E78Ch
	add r0,r1,r2
	ldrb r1,[r0]
	add r2,10h
	add r0,r1,r2
	ldrb r0,[r0]
	ldrb r3,[r4,1Bh]
	cmp r0,r3
	beq DownDCB
	strb r1,[r4,1Fh]
DownDCB:
	ldrh r3,[r4,10h]
	ldrh r0,[r4,12h]
	orr r0,r3
	mov r1,0Fh
	and r0,r1
	cmp r0,0h
	bne 80540E0h
	ldrb r0,[r4,1Fh]
	strb r0,[r4,1Bh]
	ldr r0,[r5]
	strh r3,[r0,30h]
	ldr r2,[r5]
	ldrh r0,[r4,12h]
	strh r0,[r2,2Ch]
	ldr r1,=3002340h
	ldr r2,=1D4Ah
	add r1,r1,r2
	mov r0,6h
	strb r0,[r1]
	bl 800EEC8h
	b 8054134h
	.pool

.org 0x8054106
	bl FreeSpaceDCF

.org 0x8054130
	bl FreeSpaceDCF

.org 0x805695C	;Part of fix item carry (FIC)
	push r4-r6,r14

.org 0x8056BE8
	ldr r3,=3002340h
	ldr r1,=0854h
	
.org 0x8056BF6
	beq ItemNotCarried
	ldr r2,=3007A48h
	ldr r2,[r2]
	ldr r0,=0EDAh
	add r1,r2,r0
	ldr r5,=1C58h
	add r0,r3,r5
	ldr r0,[r0]
	ldr r6,=10FAh
	add r0,r0,r6
	bl FreeSpaceFIC2
	orr r1,r0
	cmp r1,0h
	bne ItemNotCarried
	mov r0,0Bh
	strb r0,[r4,1Ch]
	mov r0,r4
	add r0,36h
	strb r1,[r0]
	ldr r6,=0EDAh
	add r0,r2,r6
	mov r1,1h
	strb r1,[r0]
	add r6,1h
	add r0,r2,r6
	strb r1,[r0]
	add r5,96h
	add r1,r3,r5
	mov r0,8h
	strb r0,[r1]
ItemNotCarried:
	mov r0,r4
	bl 802CA2Ch
	b 8056C6Ch
	.pool

.org 0x8056C8A
	pop r4-r6
	
.org 0x80573E4	;Prevent the Player from activating a secret exit with a key after dying (FSD)
	ldr r2,=3002340h
	mov r1,0E6h
	lsl r1,r1,5h
	add r0,r2,r1
	mov r1,r6
	add r1,34h
	ldrb r0,[r0]
	cmp r0,2h
	bne DownFSD1
	mov r0,73h
	b DownFSD2
DownFSD1:
	mov r0,7Fh
DownFSD2:
	strb r0,[r1]
	ldr r1,=1C58h
	bl FreeSpaceFSD
	cmp r0,0h
	bne 80574FAh

.org 0x8057464
	.pool

.org 0x8057928	;Part of fix skull bug (FSB)
	blt DownSkull1
	str r0,[r4,0Ch]
DownSkull1:
	mov r0,r4
	bl 802F17Ch
	mov r0,r4
	add r0,2Bh
	ldrb r0,[r0]
	mov r1,4h
	and r0,r1
	cmp r0,0h
	beq DownSkull2
	mov r0,80h
	lsl r0,r0,9h
	str r0,[r4,0Ch]
DownSkull2:
	mov r0,r4
	bl 803515Ch
	strb r0,[r4,1Fh]

.org 0x80579CC
	.word 0x20000

.org 0x80579AE
	b DownSkull3

.org 0x80579E4
	ldr r0,[r6]
	sub r7,26h
	add r0,r0,r7
	mov r1,1Ch
DownSkull3:
	strh r1,[r0]
	ldr r2,=3002340h
	ldr r3,=3007A48h
	ldr r0,[r3]
	ldr r7,=0EB6h
	add r0,r0,r7
	ldrh r1,[r4,12h]
	ldrh r0,[r0]
	sub r1,r1,r0
	add r1,1h
	ldr r4,=1C94h
	add r0,r2,r4
	strh r1,[r0]
	ldr r7,=1C66h

.org 0x8057A14
	ldr r0,[r3]
	ldr r1,=0683h
	add r5,r0,r1
	ldrb r0,[r5]
	cmp r0,0h
	bne DownSkull4
	mov r0,1h
	strb r0,[r5]
	ldr r7,=0EE9h
	bl FreeSpaceFSB
DownSkull4:
	pop r4-r7
	pop r0
	bx r0
	.pool
	
.org 0x8057A64	;Make lightswitch solid for sprites
	bl 8034964h
	mov r0,r7
	bl 8035324h
	mov r0,r7
	bl FreeSpaceSLS
	
.org 0x805CA4A	;Reset Yoshicolor when reseting yoshi
	strh r1,[r0]
	
.org 0x805CC80	;Update yoshi correctly after dying in lava
	ldr r2,[r0]

.org 0x805CC84
	add r0,r2,r1
	
.org 0x805CCBC
	ldr r1,=0ED5h
	add r0,r2,r1
	ldrb r0,[r0]
	bl FreeSpaceUYD

.org 0x805CCD2
	.pool
	
.org 0x805CED8	;Gives 100p when yoshi eats a red/pink berry and 200p when yoshi eats an enemy and gives a coin
	bl FreeSpaceGHP1
	
.org 0x805D204	;Fix 0-time glitch (yoshi eats upgrade)
	bl FreeSpacePII
	cmp r7,13h
	bhi 805D25Eh
	cmp r1,9h
	beq 805D25Eh
	
.org 0x805D214	;Prevents mushrooms from overwritting flowers/feathers in the item stock
	ldrb r2,[r2]
	cmp r2,0h
	beq 805D24Ah
	ldr r0,=0828h
	add r4,r6,r0
	bl FreeSpacePMO
	cmp r0,0h
	beq 805D22Eh

.org 0x805D242
	bl FreeSpaceJWN
	
.org 0x805D26C
	.pool
	
.org 0x805D86E	;Makes Yoshi swallow a null sprite immediately
	beq DownYoshiSwallow2

.org 0x805D884
	bhi DownYoshiSwallow2

.org 0x805D8A4	;Prevent invalid Yoshi having glitched abilities
	bl FreeSpacePIA
	
.org 0x805D8BC	;Prevent invalid Koopa shell giving glitched abilities
	bl FreeSpacePIA

.org 0x805D8F4	;Makes Yoshi swallow a null sprite immediately
	beq DownYoshiSwallow2
	
.org 0x805D900
	bne DownYoshiSwallow2
	
.org 0x805D916
	b DownYoshiSwallow1
	
.org 0x805D950
	mov r4,9Eh
	lsl r4,r4,3h
	add r1,r1,r4
DownYoshiSwallow1:
	mov r0,0Ch
	strb r0,[r1,18h]
DownYoshiSwallow2:
	ldr r6,=3002340h
	bl FreeSpaceSNS
	cmp r0,0h
	bne 805D9B8h
	ldr r0,=0894h
	add r0,r6,r0
	ldrb r0,[r0]
	mov r1,3h  
	and r0,r1  
	cmp r0,0h  
	bne 805D9B8h
	ldr r2,=3007A48h
	ldr r0,[r2]
	ldr r3,=067Ah
	add r1,r0,r3
	ldrb r0,[r1]
	cmp r0,0h
	beq 805D9B8h
	ldrb r0,[r1]
	sub r0,1h
	strb r0,[r1]
	ldrb r0,[r1]

.org 0x805D9A8
	.pool
	
.org 0x805DC38	;Fix 0-time glitch (yoshi eats wings)
	ldrb r4,[r5,1Bh]
	cmp r4,0h
	beq 805DC80h
	mov r0,r6
	bl 805DA7Ch
	cmp r4,2h
	bne DownYoshiWings1
	ldr r1,=3002340h
	mov r0,8h
	bl FreeSpaceF0T1
	cmp r0,8h
	bne DownYoshiWings1
	bl 80714F0h
	ldr r3,=3002340h
	ldr r1,=08C4h
	add r2,r3,r1
	ldrh r0,[r5,10h]
	ldrh r2,[r2]
	sub r0,r0,r2
	sub r1,9Ch
	add r1,r3,r1
	strh r0,[r1]
	mov r0,3Bh
	bl 809C1C4h
DownYoshiWings1:
	mov r0,r5
	bl 805CCD8h
	b 805DCA2h
	.pool

.org 0x805DE0C	;Give the Player the correct amount of points when yoshi eats them
	bl FreeSpaceRAP

.org 0x805E536	;Prevents Yoshi from using his pipe animation when he is not mounted by the Player (FYA)
	bl FreeSpaceFYA
	
.org 0x805E880	;Fixes Player can slide up slopes when riding yoshi
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r3,=067Dh

.org 0x805E88C
	beq YoshiNotPunched

.org 0x805E896
	ldr r3,=3002340h
	b 805E8CCh
	.pool
	
YoshiNotPunched:
	ldr r3,=3002340h
	ldr r1,=1CD6h
	add r0,r3,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne 805E8D6h
	ldr r4,=0854h
	add r0,r3,r4
	ldrh r0,[r0]
	mov r1,80h
	and r0,r1
	cmp r0,0h
	beq 805E8D6h
	bl FreeSpaceSYF
	cmp r0,0h
	bne 805E8D6h

.org 0x805E91C
	.pool

.org 0x805ED2C	;Reset Yoshicolor when reseting Yoshi
	strh r4,[r0]
	
.org 0x805EE10	;Fix 0-time glitch (Player touches wings)
	ldrb r0,[r4,1Ah]
	cmp r0,0BFh
	beq 805EEA2h
	cmp r0,7Eh
	bne 805EE5Ch
	ldrb r0,[r4,1Bh]
	cmp r0,0h
	beq 805EEA2h
	cmp r0,2h
	bne DownYoshiWings2
	ldr r1,=3002340h
	mov r0,8h
	bl FreeSpaceF0T1
	cmp r0,8h
	bne DownYoshiWings2
	bl 80714F0h
	ldr r3,=3002340h
	ldr r1,=8C4h
	add r2,r3,r1
	ldrh r0,[r4,10h]
	ldrh r2,[r2]
	sub r0,r0,r2
	sub r1,9Ch
	add r1,r3,r1
	strh r0,[r1]
	mov r0,3Bh
	bl 809C1C4h
DownYoshiWings2:
	add r0,r4,0
	bl 805CCD8h
	b 805EEA2h
	.pool
	
.org 0x805F67A	;Prevents Yoshi from falling through lakitu's cloud and correct Yoshi's position on top of skull platforms if the player also stands on it
	beq YoshiSolidSprite6

.org 0x805F688
	bge YoshiSolidSprite6

.org 0x805F694
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r3,=0EC2h

.org 0x805F6AE
	beq YoshiSolidSprite6
	cmp r6,45h
	bne YoshiSolidSprite1
	ldrh r0,[r5,12h]
	sub r0,20h
	b YoshiSolidSprite4
YoshiSolidSprite1:
	cmp r6,61h
	bne YoshiSolidSprite2
	bl FreeSpaceYSP
	b YoshiSolidSprite4
	.pool
YoshiSolidSprite2:
	cmp r6,87h
	bne YoshiSolidSprite3
	bl FreeSpaceYLC
	b YoshiSolidSprite7
YoshiSolidSprite3:
	ldrh r0,[r5,12h]
	sub r0,1Fh
YoshiSolidSprite4:
	strh r0,[r4,12h]
	cmp r6,0B9h
	beq YoshiSolidSprite5
	cmp r6,0C8h
	beq YoshiSolidSprite5
	mov r0,r6
	sub r0,83h
	cmp r0,1h
	bhi YoshiSolidSprite7
YoshiSolidSprite5:
	mov r0,r5
	add r0,24h
	ldrb r0,[r0]
	cmp r0,7h
	bls YoshiSolidSprite7
	ldr r0,=0FFFE0000h
	str r0,[r4,0Ch]
YoshiSolidSprite6:
	mov r0,0h
	b YoshiSolidSprite9
	.pool
YoshiSolidSprite7:
	mov r1,12h
	ldsh r0,[r4,r1]
	lsl r0,r0,10h
	str r0,[r4,4h]
	mov r2,r5
	add r2,56h
	mov r0,0h
	ldsb r0,[r2,r0]
	ldrh r3,[r4,10h]
	add r0,r0,r3
	mov r1,0h
	strh r0,[r4,10h]
	mov r3,10h
	ldsh r0,[r4,r3]
	lsl r0,r0,10h
	str r0,[r4]
	strb r1,[r2]
	ldrb r0,[r4,1Bh]
	cmp r0,0h
	bne YoshiSolidSprite8
	str r0,[r4,8h]
YoshiSolidSprite8:
	ldr r0,=3007A48h
	ldr r1,[r0]
	ldr r0,=0F2Eh
	add r1,r1,r0
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]
	mov r0,1h
YoshiSolidSprite9:
	pop r4-r6
	pop r1
	bx r1
	.pool
	
.org 0x805F800	;Fix yoshi runs on air when running on a line-guded checkered platform before falling downwards and fix yoshis position on top of line-guded platforms
	ldr r4,[r4]
	ldr r1,=0EC2h
	add r0,r4,r1

.org 0x805F810
	ldr r0,=0EB4h
	add r2,r4,r0
	ldrh r0,[r2]
	bl FreeSpaceYLP
	strh r0,[r2]
	ldr r0,=0EB6h
	add r1,r4,r0
	
.org 0x805F832
	sub r0,25h
	
.org 0x805F878
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fixed a bug that causes the Player to climb in the air when getting pushed from a rope mechanism by a solid block and stop the rope mechanism carrying the Player when they touch the ground
.org 0x8063322
	ldr r5,=3002340h
	ldr r3,=1C66h
	add r0,r5,r3
	bl FreespaceFRG
	add r0,r5,r3
	ldrb r0,[r0]
	mov r1,3h
	and r0,r1
	cmp r0,0h
	beq RopeDown
	mov r2,r4
	add r2,28h
	b 8063394h
RopeDown:
	mov r0,r4
	bl 8034BC4h
	lsl r0,r0,18h
	lsr r1,r0,18h
	cmp r1,0h
	bne 8063364h
	mov r2,r4
	add r2,28h
	ldrb r0,[r2]
	cmp r0,0h
	bne 8063394h
	b 8063518h
	.pool
	.word 0x00000000
	
.org 0x806336A
	ldr r0,=3007A48h
	ldr r1,[r0]
	ldr r0,=0EDAh
	add r1,r1,r0
	ldr r5,=3002340h
	ldr r2,=1C58h
	add r0,r5,r2
	ldr r0,[r0]
	ldr r3,=10FAh
	add r0,r0,r3

.org 0x8063398
	ldr r6,=1D0Fh
	add r0,r5,r6
	b 8063516h
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix Fuzzy death animation (FDA)
.org 0x806352A
	bl FreeSpaceFDA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Adjusts the spawn height of several sprites (2)
.org 0x802F4B8
	bl FreeSpaceASH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Gives Iggy Koopa his correct hair tile (FIH)
.org 0x8066460
	bl FreeSpaceFIH
	cmp r0,4h
	bhi 806647Eh
	lsr r0,r0,1h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;others
.org 0x8067CFC	;Makes goal item a 1-up if Player is big and has feather or flower in stock
	ldr r3,=3002340h
	ldr r0,[r3,20h]
	add r0,0E0h
	ldrb r5,[r0]
	add r2,r5,0h
	ldr r0,=1C58h
	add r1,r3,r0
	ldr r0,[r1]
	ldr r1,=1158h
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,0h
	beq DownGIM
	mov r2,4h
DownGIM:
	ldr r0,=1C58h
	add r1,r3,r0
	ldr r0,[r1]
	
.org 0x8067D38
	.pool

.org 0x8067D6A
	bl FreeSpaceGIM
	
.org 0x80691FC	;Fix a glitch that causes Luigi to use Marios Voice when saying Bravo after collecting 5 Yoshi coins
	add r4,r1,r3
	ldrb r0,[r4]
	
.org 0x806920C
	ldrb r0,[r4]
	cmp r0,5h
	bne 8069228h
	ldr r0,=1C70h
	add r0,r9
	ldr r1,=0828h
	add r1,r9
	ldrh r0,[r0]
	strh r0,[r1]
	bl FreeSpaceFLB

.org 0x80692A8
	.pool

.org 0x8069C4C	;Fixes an issue that causes Mario/Luigi to fly without a cape and glide while riding a yoshi (1)
	bl FreeSpaceFWC
	
.org 0x8069DCC
	bl FreeSpaceFWC

.org 0x8069F14
	bl FreeSpaceFWC
	
.org 0x806A698
	bl FreeSpaceFWC
	
.org 0x806A7CC	;Fix showing time up when dying in a level without time limit and time up not showing when game over
	strh r3,[r0]
	ldr r1,[r4,20h]
	add r1,9Ch
	ldrh r0,[r1]
	sub r0,1h
	strh r0,[r1]
	b CheckTimeLimit
NoTimeLimit:

.org 0x806A7E4
	bge 806A8D0h

.org 0x806A83C
CheckTimeLimit:
	ldr r1,=1C58h
	add r0,r4,r1
	ldr r2,[r0]
	ldr r1,=08EEh
	add r0,r2,r1
	ldrh r1,[r0]
	lsl r1,r1,2h
	bl FreeSpaceFTL
	lsr r0,r0,6h
	cmp r0,0h
	beq NoTimeLimit
	ldr r3,=116Ah
	add r0,r2,r3
	add r3,1h
	add r1,r2,r3
	ldrb r0,[r0]
	ldrb r1,[r1]
	orr r0,r1
	add r3,1h
	add r2,r2,r3
	ldrb r1,[r2]
	orr r0,r1
	cmp r0,0h
	beq 806A87Ch
	b NoTimeLimit
	.pool

.org 0x806AF9C	;Fixes an issue that causes Mario/Luigi to fly without a cape and glide while riding a yoshi (2)
	bl FreeSpaceFWC

.org 0x806AFB4	;Save Yoshicolor when entering castle/ghost house while riding a Yoshi
	beq DownOthers1
	bl 8070A94h
	b DownOthers1
	
.org 0x806AFD8
	ldr r4,=3002340h
	ldr r2,=1C58h
	add r0,r4,r2
	ldr r1,[r0]
	ldr r0,=114Eh
	add r1,r1,r0
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]
	ldr r2,=0886h
	add r1,r4,r2
	mov r0,1Fh
	strb r0,[r1]
	cmp r5,10h
	bls DownOthers2
	ldr r3,=3007A48h
	bl FreeSpaceGYC
DownOthers2:
	ldr r0,=3002340h
	ldr r1,=1C5Ch
	add r0,r0,r1
	ldr r0,[r0]
	add r0,55h
	mov r1,1h
	strb r1,[r0]
DownOthers1:
	pop r4-r7
	pop r0
	bx r0
	.pool

.org 0x806B370	;Fixes an issue that causes Mario/Luigi to fly without a cape and glide while riding a yoshi (3)
	bl FreeSpaceFWC
;;;;;;;;

;Part 3 of Mario palette move (MPM)
.org 0x806B5A8
	bl FreeSpaceMPM3

.org 0x806B5B2
	bl FreeSpaceMPM3
	
.org 0x806BCE6
	ldrb r0,[r4,5h]
	bl FreeSpaceMPM4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of Fix 0-time glitch (F0T)
.org 0x806CA3A	;(Player enters a door)
	bl FreeSpaceF0T2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Reduces the death boundary below ground to prevent swimming or flying below blocks (FBB)
.org 0x806DE2A
	ldr r4,=3002340h

.org 0x806DE2E
	add r0,r4,r2
	bl FreeSpaceFBB
	sub r1,r1,r3
	cmp r1,0h
	blt 806DE78h
	ldr r1,=1C58h
	add r0,r4,r1
	
.org 0x806DE54
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part of MoonRespawn, makes hidden 1ups respawn when reentering the level (H1RS)
.org 0x806E382
	bl FreeSpaceH1RS
	lsl r0,r0,18h
	lsr r3,r0,18h
	ldr r0,[r4,20h]
	mov r1,r13
	ldrb r1,[r1]
	ldr r2,=11Fh
	add r0,r0,r2
	add r0,r0,r1
	ldrb r1,[r0]
	orr r1,r3
	strb r1,[r0]
	b 806E3BAh
	.halfword 0x0000
	
.org 0x806E3AC
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
.org 0x806E430	;Put a mushroom in item stock if touching a checkpoint flag while big and item stock empty
	bl FreeSpaceDMI
	
.org 0x806E5AA	;Fix a bug that causes Luigi to use Marios voice or vice versa when saying Bravo after collecting 5 Yoshi coins
	add r4,r1,r2
	ldrb r0,[r4]
	
.org 0x806E5BA
	ldrb r0,[r4]
	cmp r0,5h
	bne 806E5D6h
	ldr r0,=1C70h
	add r0,r9
	ldr r1,=0828h
	add r1,r9
	ldrh r0,[r0]
	strh r0,[r1]
	bl FreeSpaceFLB

.org 0x806E614
	.pool
	
.org 0x806E620	;Gives the Player 100p when collecting a coin
	ldr r4,=3002340h
	bl FreeSpaceGHP2
	ldr r1,=1C70h
	add r0,r4,r1
	bl FreeSpaceGHP3
	
.org 0x806E64C
	.pool
;;;;;;;

;Part 2 of Fix 0-time glitch (F0T)
.org 0x806E814	;(Player enters a pipe)
	bl FreeSpaceF0T3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of Yoshi Coins Cutscene (YCC)
.org 0x8070B08
	push r14
	ldr r3,=3002340h
	ldr r1,=1C58h
	add r0,r3,r1
	ldr r0,[r0]
	ldr r1,=11B1h
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,0h
	beq DownYCC3
	bl FreeSpaceYCC2
	and r1,r2
	cmp r1,0h
	bne DownYCC2
	ldr r0,[r3,20h]
	add r0,0D6h
	ldrb r1,[r0]
	cmp r1,44h
	beq DownYCC1
	add r1,1h
	strb r1,[r0]
DownYCC1:
	ldr r1,[r3,20h]
	add r2,r1,0
	add r2,0EBh
	ldrb r0,[r2]
	cmp r0,0h
	bne DownYCC2
	add r0,r1,0
	add r0,0D6h
	ldrb r0,[r0]
	cmp r0,44h
	bne DownYCC2
	mov r0,1h
	strb r0,[r2]
DownYCC2:
	bl FreeSpaceYCC2
	orr r1,r2
	strb r1,[r0]
DownYCC3:
	pop r0
	bx r0
	.pool
	.word 0x00000000
	.halfword 0x0000

CheckTriggerCutscene:
	add r0,1h
	cmp r0,1Dh
	bne ReturnYCC
	ldr r3,[r4,20h]
	add r3,0EBh
	ldrb r2,[r3]
	cmp r2,1h
	bne ReturnYCC
	add r2,1h
	strb r2,[r3]
	mov r0,45h
ReturnYCC:
	strb r0,[r1]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix Mario gets pushed inside the wall in roy boss fight (FRW)
.org 0x807163E
	ldr r0,=3007A48h
	ldr r4,=300302Ch

.org 0x8071648
	ldr r0,=0FFFFF314h
	
.org 0x807165E
	ldr r1,=0FD7h
	add r0,r4,r1
	ldrb r6,[r0]
	ldr r2,=0F81h

.org 0x8071670
	ldr r7,=0FA8h
	add r3,r4,r7
	ldr r1,=811A440h

.org 0x807168E
	ldr r1,=0F84h
	add r0,r4,r1
	ldr r2,=0FFFFFB3Ch

.org 0x807169A
	ldr r1,=828h

.org 0x80716A4
	ldr r1,=811A440h

.org 0x80716B2
	bne DownFRW4
	ldr r0,=3007A48h
	ldr r0,[r0]
	mov r2,0A5h
	lsl r2,r2,4h
	add r7,r0,r2
	ldrb r0,[r7,1Ah]
	cmp r0,29h
	bne DownFRW4
	mov r0,r7
	add r0,37h
	ldrb r3,[r0]
	add r3,1h
	ldr r5,=3002340h
	ldr r4,=1C90h
	add r0,r5,r4
	ldrh r1,[r0]
	mov r6,0h
	ldsh r0,[r0,r6]
	cmp r3,r0
	bgt DownFRW1
	mov r2,0h
	b DownFRW2
	.pool
DownFRW1:
	add r0,r5,r4
	ldrh r3,[r0]
	add r3,0Fh
	mov r0,r7
	add r0,21h
	ldrb r1,[r0]
	mov r2,1h
DownFRW2:
	lsl r0,r3,10h
	asr r0,r0,10h
	lsl r1,r1,10h
	asr r1,r1,10h
	sub r3,r1,r0
	cmp r3,1h
	ble DownFRW3
	sub r3,1h
	bl FreeSpaceFRW
DownFRW3:
	bl 8071918h
DownFRW4:
	b 8071804h
	.word 0x00000000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 3 of ChangeYoshiCoins (CYC)
.org 0x8072A50
	bl FreeSpaceCYC3
	
.org 0x8072B44
	.halfword 0x0000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix smoke of yoshis house becomes garbeled when pressing A or Start during the beginning of the intro (YHI)
.org 0x8074C40
	bl FreeSpaceYHI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Part 2 of Prevent 1ups from beeing omited when exiting a level earlier than expected (ELO)
.org 0x807C6E4
	bl FreeSpaceELO2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Fix Music when not riding yoshi in switch palaces and bonus rooms (FYM)
;Also contains parts of Save Prompt (SPR);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Also contains part of level default value table expansion (LDT);;;;;;;;
.org 0x809BF50
	beq SkipMethodFYM1

.org 0x809BF6A
	bne SkipMethodFYM1
	
.org 0x809BF72
	bne DownFYM1
	lsr r1,r1,1h
DownFYM1:
	mov r2,1h
	mov r0,r10
	ldr r0,[r0,20h]
	add r0,0E2h
	bl FreeSpaceFYM1
SkipMethodFYM1:
	pop r4,r5
	pop r0
	bx r0

.org 0x809BFD4
	blt SkipMethodFYM2

.org 0x809BFDE
	mov r0,0C0h
	lsl r0,r0,3h
	and r1,r0
	cmp r1,0h
	beq SkipMethodFYM2
	cmp r1,r0
	beq SkipMethodFYM2
	mov r2,0h
	cmp r4,0h
	bne DownFYM2
	mov r2,1h
DownFYM2:
	mov r0,13h
	bl FreeSpaceFYM2
SkipMethodFYM2:
	pop r4
	pop r0
	bx r0

.org 0x80D5CA8	;(LDT)
	.word FreeSpaceLDT

.org 0x80FE25C	;(SPR)
	.byte 0x58, 0x59, 0x5D, 0x77, 0x79, 0x7E, 0xC2, 0xC3
	
.org 0x8102F28	;(SPR)
	.byte 0x58, 0x59, 0x5D, 0x77, 0x79, 0x7E, 0xC2, 0xC3
	
.org 0x81088E8	;(DSL)
	.word FreeSpaceDSL+1
	
.org 0x810AC04
	.halfword 0x0000, 0x0000
	.halfword 0x0000, 0x0000
	.halfword 0x0000, 0x0000

.org 0x810AC1C
	.word FreeSpaceSSI1

.org 0x81B3F19
	.byte 0x05
	
.org 0x81B3F39
	.byte 0x04
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;