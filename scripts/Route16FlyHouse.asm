Route16FlyHouse_Script:
	RPTextChooser Route16FlyHouse_TextPointers, Route16FlyHouse_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, Route16FlyHouse_ScriptPointers
	ld a, [wCurMapScript]
	call CallFunctionInTable
	ret

; scripts ==============================

Route16FlyHouse_ScriptPointers:
	dw Route16FlyHouseScript0
	dw Route16FlyHouseScript_PostPokemonBattle

Route16FlyHouseScript0:
	ret

Route16FlyHouseScript_PostPokemonBattle:
	ld a, [wIsInBattle]
	cp $ff
	jr z, Route16FlyHouseResetScripts
	ld a, [wBattleResult] ; to check if we ran: 0 = win, 1 = lose, 2 = draw/run
	and a
	jr nz, Route16FlyHouseResetScripts
; we won
	SetEvent EVENT_RP_BEAT_ROUTE_16_FLY_HOUSE_FEAROW
; exclamation bubble
	ld a, 1
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; print message
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; fallthrough

Route16FlyHouseResetScripts:
	ResetEvent EVENT_CANNOT_USE_ITEMS_IN_BATTLE
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts ================================

Route16FlyHouse_TextPointers:
	dw Route16HouseText1
	dw Route16HouseText2 ; Mon

Route16FlyHouse_TextPointers_Rocket:
	dw Route16HouseText1_RP
	dw Route16HouseText2_RP ; Mon
	; scripts
	dw Route16HouseScriptText1_RP

Route16HouseText1: ; edited
	text_asm
	CheckEvent EVENT_GOT_HM02
	ld hl, HM02ExplanationText
	jr nz, .printAndEnd
; we don't have the item yet
	ld hl, Route16HouseText3 ; intro
	call PrintText
; check if have cookie
	ld b, SEVII_COOKIE
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .done ; no cookie
;.haveCookie
	call WaitForTextScrollButtonPress
	ld hl, Route16HouseText_YesCookie
	call PrintText
; bag not full
	ld a, SEVII_COOKIE
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_GOT_HM02
	ld hl, ReceivedHM02Text
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

Route16HouseText_NoCookie:
	text_far _Route16HouseText_NoCookie
	text_end

Route16HouseText_YesCookie:
	text_far _Route16HouseText_YesCookie
	text_end

Route16HouseText3:
	text_far _Route16HouseText3
	text_end

ReceivedHM02Text:
	text_far _ReceivedHM02Text
	sound_get_key_item
	text_end

HM02ExplanationText:
	text_far _HM02ExplanationText
	text_end

Route16HouseText2:
	text_asm
	ld hl, Route16HouseText_1e652
	call PrintText
	ld a, FEAROW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

Route16HouseText_1e652:
	text_far _Route16HouseText_1e652
	text_end

; new for RP --------------------

Route16HouseText2_RP:
	text_asm
; did we obtain the Fly HM?
	CheckEvent EVENT_GOT_HM02
	jr z, .checkIfBeatFearow
	ld hl, Route16HouseText2_RP_PostHM
	call PrintText
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 28
	ld b, FEAROW
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_ROUTE_16_FLY_HOUSE_MON_1
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	jp TextScriptEnd
.checkIfBeatFearow
; did we beat Fearow already?
	CheckEvent EVENT_RP_BEAT_ROUTE_16_FLY_HOUSE_FEAROW
	jr z, .triggerBattle
	ld hl, Route16HouseText2_RP_PostDefeat
	call PrintText
	jp TextScriptEnd
.triggerBattle
; first interaction: trigger "wild" battle
	ld hl, Route16HouseText_1e652
	call PrintText
	ld a, FEAROW
	call PlayCry
	call WaitForSoundToFinish
	SetEvent EVENT_CANNOT_USE_ITEMS_IN_BATTLE
	ld a, FEAROW
	ld [wCurOpponent], a
	ld a, 28
	ld [wCurEnemyLVL], a
	xor a
	ld [wIsTrainerBattle], a
	ld [wJoyIgnore], a
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

Route16HouseText2_RP_PostHM:
	text_far _Route16HouseText2_RP_PostHM
	text_end

Route16HouseText2_RP_PostDefeat:
	text_far _Route16HouseText2_RP_PostDefeat
	text_end

Route16HouseText1_RP:
	text_asm
; stole Fearow?
	CheckHideShowExtra HS_ROUTE_16_FLY_HOUSE_MON_1 ; z flag if is SHOW, nz if is HIDE
	ld hl, Route16HouseText1_RP_PostFearow
	jr nz, .printAndEnd
; obtained Fly?
	CheckEvent EVENT_GOT_HM02 ; abused
	ld hl, Route16HouseText1_RP_PostFly
	jp nz, .printAndEnd
; beaten Fearow?
	CheckEvent EVENT_RP_BEAT_ROUTE_16_FLY_HOUSE_FEAROW
	ld hl, Route16HouseText1_RP_PreFly
	jr z, .printAndEnd
; beaten Fearow: take Fly
	ld hl, Route16HouseText1_RP_TakeFly
	call PrintText
	SetEvent EVENT_GOT_HM02
	ld hl, Route16HouseText1_RP_GotItem
.printAndEnd
	call PrintText
	jp TextScriptEnd

Route16HouseText1_RP_PostFearow:
	text_far _Route16HouseText1_RP_PostFearow
	text_end

Route16HouseText1_RP_PostFly:
	text_far _Route16HouseText1_RP_PostFly
	text_end

Route16HouseText1_RP_TakeFly:
	text_far _Route16HouseText1_RP_TakeFly
	text_end

Route16HouseText1_RP_PreFly:
	text_far _Route16HouseText1_RP_PreFly
	text_end

Route16HouseText1_RP_GotItem:
	text_far _ReceivedHM02Text
	sound_get_key_item
	text_end

Route16HouseScriptText1_RP:
	text_far _Route16HouseScriptText1_RP
	text_end
