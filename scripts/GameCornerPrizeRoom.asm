GameCornerPrizeRoom_Script:
	RPTextChooser GameCornerPrizeRoom_TextPointers, GameCornerPrizeRoom_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

GameCornerPrizeRoom_TextPointers:
	dw CeladonPrizeRoomText1
	dw CeladonPrizeRoomText2
	dw CeladonPrizeRoomText3
	dw CeladonPrizeRoomText3
	dw CeladonPrizeRoomText3

GameCornerPrizeRoom_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	; signs (for prizes)
	dw CeladonPrizeRoomText3
	dw CeladonPrizeRoomText3
	dw CeladonPrizeRoomText3

CeladonPrizeRoomText1:
	text_far _CeladonPrizeRoomText1
	text_end

CeladonPrizeRoomText2:
	text_far _CeladonPrizeRoomText2
	text_end

CeladonPrizeRoomText3:
	script_prize_vendor
