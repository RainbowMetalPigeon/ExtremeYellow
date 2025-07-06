SeviiOneIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ReactivateDebugBUffs
	jp EnableAutoTextBoxDrawing

ReactivateDebugBUffs:
	IF DEF(_DEBUG)
		ld hl, wd732
		set 1, [hl]
	ENDC
	ret
	
SeviiOneIslandDock_TextPointers:
	dw SeviiOneIslandDockText1
;	dw PickUpItemText
;	dw PickUpItemText
;	dw PickUpItemText
	text_end

;SeviiOneIslandDockText3:
;	text_far _SeviiOneIslandDockText3
;	text_end

SeviiOneIslandDockText1:
	text_far _PalletTownText2
;	text_asm
;	SetEvent EVENT_IN_SEVII
;	jp TextScriptEnd
	text_end
