ObsidianHouses_Script:
	call EnableAutoTextBoxDrawing
	ret

ObsidianHouses_TextPointers:
	dw ObsidianHousesTextFlowerEnthusiast
	dw ObsidianHousesTextFishingSuperGuru
	dw ObsidianHousesTextFamily1
	dw ObsidianHousesTextFamily2
	dw ObsidianHousesTextFamily3
	dw ObsidianHousesTextFamily4
	; signs
	dw ObsidianHousesTextFlowerNotes
	dw ObsidianHousesTextFishingBoard
	dw ObsidianHousesTextFishingBoard

; ------------------------

ObsidianHousesTextFlowerEnthusiast:
	text_far _ObsidianHousesTextFlowerEnthusiast
	text_end

ObsidianHousesTextFishingSuperGuru:
	text_far _ObsidianHousesTextFishingSuperGuru
	text_end

ObsidianHousesTextFamily1:
	text_far _ObsidianHousesTextFamily1
	text_end

ObsidianHousesTextFamily2:
	text_far _ObsidianHousesTextFamily2
	text_end

ObsidianHousesTextFamily3:
	text_far _ObsidianHousesTextFamily3
	text_end

ObsidianHousesTextFamily4:
	text_far _ObsidianHousesTextFamily4
	text_end

ObsidianHousesTextFlowerNotes:
	text_far _ObsidianHousesTextFlowerNotes
	text_end

ObsidianHousesTextFishingBoard:
	text_far _ObsidianHousesTextFishingBoard
	text_end
