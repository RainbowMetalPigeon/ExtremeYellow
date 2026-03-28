Route7_Script:
	call EnableAutoTextBoxDrawing
	ret

Route7_TextPointers:
	dw PickUpItemText ; new, LINK_CABLE
	dw Route7RepairPersonText ; new
	dw Route7Text1

Route7Text1:
	text_far _Route7Text1
	text_end

Route7RepairPersonText: ; new
	text_asm
; first time?
	CheckEvent EVENT_SPOKEN_WITH_REPAIR_PERSON
	ld hl, Route7RepairPersonText_NotFirstTime
	jr nz, .continue
; first time
	SetEvent EVENT_SPOKEN_WITH_REPAIR_PERSON
	ld hl, Route7RepairPersonText_FirstTime
.continue
	call PrintText
; have screwdriver?
	ld b, SCREWDRIVER
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .done
; have screwdriver
	call WaitForTextScrollButtonPress
	ld hl, Route7RepairPersonText_YouFoundIt
	call PrintText
	call GBFadeOutToBlack
	ld a, SCREWDRIVER
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_FIXED_MATCHA_MACHINE
	ld a, HS_ROUTE_7_REPAIR_PERSON
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jr .done
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

Route7RepairPersonText_NotFirstTime:
	text_far _Route7RepairPersonText_NotFirstTime
	text_end

Route7RepairPersonText_FirstTime:
	text_far _Route7RepairPersonText_FirstTime
	text_end

Route7RepairPersonText_YouFoundIt:
	text_far _Route7RepairPersonText_YouFoundIt
	text_end
