SafariZoneGate_Script:
	RPTextChooser SafariZoneGate_TextPointers, SafariZoneGate_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, SafariZoneGate_ScriptPointers
	ld a, [wSafariZoneGateCurScript]
	call CallFunctionInTable
	ret

SafariZoneGate_ScriptPointers:
	dw .SafariZoneEntranceScript0
	dw .SafariZoneEntranceScript1
	dw .SafariZoneEntranceScript2
	dw .SafariZoneEntranceScript3
	dw .SafariZoneEntranceScript4
	dw .SafariZoneEntranceScript5
	dw .SafariZoneEntranceScript6

.SafariZoneEntranceScript0
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	ret nz
; BTV
	ld hl, .CoordsData_75221
	call ArePlayerCoordsInArray
	ret nc
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	xor a
	ldh [hJoyHeld], a
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, [wCoordIndex]
	cp $1
	jr z, .asm_7520f
	ld a, $2
	ld [wSafariZoneGateCurScript], a
	ret
.asm_7520f
	ld a, D_RIGHT
	ld c, $1
	call SafariZoneEntranceAutoWalk
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $1
	ld [wSafariZoneGateCurScript], a
	ret

.CoordsData_75221:
	dbmapcoord  3,  2
	dbmapcoord  4,  2
	db -1 ; end

.SafariZoneEntranceScript1
	call SafariZoneEntranceScript_DidWeFinishAutowalking
	ret nz
.SafariZoneEntranceScript2
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	call UpdateSprites
	ld a, $4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ret

.SafariZoneEntranceScript3
	call SafariZoneEntranceScript_DidWeFinishAutowalking
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, $5
	ld [wSafariZoneGateCurScript], a
	ret

.SafariZoneEntranceScript5
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	CheckAndResetEvent EVENT_SAFARI_GAME_OVER
	jr z, .asm_7527f
	ResetEventReuseHL EVENT_IN_SAFARI_ZONE
	call UpdateSprites
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $6
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wNumSafariBalls], a
	ld [wSafariSteps], a
	ld a, D_DOWN
	ld c, $3
	call SafariZoneEntranceAutoWalk
	ld a, $4
	ld [wSafariZoneGateCurScript], a
	jr .asm_75286
.asm_7527f
	ld a, $5 ; leaving early?
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.asm_75286
	ret

.SafariZoneEntranceScript4
	call SafariZoneEntranceScript_DidWeFinishAutowalking
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, $0
	ld [wSafariZoneGateCurScript], a
	ret

.SafariZoneEntranceScript6
	call SafariZoneEntranceScript_DidWeFinishAutowalking
	ret nz
	call Delay3
	ld a, [wcf0d]
	ld [wSafariZoneGateCurScript], a
	ret

SafariZoneEntranceAutoWalk:
	push af
	ld b, 0
	ld a, c
	ld [wSimulatedJoypadStatesIndex], a
	ld hl, wSimulatedJoypadStatesEnd
	pop af
	call FillMemory
	jp StartSimulatingJoypadStates

SafariZoneEntranceScript_DidWeFinishAutowalking:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret

SafariZoneGate_TextPointers:
	dw SafariZoneEntranceText1
	dw SafariZoneEntranceText2
	; scripts
	dw SafariZoneEntranceText1
	dw SafariZoneEntranceText4
	dw SafariZoneEntranceText5
	dw SafariZoneEntranceText6

SafariZoneGate_TextPointers_Rocket:
	dw SafariZoneEntranceText1 ; TBE
	dw SafariZoneEntranceText2 ; TBE

SafariZoneEntranceText1:
	text_far _SafariZoneEntranceText1
	text_end

SafariZoneEntranceText4:
	text_asm
	callfar Func_f1f77
	jp TextScriptEnd

SafariZoneEntranceText5:
	text_far SafariZoneEntranceText_LeavingEarly
	text_asm
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .notLeavingEarly
	ld hl, SafariZoneEntranceText_PleaseReturnBalls
	call PrintText
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, D_DOWN
	ld c, $3
	call SafariZoneEntranceAutoWalk
	ResetEvents EVENT_SAFARI_GAME_OVER, EVENT_IN_SAFARI_ZONE
	ld a, $0
	ld [wcf0d], a
	jr .loadNextScript
.notLeavingEarly
	ld hl, SafariZoneEntranceText_753c0
	call PrintText
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, D_UP
	ld c, $1
	call SafariZoneEntranceAutoWalk
	ld a, $5
	ld [wcf0d], a
.loadNextScript
	ld a, $6
	ld [wSafariZoneGateCurScript], a
	jp TextScriptEnd

SafariZoneEntranceText_PleaseReturnBalls:
	text_far _SafariZoneEntranceText_PleaseReturnBalls
	text_end

SafariZoneEntranceText_753c0:
	text_far _SafariZoneEntranceText_753c0
	text_end

SafariZoneEntranceText6:
	text_far _SafariZoneEntranceText_753c5
	text_end

SafariZoneEntranceText2:
	text_asm
	callfar Func_f203e
	jp TextScriptEnd

; new for RP ====================================

OpenUpSouthObsidianBridge::
	SetEvent EVENT_RP_BRIDGE_COMPLETED
	call HideNPCs_SafariPoaching_RP
	jp HideNPCsExtra_SafariPoaching_RP ; could fallthrough but this way it's cleaner

HideNPCs_SafariPoaching_RP:
	ld hl, NPCsToHideSafariPoaching
.hideLoop
	ld a, [hli]
	cp $ff ; have we run out of NPCs to hide?
	ret z ; if so, we're done
	push hl
	ld [wMissableObjectIndex], a
	predef HideObject
	pop hl
	jr .hideLoop

NPCsToHideSafariPoaching:
	db HS_SAFARI_ZONE_GATE_GUARD_1
	db HS_SAFARI_ZONE_GATE_GUARD_2
	db $ff

HideNPCsExtra_SafariPoaching_RP:
	ld hl, NPCsToHideSafariPoachingExtra
.hideLoop
	ld a, [hli]
	cp $ff ; have we run out of NPCs to hide?
	ret z ; if so, we're done
	push hl
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	pop hl
	jr .hideLoop

NPCsToHideSafariPoachingExtra:
	db HS_OBSIDIAN_ISLAND_ROCKET_2
	db HS_OBSIDIAN_ISLAND_ROCKET_3
	db HS_OBSIDIAN_ISLAND_SLAVE_1
	db HS_OBSIDIAN_ISLAND_SLAVE_2
	db HS_SAFARI_ZONE_NORTH_GUARD_1
	db HS_SAFARI_ZONE_NORTH_GUARD_2
	db HS_FUCHSIA_CITY_ROCKET_SAFARI
	db $ff
