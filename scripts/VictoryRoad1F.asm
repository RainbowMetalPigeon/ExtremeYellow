VictoryRoad1F_Script:
	RPTextChooser VictoryRoad1F_TextPointers, VictoryRoad1F_TextPointers_Rocket
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, .next
	call EnableAutoTextBoxDrawing
	ld hl, VictoryRoad1TrainerHeaders
	ld de, VictoryRoad1F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret
.next
	CheckEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	ret z
	ld a, $1d
	ld [wNewTileBlockID], a
	lb bc, 6, 4
	predef_jump ReplaceTileBlock

VictoryRoad1F_ScriptPointers:
	dw VictoryRoad1Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

VictoryRoad1Script0:
	CheckEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	jp nz, CheckFightingMapTrainers
	ld hl, CoordsData_5da5c
	call CheckBoulderCoords
	jp nc, CheckFightingMapTrainers
	ldh a, [hSpriteIndex]
	cp $f
	jp z, CheckFightingMapTrainers
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	SetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	ret

CoordsData_5da5c:
	dbmapcoord 17, 13
	db -1 ; end

VictoryRoad1F_TextPointers:
	dw VictoryRoad1Text1 ; Manga Green
	dw VictoryRoad1Text2 ; Manga Red
	dw VictoryRoad1Text3 ; Manga Yellow
	dw VictoryRoad1Text4 ; Manga Blue
	dw PickUpItemText
	dw PickUpItemText
	dw BoulderText
	dw BoulderText
	dw BoulderText

VictoryRoad1F_TextPointers_Rocket:
	dw VictoryRoad1Text1 ; Manga Green TBE
	dw VictoryRoad1Text2 ; Manga Red TBE
	dw VictoryRoad1Text3 ; Manga Yellow TBE
	dw VictoryRoad1Text4 ; Manga Blue TBE
	dw PickUpItemText
	dw PickUpItemText
	dw BoulderText
	dw BoulderText
	dw BoulderText

VictoryRoad1TrainerHeaders:
	def_trainers
VictoryRoad1TrainerHeader0: ; pseudo-GREEN
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_0, 2, VictoryRoad1BattleText1, VictoryRoad1EndBattleText1, VictoryRoad1AfterBattleText1
VictoryRoad1TrainerHeader1: ; pseudo-RED
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_1, 4, VictoryRoad1BattleText2, VictoryRoad1EndBattleText2, VictoryRoad1AfterBattleText2
VictoryRoad1TrainerHeader2: ; pseudo-YELLOW
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_2, 1, VictoryRoad1BattleText3, VictoryRoad1EndBattleText3, VictoryRoad1AfterBattleText3
VictoryRoad1TrainerHeader3: ; pseudo-BLUE
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_3, 1, VictoryRoad1BattleText4, VictoryRoad1EndBattleText4, VictoryRoad1AfterBattleText4
	db -1 ; end

; -------------------------------

VictoryRoad1Text1:
	text_asm
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld hl, VictoryRoad1TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

; ---

VictoryRoad1BattleText1:
	text_asm
	ld hl, VictoryRoad1BattleText1_HP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printAndEnd
; RP, check if it's our alter ego
	ld a, [wPlayerGender] ; 0=Red, 1=Green, 2=Yellow
	cp 1
	ld hl, VictoryRoad1BattleText_RP_YesUs
	jr z, .printAndEnd
	ld hl, VictoryRoad1BattleText_RP_NotUs
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1BattleText1_HP:
	text_far _VictoryRoad1BattleText1_HP
	text_end

VictoryRoad1BattleText_RP_YesUs:
	text_far _VictoryRoad1BattleText_RP_YesUs
	text_end

VictoryRoad1BattleText_RP_NotUs:
	text_far _VictoryRoad1BattleText_RP_NotUs
	text_end

; ---

VictoryRoad1EndBattleText1:
	text_asm
	ld hl, VictoryRoad1EndBattleText1_HP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printAndEnd
; RP, check if it's our alter ego
	ld a, [wPlayerGender] ; 0=Red, 1=Green, 2=Yellow
	cp 1
	ld hl, VictoryRoad1EndBattleText_RP_YesUs
	jr z, .printAndEnd
	ld hl, VictoryRoad1EndBattleText_RP_NotUs
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1EndBattleText1_HP:
	text_far _VictoryRoad1EndBattleText1_HP
	text_end

VictoryRoad1EndBattleText_RP_YesUs:
	text_far _VictoryRoad1EndBattleText_RP_YesUs
	text_end

VictoryRoad1EndBattleText_RP_NotUs:
	text_far _VictoryRoad1EndBattleText_RP_NotUs
	text_end

; ---

VictoryRoad1AfterBattleText1:
	text_asm
	ld hl, VictoryRoad1AfterBattleText1_HP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printAndEnd
; RP, check if it's our alter ego
	ld a, [wPlayerGender] ; 0=Red, 1=Green, 2=Yellow
	cp 1
	ld hl, VictoryRoad1AfterBattleText_RP_YesUs
	jr z, .printAndEnd
	ld hl, VictoryRoad1AfterBattleText_RP_NotUs
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1AfterBattleText1_HP:
	text_far _VictoryRoad1AfterBattleText1_HP
	text_end

VictoryRoad1AfterBattleText_RP_YesUs:
	text_far _VictoryRoad1AfterBattleText_RP_YesUs
	text_end

VictoryRoad1AfterBattleText_RP_NotUs:
	text_far _VictoryRoad1AfterBattleText_RP_NotUs
	text_end

; -------------------------------

VictoryRoad1Text2:
	text_asm
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld hl, VictoryRoad1TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

; ---

VictoryRoad1BattleText2:
	text_asm
	ld hl, VictoryRoad1BattleText2_HP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printAndEnd
; RP, check if it's our alter ego
	ld a, [wPlayerGender] ; 0=Red, 1=Green, 2=Yellow
	cp 0
	ld hl, VictoryRoad1BattleText_RP_YesUs
	jr z, .printAndEnd
	ld hl, VictoryRoad1BattleText_RP_NotUs
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1BattleText2_HP:
	text_far _VictoryRoad1BattleText2_HP
	text_end

; ---

VictoryRoad1EndBattleText2:
	text_asm
	ld hl, VictoryRoad1EndBattleText2_HP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printAndEnd
; RP, check if it's our alter ego
	ld a, [wPlayerGender] ; 0=Red, 1=Green, 2=Yellow
	cp 0
	ld hl, VictoryRoad1EndBattleText_RP_YesUs
	jr z, .printAndEnd
	ld hl, VictoryRoad1EndBattleText_RP_NotUs
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1EndBattleText2_HP:
	text_far _VictoryRoad1EndBattleText2_HP
	text_end

; ---

VictoryRoad1AfterBattleText2:
	text_asm
	ld hl, VictoryRoad1AfterBattleText2_HP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printAndEnd
; RP, check if it's our alter ego
	ld a, [wPlayerGender] ; 0=Red, 1=Green, 2=Yellow
	cp 0
	ld hl, VictoryRoad1AfterBattleText_RP_YesUs
	jr z, .printAndEnd
	ld hl, VictoryRoad1AfterBattleText_RP_NotUs
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1AfterBattleText2_HP:
	text_far _VictoryRoad1AfterBattleText2_HP
	text_end

; -------------------------------

VictoryRoad1Text3:
	text_asm
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld hl, VictoryRoad1TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

; ---

VictoryRoad1BattleText3:
	text_asm
	ld hl, VictoryRoad1BattleText3_HP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printAndEnd
; RP, check if it's our alter ego
	ld a, [wPlayerGender] ; 0=Red, 1=Green, 2=Yellow
	cp 2
	ld hl, VictoryRoad1BattleText_RP_YesUs
	jr z, .printAndEnd
	ld hl, VictoryRoad1BattleText_RP_NotUs
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1BattleText3_HP:
	text_far _VictoryRoad1BattleText3_HP
	text_end

; ---

VictoryRoad1EndBattleText3:
	text_asm
	ld hl, VictoryRoad1EndBattleText3_HP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printAndEnd
; RP, check if it's our alter ego
	ld a, [wPlayerGender] ; 0=Red, 1=Green, 2=Yellow
	cp 2
	ld hl, VictoryRoad1EndBattleText_RP_YesUs
	jr z, .printAndEnd
	ld hl, VictoryRoad1EndBattleText_RP_NotUs
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1EndBattleText3_HP:
	text_far _VictoryRoad1EndBattleText3_HP
	text_end

; ---

VictoryRoad1AfterBattleText3:
	text_asm
	ld hl, VictoryRoad1AfterBattleText3_HP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printAndEnd
; RP, check if it's our alter ego
	ld a, [wPlayerGender] ; 0=Red, 1=Green, 2=Yellow
	cp 2
	ld hl, VictoryRoad1AfterBattleText_RP_YesUs
	jr z, .printAndEnd
	ld hl, VictoryRoad1AfterBattleText_RP_NotUs
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1AfterBattleText3_HP:
	text_far _VictoryRoad1AfterBattleText3_HP
	text_end

; -------------------------------

VictoryRoad1Text4:
	text_asm
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld hl, VictoryRoad1TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

; ---

VictoryRoad1BattleText4:
	text_asm
	CheckEvent EVENT_ROCKET_PATH
	ld hl, VictoryRoad1BattleText4_RP
	jr nz, .printAndEnd
	ld hl, VictoryRoad1BattleText4_HP
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1BattleText4_HP:
	text_far _VictoryRoad1BattleText4_HP
	text_end

VictoryRoad1BattleText4_RP:
	text_far _VictoryRoad1BattleText4_RP
	text_end

; ---

VictoryRoad1EndBattleText4:
	text_asm
	CheckEvent EVENT_ROCKET_PATH
	ld hl, VictoryRoad1EndBattleText4_RP
	jr nz, .printAndEnd
	ld hl, VictoryRoad1EndBattleText4_HP
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1EndBattleText4_HP:
	text_far _VictoryRoad1EndBattleText4_HP
	text_end

VictoryRoad1EndBattleText4_RP:
	text_far _VictoryRoad1EndBattleText4_RP
	text_end

; ---

VictoryRoad1AfterBattleText4:
	text_asm
	CheckEvent EVENT_ROCKET_PATH
	ld hl, VictoryRoad1AfterBattleText4_RP
	jr nz, .printAndEnd
	ld hl, VictoryRoad1AfterBattleText4_HP
.printAndEnd
	call PrintText
	jp TextScriptEnd

VictoryRoad1AfterBattleText4_HP:
	text_far _VictoryRoad1AfterBattleText4_HP
	text_end

VictoryRoad1AfterBattleText4_RP:
	text_far _VictoryRoad1AfterBattleText4_RP
	text_end

; -------------------------------
