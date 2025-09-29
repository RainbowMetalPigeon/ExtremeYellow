SeviiSevenIslandGym1_Script:
	call ResetGymDungeon
	call EnableAutoTextBoxDrawing
	ld de, SeviiSevenIslandGym1_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiSevenIslandGym1_ScriptPointers:
	dw SeviiSevenIslandGym1Script0

SeviiSevenIslandGym1Script0:
; already warned?
	CheckEvent EVENT_SEVII_ALREADY_WARNED_ABOUT_ANOMALIES
	ret nz
; front of the door?
	ld hl, SeviiSevenIslandGym1InFrontOfDoorCoords
	call ArePlayerCoordsInArray
	ret nc
; do we have "forbidden" stuff?
	callfar CheckIfTeamValidForSeviiSagesRewards ; output: c flag if "invalid"
	ret nc
; warn the player
	ld a, 1
	ldh [hSpriteIndex], a
	lb bc, STAY, UP
	call ChangeSpriteMovementBytes ; new fancy approach from Engeze
	ld a, 2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_SEVII_ALREADY_WARNED_ABOUT_ANOMALIES
	ret

SeviiSevenIslandGym1InFrontOfDoorCoords:
	dbmapcoord  4,  1
	db -1 ; end

SeviiSevenIslandGym1_TextPointers:
	dw SeviiSevenIslandGym1Text1
	; scripts
	dw SeviiSevenIslandGym1Text2

SeviiSevenIslandGym1Text1:
	text_far _SeviiSevenIslandGym1Text1
	text_end

SeviiSevenIslandGym1Text2:
	text_far _SeviiNoRewardsIfAnomalies
	text_end

ResetGymDungeon:
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
	ld a, [wWarpedFromWhichMap]
	cp SEVII_ROUTE_41
	jr z, .skipBagHandling
; load bag from SRAM if we're coming from anywhere but outside (so any of the internal dungeon maps)
	call ReloadBagFromSpecialSRAM
.skipBagHandling

	SetEvent EVENT_SEVII_JUST_ENTERED_SEVEN_GYM

	ResetEvent EVENT_BATTLE_CAN_BE_LOST

	ResetEvent EVENT_SEVII_SEVEN_ISLAND_GYM_3_BOULDER_ON_SWITCH
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_1
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_2
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_3
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_4
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_5
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_6
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_7
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_1
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_2
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_3
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_4
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_5
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_3_TRAINER_1
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_3_TRAINER_2
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_3_TRAINER_3
	ResetEvent EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_3_TRAINER_4

	ld hl, SeviiSevenIslandGymStuffToRespawn
.showLoop
	ld a, [hli]
	cp $ff ; have we run out of stuff to show?
	ret z ; if so, we're done here
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	pop hl
	jr .showLoop

SeviiSevenIslandGymStuffToRespawn:
	db HS_SEVII_SEVEN_ISLAND_GYM_2_ITEM_1
	db HS_SEVII_SEVEN_ISLAND_GYM_2_ITEM_2
	db HS_SEVII_SEVEN_ISLAND_GYM_2_ITEM_3
	db HS_SEVII_SEVEN_ISLAND_GYM_2_ITEM_4
	db HS_SEVII_SEVEN_ISLAND_GYM_2_ITEM_5
	db HS_SEVII_SEVEN_ISLAND_GYM_2_DIVE_ITEM_1
	db HS_SEVII_SEVEN_ISLAND_GYM_2_DIVE_ITEM_2
	db HS_SEVII_SEVEN_ISLAND_GYM_2_DIVE_ITEM_3
	db HS_SEVII_SEVEN_ISLAND_GYM_2_DIVE_ITEM_4
	db HS_SEVII_SEVEN_ISLAND_GYM_2_DIVE_ITEM_5
	db HS_SEVII_SEVEN_ISLAND_GYM_2_DIVE_ITEM_6
	db HS_SEVII_SEVEN_ISLAND_GYM_2_DIVE_CAVERN_ITEM_1
	db HS_SEVII_SEVEN_ISLAND_GYM_3_ITEM_1
	db HS_SEVII_SEVEN_ISLAND_GYM_3_ITEM_2
	db HS_SEVII_SEVEN_ISLAND_GYM_3_ITEM_3
	db HS_SEVII_SEVEN_ISLAND_GYM_3_ITEM_4
	db $FF

; =====================================

SaveBagIntoSpecialSRAM:
; enable sram saving
	ld a, SRAM_ENABLE
	ld [MBC1SRamEnable], a
	ld a, $1
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamBank], a
; copy data
	ld hl, wNumBagItems ; origin
	ld de, sTemporarySaveForSeviiSages ; destination
	ld bc, BAG_ITEM_CAPACITY * 2 + 2
;	ld bc, wPlayerMoney - wNumBagItems
	call CopyData ; Copy bc bytes from hl to de.
; disable sram saving
	ld a, SRAM_DISABLE
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamEnable], a
	ret

ReloadBagFromSpecialSRAM:
; enable sram saving
	ld a, SRAM_ENABLE
	ld [MBC1SRamEnable], a
	ld a, $1
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamBank], a
; copy data
	ld hl, sTemporarySaveForSeviiSages ; origin
	ld de, wNumBagItems ; destination
	ld bc, BAG_ITEM_CAPACITY * 2 + 2
;	ld bc, wPlayerMoney - wNumBagItems
	call CopyData ; Copy bc bytes from hl to de.
; disable sram saving
	ld a, SRAM_DISABLE
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamEnable], a
	ret

ClearPlayersBag:
	ld hl, wNumBagItems
	xor a ; count
	ld [hli], a
	dec a ; terminator
	ld [hl], a
	ret

; -------------------------------------
