SunkenShip1F_Script:
	call EnableAutoTextBoxDrawing
	ret

; scripts ====================================================

; texts ====================================================

SunkenShip1F_TextPointers:
	; top floor
	dw LockedDoorText_TopFloorRoom4
	dw DoorCantBeOpenedText
	dw DoorCantBeOpenedText
	dw LockedDoorText_TopFloorRoom7
	; mid floor
	dw LockedDoorText_MidFloorRoom2
	dw DoorCantBeOpenedText
	dw LockedDoorText_MidFloorRoom5
	dw DoorCantBeOpenedText
	; bottom floor
	dw DoorCantBeOpenedText
	dw LockedDoorText_BottomFloorRoom2
	dw DoorCantBeOpenedText
	dw DoorCantBeOpenedText
	dw LockedDoorText_BottomFloorRoom8

LockedDoorText_TopFloorRoom4: ; TBE
	text_far _LockedDoorText_TopFloorRoom4
	text_end

LockedDoorText_TopFloorRoom7: ; TBE
	text_far _LockedDoorText_TopFloorRoom7
	text_end

LockedDoorText_MidFloorRoom2: ; TBE
	text_far _LockedDoorText_MidFloorRoom2
	text_end

LockedDoorText_MidFloorRoom5: ; TBE
	text_far _LockedDoorText_MidFloorRoom5
	text_end

LockedDoorText_BottomFloorRoom2: ; TBE
	text_far _LockedDoorText_BottomFloorRoom2
	text_end

LockedDoorText_BottomFloorRoom8: ; TBE
	text_far _LockedDoorText_BottomFloorRoom8
	text_end

DoorCantBeOpenedText:
	text_far _DoorCantBeOpenedText
	text_end
