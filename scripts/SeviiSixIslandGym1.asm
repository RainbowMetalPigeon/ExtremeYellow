SeviiSixIslandGym1_Script:
	call ApplyMalusOnEntry1
	call EnableAutoTextBoxDrawing
	ld de, SeviiSixIslandGym1_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiSixIslandGym1_ScriptPointers:
	dw SeviiSixIslandGym1Script0

SeviiSixIslandGym1Script0:
; already warned?
	CheckEvent EVENT_SEVII_ALREADY_WARNED_ABOUT_ANOMALIES
	ret nz
; front of the door?
	ld hl, SeviiSixIslandGym1InFrontOfDoorCoords
	call ArePlayerCoordsInArray
	ret nc
; do we have "forbidden" stuff?
	callfar CheckIfTeamValidForSeviiSagesRewards ; output: c flag if "invalid"
	ret nc
; warn the player
	ld a, 10
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_SEVII_ALREADY_WARNED_ABOUT_ANOMALIES
	ret

SeviiSixIslandGym1InFrontOfDoorCoords:
	dbmapcoord  4,  3
	db -1 ; end

ApplyMalusOnEntry1:
	ld hl, wCurrentMapScriptFlags ; new
	bit 5, [hl]
	res 5, [hl]
	ret z
	ld a, [wXCoord]
; Intro room?
	cp 10 ; between Intro room and Stat-Debuff room
	jr nc, .checkStatDebuffRoom
; initialize the special modifiers
	ld a, $7 ; default stat modifier
	ld b, 6 ; effective number of stat modifiers, two were allocated but never used
	ld hl, wUniQuizAnswer ; temporary storage
.statModLoop
	ld [hli], a
	dec b
	jr nz, .statModLoop
	xor a
	ld [hli], a ; Rocks: wUniQuizAnswer+6
	ld [hli], a ; Spikes
	ld [hli], a ; Toxic Spikes
	ld [hl], a ; Web
	ld [wPlayerBattleStatus1], a
	ld [wPlayerBattleStatus2], a
	ld [wPlayerBattleStatus3], a
	ResetEvent EVENT_BATTLE_CAN_BE_LOST
	SetEvent EVENT_SEVII_JUST_ENTERED_SIX_GYM
	ret
.checkStatDebuffRoom
	SetEvent EVENT_BATTLE_CAN_BE_LOST ; for overworld death to poison
	CheckAndResetEvent EVENT_SEVII_JUST_ENTERED_SIX_GYM
	jr z, .notJustEntered
	predef HealParty
.notJustEntered
	ld a, [wXCoord] ; reload it because the above overwrote it
	cp 24
	jr nc, .checkPSNRoom
	call CheckIfAStatModifierCanBeLowered ; z flag if all stats have been minimized
	ret z
	call ApplyRandomStatDebuff
	ld a, 6
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkPSNRoom
; one check for all status rooms: if all mons are statused, skip the rest
	call CheckIfAllMonsAreStatused ; z flag if at least 1 mon is NOT statused
	ret nz
; now, normal checks
	ld a, [wXCoord] ; need to be reloaded because was overwritten above
	cp 38
	jr nc, .checkBRNRoom
	call FindARandomNonStatusedPokemon ; hl now points to a non-statused mon
	set PSN, [hl]
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkBRNRoom
	cp 52
	jr nc, .PARRoom
	call FindARandomNonStatusedPokemon ; hl now points to a non-statused mon
	set BRN, [hl]
	ld a, 8
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.PARRoom
	call FindARandomNonStatusedPokemon ; hl now points to a non-statused mon
	set PAR, [hl]
	ld a, 9
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

SeviiSixIslandGym1_TextPointers:
	dw SeviiSixIslandGym1Text1
	; signs
	dw SeviiSixIslandGym1SignText1
	dw SeviiSixIslandGym1SignText2
	dw SeviiSixIslandGym1SignText3
	dw SeviiSixIslandGym1SignText4
	; scripts
	dw SeviiSixIslandGym1PopUpMessageStatDebuff ; 6
	dw SeviiSixIslandGym1PopUpMessagePoison ; 7
	dw SeviiSixIslandGym1PopUpMessageBurn ; 8
	dw SeviiSixIslandGym1PopUpMessageParalysis ; 9
	dw SeviiSixIslandGym1Text10 ; 10

SeviiSixIslandGym1Text1:
	text_far _SeviiSixIslandGym1Text1
	text_end

/*
; check if team is valid for reward
	callfar CheckIfTeamValidForSeviiSagesRewards ; output: c flag if "invalid"
	jr nc, .setUpBattle
; ask the player if they actually wanna fight
	call WaitForTextScrollButtonPress
	ld hl, SeviiSixIslandGym3Text1_NoRewardWannaFight
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .yesBattle
; player refuses to battle
	ld hl, SeviiSixIslandGym3Text1_NoRewardNoFight
	jr .printAndEnd
.yesBattle
	ld hl, SeviiSixIslandGym3Text1_NoRewardYesFight
	call PrintText
; fallthrough
.setUpBattle

SeviiSixIslandGym3Text1_NoRewardWannaFight:
	text_far _SeviiIslandGymText_NoRewardWannaFight
	text_end

SeviiSixIslandGym3Text1_NoRewardNoFight:
	text_far _SeviiIslandGymText_NoRewardNoFight
	text_end

SeviiSixIslandGym3Text1_NoRewardYesFight:
	text_far _SeviiIslandGymText_NoRewardYesFight
	text_end

*/

SeviiSixIslandGym1SignText1:
	text_far _SeviiSixIslandGym1SignText1
	text_end

SeviiSixIslandGym1SignText2:
	text_far _SeviiSixIslandGym1SignText2
	text_end

SeviiSixIslandGym1SignText3:
	text_far _SeviiSixIslandGym1SignText3
	text_end

SeviiSixIslandGym1SignText4:
	text_far _SeviiSixIslandGym1SignText4
	text_end

SeviiSixIslandGym1PopUpMessageStatDebuff:
	text_far _SeviiSixIslandGym1PopUpMessageStatDebuff
	text_end
	
SeviiSixIslandGym1PopUpMessagePoison:
	text_far _SeviiSixIslandGym1PopUpMessagePoison
	text_end
	
SeviiSixIslandGym1PopUpMessageBurn:
	text_far _SeviiSixIslandGym1PopUpMessageBurn
	text_end
	
SeviiSixIslandGym1PopUpMessageParalysis:
	text_far _SeviiSixIslandGym1PopUpMessageParalysis
	text_end
	
SeviiSixIslandGym1Text10:
	text_far _SeviiNoRewardsIfAnomalies
	text_end

; ------------------------------------------------------------

; z flag if at least 1 mon is NOT statused
CheckIfAllMonsAreStatused:
	ld a, [wPartyCount]
	ld b, a ; d has the number of Mons in the party
	ld de, wPartyMon2Status - wPartyMon1Status
	ld hl, wPartyMon1Status - (wPartyMon2Status - wPartyMon1Status)
.loop
	add hl, de
	ld a, [hl]
	and a
	ret z
	dec b
	jr nz, .loop
	ld a, 1
	and a ; to ensure nz flag is set
	ret

; returns hl as the pointer to a status-izable mon
FindARandomNonStatusedPokemon:
	ld a, [wPartyCount]
	ld d, a ; d has the number of Mons in the party
.RNGLoop
	call Random
	and 7 ; bit-wise and with %0000111
	cp d
	jr nc, .RNGLoop
; here we have a random number between 0 and b-1,
; i.e. the number of members - 1
; e.g. 0-5 if we have 6 members
	; a holds the random number
	ld hl, wPartyMon1Status
	ld bc, wPartyMon2Status - wPartyMon1Status
	call AddNTimes ; add bc to hl a times
	; now hl points to the status of the n-th mon
	ld a, [hl]
	and a
	jr nz, .RNGLoop ; back to RNG if the mon is already statused
; we can status-ize the mon
	ret

;DEF SLP_MASK EQU %111 ; 0-7 turns
;	const_def 3
;	const PSN ; 3
;	const BRN ; 4
;	const FRZ ; 5
;	const PAR ; 6

; ------------------------------------------------------------

; returns z flag if all stat modifiers are at 1
CheckIfAStatModifierCanBeLowered:
	ld hl, wUniQuizAnswer
	ld b, 6
.loop
	ld a, [hli]
	cp 1
	ret nz
	dec b
	ret z
	jr .loop

ApplyRandomStatDebuff:
.RNGLoop
	call Random
	and 7 ; bit-wise and with %0000111
	cp 6
	jr nc, .RNGLoop
; here we have a random number between 0 and 5
	ld hl, wUniQuizAnswer
.increaseLoop
	and a
	jr z, .doneIncrease
	inc hl
	dec a
	jr .increaseLoop
.doneIncrease ; now hl points to the n-th stat we want to debuff
	ld a, [hl]
	cp 1
	jr z, .RNGLoop ; back to RNG if the mon is already statused
; we can reduce this stat
	dec a
	ld [hl], a
	ret
