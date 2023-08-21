ObsidianIsland_Script:
	jp EnableAutoTextBoxDrawing

ObsidianIsland_TextPointers:
	dw ObsidianIslandTextTest ; welcome
	dw MartSignText
	dw PokeCenterSignText
	dw ObsidianIslandTextTest ; pier
	dw ObsidianIslandTextTest ; forest
	dw ObsidianIslandTextTest ; forest
	dw ObsidianIslandTextTest ; mines
	dw ObsidianIslandTextTest ; warehouse

ObsidianIslandTextTest:
	text_far _ObsidianIslandTextTest
	text_end
