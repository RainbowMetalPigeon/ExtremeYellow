ObsidianIsland_Script:
	jp EnableAutoTextBoxDrawing

ObsidianIsland_TextPointers:
	dw ObsidianIslandText1_RocketMines
	dw ObsidianIslandText2_RocketSouthBridge1
	dw ObsidianIslandText3_RocketSouthBridge2
	dw ObsidianIslandText4_RocketEastBridge
	dw ObsidianIslandText5_SouthBridgeSlave1
	dw ObsidianIslandText6_SouthBridgeSlave2

	dw ObsidianIslandText7_Scientist1
	dw ObsidianIslandText8_Scientist2
	dw ObsidianIslandText9_Officier
	dw ObsidianIslandText10_Citizen1
	dw ObsidianIslandText11_Citizen2
	dw ObsidianIslandText12_Citizen3
	dw ObsidianIslandText13_Citizen4

	dw PickUpItemText

	dw ObsidianIslandTextTest ; welcome
	dw PokeCenterSignText
	dw MartSignText
	dw ObsidianIslandTextTest ; pier
	dw ObsidianIslandTextTest ; forest
	dw ObsidianIslandTextTest ; forest
	dw ObsidianIslandTextTest ; mines
	dw ObsidianIslandTextTest ; warehouse

; ----------------- people -----------------

ObsidianIslandText1_RocketMines:
ObsidianIslandText2_RocketSouthBridge1:
ObsidianIslandText3_RocketSouthBridge2:
ObsidianIslandText4_RocketEastBridge:
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
