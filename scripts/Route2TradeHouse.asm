Route2TradeHouse_Script:
	RPTextChooser Route2TradeHouse_TextPointers, Route2TradeHouse_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

Route2TradeHouse_TextPointers:
	dw Route2HouseText1
	dw Route2HouseText2

Route2TradeHouse_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath

Route2HouseText1:
	text_far _Route2HouseText1
	text_end

Route2HouseText2:
	text_asm
	ld a, TRADE_FOR_MILES
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd
