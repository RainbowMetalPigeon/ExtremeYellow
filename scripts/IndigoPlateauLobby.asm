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

IndigoCashier2Text: ; new
	script_mart TM_MEGA_PUNCH, TM_MEGAHORN, TM_SWORDS_DANCE, TM_COUNTER, TM_DRAGON_CLAW, TM_TOXIC, TM_DARK_PULSE, TM_BODY_SLAM, TM_METEOR_MASH, TM_DOUBLE_EDGE, TM_BUBBLEBEAM, TM_METRONOME, TM_ICE_BEAM, TM_BLIZZARD, TM_HYPER_BEAM, TM_MIRROR_COAT, TM_DRAININGKISS, TM_FLASH_CANNON, TM_SEISMIC_TOSS, TM_FEINT_ATTACK, TM_GIGA_DRAIN, TM_STONE_EDGE, TM_WILL_O_WISP, TM_THUNDERBOLT, TM_THUNDER, TM_EARTHQUAKE, TM_FISSURE, TM_DIG, TM_PSYCHIC_M, TM_MOONBLAST, TM_MIMIC, TM_DOUBLE_TEAM, TM_REFLECT, TM_BIDE, TM_HYDRO_PUMP, TM_SELFDESTRUCT, TM_CLOSE_COMBAT, TM_FIRE_BLAST, TM_SHADOW_SNEAK, TM_OUTRAGE, TM_BRAVE_BIRD, TM_REST, TM_GUNK_SHOT, TM_X_SCISSOR, TM_THUNDER_WAVE, TM_PSYWAVE, TM_EXPLOSION, TM_ROCK_SLIDE, TM_SHADOW_BALL, TM_SUBSTITUTE
