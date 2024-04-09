OchreCity_Script:
	ld hl, wCurrentMapScriptFlags ; for the fence
	bit 6, [hl]
	res 6, [hl]
	call nz, OchreCityHideShowRehabilitationFence
	ld hl, wCurrentMapScriptFlags ; from Vortiene
	bit 4, [hl]
	res 4, [hl]
	call nz, OchreCityHideShowRehabilitationFence
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld de, OchreCity_ScriptPointers
	ld a, [wOchreCityCurScript]
	call ExecuteCurMapScriptInTable
	ld [wOchreCityCurScript], a
	ret

OchreCityHideShowRehabilitationFence:
	CheckEvent EVENT_OCHRE_CITY_FENCE_FORCED
	jr nz, .fenceForced	; if yes, remove fence
	ld a, $4D			; solid fence block ID
	jr .replaceBlock
.fenceForced
	ld a, $E6			; fence-less block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc, 16, 20 ; Y and X coordinates - opposite as usual
	predef_jump ReplaceTileBlock

OchreCity_ScriptPointers: ; new, for traveler
	dw OchreScript0
	dw OchreScript_Traveler

OchreScript0:
	ret

OchreCity_TextPointers:
	; NPCs
	dw OchreCity_NPCText1
	dw OchreCity_NPCText2
	dw OchreCity_NPCText3
	dw OchreCity_NPCText4
	dw OchreCity_NPCText5
	dw OchreCity_NPCText6
	dw OchreCity_NPCText7
	dw OchreCity_NPCText8
	dw OchreCity_NPCText9
	dw TextPreBattle_OchreTraveler ; new, for traveler
	dw OchreCity_NPCText11
	dw OchreCity_NPCText12
	dw OchreCity_NPCText13
	dw OchreCity_NPCText14
	; signs
	dw MartSignText
	dw PokeCenterSignText
	dw OchreCity_SignCity
	dw OchreCity_SignGym
	dw OchreCity_SignRehabilitation
	dw OchreCity_SignParkAndSquare
	dw OchreCity_SignResearch
	dw OchreCity_SignBirbFan
	dw OchreCity_LooseFence
	; non-NPC dialogues
	dw TextPostBattle_OchreTraveler ; 24, new, for traveler

; -------------- NPCs texts --------------

OchreCity_NPCText1:
	text_far _OchreCity_NPCText1
	text_end

OchreCity_NPCText2:
	text_far _OchreCity_NPCText2
	text_end

OchreCity_NPCText3:
	text_far _OchreCity_NPCText3
	text_end

OchreCity_NPCText4:
	text_far _OchreCity_NPCText4
	text_end

OchreCity_NPCText5:
	text_far _OchreCity_NPCText5
	text_end

OchreCity_NPCText6:
	text_far _OchreCity_NPCText6
	text_end

OchreCity_NPCText7:
	text_far _OchreCity_NPCText7
	text_end

OchreCity_NPCText8:
	text_far _OchreCity_NPCText8
	text_end

OchreCity_NPCText9:
	text_far _OchreCity_NPCText9
	text_end

;OchreCity_NPCText10:
;	text_far _OchreCity_NPCText10
;	text_end

OchreCity_NPCText11:
	text_far _OchreCity_NPCText11
	text_end

OchreCity_NPCText12:
	text_far _OchreCity_NPCText12
	text_end

OchreCity_NPCText13:
	text_asm
	ld hl, OchreCity_NPCText13_Bird
	call PrintText
	call DontTouchTheBribs
    jp TextScriptEnd

OchreCity_NPCText13_Bird:
	text_far _OchreCity_NPCText13_Bird
	text_end

OchreCity_NPCText14:
	text_asm
	ld hl, OchreCity_NPCText14_Bird
	call PrintText
	call DontTouchTheBribs
    jp TextScriptEnd

OchreCity_NPCText14_Bird:
	text_far _OchreCity_NPCText14_Bird
	text_end

OchreCity_Scolded:
	text_far _OchreCity_Scolded
	text_end

; -------------- signs texts --------------

OchreCity_SignCity:
	text_far _OchreCity_SignCity
	text_end

OchreCity_SignGym:
	text_far _OchreCity_SignGym
	text_end

OchreCity_SignRehabilitation:
	text_far _OchreCity_SignRehabilitation
	text_end

OchreCity_SignParkAndSquare:
	text_far _OchreCity_SignParkAndSquare
	text_end

OchreCity_SignResearch:
	text_far _OchreCity_SignResearch
	text_end

OchreCity_SignBirbFan:
	text_far _OchreCity_SignBirbFan
	text_end

OchreCity_LooseFence:
	text_asm
	CheckEvent EVENT_OCHRE_CITY_FENCE_FORCED
	jr nz, .alreadyForced
	ld hl, OchreCity_LooseFence_ItsLoose
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .notOpen
    ld a, SFX_PUSH_BOULDER
    call PlaySound
    SetEvent EVENT_OCHRE_CITY_FENCE_FORCED
    ld a, $E6 ; clear floor block ID
    ld [wNewTileBlockID], a
    lb bc, 16, 20 ; y, x coordinates
    predef ReplaceTileBlock
    ld hl, OchreCity_LooseFence_FenceForced
    call PrintText
    jr .done
.alreadyForced
    ld hl, OchreCity_LooseFence_AlreadyForced
    call PrintText
	jr .done
.notOpen
    ld hl, OchreCity_LooseFence_BetterNotTo
    call PrintText
.done
    jp TextScriptEnd

OchreCity_LooseFence_ItsLoose:
	text_far _OchreCity_LooseFence_ItsLoose
	text_end

OchreCity_LooseFence_FenceForced:
	text_far _OchreCity_LooseFence_FenceForced
	text_end

OchreCity_LooseFence_AlreadyForced:
	text_far _OchreCity_LooseFence_AlreadyForced
	text_end

OchreCity_LooseFence_BetterNotTo:
	text_far _OchreCity_LooseFence_BetterNotTo
	text_end

; ================================

TextPreBattle_OchreTraveler: ; new
	text_asm
	ld hl, Text_Intro_OchreTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_OchreTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_OchreTraveler
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl]	; Turn on battle animations to make the battle feel more epic
	call Delay3
	ld a, OPP_TRAVELER
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld hl, Text_DefeatPostBattle_OchreTraveler
	ld de, Text_VictoryPostBattle_OchreTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 1 ; city-specific
	ld [wOchreCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_OchreTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_OchreTraveler
	call PrintText
	call GBFadeOutToBlack
    ld a, SFX_PUSH_BOULDER
    call PlaySound
	ld c, 50
	call DelayFrames
	call GBFadeInFromBlack
	call GBFadeOutToBlack
	call GBFadeInFromBlack
	call GBFadeOutToBlack
    ld a, SFX_GO_INSIDE
    call PlaySound
	ld c, 50
	call DelayFrames
	call GBFadeInFromBlack
	ld hl, Text_WhatWasThat_OchreTraveler
	call PrintText
	; script handling
	xor a
	ld [wOchreCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

OchreScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wOchreCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	ret
.notDefeated
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_OCHRE_CITY_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra ; city-specific
	ld a, 24 ; city-specific
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; make the traveler run away to search Mega Mewtwo
	call GBFadeOutToBlack
    callfar LoopHideTraveler
    callfar LoopHideTravelerExtra
	ld a, HS_CERULEAN_CAVE_B1F_TRAVELER
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	ret

; --------------------------------

Text_Intro_OchreTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_OchreTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_OchreTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_OchreTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_OchreTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_OchreTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_OchreTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; ================================

DontTouchTheBribs:
	call StopAllMusic
	ld c, BANK(SFX_Safari_Zone_PA)
	ld a, SFX_SAFARI_ZONE_PA
	call PlayMusic
.waitForMusicToPlay
	ld a, [wChannelSoundIDs + CHAN5]
	cp SFX_SAFARI_ZONE_PA
	jr nz, .waitForMusicToPlay
	ld hl, OchreCity_Scolded
	call PrintText
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, OCHRE_REHABILITATION_CENTER
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld a, OCHRE_CITY
	ld [wLastMap], a
	CheckAndSetEvent EVENT_OCHRE_REHABILITATION_SCOLDED_ONCE
	jr z, .firstTime
	SetEvent EVENT_OCHRE_REHABILITATION_SCOLDED_AGAIN
.firstTime
	ld a, HS_OCHRE_REHABILITATION_GURU_2
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, 1
	ld [wOchreRehabilitationCenterCurScript], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ret
