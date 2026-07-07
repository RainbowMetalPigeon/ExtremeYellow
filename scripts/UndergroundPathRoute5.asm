UndergroundPathRoute5_Script:
	RPTextChooser UndergroundPathRoute5_TextPointers, UndergroundPathRoute5_TextPointers_Rocket
	ld a, ROUTE_5
	ld [wLastMap], a
;	ret ; edited
	jp EnableAutoTextBoxDrawing ; edited

UndergroundPathEntranceRoute5_TextScriptEndingText:
	text_end

UndergroundPathRoute5_TextPointers:
	dw UndergroundPathEntranceRoute5Text1

UndergroundPathRoute5_TextPointers_Rocket:
	dw GenericNPCText_RocketPath

UndergroundPathEntranceRoute5Text1:
	text_asm
	ld a, TRADE_FOR_SHELLO ; edited
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	ld hl, UndergroundPathEntranceRoute5_TextScriptEndingText
	ret
