HauntedHouse4_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedHouse4HandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
;	ld hl, HauntedHouse4_ScriptPointers
;	ld a, [wHauntedHouse4CurScript]
;	call CallFunctionInTable
	ret

HauntedHouse4HandleRandomGlitchyBehaviours:
	callfar HauntedHouseHandleRandomGlitchyBehaviours ; testing
	ret

;HauntedHouse4_ScriptPointers:
;	dw HauntedHouse4Script0

;HauntedHouse4Script0:
;	ret

; ============================

HauntedHouse4_TextPointers:
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextPokeBall

HauntedHouse4TextProxy:
	text_far _HauntedHouse4TextProxy
	text_end

HauntedHouse4TextPokeBall:
	text_asm

;	call StopAllMusic
;	ld c, BANK(SFX_Safari_Zone_PA)
;	ld a, SFX_SAFARI_ZONE_PA
;	call PlayMusic
;.waitForMusicToPlay
;	ld a, [wChannelSoundIDs + CHAN5]
;	cp SFX_SAFARI_ZONE_PA
;	jr nz, .waitForMusicToPlay

;	ld hl, OchreCity_Scolded
;	call PrintText

	CheckAndSetEvent EVENT_HAUNTED_HOUSE_INTERACTED_WITH_POKEBALL
	jr nz, .alreadyInteractedWithWarpyBall

	ld a, HAUNTED_HOUSE_1
	ldh [hWarpDestinationMap], a
	ld a, 0 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	jr .doTheWarp

.alreadyInteractedWithWarpyBall
	ld a, HAUNTED_REDS_HOUSE
	ldh [hWarpDestinationMap], a
	ld a, 4 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a

.doTheWarp
;	ld a, ROUTE_25
;	ld [wLastMap], a
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp

	jp TextScriptEnd