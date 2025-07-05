SeviiOneIslandDock_Script:
	jp EnableAutoTextBoxDrawing

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
