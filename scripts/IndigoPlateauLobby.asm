IndigoPlateauLobby_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	call EnableAutoTextBoxDrawing
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	ret z
	ResetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	ld hl, wBeatLorelei
	bit 1, [hl]
	res 1, [hl]
	ret z
	; Elite 4 events
	ResetEventRange INDIGO_PLATEAU_EVENTS_START, EVENT_LANCES_ROOM_LOCK_DOOR
	ret

IndigoPlateauLobby_TextPointers:
	dw IndigoHealNurseText
	dw IndigoPlateauLobbyText2
	dw IndigoPlateauLobbyText3
	dw IndigoCashier1Text
	dw IndigoCashier2Text
	dw IndigoTradeNurseText
	dw IndigoPlateauLobbyText6

IndigoHealNurseText:
	script_pokecenter_nurse

IndigoPlateauLobbyText2:
	text_far _IndigoPlateauLobbyText2
	text_end

IndigoPlateauLobbyText3:
	text_far _IndigoPlateauLobbyText3
	text_end

IndigoTradeNurseText:
	script_cable_club_receptionist

IndigoPlateauLobbyText6:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

IndigoCashier1Text: ; moved and renamed
	script_mart ULTRA_BALL, GREAT_BALL, FULL_RESTORE, MAX_POTION, FULL_HEAL, REVIVE, MAX_REPEL

IndigoCashier2Text: ; testing
    text_asm
	callfar TMMartClerkDialogue
    jp TextScriptEnd
