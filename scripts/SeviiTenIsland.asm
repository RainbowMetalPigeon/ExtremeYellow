SeviiTenIsland_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiTenIsland_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; scripts ====================================

SeviiTenIsland_ScriptPointers:
	dw SeviiTenIslandScript_0 ;  0
	dw SeviiTenIslandScript_TimeTravelEffects ;  1
	dw SeviiTenIslandScript_YoungOakDialogueAndBattle ;  2
	dw SeviiTenIslandScript_PostBattle ;  3
	
SeviiTenIslandScript_0: ; 0
	ret

SeviiTenIslandScript_TimeTravelEffects:
; stop all music
	call StopAllMusic
; hide ball
	ld a, HS_SEVII_TEN_ISLAND_GS_BALL
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; wait
	ld c, 30
	call DelayFrames
; play sound
	ld a, SFX_SHRINK ; SFX_GET_KEY_ITEM
	call PlaySound
; show sprite celebi
	ld a, HS_SEVII_TEN_ISLAND_CELEBI
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
; exclamation mark?
	ld a, 2
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; dialogue
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; mew cry
	ld a, MEW
	call PlayCry
	call WaitForSoundToFinish
; fade out black
	call GBFadeOutToBlack
; play sound
	ld a, SFX_TELEPORT_ENTER_1
	call PlaySound
; hide celebi
	ld a, HS_SEVII_TEN_ISLAND_CELEBI
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; show chris
	ld a, HS_SEVII_TEN_ISLAND_CHRIS
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
; fade in from black
	call GBFadeInFromBlack
; wait
	ld c, 30
	call DelayFrames
; fade out white
	call GBFadeOutToWhite
; play sound
	ld a, SFX_TELEPORT_ENTER_2
	call PlaySound
; hide chris
	ld a, HS_SEVII_TEN_ISLAND_CHRIS
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; show oak
	ld a, HS_SEVII_TEN_ISLAND_OAK
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
; fade in white
	call GBFadeInFromWhite
; wait
	ld c, 30
	call DelayFrames
; fade out black
	call GBFadeOutToBlack
; play sound
	ld a, SFX_TELEPORT_EXIT_1
	call PlaySound
; hide oak
	ld a, HS_SEVII_TEN_ISLAND_OAK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; show kris
	ld a, HS_SEVII_TEN_ISLAND_KRIS
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
; fade in black
	call GBFadeInFromBlack
; wait
	ld c, 30
	call DelayFrames
; fade out white
	call GBFadeOutToWhite
; play sound
	ld a, SFX_TELEPORT_EXIT_2
	call PlaySound
; hide kris
	ld a, HS_SEVII_TEN_ISLAND_KRIS
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; show young oak
	ld a, HS_SEVII_TEN_ISLAND_YOUNG_OAK
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
; fade in white
	call GBFadeInFromWhite
; turn Young Oak if needed
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_DOWN
	ld c, UP
	ld e, SPRITE_FACING_UP
	jr z, .gotYoungOakFacing
	cp SPRITE_FACING_UP
	ld c, DOWN
	ld e, SPRITE_FACING_DOWN
	jr z, .gotYoungOakFacing
	cp SPRITE_FACING_LEFT
	ld c, RIGHT
	ld e, SPRITE_FACING_RIGHT
	jr z, .gotYoungOakFacing
;	cp SPRITE_FACING_RIGHT
	ld c, LEFT
	ld e, SPRITE_FACING_LEFT
;	jr z, .gotYoungOakFacing
.gotYoungOakFacing
	ld b, STAY
	ld a, 6
	ld d, 6
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes ; new from Engeze
	callfar ChangeSpriteFacing ; new Pigeon approach
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

SeviiTenIslandScript_YoungOakDialogueAndBattle:
; exclamation mark
	ld a, 6
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; dialogue
	ld a, 8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; start battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl] ; turn on battle animations
	set 6, [hl] ; battle style set
	call Delay3
	ld a, OPP_YOUNG_OAK
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiTenIslandYoungOakDefeatedText
	ld de, SeviiTenIslandYoungOakBeatYouText
	call SaveEndBattleTextPointers
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiTenIslandScript_PostBattle:
; did we lose?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiTenIslandResetScriptAfterLoss
; we won ---------
; restart music
	call PlayDefaultMusic
; post-battle Samuel dialogue
	ld a, 9
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; stop all music
	call StopAllMusic
; fade out black
	call GBFadeOutToBlack
; play sound
	ld a, SFX_TELEPORT_ENTER_1
	call PlaySound
; hide young oak
	ld a, HS_SEVII_TEN_ISLAND_YOUNG_OAK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; fade in black
	call GBFadeInFromBlack
; fade out white
	call GBFadeOutToWhite
; play sound
	ld a, SFX_TELEPORT_ENTER_2
	call PlaySound
; show celebi
	ld a, HS_SEVII_TEN_ISLAND_CELEBI
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
; fade in white
	call GBFadeInFromWhite
; celebi dialogue
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; play cry
	ld a, MEW
	call PlayCry
	call WaitForSoundToFinish
; fade out black
	call GBFadeOutToBlack
; play sound
	ld a, SFX_SHRINK
	call PlaySound
; hide celebi
	ld a, HS_SEVII_TEN_ISLAND_CELEBI
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; fade in black
	call GBFadeInFromBlack
; return commands?
; restart music
	call PlayDefaultMusic
	jr SeviiTenIslandResetScriptAfterWin

SeviiTenIslandResetScriptAfterLoss:
	ld a, HS_SEVII_TEN_ISLAND_GS_BALL
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	; fallthrough
SeviiTenIslandResetScriptAfterWin:
	ld a, HS_SEVII_TEN_ISLAND_CELEBI
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_TEN_ISLAND_CHRIS
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_TEN_ISLAND_OAK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_TEN_ISLAND_KRIS
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_TEN_ISLAND_YOUNG_OAK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts ====================================

SeviiTenIsland_TextPointers:
	dw SeviiTenIslandText1 ; 1
	dw SeviiTenIslandTextProxy ; 2
	dw SeviiTenIslandTextProxy ; 3
	dw SeviiTenIslandTextProxy ; 4
	dw SeviiTenIslandTextProxy ; 5
	dw SeviiTenIslandTextProxy ; 6
	; scripts
	dw SeviiTenIslandScriptText1 ; 7, Celebi cry
	dw SeviiTenIslandScriptText2 ; 8, Young Oak pre-battle
	dw SeviiTenIslandScriptText3 ; 9, Young Oak post-battle

SeviiTenIslandText1:
	text_asm
	ld hl, SeviiTenIslandText1_Intro
	call PrintText
; load next script
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTenIslandText1_Intro:
	text_far _SeviiTenIslandText1_Intro
	text_end

SeviiTenIslandTextProxy:
	text_far _SeviiTenIslandTextProxy
	text_end

SeviiTenIslandScriptText1:
	text_far _SeviiTenIslandScriptText1
	text_end

SeviiTenIslandScriptText2:
	text_far _SeviiTenIslandScriptText2
	text_end

SeviiTenIslandScriptText3:
	text_far _SeviiTenIslandScriptText3
	text_end

SeviiTenIslandYoungOakDefeatedText:
	text_far _SeviiTenIslandYoungOakDefeatedText
	text_end

SeviiTenIslandYoungOakBeatYouText:
	text_far _SeviiTenIslandYoungOakBeatYouText
	text_end
