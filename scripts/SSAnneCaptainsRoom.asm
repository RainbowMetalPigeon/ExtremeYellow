SSAnneCaptainsRoom_Script:
	call SSAnne7Script_6189b
	call EnableAutoTextBoxDrawing
	ld de, SSAnneCaptainsRoom_ScriptPointers
	ld a, [wSSAnneCaptainsRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSSAnneCaptainsRoomCurScript], a
	ret

SSAnneCaptainsRoom_ScriptPointers: ; new, for battle vs Captain
	dw SSAnneCaptainsRoomScript0
	dw SSAnneCaptainsRoomScript1

SSAnneCaptainsRoomScript0: ; new
	ret

SSAnneCaptainsRoomScript1: ; new
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wSSAnneCaptainsRoomCurScript], a
	ld [wCurMapScript], a
	ret
.notDefeated
	ld a, 5
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide Captain and show Jenny
	call GBFadeOutToBlack
	ld a, HS_SS_ANNE_CAPTAINS_ROOM_CAPTAIN
    ld [wMissableObjectIndex], a
    predef HideObjectExtra
	ld a, HS_SS_ANNE_CAPTAINS_ROOM_JENNY
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; Jenny turn and dialogue
	ld hl, LeftWrtJennyCoord
	call ArePlayerCoordsInArray
	jp c, .turnJennyLeft
	ld hl, RightWrtJennyCoord
	call ArePlayerCoordsInArray
	jp c, .turnJennyRight
; third check is unnecessary, and turning is unnecessary too
	jr .goToDialogue
.turnJennyLeft
	ld a, $2
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	jr .goToDialogue
.turnJennyRight
	ld a, $2
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
.goToDialogue
	ld a, 2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wSSAnneCaptainsRoomCurScript], a
	ld [wCurMapScript], a
	ret

LeftWrtJennyCoord:
	dbmapcoord 3,  2
	db -1 ; end

RightWrtJennyCoord:
	dbmapcoord 5,  2
	db -1 ; end

SSAnne7Script_6189b:
	CheckEvent EVENT_GOT_HM01
	ret nz
	ld hl, wd72d
	set 5, [hl]
	ret

SSAnneCaptainsRoom_TextPointers:
	dw SSAnne7Text1 ; captain
	dw SSAnne7TextJenny ; new, Jenny
	dw SSAnne7Text2 ; trash
	dw SSAnne7Text3 ; book
	dw SSAnne7Text5 ; defeated captain

SSAnne7Text1:
	text_asm
; --- beginning, new code for battle vs Captain ---
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH
	jr z, .preExtraBattle
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	ld hl, SSAnne7TextCaptain_PreBattle
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_GENTLEMAN
	ld [wCurOpponent], a
	ld a, 6
	ld [wTrainerNo], a
	ld hl, SSAnne7TextCaptain_Defeat
	ld de, SSAnne7TextCaptain_Defeat
	call SaveEndBattleTextPointers
; script handling
	ld a, 1
	ld [wSSAnneCaptainsRoomCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd
.preExtraBattle ; back to vanilla
; --- end, new code for battle vs Captain ---
	CheckEvent EVENT_GOT_HM01
	jr nz, .got_item
	ld hl, SSAnne7RubText
	call PrintText
	ld hl, ReceivingHM01Text
	call PrintText
	lb bc, HM_CUT, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedHM01Text
	call PrintText
	SetEvent EVENT_GOT_HM01
	ld hl, wd72d
	res 5, [hl]
	jr .done
.bag_full
	ld hl, HM01NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, SSAnne7Text_61932
	call PrintText
.done
	jp TextScriptEnd

SSAnne7RubText:
	text_far _SSAnne7RubText
	text_asm
	ld a, [wAudioROMBank]
	cp BANK("Audio Engine 3")
	ld [wAudioSavedROMBank], a
	jr nz, .asm_61908
	call StopAllMusic
	ld a, BANK(Music_PkmnHealed)
	ld [wAudioROMBank], a
.asm_61908
	ld a, MUSIC_PKMN_HEALED
	ld [wNewSoundID], a
	call PlaySound
.asm_61910
	ld a, [wChannelSoundIDs]
	cp MUSIC_PKMN_HEALED
	jr z, .asm_61910
	call PlayDefaultMusic
	SetEvent EVENT_RUBBED_CAPTAINS_BACK
	ld hl, wd72d
	res 5, [hl]
	jp TextScriptEnd

ReceivingHM01Text:
	text_far _ReceivingHM01Text
	text_end

ReceivedHM01Text:
	text_far _ReceivedHM01Text
	sound_get_key_item
	text_end

SSAnne7Text_61932:
	text_far _SSAnne7Text_61932
	text_end

HM01NoRoomText:
	text_far _HM01NoRoomText
	text_end

SSAnne7Text2:
	text_far _SSAnne7Text2
	text_end

SSAnne7Text3:
	text_far _SSAnne7Text3
	text_end

; new ----------------------------

SSAnne7TextJenny:
	text_far _SSAnne7TextJenny
	text_end

SSAnne7Text5: ; defeated captain
	text_far _SSAnne7Text5
	text_end

SSAnne7TextCaptain_PreBattle:
	text_far _SSAnne7TextCaptain_PreBattle
	text_end

SSAnne7TextCaptain_Defeat:
	text_far _SSAnne7TextCaptain_Defeat
	text_end
