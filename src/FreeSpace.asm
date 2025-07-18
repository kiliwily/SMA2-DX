;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceLDT:
	.byte 0x28, 0x83, 0x03, 0x80, 0x4D, 0x01, 0x52, 0x01
	.byte 0x53, 0x01, 0x5B, 0x04, 0x5C, 0x02, 0x57, 0x08
	.byte 0x30, 0x01
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceMPM1:
	push r14
	bl CheckMarioOverworld
	cmp r0,0h
	beq NotInOverworld1
	mov r0,90h
	lsl r0,r0,1h
	add r5,r5,r0
NotInOverworld1:
	ldr r0,[r4]
	add r1,r5,0
	pop r2
	bx r2
	
CheckMarioOverworld:
	ldr r2,=3002340h
	ldr r1,=0886h
	add r0,r2,r1
	ldrb r1,[r0]
	mov r0,0h
	cmp r1,1Ch
	bcc ReturnNotOverworld
	cmp r1,1Fh
	bcc ReturnOverworld
	cmp r1,3Eh
	beq ReturnOverworld
	cmp r1,3Fh
	beq ReturnOverworld
	cmp r1,43h
	beq ReturnOverworld
	cmp r1,44h
	beq ReturnOverworld
	cmp r1,1Fh
	bne ReturnNotOverworld
	ldr r0,=1C58h
	add r1,r2,r0
	ldr r0,[r1]
	ldr r1,=114Bh
	add r2,r0,r1
	ldrb r1,[r2]
	mov r0,0h
	cmp r1,0h
	bne ReturnNotOverworld
	add r2,3h
	ldrb r1,[r2]
	cmp r1,0h
	bne ReturnNotOverworld
ReturnOverworld:
	mov r0,1h
ReturnNotOverworld:	
	bx r14
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
FreeSpaceCPP:
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
	ldr r1,=3007A48h
	ldr r2,[r1]
	ldr r1,=0F27h
	add r0,r2,r1
	ldrb r0,[r0]
	cmp r0,0FFh
	bne SpriteIsInYoshisMouth
	mov r0,0h
	strb r0,[r3,1Ch]
	add r3,39h
	mov r0,0FFh
	strb r0,[r3]
SpriteIsInYoshisMouth:	
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFBM:
	push r4,r14
	mov r1,r4
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
	
FreeSpaceSOB:
	ldrb r0,[r4,1Ch]
	cmp r0,0Ch
	bls NotOutOfBounds
	mov r0,0h
	strb r0,[r4,1Ch]
NotOutOfBounds:
	bx r14
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
FreeSpaceBHS:
	ldr r3,=1C94h
	add r1,r2,r3
	ldrh r1,[r1]
	ldr r3,=1C7Ch
	add r0,r2,r3
	ldrh r0,[r0]
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
	ldrb r1,[r2,1h]
	cmp r1,4h
	bls ContinuePII1
	mov r1,0h
	strb r1,[r2,1h]
ContinuePII1:
	ldrb r1,[r2]
	cmp r1,3h
	bls ContinuePII2
	mov r1,0h
	strb r1,[r2]
ContinuePII2:
	orr r0,r1
	lsl r0,r0,18h
	lsr r7,r0,18h
	ldr r1,=3002340h
	mov r0,0E3h
	lsl r0,r0,5h
	add r0,r0,r1
	ldrb r1,[r0]
	bx r14
	.pool

FreeSpacePMO:
	ldrb r2,[r2]
	add r1,r3,0h
	add r1,0E1h
	ldrb r0,[r1]
	cmp r2,r0
	beq ReturnPMO
	cmp r2,1h
	bne UpdateItemPMO
	cmp r0,2h
	beq ReturnPMO
	cmp r0,4h
	beq ReturnPMO
UpdateItemPMO:
	strb r2,[r1]
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
Gotcha:
	mov r0,70h
ReturnJWN:
	add r1,r4,0h
	bx r14
	.pool
	
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
	
FreeSpaceFRB:
	ldrh r0,[r0]
	mov r1,0h
	cmp r0,1Eh
	beq TurnBlockDestroyed
	mov r1,0FFh
TurnBlockDestroyed:
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
	
FreeSpaceDCF:
	add r2,r2,r0
	ldrh r0,[r2,4h]
	mov r1,0FCh
	lsl r1,r1,8h
	and r0,r1
	mov r1,1Eh
	orr r0,r1
	strh r0,[r2,4h]
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
	add r1,r1,r7
	ldrb r1,[r1]
	lsl r1,r1,18h
	asr r1,r1,18h
	ldrh r3,[r0]
	add r1,r1,r3
	strh r1,[r0]
	bx r14
	
FreeSpaceGHP1:
	push r14
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
	beq ResetSprite
	pop r0
	b ReturnSNS
	.pool
	
NoSpriteInMouth:
	mov r2,r12
	add r2,37h
	mov r0,0FFh
	strb r0,[r2]
	pop r0
	b ReturnSNS
	
ResetSprite:
	mov r0,0h
	strb r0,[r1]
	mov r0,r12
	bl 805DA7Ch
	mov r0,r12
	bl 805CEA4h
	mov r0,r12
	bl 805D518h
	pop r0
	add r0,0E4h
ReturnSNS:
	bx r0

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
	
FreeSpaceYLC:
	ldrh r0,[r5,12h]
	sub r0,20h
	cmp r6,87h
	bne StoreYposYoshi
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
YoshiRunCloud:
	ldrh r0,[r5,12h]
	sub r0,10h
StoreYposYoshi:
	strh r0,[r4,12h]
NoLakituCloud:
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
	ldr r3,=1CCEh
	add r0,r2,r3
	mov r1,0h
	strb r1,[r0]
	sub r3,1Ah
	add r0,r2,r3
	ldrb r1,[r0]
	mov r3,7Fh
	and r1,r3
	strb r1,[r0]
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

FreeSpaceGHP3:
	push r14
	mov r2,0h
	ldsh r0,[r0,r2]
	bl 803BBA0h
	pop r0
	bx r0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceMPM3:
	push r14
	add r3,r0,0
	bl CheckMarioOverworld
	cmp r0,0h
	beq NotInOverworld2
	mov r0,90h
	lsl r0,r0,1h
	add r3,r3,r0
NotInOverworld2:
	add r0,r3,0
	add r1,r4,0
	mov r2,14h
	pop r3
	bx r3
	
FreeSpaceMPM4:
	push r14
	bl CheckMarioOverworld
	add r2,r0,0h
	ldrb r0,[r4,5h]
	mov r1,0Fh
	cmp r2,0h
	beq NotInOverworld3
	mov r1,90h
	orr r0,r1
	mov r1,9Fh
NotInOverworld3:
	pop r2
	bx r2
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
FreeSpaceCSI:
	ldr r0,[r4]
	ldr r3,=0EDBh
	add r0,r0,r3
	ldrb r0,[r0]
	cmp r0,0h
	bne NotSliding
	mov r0,80h
	strb r0,[r1]
NotSliding:
	bx r14
	.pool
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FreeSpaceFMB:
	ldr r0,=3002340h
	ldr r2,=1C58h
	add r0,r0,r2
	ldr r0,[r0]
	ldr r2,=1190h
	add r0,r0,r2
	ldrb r0,[r0]
	cmp r0,0h
	beq NoFreezeChecked
	mov r1,0h
NoFreezeChecked:
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
	push r14
	push r4-r7
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