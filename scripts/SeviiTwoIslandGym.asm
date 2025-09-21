SeviiTwoIslandGym_Script:
	call ChooseNiuesTeam
	call EnableAutoTextBoxDrawing
	ld de, SeviiTwoIslandGym_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; ===============================

ChooseNiuesTeam:
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
; choose Niue's team at random out of 8: 0-7
	call Random
	and %00000111 ;=7 -> a in 0-7
	inc a ; 1-8
	ld [wTrainerNo], a
    ret

SeviiTwoIslandGym_ScriptPointers:
	dw SeviiTwoIslandGymScript0
	dw SeviiTwoIslandGymScriptPostBattle

SeviiTwoIslandGymScript0:
	ret

SeviiTwoIslandGymScriptPostBattle:
	xor a
	ld [wCurMapScript], a
; regardless of result, reload player's party
	call ReloadPartyFromSpecialSRAM
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr z, .gotDefeated
; if you won
	xor a
	ld [wIsTrainerBattle], a
	SetEvent EVENT_DEFEATED_SEVII_SAGE_NIUE
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gotDefeated ; TBE, modify defeat system to make this an "ok-to-lose battle"
	ret

; ===============================

SeviiTwoIslandGym_TextPointers:
	dw SeviiTwoIslandGymText1
	dw SeviiTwoIslandGymText2
	; scripts
	dw SeviiTwoIslandGymText3_Victory

SeviiTwoIslandGymText1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiTwoIslandGymText1_NoChampionYet
	jp z, .printAndEnd

; save party, clear it, and load a random one
	call SavePartyIntoSpecialSRAM
	call ClearPlayersParty
; handle all wram variables needed for randomization
	xor a
	ld [wBattleFacilityWhichMonIsRandomized], a
	ld [wBattleFacilityMonNumber1], a
	ld [wBattleFacilityMonNumber2], a
	ld [wBattleFacilityMonNumber3], a
	ld [wBattleFacilityMonNumber4], a
	ld [wBattleFacilityMonNumber5], a
; randomize 3 mons now
	callfar AddPartyMonRental
	callfar AddPartyMonRental
	callfar AddPartyMonRental

	ld hl, SeviiTwoIslandGymText1_Intro
	call PrintText

; and randomize another 3 mons now
	callfar AddPartyMonRental
	callfar AddPartyMonRental
	callfar AddPartyMonRental

	predef HealParty ; because of the HPs

; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, NiueText_PostBattleText
	ld de, NiueText_PostBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_NIUE
	ld [wCurOpponent], a
; trainer number chosen when we enter the gym
	ld a, 1
	ld [wIsTrainerBattle], a
	xor a
	ldh [hJoyHeld], a
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiTwoIslandGymText1_NoChampionYet:
	text_far _SeviiTwoIslandGymText1_NoChampionYet
	text_end

SeviiTwoIslandGymText1_Intro:
	text_far _SeviiTwoIslandGymText1_Intro
	text_end

SeviiTwoIslandGymText2:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiTwoIslandGymText2_PreLeague
	jr z, .printAndEnd
	ld hl, SeviiTwoIslandGymText2_PostLeague
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiTwoIslandGymText2_PreLeague:
	text_far _SeviiTwoIslandGymText2_PreLeague
	text_end

SeviiTwoIslandGymText2_PostLeague:
	text_far _SeviiTwoIslandGymText2_PostLeague
	text_end

NiueText_PostBattleText:
	text_far _NiueText_PostBattleText
	text_end

SeviiTwoIslandGymText3_Victory:
	text_far _SeviiTwoIslandGymText3_Victory
	text_end

; =====================================

SavePartyIntoSpecialSRAM::
; enable sram saving
	ld a, SRAM_ENABLE
	ld [MBC1SRamEnable], a
	ld a, $1
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamBank], a
; copy data
	ld hl, wPartyDataStart ; origin
	ld de, sTemporarySaveForSeviiSages ; destination
	ld bc, wPartyDataEnd - wPartyDataStart
	call CopyData ; Copy bc bytes from hl to de.
; disable sram saving
	ld a, SRAM_DISABLE
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamEnable], a
	ret
	
ReloadPartyFromSpecialSRAM::
; enable sram saving
	ld a, SRAM_ENABLE
	ld [MBC1SRamEnable], a
	ld a, $1
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamBank], a
; copy data
	ld hl, sTemporarySaveForSeviiSages ; origin
	ld de, wPartyDataStart ; destination
	ld bc, wPartyDataEnd - wPartyDataStart
	call CopyData ; Copy bc bytes from hl to de.
; disable sram saving
	ld a, SRAM_DISABLE
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamEnable], a
	ret
	
ClearPlayersParty::
	xor a
	ld hl, wPartyDataStart
	ld bc, wPartyDataEnd - wPartyDataStart
	jp FillMemory
	
; -------------------------------------
	
RandomizePlayersTeamForNiueBattle::
	ld de, wBattleFacilityMonNumber1
	ld a, [wBattleFacilityWhichMonIsRandomized]
	inc a
	ld [wBattleFacilityWhichMonIsRandomized], a
	dec a
	cp 5
	jr nc, .continue ; we don't need to move the address next if we are treating already the 6th mon
.storeMonAddressLoop
	dec a
	cp $FF
	jr z, .continue
	inc de
	jr .storeMonAddressLoop
.continue

; we want to generate any mon UP TO Mewtwo EXCLUDED
.innerRandomLoop
	call Random
	cp MEWTWO
	jr nc, .innerRandomLoop

	ld b, a ; now b contains the mon we just generated
; now we need to check if the mon we just generated is the same as any of the previously generated ones
	ld a, [wBattleFacilityMonNumber1]
	cp b
	jr z, .innerRandomLoop
	ld a, [wBattleFacilityMonNumber2]
	cp b
	jr z, .innerRandomLoop
	ld a, [wBattleFacilityMonNumber3]
	cp b
	jr z, .innerRandomLoop
	ld a, [wBattleFacilityMonNumber4]
	cp b
	jr z, .innerRandomLoop
	ld a, [wBattleFacilityMonNumber5]
	cp b
	jr z, .innerRandomLoop

; conclude
	ld a, b
	ld [wcf91], a
	ld b, a
	ld a, [wBattleFacilityWhichMonIsRandomized]
	cp 6
	ret z ; if we're treating the 6th mon, we don't save anything in the non-existing wBattleFacilityMonNumber6, otherwise we mess up stuff
	ld a, b
	ld [de], a ; saves Mon in wBattleFacilityMonNumberN
	ret
