ObsidianIsland_Script:
	call EnableAutoTextBoxDrawing
	ld hl, ObsidianIsland_ScriptPointers
	ld a, [wObsidianIslandCurScript]
	call CallFunctionInTable
	ret

ObsidianIsland_ScriptPointers:
	dw ObsidianIslandScript0
	dw ObsidianIslandScript1
	
ObsidianIslandScript0:
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4
	ret nz
	ld hl, CoordsData_ObsidianHouses
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, $16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ld a, $1
	ld [wObsidianIslandCurScript], a
	ret

ObsidianIslandScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	ld a, $0
	ld [wObsidianIslandCurScript], a
	ret

CoordsData_ObsidianHouses:
	dbmapcoord 17,  4
	dbmapcoord 35,  22
	dbmapcoord 35,  26
	dbmapcoord 35,  12 ; mart
	db -1 ; end

ObsidianIsland_TextPointers:
	; before Giovanni's defeat
	dw ObsidianIslandText1_RocketMines
	dw ObsidianIslandText2_RocketSouthBridge1
	dw ObsidianIslandText3_RocketSouthBridge2
	dw ObsidianIslandText5_SouthBridgeSlave1
	dw ObsidianIslandText6_SouthBridgeSlave2
	; after Giovanni's defeat
	dw ObsidianIslandText7_Scientist1
	dw ObsidianIslandText8_Scientist2
	dw ObsidianIslandText9_Officier
	dw ObsidianIslandText10_Citizen1
	dw ObsidianIslandText11_Citizen2
	dw ObsidianIslandText12_Citizen3
	dw ObsidianIslandText13_Citizen4
	; item
	dw PickUpItemText
	; signs
	dw ObsidianIslandTextTest ; welcome
	dw PokeCenterSignText
	dw MartSignText
	dw ObsidianIslandTextTest ; pier
	dw ObsidianIslandTextTest ; forest
	dw ObsidianIslandTextTest ; forest
	dw ObsidianIslandTextTest ; mines
	dw ObsidianIslandTextTest ; warehouse
	; other
	dw ObsidianIslandTextClosedHouse ; 22 = $16

; ----------------- people -----------------

ObsidianIslandText1_RocketMines:
ObsidianIslandText2_RocketSouthBridge1:
ObsidianIslandText3_RocketSouthBridge2:
ObsidianIslandText5_SouthBridgeSlave1:
ObsidianIslandText6_SouthBridgeSlave2:
ObsidianIslandText7_Scientist1:
ObsidianIslandText8_Scientist2:
ObsidianIslandText9_Officier:
ObsidianIslandText10_Citizen1:
ObsidianIslandText11_Citizen2:
ObsidianIslandText12_Citizen3:
ObsidianIslandText13_Citizen4:
	text_far _ObsidianIslandTextTestHuman
	text_end

; ----------------- signs -----------------

ObsidianIslandTextTest:
	text_far _ObsidianIslandTextTest
	text_end

; ----------------- other -----------------

ObsidianIslandTextClosedHouse:
	text_far _ObsidianIslandTextClosedHouse
	text_end