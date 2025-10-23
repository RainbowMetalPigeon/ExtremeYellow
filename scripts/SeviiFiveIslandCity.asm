SeviiFiveIslandCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFiveIslandCityTrainerHeaders
	ld de, SeviiFiveIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiFiveIslandCity_ScriptPointers:
	dw SeviiFiveIslandCity_Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw SeviiFiveIslandCity_Script3 ; 3
	dw SeviiFiveIslandCity_Script4 ; 4
	dw SeviiFiveIslandCity_Script5 ; 5

; scripts =========================================

SeviiFiveIslandCity_Script0:
	CheckEvent EVENT_SEVII_FIVE_ISLAND_PINK_ROCKET_FIGHT_OVER
	jp nz, CheckFightingMapTrainers
	ld hl, SeviiFiveIslandCity_Coordinates_PinkRocketScene
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jp nc, CheckFightingMapTrainers
; we're at the right coordinates and have not seen the scene yet
	SetEvent EVENT_SEVII_FIVE_ISLAND_PINK_ROCKET_FIGHT_OVER
; change music
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
; turn player right
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	call Delay3
; pink-rocket dialogue
	ld a, 22
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; battle effects (sound? shake? flash?) TBE
	call GBFadeOutToBlack
	ld a, SFX_PUSH_BOULDER
	call PlaySound
	call GBFadeOutToWhite
	ld a, SFX_PUSH_BOULDER
	call PlaySound
	call GBFadeInFromBlack
	ld a, SFX_PUSH_BOULDER
	call PlaySound
	call GBFadeInFromWhite
	ld a, SFX_PUSH_BOULDER
	call PlaySound
	ld a, HS_SEVII_FIVE_ISLAND_CITY_MONSTER_ROCKET
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	call Delay3
	predef ShowObjectSevii
	call Delay3
	predef HideObjectSevii
	call Delay3
	predef ShowObjectSevii
	call Delay3
	predef HideObjectSevii
	call Delay3
	predef ShowObjectSevii
	ld c, 30
	call DelayFrames
; rocket mon hidden
	ld a, HS_SEVII_FIVE_ISLAND_CITY_MONSTER_ROCKET
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; rocket dialogue
	ld a, 23
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; rocket walks 1 step up
	ld de, SeviiFiveIslandRocketMovements
	ld a, 5
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiFiveIslandCity_Coordinates_PinkRocketScene:
	dbmapcoord 27, 29
	db -1 ; end

SeviiFiveIslandRocketMovements:
	db NPC_MOVEMENT_UP
	db -1 ; end

SeviiFiveIslandCity_Script3:
; wait for Rocket to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; go inside sound
	ld a, SFX_GO_INSIDE
	call PlaySound
; rocket hidden
	ld a, HS_SEVII_FIVE_ISLAND_CITY_ROCKET
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; back to default music
	call PlayDefaultMusic
; return controls
	ld a, $0
	ld [wJoyIgnore], a
; pink dialogue
	ld a, 24
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; pink mon hidden
	ld a, HS_SEVII_FIVE_ISLAND_CITY_MONSTER_PINK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; pink turn left
	lb de, 6, SPRITE_FACING_LEFT
	callfar ChangeSpriteFacing ; new Pigeon approach
; pink dialogue
	ld a, 25
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; pink approaches player
	ld de, SeviiFiveIslandPinkToPlayerMovements
	ld a, 6
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 4
	ld [wCurMapScript], a
	ret

SeviiFiveIslandPinkToPlayerMovements:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db -1 ; end

SeviiFiveIslandCity_Script4:
; wait for Pink to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; return controls
	ld a, $0
	ld [wJoyIgnore], a
; pink dialogue
	ld a, 26
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; pink goes into the warehouse
	ld de, SeviiFiveIslandPinkToWarehouseMovements
	ld a, 6
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 5
	ld [wCurMapScript], a
	ret

SeviiFiveIslandPinkToWarehouseMovements:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db -1 ; end

SeviiFiveIslandCity_Script5:
; wait for Pink to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; go inside sound
	ld a, SFX_GO_INSIDE
	call PlaySound
; pink hidden
	ld a, HS_SEVII_FIVE_ISLAND_CITY_PINK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; load next script and return controls
	xor a
	ld [wCurMapScript], a
	ld [wJoyIgnore], a
	ret

; texts =========================================

SeviiFiveIslandCity_TextPointers:
	dw SeviiFiveIslandCityText1  ;  1 person
	dw SeviiFiveIslandCityText2  ;  2 person
	dw SeviiFiveIslandCityText3  ;  3 Monster Rocket
	dw SeviiFiveIslandCityText4  ;  4 Monster Pink
	dw SeviiFiveIslandCityText5  ;  5 Rocket
	dw SeviiFiveIslandCityText6  ;  6 Pink
	dw SeviiFiveIslandCityText7  ;  7 trainer
	dw SeviiFiveIslandCityText8  ;  8 trainer
	dw SeviiFiveIslandCityText9  ;  9 trainer
	dw SeviiFiveIslandCityText10 ; 10 trainer
	dw RockSmashText ; 11
	dw PickUpItemText ; 12
	dw PickUpItemText ; 13
	dw PickUpItemText ; 14
	; signs
	dw SeviiFiveIslandCitySignText1 ; 15
	dw SeviiFiveIslandCitySignText2 ; 16
	dw SeviiFiveIslandCitySignText3 ; 17
	dw SeviiFiveIslandCitySignText4 ; 18
	dw SeviiFiveIslandCitySignText5 ; 19
	dw PokeCenterSignText ; 20
	dw MartSignText ; 21
	; scripts
	dw SeviiFiveIslandCityScriptText1 ; 22 ; pink vs rocket
	dw SeviiFiveIslandCityScriptText2 ; 23 ; rocket swearing
	dw SeviiFiveIslandCityScriptText3 ; 24 ; pink swearing post victory
	dw SeviiFiveIslandCityScriptText4 ; 25 ; pink sees you
	dw SeviiFiveIslandCityScriptText5 ; 26 ; pink asks help

SeviiFiveIslandCityTrainerHeaders:
	def_trainers 7
SeviiFiveIslandCityTrainerHeader1:
	trainer EVENT_BEAT_SEVII_FIVE_ISLAND_CITY_TRAINER_1, 1, SeviiFiveIslandCityBattleText1, SeviiFiveIslandCityEndBattleText1, SeviiFiveIslandCityAfterBattleText1
SeviiFiveIslandCityTrainerHeader2:
	trainer EVENT_BEAT_SEVII_FIVE_ISLAND_CITY_TRAINER_2, 1, SeviiFiveIslandCityBattleText2, SeviiFiveIslandCityEndBattleText2, SeviiFiveIslandCityAfterBattleText2
SeviiFiveIslandCityTrainerHeader3:
	trainer EVENT_BEAT_SEVII_FIVE_ISLAND_CITY_TRAINER_3, 1, SeviiFiveIslandCityBattleText3, SeviiFiveIslandCityEndBattleText3, SeviiFiveIslandCityAfterBattleText3
SeviiFiveIslandCityTrainerHeader4:
	trainer EVENT_BEAT_SEVII_FIVE_ISLAND_CITY_TRAINER_4, 3, SeviiFiveIslandCityBattleText4, SeviiFiveIslandCityEndBattleText4, SeviiFiveIslandCityAfterBattleText4
	db -1 ; end

SeviiFiveIslandCity_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiFiveIslandCityText7:
	text_asm
	ld hl, SeviiFiveIslandCityTrainerHeader1
	jr SeviiFiveIslandCity_TalkToTrainer

SeviiFiveIslandCityBattleText1:
	text_far _SeviiFiveIslandCityBattleText1
	text_end

SeviiFiveIslandCityEndBattleText1:
	text_far _SeviiFiveIslandCityEndBattleText1
	text_end

SeviiFiveIslandCityAfterBattleText1:
	text_far _SeviiFiveIslandCityAfterBattleText1
	text_end

; ---------------------------------------

SeviiFiveIslandCityText8:
	text_asm
	ld hl, SeviiFiveIslandCityTrainerHeader2
	jr SeviiFiveIslandCity_TalkToTrainer

SeviiFiveIslandCityBattleText2:
	text_far _SeviiFiveIslandCityBattleText2
	text_end

SeviiFiveIslandCityEndBattleText2:
	text_far _SeviiFiveIslandCityEndBattleText2
	text_end

SeviiFiveIslandCityAfterBattleText2:
	text_far _SeviiFiveIslandCityAfterBattleText2
	text_end

; ---------------------------------------

SeviiFiveIslandCityText9:
	text_asm
	ld hl, SeviiFiveIslandCityTrainerHeader3
	jr SeviiFiveIslandCity_TalkToTrainer

SeviiFiveIslandCityBattleText3:
	text_far _SeviiFiveIslandCityBattleText3
	text_end

SeviiFiveIslandCityEndBattleText3:
	text_far _SeviiFiveIslandCityEndBattleText3
	text_end

SeviiFiveIslandCityAfterBattleText3:
	text_far _SeviiFiveIslandCityAfterBattleText3
	text_end

; ---------------------------------------

SeviiFiveIslandCityText10:
	text_asm
	ld hl, SeviiFiveIslandCityTrainerHeader4
	jr SeviiFiveIslandCity_TalkToTrainer

SeviiFiveIslandCityBattleText4:
	text_far _SeviiFiveIslandCityBattleText4
	text_end

SeviiFiveIslandCityEndBattleText4:
	text_far _SeviiFiveIslandCityEndBattleText4
	text_end

SeviiFiveIslandCityAfterBattleText4:
	text_far _SeviiFiveIslandCityAfterBattleText4
	text_end

; ---------------------------------------

SeviiFiveIslandCityText1:
	text_far _SeviiFiveIslandCityText1
	text_end

SeviiFiveIslandCityText2:
	text_far _SeviiFiveIslandCityText2
	text_end

SeviiFiveIslandCityText3:
	text_far _SeviiFiveIslandCityText3
	text_end

SeviiFiveIslandCityText4:
	text_far _SeviiFiveIslandCityText4
	text_end

SeviiFiveIslandCityText5:
	text_far _SeviiFiveIslandCityText5
	text_end

SeviiFiveIslandCityText6:
	text_far _SeviiFiveIslandCityText6
	text_end

; ---------------------------------------

SeviiFiveIslandCitySignText1:
	text_far _SeviiFiveIslandCitySignText1
	text_end

SeviiFiveIslandCitySignText2:
	text_far _SeviiFiveIslandCitySignText2
	text_end

SeviiFiveIslandCitySignText3:
	text_far _SeviiFiveIslandCitySignText3
	text_end

SeviiFiveIslandCitySignText4:
	text_far _SeviiFiveIslandCitySignText4
	text_end

SeviiFiveIslandCitySignText5:
	text_far _SeviiFiveIslandCitySignText5
	text_end

; ---------------------------------------

SeviiFiveIslandCityScriptText1:
	text_far _SeviiFiveIslandCityScriptText1
	text_end

SeviiFiveIslandCityScriptText2:
	text_far _SeviiFiveIslandCityScriptText2
	text_end

SeviiFiveIslandCityScriptText3:
	text_far _SeviiFiveIslandCityScriptText3
	text_end

SeviiFiveIslandCityScriptText4:
	text_far _SeviiFiveIslandCityScriptText4
	text_end

SeviiFiveIslandCityScriptText5:
	text_far _SeviiFiveIslandCityScriptText5
	text_end
