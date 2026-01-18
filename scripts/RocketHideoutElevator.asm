RocketHideoutElevator_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	push hl
	call nz, RocketHideoutElevatorScript_4572c
	pop hl
	bit 7, [hl]
	res 7, [hl]
	call nz, RocketHideoutElevatorScript_4575f
	xor a
	ld [wAutoTextBoxDrawingControl], a
	inc a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret

RocketHideoutElevatorScript_4572c:
	ld hl, wWarpEntries
	ld a, [wWarpedFromWhichWarp]
	ld b, a
	ld a, [wWarpedFromWhichMap]
	ld c, a
	call RocketHideoutElevatorScript_4573a

RocketHideoutElevatorScript_4573a:
	inc hl
	inc hl
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ret

RocketHideoutElevatorScript_LoadFloorsItemList:
	ld hl, RocketHideoutElavatorFloors
	call LoadItemList
	ld hl, RocketHideoutElevatorWarpMaps
	ld de, wElevatorWarpMaps
	ld bc, RocketHideoutElevatorWarpMapsEnd - RocketHideoutElevatorWarpMaps
	call CopyData
	ret

RocketHideoutElavatorFloors:
	db 3 ; #
	db FLOOR_B1F
	db FLOOR_B2F
	db FLOOR_B4F
	db -1 ; end

; These specify where the player goes after getting out of the elevator.
RocketHideoutElevatorWarpMaps:
	; warp number, map id
	db 4, ROCKET_HIDEOUT_B1F
	db 4, ROCKET_HIDEOUT_B2F
	db 2, ROCKET_HIDEOUT_B4F
RocketHideoutElevatorWarpMapsEnd:

RocketHideoutElevatorScript_4575f:
	call Delay3
	farcall ShakeElevator
	ret

RocketHideoutElevator_TextPointers:
	dw RocketHideoutElevatorText1

RocketHideoutElevatorText1:
	text_asm
; new
	CheckEvent EVENT_ROCKET_USED_LIFT_KEY
	jr nz, .elevatorAlreadyActive
; BTV
; check if we have the key
	ld b, LIFT_KEY
	call IsItemInBag
	jr z, .noKey
; yes key
; new code to remove the key once used
	ld a, LIFT_KEY
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_ROCKET_USED_LIFT_KEY
	ld hl, RocketElevatorText_KeyInCard
	call PrintText
; BTV
.elevatorAlreadyActive
	call RocketHideoutElevatorScript_LoadFloorsItemList
	ld hl, RocketHideoutElevatorWarpMaps
	predef DisplayElevatorFloorMenu
	jr .done
.noKey
	ld hl, RocketElevatorText_NeedsKey
	call PrintText
.done
	jp TextScriptEnd

RocketElevatorText_NeedsKey:
	text_far _RocketElevatorText_NeedsKey
	text_waitbutton
	text_end

RocketElevatorText_KeyInCard:
	text_far _RocketElevatorText_KeyInCard
	text_end
