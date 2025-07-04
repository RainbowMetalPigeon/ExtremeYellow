CeladonChiefHouse_Script:
	call EnableAutoTextBoxDrawing
	ld de, CeladonChiefHouse_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

CeladonChiefHouse_ScriptPointers: ; new
	dw LunarShrineScript0 ; ret
	dw LunarShrineScript1
	dw LunarShrineScript2
	dw LunarShrineScript3
	dw LunarShrineScript4
	dw LunarShrineScript5
	dw LunarShrineScript6
	dw LunarShrineScript7
	dw LunarShrineScript8
	dw LunarShrineScript9
	dw LunarShrineScript10
	dw LunarShrineScript11
	dw LunarShrineScript12
	dw LunarShrineScript13
	dw LunarShrineScript14

LunarShrineScript0:
	ret

LunarShrineScript1:
; music change, dialogue, and controls stuff
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	xor a
	ldh [hJoyHeld], a
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; player looks down
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
; Monk looks down
	ld c, 10
	call DelayFrames
	call MonkFacesDown
; exclamation bubbles
	ld a, $0 ; player
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, $4 ; Monk
	ld [wEmotionBubbleSpriteIndex], a
;	ld a, EXCLAMATION_BUBBLE
;	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld c, 20
	call DelayFrames
; make Rockets visible and walk toward player
	; Rocket 1
	ld a, HS_LUNAR_SHRINE_2
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld de, LunarShrineMovements1_Sprite5
	ld a, 5
	ldh [hSpriteIndex], a
	call MoveSprite
	; Rocket 2
	ld a, HS_LUNAR_SHRINE_3
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld de, LunarShrineMovements1_Sprite6
	ld a, 6
	ldh [hSpriteIndex], a
	call MoveSprite
	; Rocket 3
	ld a, HS_LUNAR_SHRINE_4
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld de, LunarShrineMovements_Sprite7
	ld a, 7
	ldh [hSpriteIndex], a
	call MoveSprite
	; Rocket 4
	ld a, HS_LUNAR_SHRINE_5
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld de, LunarShrineMovements_Sprite8
	ld a, 8
	ldh [hSpriteIndex], a
	call MoveSprite
; try fixing Monk facing
	call MonkFacesDown
; script handling
	ld a, $2
	ld [wCurMapScript], a
	ret

LunarShrineScript2:
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
; fix facing of Monk
	call MonkFacesDown
; fix facing of bottom Rockets
	call Rocket1FaceUp
	call Rocket2FaceUp
	call Rocket3FaceUp
	call Rocket4FaceUp
; script handling
	ld a, $3
	ld [wCurMapScript], a
	ret

LunarShrineScript3:
; fix facings
	call MonkFacesDown
	call Rocket1FaceUp
	call Rocket2FaceUp
	call Rocket3FaceUp
	call Rocket4FaceUp
; dialogue
	ld a, $0 ; return controls to the player?
	ld [wJoyIgnore], a
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; script handling
	ld a, $4
	ld [wCurMapScript], a
	ret

LunarShrineScript4:
; fix facings
	call MonkFacesDown
	call Rocket1FaceUp
	call Rocket2FaceUp
	call Rocket3FaceUp
	call Rocket4FaceUp
; dialogues
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; script handling
	ld a, $5
	ld [wCurMapScript], a
	ret

LunarShrineScript5:
; fix facings
	call MonkFacesDown
	call Rocket3FaceUp
	call Rocket4FaceUp
; keep moving the side Rockets
; Rocket 1
	ld de, LunarShrineMovements2_Sprite5
	ld a, 5
	ldh [hSpriteIndex], a
	call MoveSprite
; Rocket 2
	ld de, LunarShrineMovements2_Sprite6
	ld a, 6
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, $6
	ld [wCurMapScript], a
	ret

LunarShrineScript6:
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
; fix facings
	call MonkFacesDown
	call Rocket3FaceUp
	call Rocket4FaceUp
	call Rocket1FaceRight
	call Rocket2FaceLeft
; script handling
	ld a, $7
	ld [wCurMapScript], a
	ret

LunarShrineScript7:
; fix facings
	call MonkFacesDown
	call Rocket3FaceUp
	call Rocket4FaceUp
	call Rocket1FaceRight
	call Rocket2FaceLeft
; trigger 1st battle
	xor a
	ld [wJoyIgnore], a
	ld hl, wd72d ; nobody knows what it does lol
	set 6, [hl]
	set 7, [hl]
	ld hl, LunarShrineRocket1Text_Win ; text if player wins
	ld de, LunarShrineRocket1Text_Win ; text if player loses
	call SaveEndBattleTextPointers
	ld a, OPP_ROCKET
	ld [wCurOpponent], a
	ld a, 55
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
; script handling
	ld a, $8
	ld [wCurMapScript], a
	ret

LunarShrineScript8:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	jp HandleDefeat
.notDefeated
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
; fix facings
	call MonkFacesDown
	call Rocket3FaceUp
	call Rocket4FaceUp
	call Rocket1FaceRight
	call Rocket2FaceLeft
; trigger 2nd battle
	xor a
	ld [wJoyIgnore], a
	ld a, 20
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d ; nobody knows what it does lol
	set 6, [hl]
	set 7, [hl]
	ld hl, LunarShrineRocket2Text_Win ; text if player wins
	ld de, LunarShrineRocket2Text_Win ; text if player loses
	call SaveEndBattleTextPointers
	ld a, OPP_ROCKET
	ld [wCurOpponent], a
	ld a, 56
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
; script handling
	ld a, $9
	ld [wCurMapScript], a
	ret

LunarShrineScript9:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	jp HandleDefeat
.notDefeated
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
; fix facings
	call MonkFacesDown
	call Rocket3FaceUp
	call Rocket4FaceUp
	call Rocket1FaceRight
	call Rocket2FaceLeft
; trigger 3rd battle
	xor a
	ld [wJoyIgnore], a
	ld a, 21
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d ; nobody knows what it does lol
	set 6, [hl]
	set 7, [hl]
	ld hl, LunarShrineRocket3Text_Win ; text if player wins
	ld de, LunarShrineRocket3Text_Win ; text if player loses
	call SaveEndBattleTextPointers
	ld a, OPP_ROCKET
	ld [wCurOpponent], a
	ld a, 57
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
; script handling
	ld a, 10
	ld [wCurMapScript], a
	ret

LunarShrineScript10:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	jp HandleDefeat
.notDefeated
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
; fix facings
	call MonkFacesDown
	call Rocket3FaceUp
	call Rocket4FaceUp
	call Rocket1FaceRight
	call Rocket2FaceLeft
; trigger 4th battle
	xor a
	ld [wJoyIgnore], a
	ld a, 22
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d ; nobody knows what it does lol
	set 6, [hl]
	set 7, [hl]
	ld hl, LunarShrineRocket4Text_Win ; text if player wins
	ld de, LunarShrineRocket4Text_Win ; text if player loses
	call SaveEndBattleTextPointers
	ld a, OPP_ROCKET
	ld [wCurOpponent], a
	ld a, 58
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
; script handling
	ld a, 11
	ld [wCurMapScript], a
	ret

LunarShrineScript11:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	jp HandleDefeat
.notDefeated
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
; fix facings
	call MonkFacesDown
	call Rocket3FaceUp
	call Rocket4FaceUp
	call Rocket1FaceRight
	call Rocket2FaceLeft
; dialogue
	ld a, 23
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff ; testing
	ld [wJoyIgnore], a
; hide Rocket siblings
	call GBFadeOutToBlack
	ld a, HS_LUNAR_SHRINE_2
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_LUNAR_SHRINE_3
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_LUNAR_SHRINE_4
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_LUNAR_SHRINE_5
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; script handling
	ld a, 12
	ld [wCurMapScript], a
	ret

LunarShrineScript12:
	call PlayDefaultMusic
	ld a, 4
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, $f0 ; testing
	ld [wJoyIgnore], a
	ld a, 24
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; script handling
	ld a, 13
	ld [wCurMapScript], a
	ret

LunarShrineScript13:
	ld a, 4
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, $f0 ; testing
	ld [wJoyIgnore], a
	ld a, 25
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, LUNAR_RELIC
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_RETURNED_LUNAR_RELIC
; script handling
	ld a, 14
	ld [wCurMapScript], a
	ret

LunarShrineScript14:
	ld a, 4
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, 26
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	lb bc, HM_STRENGTH, 1
	call GiveItem
	ld a, 27
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 28
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; end stuff
	ld a, $0 ; return controls to the player?
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

HandleDefeat:
	xor a
	ld [wCurMapScript], a
	ld a, HS_LUNAR_SHRINE_2
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_LUNAR_SHRINE_3
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_LUNAR_SHRINE_4
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_LUNAR_SHRINE_5
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ret

; -----------------------------

LunarShrineMovements1_Sprite5:
LunarShrineMovements1_Sprite6:
LunarShrineMovements_Sprite7:
LunarShrineMovements_Sprite8:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

LunarShrineMovements2_Sprite5:
LunarShrineMovements2_Sprite6:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

MonkFacesDown:
	ld a, 4
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ret

Rocket1FaceUp:
	ld a, 5
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ret

Rocket2FaceUp:
	ld a, 6
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ret

Rocket3FaceUp:
	ld a, 7
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ret

Rocket4FaceUp:
	ld a, 8
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ret

Rocket1FaceRight:
	ld a, 5
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ret

Rocket2FaceLeft:
	ld a, 6
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ret

; ================================================

CeladonChiefHouse_TextPointers:
	dw CeladonHouseText1
	dw CeladonHouseText2
	dw CeladonHouseText3
	; Lunar Shrine
	dw LunarShrineTextMonk ; monk
	dw LunarShrineText2 ; Rocket 1, proxy
	dw LunarShrineText3 ; Rocket 2, proxy
	dw LunarShrineText4 ; Rocket 3, proxy
	dw LunarShrineText5 ; Rocket 4, proxy
	; tourists
	dw LunarShrineTextTourist1 ; tourist 1
	dw LunarShrineTextTourist2 ; tourist 2
	dw LunarShrineTextTourist3 ; tourist 3
	dw LunarShrineTextTourist4 ; tourist 4
	; signs
	dw LunarShrineTextTemple ; 13, shrine
	; non-NPC dialogues
	dw LunarShrineTextRockets1 ; 14
	dw LunarShrineTextRockets2 ; 15, Monk
	dw LunarShrineTextRockets3 ; 16, Rocket 1
	dw LunarShrineTextRockets4 ; 17, Rocket 2
	dw LunarShrineTextRockets5 ; 18, Rocket 3
	dw LunarShrineTextRockets6 ; 19, Rocket 4
	dw LunarShrineTextRockets7 ; 20, post-battle 1
	dw LunarShrineTextRockets8 ; 21, post-battle 2
	dw LunarShrineTextRockets9 ; 22, post-battle 3
	dw LunarShrineTextRockets10 ; 23, post-battle 4
	dw LunarShrineTextRockets11 ; 24, Monk thanks and let's place Relic
	dw LunarShrineTextRockets12 ; 25, Monk and Player place Relic
	dw LunarShrineTextRockets13 ; 26, Monk wants to reward Player
	dw LunarShrineTextRockets14 ; 27, Monk gifts STRENGTH
	dw LunarShrineTextRockets15 ; 28, Monk explains STRENGTH

CeladonHouseText1:
	text_far _CeladonHouseText1
	text_end

CeladonHouseText2:
	text_far _CeladonHouseText2
	text_end

CeladonHouseText3:
	text_far _CeladonHouseText3
	text_end

; LUNAR SHRINE ===================================

LunarShrineTextMonk:
	text_asm
	CheckEvent EVENT_RETURNED_LUNAR_RELIC
	jr nz, .alreadyReturnedRelic
	CheckEvent EVENT_MONK_NOTICED_RELIC
	jr nz, .relicAlreadyNoticed
	ld b, LUNAR_RELIC
	call IsItemInBag
	jr nz, .relicInBag
	ld hl, LunarShrineMonkText_RelicNotInBag
	jp .printAndEnd
.alreadyReturnedRelic
	ld hl, LunarShrineMonkText_AlreadyReturnedRelic
	jr .printAndEnd
.relicInBag
	SetEvent EVENT_MONK_NOTICED_RELIC
	ld hl, LunarShrineMonkText_RelicInBag_FirstTime
	jr .printAndEnd
.relicAlreadyNoticed
	ld hl, LunarShrineMonkText_RelicInBag_NotFirstTime
.printAndEnd
	call PrintText
	jp TextScriptEnd

LunarShrineTextTemple:
	text_asm
	CheckEvent EVENT_RETURNED_LUNAR_RELIC
	jr z, .relicNotYetReturned
	ld hl, LunarShrineTempleText_RelicAlreadyReturned
	jr .printAndEnd
.relicNotYetReturned
	CheckEvent EVENT_MONK_NOTICED_RELIC
	jr nz, .canTryPlacingRelic
	ld hl, LunarShrineTempleText_RelicNotNoticed
	jr .printAndEnd
.canTryPlacingRelic
	ld b, LUNAR_RELIC
	call IsItemInBag
	jr nz, .relicInBag
	ld hl, LunarShrineTempleText_RelicNotWithYou
	jp .printAndEnd
.relicInBag
	ld hl, LunarShrineTempleText_YesNo
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, LunarShrineTempleText_DoNotPlaceRelic
	jp nz, .printAndEnd
; try to place the relic, handle the scripts and print corresponding text
	ld a, 1
	ld [wCurMapScript], a
	ld hl, LunarShrineTempleText_PlaceRelic
.printAndEnd
	call PrintText
	jp TextScriptEnd

; ---------------------------------------------------

LunarShrineMonkText_RelicNotInBag:
	text_far _LunarShrineMonkText_RelicNotInBag
	text_end

LunarShrineMonkText_AlreadyReturnedRelic:
	text_far _LunarShrineMonkText_AlreadyReturnedRelic
	text_end

LunarShrineMonkText_RelicInBag_FirstTime:
	text_far _LunarShrineMonkText_RelicInBag_FirstTime
	text_end

LunarShrineMonkText_RelicInBag_NotFirstTime:
	text_far _LunarShrineMonkText_RelicInBag_NotFirstTime
	text_end

; ---------------------------

LunarShrineTempleText_RelicNotNoticed:
	text_far _LunarShrineTempleText_RelicNotNoticed
	text_end

LunarShrineTempleText_YesNo:
	text_far _LunarShrineTempleText_YesNo
	text_end

LunarShrineTempleText_DoNotPlaceRelic:
	text_far _LunarShrineTempleText_DoNotPlaceRelic
	text_end

LunarShrineTempleText_PlaceRelic:
	text_far _LunarShrineTempleText_PlaceRelic
	text_end

LunarShrineTempleText_RelicAlreadyReturned:
	text_far _LunarShrineTempleText_RelicAlreadyReturned
	text_end

LunarShrineTempleText_RelicNotWithYou:
	text_far _LunarShrineTempleText_RelicNotWithYou
	text_end

; ---------------------------

LunarShrineText2:
LunarShrineText3:
LunarShrineText4:
LunarShrineText5:
	text_far _LunarShrineTextProxy
	text_end

; ---------------------------

LunarShrineTextRockets1:
	text_far _LunarShrineTextRockets1
	text_end

LunarShrineTextRockets2:
	text_far _LunarShrineTextRockets2
	text_end

LunarShrineTextRockets3:
	text_far _LunarShrineTextRockets3
	text_end

LunarShrineTextRockets4:
	text_far _LunarShrineTextRockets4
	text_end

LunarShrineTextRockets5:
	text_far _LunarShrineTextRockets5
	text_end

LunarShrineTextRockets6:
	text_far _LunarShrineTextRockets6
	text_end

LunarShrineTextRockets7:
	text_far _LunarShrineTextRockets7
	text_end

LunarShrineTextRockets8:
	text_far _LunarShrineTextRockets8
	text_end

LunarShrineTextRockets9:
	text_far _LunarShrineTextRockets9
	text_end

LunarShrineTextRockets10:
	text_far _LunarShrineTextRockets10
	text_end

LunarShrineTextRockets11:
	text_far _LunarShrineTextRockets11
	text_end

LunarShrineTextRockets12:
	text_far _LunarShrineTextRockets12
	sound_get_item_1 ; testing
	text_end

LunarShrineTextRockets13:
	text_far _LunarShrineTextRockets13
	text_end

LunarShrineTextRockets14:
	text_far _LunarShrineTextRockets14
	sound_get_key_item ; testing
	text_end

LunarShrineTextRockets15:
	text_far _LunarShrineTextRockets15
	text_end

LunarShrineRocket1Text_Win:
	text_far _LunarShrineRocket1Text_Win
	text_end

LunarShrineRocket2Text_Win:
	text_far _LunarShrineRocket2Text_Win
	text_end

LunarShrineRocket3Text_Win:
	text_far _LunarShrineRocket3Text_Win
	text_end

LunarShrineRocket4Text_Win:
	text_far _LunarShrineRocket4Text_Win
	text_end

; ---------------------------

LunarShrineTextTourist1:
	text_far _LunarShrineTextTourist1
	text_end

LunarShrineTextTourist2:
	text_far _LunarShrineTextTourist2
	text_end

LunarShrineTextTourist3:
	text_far _LunarShrineTextTourist3
	text_end

LunarShrineTextTourist4:
	text_far _LunarShrineTextTourist4
	text_end
