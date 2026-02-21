;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceLDT:
	.byte 0x28, 0x83, 0x03, 0x80, 0x4D, 0x01, 0x52, 0x01
	.byte 0x53, 0x01, 0x5B, 0x04, 0x5C, 0x02, 0x57, 0x08
	.byte 0x30, 0x01
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceSSI1:
	.halfword 0x000E, 0xFFF1
	.halfword 0x0010, 0xFFE0
	.halfword 0x001F, 0xFFF1
	.halfword 0x002F, 0xFFF1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceUVR:
	push r14
	ldr r1,=3002340h
	ldr r0,=886h
	add r1,r1,r0
	ldrb r0,[r1]
	sub r0,2Eh
	cmp r0,3h
	bhi NoVRAMUpdate
	bl 800204Ch
NoVRAMUpdate:
	pop r0
	bx r0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceMPM1:
	push r14
	cmp r6,6h
	bne NotInOverworld1
	mov r0,90h
	lsl r0,r0,1h
	add r5,r5,r0
NotInOverworld1:
	ldr r0,[r4]
	add r1,r5,0
	pop r2
	bx r2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceUFC:
	push r14
	bl 80014F4h
	ldr r0,=3002340h
	ldr r1,=0894h
	add r0,r0,r1
	ldrb r1,[r0]
	add r1,1h
	strb r1,[r0]
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceELO1:
	push r14
	ldr r1,=0886h
	add r0,r6,r1
	ldrb r1,[r0]
	cmp r1,24h
	beq NoLevelExit
	bl 8039418h
NoLevelExit:
	bl 8037A50h
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceRCS1:
	push r4,r5
	mov r3,r0
	mov r4,0BFh
	mov r5,0h
	b DownRCS
UpRCS:
	ldrb r0,[r1]
	cmp r5,6h
	bcc Unnecessary
	cmp r5,62h
	bhi Unnecessary
	and r0,r4
Unnecessary:
	strb r0,[r3]
	add r1,1h
	add r3,1h
	add r5,1h
DownRCS:
	cmp r5,r2
	bcc UpRCS
	pop r4,r5
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceCYC1:
	ldr r0,[r6,20h]
	add r0,0D6h
	ldrb r0,[r0]
	cmp r0,44h
	bne DownCYC1
	mov r0,1h
	strb r0,[r7,7h]
DownCYC1:
	ldr r0,[r6,20h]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceMPM2:
	push r14
	bl 800923Ch
	ldr r0,=0276h
	ldr r1,=0191h
	mov r2,6h
	mov r3,0h
	bl 800923Ch
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFCR:
	add r0,r1,r2
	ldrb r0,[r0]
	cmp r0,1Ch
	beq SetToFF
	cmp r0,29h
	beq SetToFF
	cmp r0,43h
	bne ReturnFCR
SetToFF:
	mov r0,0FFh
ReturnFCR:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceCYC2:
	push r14
	ldr r4,=3002340h
	mov r1,8Ah
	lsl r1,r1,4h
	add r0,r4,r1
	ldrb r0,[r0,7h]
	cmp r0,0h
	beq NoPeachCoinsCYC2
	bl MakePeachCoins
NoPeachCoinsCYC2:
	ldr r2,=0899h
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceCPG:
	push r14
	bl 800E8ECh
	cmp r5,38h
	bne NotACheckPoint
	ldr r0,=3002340h
	ldr r1,=086Ch
	add r0,r0,r1
	ldrh r2,[r0]
	sub r2,4h
	strh r2,[r0]
	sub r4,1h
	ldr r1,[r6]
	ldr r0,=1184h
	add r1,r1,r0
	ldr r1,[r1]
	add r1,r1,r4
	mov r0,30h
	strb r0,[r1]
	bl 800E8ECh
NotACheckPoint:
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceCEO:
	mov r1,r7
	ldr r2,=1C5Ch
	add r0,r1,r2
	ldr r0,[r0]
	ldrb r0,[r0,1Eh]
	cmp r0,5h
	beq CaveEnemys
	cmp r0,9h
	bne ReturnNoPriorityChange
	ldrb r0,[r5,2h]
	cmp r0,0CCh
	beq ChangePriority
ReturnNoPriorityChange:
	mov r0,0h
	b ReturnToEnemyRollOAM
	.pool
	
CaveEnemys:
	ldrb r0,[r5,2h]
	cmp r0,92h
	beq ChangePriority
	cmp r0,94h
	beq ChangePriority
	cmp r0,96h
	beq ChangePriority
	cmp r0,0C6h
	beq ChangePriority
	cmp r0,0C7h
	beq ChangePriority
	cmp r0,0C8h
	beq ChangePriority
	cmp r0,0D0h
	beq ChangePriority
	cmp r0,0D6h
	beq ChangePriority
	cmp r0,0E6h
	beq ChangePriority
	cmp r0,0E7h
	bne ReturnNoPriorityChange
ChangePriority:
	ldrb r1,[r3,5h]
	mov r0,0F3h
	and r1,r0
	mov r0,0Ch
	orr r1,r0
	strb r1,[r3,5h]
	mov r0,1h
ReturnToEnemyRollOAM:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceSRL:
	mov r2,0h
	cmp r3,5Eh
	beq SetLevelStar1
	cmp r3,13h
	bne ContinueLevelCheck1
SetLevelStar1:
	ldr r2,[r4,20h]
	add r2,5Eh
	ldrb r0,[r2]
	ldrb r1,[r5,1h]
	b ReturnWithChecks
ContinueLevelCheck1:
	cmp r3,52h
	beq SetLevelStar2
	cmp r3,1Eh
	bne ContinueLevelCheck2
SetLevelStar2:
	ldr r2,[r4,20h]
	add r2,5Ah
	ldrb r0,[r2]
	ldrb r1,[r5,2h]
	b ReturnWithChecks
ContinueLevelCheck2:
	cmp r3,55h
	beq SetLevelStar3
	cmp r3,60h
	bne ContinueLevelCheck3
SetLevelStar3:
	ldr r2,[r4,20h]
	add r2,5Ch
	ldrb r0,[r2]
	ldrb r1,[r5]
	b ReturnWithChecks
ContinueLevelCheck3:	
	cmp r3,58h
	beq SetLevelStar4
	cmp r3,35h
	bne ReturnWithChecks
SetLevelStar4:	
	ldr r2,[r4,20h]
	add r2,5Fh
	ldrb r0,[r2]
	ldrb r1,[r5,3h]
ReturnWithChecks:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceSPR3:
	ldr r0,=3002340h
	ldr r0,[r0,20h]
	ldr r1,=0111h
	mov r2,0EBh
	add r1,r0,r1
	add r2,r0,r2
	ldrb r1,[r1]
	ldrb r0,[r2]
	cmp r1,2h
	bne ReturnSPR3
	cmp r0,2h
	bne ReturnSPR3
	add r0,1h
	strb r0,[r2]
ReturnSPR3:
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceYCC1:
	ldr r1,[r7,20h]
	add r0,r1,0h
	add r0,0DCh
	ldrb r0,[r0]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceRCS2:
	mov r4,0BFh
	mov r3,6h
LoopRCS:
	add r1,r0,r3
	ldrb r2,[r1]
	and r2,r4
	strb r2,[r1]
	add r3,1h
	cmp r3,62h
	bls LoopRCS
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFLE:
	push r14
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=066Ah
	add r0,r0,r1
	mov r1,20h
	strb r1,[r0]
	ldr r1,=3002340h
	ldr r2,=0828h
	add r1,r1,r2
	mov r0,78h
	strh r0,[r1]
	mov r0,3Fh
	bl 809C1C4h
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceEUT:
	add r0,r0,r2
	ldr r1,[r1]
	add r4,r0,r1
	mov r0,8h
	strb r0,[r4,1Ch]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceDSL:
	add r3,r0,0h
	ldr r2,=3007A48h
	ldr r2,[r2]
	ldr r1,=0F27h
	add r0,r2,r1
	sub r1,52h
	add r2,r2,r1
	ldrb r0,[r0]
	ldrb r2,[r2]
	cmp r0,r2
	beq SpriteIsInYoshisMouth
	mov r1,0h
	strb r1,[r3,1Ch]
SpriteIsInYoshisMouth:	
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFBM:
	push r4,r14
	mov r4,r1
	bl 8030D90h
	mov r0,0h
	strh r0,[r4,3Ah]
	mov r1,r4
	add r1,5Eh
	strh r0,[r1]
	sub r1,2h
	strh r0,[r1]
	pop r4
	pop r0
	bx r0
	
FreeSpacePBF:
	push r14
	cmp r0,0h
	bne PBalloonPlayerGotHitOrPBalloonExpires
	ldr r0,=3002340h
	mov r2,0E3h
	lsl r2,r2,5h
	add r0,r0,r2
	ldrb r0,[r0]
	cmp r0,0h
	beq PBalloonPlayerNotHit
PBalloonPlayerGotHitOrPBalloonExpires:
	ldr r4,=3002340h
	ldr r0,=1CBAh
	add r1,r4,r0
	mov r0,0h
	strb r0,[r1]
	mov r0,r5
	bl 802F2F0h
	ldr r1,=1C58h
	add r4,r4,r1
	ldr r0,[r4]
	ldr r2,=116Ah
	add r1,r0,r2
	ldrb r1,[r1]
	mov r0,0h
	lsl r1,r1,18h
	asr r1,r1,18h
	cmp r1,0h
	bne PBalloonMoreThan100SecsLeft
	mov r0,1h
PBalloonMoreThan100SecsLeft:
	bl 809C024h
	b PBalloonReturn
	.pool
	
PBalloonPlayerNotHit:
	mov r6,0h
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0EE1h
	add r2,r0,r1
	ldrb r0,[r2]
	ldr r4,=3002340h
	ldr r1,=1CD1h
	add r3,r4,r1
	ldrb r1,[r3]
	orr r0,r1
	cmp r0,0h
	beq PBalloonNoSpinJump
	strb r6,[r2]
	strb r6,[r3]
PBalloonNoSpinJump:
	ldr r0,=1CB4h
	add r2,r4,r0
	ldrb r0,[r2]
	ldr r1,=1CCEh
	add r3,r4,r1
	ldrb r1,[r3]
	orr r0,r1
	cmp r0,0h
	beq PBalloonNoSlideOrGlide
	strb r6,[r2]
	strb r6,[r3]
PBalloonNoSlideOrGlide:
	ldr r0,=1CF5h
	add r1,r4,r0	
	strb r6,[r1]
	ldr r1,=1C61h
	add r0,r4,r1
	mov r2,24h
	strb r2,[r0]
	mov r0,r5
	bl CheckFreezeFlagController
	mov r0,r5
	bl 802BED0h
PBalloonReturn:
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceUYE:
	ldrb r1,[r0]
	ldr r0,[r2]
	add r4,3h
	add r0,r0,r4
	strb r1,[r0]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFIC2:
	ldrb r1,[r1]
	ldrb r0,[r0]
	orr r1,r0
FreeSpaceFIC1:
	ldr r6,=1C63h
	add r0,r3,r6
	ldrb r0,[r0]
	orr r1,r0
	add r6,51h
	add r0,r3,r6
	ldrb r0,[r0]
	orr r1,r0
	add r6,1Ah
	add r0,r3,r6
	ldrb r0,[r0]
	orr r1,r0
	add r6,3h
	add r0,r3,r6
	ldrb r0,[r0]
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceITA:
	ldrb r0,[r3,1Ah]
	sub r0,74h
	cmp r0,0Ch
	bls RealItem
	mov r0,8h
RealItem:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceASH:
	push r4,r14
	mov r4,r0
	bl 802F4C4h
	mov r2,r4
	ldrh r0,[r2,10h]
	ldrh r1,[r2,12h]
	orr r0,r1
	cmp r0,0h
	beq ReturnPositionAdjustment
	ldrb r0,[r2,1Ah]
	cmp r0,49h
	beq AdjustPosition
	cmp r0,4Ch
	beq AdjustPosition
	cmp r0,55h
	beq AdjustPosition
	cmp r0,57h
	beq AdjustPosition
	cmp r0,59h
	beq AdjustPosition
	cmp r0,5Ah
	beq AdjustPosition
	cmp r0,5Bh
	beq AdjustPosition
	cmp r0,5Ch
	beq AdjustPosition
	cmp r0,6Dh
	beq AdjustPosition
	cmp r0,83h
	beq AdjustPosition
	cmp r0,84h
	beq AdjustPosition
	cmp r0,8Fh
	beq AdjustPosition
	cmp r0,9Ch
	beq AdjustPosition
	cmp r0,0B1h
	beq AdjustPosition
	cmp r0,0B9h
	beq AdjustPosition
	cmp r0,0BAh
	beq AdjustPosition
	cmp r0,0BBh
	beq AdjustPosition
	cmp r0,0BEh
	beq AdjustPosition
	cmp r0,0C1h
	beq AdjustPosition
	cmp r0,0C4h
	beq AdjustPosition
	cmp r0,0C8h
	bne ReturnPositionAdjustment
AdjustPosition:
	ldrh r0,[r2,12h]
	sub r0,1h
	strh r0,[r2,12h]
	mov r0,12h
	ldsh r1,[r2,r0]
	lsl r1,r1,10h
	str r1,[r2,4h]
ReturnPositionAdjustment:
	pop r4
	pop r0
	bx r0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFGS1:
	push r14
	bl 805EBDCh
	add r0,r5,0h
	add r0,2Dh
	mov r2,0h
	strb r2,[r0]
	pop r0
	bx r0

FreeSpaceFGS2:
	push r14
	add r1,5Eh
	add r0,r2,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne	Invincible
	bl 8030A00h
Invincible:
	pop r0
	bx r0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceSCL:
	lsr r0,r1,18h
	sub r0,59h
	cmp r0,2h
	bls DownFCS1
	cmp r0,0A6h
	beq DownFCS1
	mov r0,0h
	lsr r1,r1,18h
	sub r1,11h
	cmp r1,5Ch
	bls DownFCS2
DownFCS1:
	mov r0,1h
DownFCS2:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceSSI2:
	mov r1,0h
	cmp r4,83h
	bne Check3TurnblockFlyingPlatform
	ldrb r0,[r5,1Bh]
	cmp r0,0h
	bne ReturnNoSpecialSprite
	cmp r7,1h
	bne ReturnNoSpecialSprite
	b SpecialSprite
Check3TurnblockFlyingPlatform:
	cmp r4,0C1h
	bne ReturnNoSpecialSprite
	ldr r0,=3002340h
	ldr r3,=1C5Ch
	add r0,r0,r3
	ldr r2,[r0]
	add r2,54h
	ldrb r0,[r2]
	cmp r0,0h
	beq ReturnNoSpecialSprite
	cmp r7,6h
	bne ReturnNoSpecialSprite
SpecialSprite:
	mov r1,1h
ReturnNoSpecialSprite:
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceMFIS:
	push r14
	bl 8035738h
	ldr r1,=3002B68h
	mov r0,0Ch
	bl 809C1C4h
	pop r0
	bx r0
	.pool

FreeSpacePII:
	add r2,r3,0h
	add r2,0E0h
	ldrb r1,[r2]
	cmp r1,3h
	bls ContinuePII1
	mov r1,0h
	strb r1,[r2]
ContinuePII1:
	orr r0,r1
	lsl r0,r0,18h
	lsr r7,r0,18h
	add r3,0E1h
	ldrb r0,[r3]
	cmp r0,4h
	bls ContinuePII2
	mov r0,0h
	strb r0,[r3]
ContinuePII2:
	ldr r1,=3002340h
	mov r0,0E3h
	lsl r0,r0,5h
	add r0,r0,r1
	ldrb r1,[r0]
	bx r14
	.pool

FreeSpacePMO:
	ldrb r0,[r3]
	cmp r2,r0
	beq ReturnPMO
	cmp r2,1h
	bne UpdateItemPMO
	cmp r0,2h
	beq ReturnPMO
	cmp r0,4h
	beq ReturnPMO
UpdateItemPMO:
	strb r2,[r3]
	mov r0,1h
	b ReturnPMOPlaySound
ReturnPMO:
	mov r0,0h
ReturnPMOPlaySound:
	bx r14

FreeSpaceJWN:
	ldr r0,=810AC68h
	add r0,r7,r0
	ldrb r1,[r0]
	cmp r1,1h
	beq Gotcha
	mov r0,6Eh
	b ReturnJWN
	.pool
Gotcha:
	mov r0,70h
ReturnJWN:
	add r1,r4,0h
	bx r14
	
FreeSpacePLO:
	mov r3,0h
	ldsh r0,[r1,r3]
	ldr r2,=03E6h
	cmp r0,r2
	ble DownPLO
	strh r2,[r1]
DownPLO:
	bx r14
	.pool

FreeSpacePNPO1:
	add r0,5h
	str r0,[r1,68h]
	ldr r0,[r1,68h]
	ldr r4,=0F423Fh
	cmp r0,r4
	ble DownPNPO1
	str r4,[r1,68h]
DownPNPO1:
	bx r14
	.pool
	
FreeSpaceCSC:
	push r14
	ldr r2,=3002340h
	ldr r1,=1C58h
	add r3,r2,r1
	ldr r0,[r3]
	ldr r1,=1190h
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne SkipCapeSpinCode
	ldr r0,[r3]
	ldr r1,=10FAh
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne ResetCapeSpin
	ldr r1,[r2,20h]
	add r1,0E0h
	ldrb r0,[r1]
	cmp r0,2h
	beq HandleCapeSpin
	ldr r1,=1CF4h
	add r0,r2,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne HandleCapeSpin
ResetCapeSpin:
	ldr r2,=3007A48h
	ldr r0,[r2]
	ldr r1,=0EE1h
	add r0,r0,r1
	mov r3,0h
	strb r3,[r0]
HandleCapeSpin:
	bl 803D5BCh
SkipCapeSpinCode:
	pop r0
	bx r0
	.pool
	
FreeSpaceDCM:
	push r14
	bl 809C004h
	lsl r0,r0,10h
	asr r0,r0,10h
	cmp r0,0Dh
	bne MusicIsNotAlreadyPlaying
	mov r0,8h
	bl 809BF40h
MusicIsNotAlreadyPlaying:
	pop r0
	bx r0
	
FreeSpacePSPO1:
	add r0,5h
	str r0,[r1]
	ldr r0,[r1]
	ldr r4,=01869Fh
	cmp r0,r4
	ble DownPSPO1
	str r4,[r1]
DownPSPO1:
	bx r14
	.pool
	
FreeSpaceDIC:
	add r1,21h
	ldrb r0,[r1]
	mov r3,20h
	orr r0,r3
	strb r0,[r1]
	bx r14
	
FreeSpacePNPO2:
	add r0,r1,r0
	str r0,[r3,68h]
	ldr r3,[r2,20h]
	ldr r0,[r3,68h]
	ldr r4,=0F423Fh
	cmp r0,r4
	ble DownPNPO2
	str r4,[r3,68h]
DownPNPO2:
	bx r14
	.pool
	
FreeSpacePSPO2:
	add r0,r1,r0
	str r0,[r2]
	ldr r2,[r3]
	ldr r0,[r2]
	ldr r1,=01869Fh
	cmp r0,r1
	ble DownPSPO2
	str r1,[r2]
DownPSPO2:
	bx r14
	.pool
	
FreeSpaceCDH:
	strh r0,[r5,2h]
	add r4,1h
	strb r4,[r5]
	bx r14
	
FreeSpaceFYS:
	ldrb r0,[r2,1Ah]
	cmp r0,0A5h
	bne NotSparky
	ldr r0,=3002340h
	ldr r1,=1C58h
	add r0,r0,r1
	ldr r0,[r0]
	ldr r1,=115Eh
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,2h
	beq NotSparky
	mov r0,r2
	add r0,42h
	ldrb r1,[r0]
	mov r3,1h
	orr r1,r3
	strb r1,[r0]
NotSparky:
	bx r14
	.pool
	
FreeSpaceHVL:
	ldrh r0,[r2]
	add r0,1h
	strh r0,[r2]
	ldrh r0,[r2]
	strb r0,[r3]
	bx r14
	
FreeSpaceFMY:
	ldrb r0,[r4,1Fh]
	cmp r0,2Dh
	beq YoshiEggHatch
	cmp r0,35h
	bne NoYoshiEgg
YoshiEggHatch:
	ldr r0,=3007A48h
	ldr r2,[r0]
	ldr r1,=686h
	add r0,r2,r1
	add r1,3h
	ldrb r0,[r0]
	cmp r0,0h
	bne YoshiInTheLevel
	add r0,r2,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne YoshiInTheLevel
	add r1,r2,r1
	mov r0,0FFh
	strb r0,[r1]
	b NoYoshiEgg
	.pool
	
YoshiInTheLevel:
	mov r0,78h
	strb r0,[r4,1Fh]
NoYoshiEgg:
	ldrb r0,[r4,1Fh]
	strb r0,[r4,1Ah]
	bx r14
	
FreeSpaceDCBF:
	ldrb r0,[r2,5h]
	mov r1,3h
	and r0,r1
	mov r1,8h
	orr r0,r1
	strb r0,[r2,5h]
	ldrb r0,[r2,3h]
	mov r1,0CFh
	and r0,r1
	mov r1,40h
	orr r0,r1
	strb r0,[r2,3h]
	bx r14
	
FreeSpaceDCF:
	push r14
	bl 8054148h
	ldr r0,=3002340h
	ldr r2,=1D0Eh
	add r0,r0,r2
	mov r1,0h
	strb r1,[r0]
	pop r0
	bx r0
	.pool
	
FreeSpaceFSD:
	add r0,r2,r1
	ldr r0,[r0]
	ldr r1,=1190h
	add r0,r0,r1
	ldrb r0,[r0]
	bx r14
	.pool
	
FreeSpaceFSB:
	sub r4,4h
	add r0,r2,r4
	ldr r1,[r3]
	add r7,33h
	add r1,r1,r7
	ldrb r1,[r1]
	lsl r1,r1,18h
	asr r1,r1,18h
	ldrh r3,[r0]
	add r1,r1,r3
	strh r1,[r0]
	bx r14
	
FreeSpaceSLS:
	push r4,r14
	mov r4,r0
	bl 802F9F0h
	mov r0,r4
	add r0,24h
	ldrb r0,[r0]
SwitchNotHit:	
	pop r4
	pop r1
	bx r1
	
FreeSpaceUYD:
	add r0,1h
	ldr r1,=0686h
	add r2,r2,r1
	strb r0,[r2]
	mov r0,0h
	strb r0,[r5,1Bh]
	ldrb r0,[r5,1Ch]
	cmp r0,5h
	bne NotDiedInLava
	mov r1,r5
	add r1,24h
	ldrb r0,[r1]
	cmp r0,1h
	bhi NotDiedInLava
	add r1,13h
	mov r0,0FFh
	strb r0,[r1]
NotDiedInLava:
	bx r14
	.pool
	
FreeSpaceGHP1:
	push r14
	lsl r0,r0,10h
	asr r0,r0,10h
	bl 803BBA0h
	ldr r0,[r6]
	ldr r2,=06A3h
	add r0,r0,r2
	ldrb r1,[r0]
	cmp r1,0h
	beq EnemyEaten
	cmp r1,3h
	beq NoPoints
	mov r1,5h
	b GivePointsEaten
	.pool
EnemyEaten:
	mov r1,6h
GivePointsEaten:
	add r0,r5,0h
	bl 803E340h
NoPoints:
	pop r0
	bx r0
	
FreeSpacePIA:
	cmp r0,1h
	bls BadYoshiShell
	sub r0,2h
	cmp r0,3h
	bls GoodYoshiShell
BadYoshiShell:
	mov r0,3h
GoodYoshiShell:
	add r0,r0,r3
	bx r14
	
FreeSpaceSNS:
	push r14
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r2,=067Ah
	add r1,r0,r2
	ldrb r0,[r1]
	cmp r0,0h
	beq NoSpriteInMouth
	mov r2,r12
	add r2,37h
	ldrb r0,[r2]
	cmp r0,0FFh
	bne ReturnNoSwallow2
	mov r0,0h
	strb r0,[r1]
	mov r2,r12
	ldrb r0,[r2,1Ch]
	cmp r0,8h
	bne ReturnNoSwallow1
	mov r0,r12
	bl 805DA7Ch
	mov r0,r12
	bl 805CEA4h
	mov r0,r12
	bl 805D518h
ReturnNoSwallow1:
	pop r0
	add r0,0E2h
	bx r0
	.pool
	
NoSpriteInMouth:
	mov r2,r12
	add r2,37h
	mov r0,0FFh
	strb r0,[r2]
ReturnNoSwallow2:
	ldr r2,=1C58h
	add r0,r6,r2
	ldr r0,[r0]
	ldr r1,=1190h
	add r0,r0,r1
	ldrb r0,[r0]
	pop r1
	bx r1
	.pool
	
FreeSpaceF0T1:
	mov r2,0E3h
	lsl r2,r2,5h
	add r2,r1,r2
	ldrb r3,[r2]
	cmp r3,9h
	beq PlayerDied
	strb r0,[r2]
PlayerDied:
	ldrb r0,[r2]
	bx r14
	
FreeSpaceRAP:
	push r14
	ldrb r1,[r0,18h]
	cmp r1,2h
	bne DownOtherPoints
	bl 803B2F4h
	b ReturnRAP
DownOtherPoints:
	bl 803B348h
ReturnRAP:
	pop r0
	bx r0
	
FreeSpaceFYA:
	ldrb r2,[r1,1Bh]
	cmp r2,1h
	bne YoshiNotMounted
	add r1,36h
	strb r0,[r1]
YoshiNotMounted:
	bx r14
	
FreeSpaceSYF:
	ldr r0,=1CB5h
	add r1,r3,r0
	ldrb r1,[r1]
	cmp r1,0h
	beq YoshiIsSliding
	sub r0,1h
	add r0,r3,r0
	ldrb r0,[r0]
	lsl r0,r0,18h
	asr r0,r0,18h
	cmp r0,0h
	bne YoshiIsSliding
	mov r0,1h
	b ReturnYoshiSlope
	.pool
YoshiIsSliding:
	mov r0,0h
ReturnYoshiSlope:
	bx r14
	
FreeSpaceYSP:
	ldrb r0,[r5,1Fh]
	cmp r0,0h
	bne PlayerIsOnTheSameSkull
	ldrh r0,[r5,12h]
	sub r0,1Ch
	b ReturnYoshiOnSkull
PlayerIsOnTheSameSkull:
	ldrh r0,[r5,12h]
	sub r0,1Bh
ReturnYoshiOnSkull:
	bx r14

FreeSpaceYLC:
	ldr r0,=3007A48h
	ldr r0,[r0]
	ldr r1,=0F31h
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne NoLakituCloud
	ldrb r0,[r5,1Bh]
	cmp r0,0h
	bne NoLakituCloud
	str r0,[r5,0Ch]
	ldr r0,[r4,8h]
	str r0,[r5,8h]
	ldrh r0,[r4,10h]
	strh r0,[r5,10h]
	ldrh r0,[r5,12h]
	sub r0,10h
	strh r0,[r4,12h]
NoLakituCloud:
	bx r14
	.pool
	
FreeSpaceYLP:
	mov r3,18h
	mov r1,r6
	add r1,36h
	ldrb r1,[r1]
	cmp r1,0h
	beq NotCheckered
	mov r3,28h
NotCheckered:
	sub r0,r0,r3
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFRG:
	ldrb r0,[r0]
	mov r1,4h
	and r0,r1
	cmp r0,0h
	beq RopeNoGround
	mov r1,0h
	mov r0,r4
	add r0,28h
	strb r1,[r0]
	ldr r2,=1D0Fh
	add r0,r5,r2
	strb r1,[r0]
RopeNoGround:
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFDA:
	push r14
	bl 80632A0h
	ldrb r0,[r4,1Ch]
	cmp r0,8h
	beq NoFuzzyDeath
	ldrb r0,[r4,1Ah]
	cmp r0,68h
	bne NoFuzzyDeath
	mov r0,0A5h
	strb r0,[r4,1Ah]
NoFuzzyDeath:
	pop r0
	bx r0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFMS:
	ldr r0,=811676Ah
	add r0,r2,r0
	ldrb r0,[r0]
	cmp r0,2h
	bne MushroomRises
	ldrh r0,[r4,12h]
	mov r1,0Fh
	and r0,r1
	cmp r0,0h
	beq ChangeStemTile
NoStemTileChange:
	mov r0,0h
	b ReturnNoTileChange
	.pool
MushroomRises:
	ldr r0,[r4,4h]
	mov r1,80h
	lsl r1,r1,8h
	add r0,r0,r1
	lsl r0,r0,0Ch
	cmp r0,0h
	bne NoStemTileChange
ChangeStemTile:
	mov r0,1h
ReturnNoTileChange:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFIH:
	and r0,r2
	cmp r0,0Ch
	bne NotIggyOne
	add r3,1Eh
	b UpdateHair
NotIggyOne:
	cmp r0,2Ch
	bne NotIggyTwo
	sub r3,1h
UpdateHair:
	strh r3,[r4,4h]
NotIggyTwo:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceGIM:
	add r0,0E1h
	ldrb r0,[r0]
	cmp r5,0h
	bne CheckBigMario
	cmp r0,3h
	bne Make1Up
	b ReturnToGoalFct
CheckBigMario:
	cmp r5,1h
	bne ReturnToGoalFct
	cmp r0,2h
	beq Make1Up
	cmp r0,4h
	bne ReturnToGoalFct
Make1Up:
	mov r0,r5
ReturnToGoalFct:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFWC:
	push r14
	ldr r2,=3002340h
	ldr r1,[r2,20h]
	add r1,0E0h
	ldrb r0,[r1]
	cmp r0,2h
	bne ResetCape
	ldr r1,=1C58h
	add r0,r2,r1
	ldr r0,[r0]
	ldr r3,=10FAh
	add r0,r0,r3
	ldrb r0,[r0]
	cmp r0,0h
	beq HandleCape
ResetCape:
	ldr r1,=1CB4h
	add r3,r2,r1
	ldrb r0,[r3]
	mov r1,80h
	and r0,r1
	ldr r1,=1CCEh
	add r2,r2,r1
	ldrb r1,[r2]
	orr r0,r1
	cmp r0,0h
	beq HandleCape
	mov r0,0h
	strb r0,[r2]
	ldrb r0,[r3]
	mov r1,7Fh
	and r0,r1
	strb r0,[r3]
HandleCape:
	bl 806FC54h
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFTL:
	ldr r0,=80F9EF8h
	add r3,r0,r1
	ldr r1,[r3]
	add r1,3h
	ldrb r0,[r1]
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceGYC:
	ldr r0,[r4,20h]
	add r0,0E2h
	ldrb r1,[r0]
	cmp r1,0h
	bne ReturnGYC
	ldr r2,[r3]
	ldr r1,=0689h
	add r0,r2,r1
	ldrb r1,[r0]
	cmp r1,0h
	beq ReturnGYC
	sub r1,1h
	mov r0,64h
	mul r0,r1
	ldr r1,=06CCh
	add r0,r0,r1
	add r0,r0,r2
	ldrb r1,[r0,1Ah]
	cmp r1,35h
	bne ReturnGYC
	add r0,35h
	ldrb r1,[r0]
	ldr r0,[r4,20h]
	add r0,0E2h
	strb r1,[r0,1h]
	mov r2,1h
	strb r2,[r0]
ReturnGYC:
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceDMI:
	add r1,0E0h
	ldrb r0,[r1]
	cmp r0,3h
	bls GoodPlayerStatus
	mov r0,0h
	strb r0,[r1]
GoodPlayerStatus:
	ldrb r0,[r1,1h]
	cmp r0,4h
	bls GoodItemInStock
	mov r0,0h
	strb r0,[r1,1h]
GoodItemInStock:
	ldrb r0,[r1]
	cmp r0,0h
	beq ReturnDMI
	add r1,1h
	ldrb r0,[r1]
	cmp r0,3h
	bne ReturnDMI
	mov r0,0h
ReturnDMI:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFLB:
	mov r2,r9
	ldr r0,[r2,20h]
	add r0,0DCh
	ldrb r0,[r0]
	ldr r2,=082Ch
	add r2,r9
	strh r0,[r2]
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceGHP2:
	push r14
	ldr r5,=1C90h
	add r5,r4,r5
	ldrh r0,[r5]
	mov r8,r0
	ldr r6,=1C94h
	add r6,r4,r6
	ldrh r0,[r6]
	mov r9,r0
	ldr r1,=1C58h
	add r1,r4,r1
	ldr r1,[r1]
	ldrh r0,[r1,30h]
	strh r0,[r5]
	ldrh r0,[r1,2Ch]
	strh r0,[r6]
	mov r0,5h
	bl 806E6A0h
	mov r0,r8
	strh r0,[r5]
	mov r0,r9
	strh r0,[r6]
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceMPM3:
	push r14
	ldr r3,=1D18h
	add r1,r5,r3
	ldrb r1,[r1]
	cmp r1,6h
	bne NotInOverworld2
	mov r2,90h
	lsl r2,r2,1h
	add r0,r0,r2
NotInOverworld2:
	add r1,r4,0
	mov r2,14h
	pop r3
	bx r3
	.pool
	
FreeSpaceMPM4:
	push r14
	mov r1,0Fh
	and r0,r1
	ldr r3,=3002340h
	ldr r2,=1D18h
	add r2,r3,r2
	ldrb r2,[r2]
	cmp r2,6h
	bne NotInOverworld3
	mov r1,90h
	orr r0,r1
NotInOverworld3:
	pop r2
	bx r2
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceF0T2:
	mov r1,40h
	and r0,r1
	cmp r0,0h
	beq PlayerNotDied1
	mov r1,0E3h
	lsl r1,r1,5h
	add r2,r4,r1
	ldrb r2,[r2]
	cmp r2,9h
	bne PlayerNotDied1
	mov r0,0h
PlayerNotDied1:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFBB:
	mov r3,0h
	ldsh r1,[r0,r3]
	mov r3,0A8h
	ldr r0,[r4,20h]
	add r0,0E0h
	ldrb r0,[r0]
	cmp r0,0h
	beq PlayerIsSmall
	ldr r0,=1C62h
	add r0,r4,r0
	ldrb r0,[r0]
	cmp r0,0h
	beq PlayerIsBig
PlayerIsSmall:
	mov r3,98h
PlayerIsBig:
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceH1RS:
	push r14
	add sp,4h
	ldr r0,[r4,20h]
	ldr r2,=010Fh
	add r1,r0,r2
	ldrb r0,[r1]
	add r0,1h
	strb r0,[r1]
	mov r0,r13
	bl 806E700h
	add sp,-4h
	pop r1
	bx r1
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceF0T3:
	lsl r0,r0,18h
	lsr r1,r0,18h
	cmp r1,0h
	beq PlayerNotDied2
	mov r0,0E3h
	lsl r0,r0,5h
	add r0,r4,r0
	ldrb r0,[r0]
	cmp r0,9h
	bne PlayerNotDied2
	mov r1,0h
PlayerNotDied2:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceYCC2:
	ldr r0,[r3,20h]
	add r1,r0,0
	add r1,0A0h
	ldrh r1,[r1]
	add r0,6h
	add r0,r0,r1
	ldrb r1,[r0]
	mov r2,20h
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFVM:
	mov r4,r0
	ldr r1,=1C61h
	add r0,r2,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne PlayerInTheAir
	ldr r3,=3007A48h
	ldr r0,[r3]
	ldr r1,=06BAh
	add r0,r0,r1
	ldrh r0,[r0]
	cmp r0,0h
	beq ScrollingNotUsed
	ldr r0,[r3]
	sub r1,1h
	add r0,r0,r1
	ldrb r0,[r0]
	cmp r0,0h
	bne PlayerInTheAir
	ldr r0,[r3]
	add r1,1h
	add r0,r0,r1
	mov r1,0h
	strh r1,[r0]
ScrollingNotUsed:
	ldr r1,=1C74h
	add r0,r2,r1
	ldrh r0,[r0]
	cmp r0,56h
	bhi StopScrolling
	cmp r4,28h
	beq StopScrolling
	add r1,70h
	add r0,r2,r1
	ldrb r1,[r0]
	mov r4,0FDh
	and r1,r4
	strb r1,[r0]
	ldr r0,[r3]
	mov r1,0D7h
	lsl r1,r1,3h
	add r0,r0,r1
	mov r1,1h
	strb r1,[r0]
	mov r4,0FEh
	b SetScrolling
	.pool
StopScrolling:
	mov r4,0h
SetScrolling:
	ldr r0,[r3]
	ldr r1,=06B9h
	add r0,r0,r1
	strb r4,[r0]
PlayerInTheAir:
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFRW:
	add r5,r5,r4
	ldrh r4,[r5]
	cmp r2,0h
	beq RightWall
	add r4,r4,r3
	b FixPos
RightWall:
	sub r4,r4,r3
FixPos:
	strh r4,[r5]
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
FreeSpaceCYC3:
	push r14
	ldrb r0,[r4,7h]
	cmp r0,0h
	beq NoPeachCoinsCYC3
	bl MakePeachCoins
NoPeachCoinsCYC3:
	ldr r4,=3002340h
	ldr r0,=0886h
	pop r1
	bx r1
	.pool
	
MakePeachCoins:
	push r4-r7,r14
	ldr r4,=82002F4h
	ldr r1,=6000100h
	add r0,r4,0h
	mov r2,10h
	bl 809EBB4h
	mov r0,40h
	add r0,r0,r4
	mov r7,r0
	ldr r1,=6000300h
	mov r2,10h
	bl 809EBB4h
	add r6,r4,0h
	add r6,80h
	ldr r1,=6000500h
	add r0,r6,0h
	mov r2,10h
	bl 809EBB4h
	add r5,r4,0h
	add r5,0C0h
	ldr r1,=6000700h
	add r0,r5,0h
	mov r2,10h
	bl 809EBB4h
	ldr r1,=6014040h
	add r0,r4,0h
	mov r2,10h
	bl 809EBB4h
	ldr r1,=6014440h
	mov r0,r7
	mov r2,10h
	bl 809EBB4h
	ldr r1,=6014840h
	add r0,r6,0h
	mov r2,10h
	bl 809EBB4h
	ldr r1,=6014C40h
	add r0,r5,0h
	mov r2,10h
	bl 809EBB4h
	pop r4-r7
	pop r0
	bx r0
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceYHI:
	ldr r1,[r4]
	ldrb r0,[r1,14h]
	add r1,54h
	ldrb r1,[r1]
	cmp r1,0h
	beq NoButtonPressedDuringIntro
	mov r0,0h
NoButtonPressedDuringIntro:
	bx r14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceELO2:
	push r14
	bl 8039418h
	bl 800A4F0h
	bl 807C610h
	pop r0
	bx r0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFYM1:
	push r14
	ldrb r3,[r0]
	cmp r3,0h
	bne DownFYM3
	mov r3,10h
	orr r1,r3
DownFYM3:
	mov r0,13h
	bl 809E57Ch
	pop r0
	bx r0
	
FreeSpaceFYM2:
	push r14
	lsr r1,r1,3h
	cmp r1,40h
	beq DownFYM4
	lsr r1,r1,3h
DownFYM4:
	bl 809E57Ch
	pop r0
	bx r0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;