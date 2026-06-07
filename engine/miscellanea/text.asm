RandomizeGenericNPCText_RocketPath:: ; TBE: (many?) more texts (2^n?), selections to be adapted
	call EnableAutoTextBoxDrawing

	call Random
	and %00000001

	ld hl, GenericNPCText_RocketPath_1
	jr nz, .printAndEnd

	ld hl, GenericNPCText_RocketPath_2

.printAndEnd
	call PrintText
	ret

GenericNPCText_RocketPath_1:
	text_far _GenericNPCText_RocketPath_1
	text_end

GenericNPCText_RocketPath_2:
	text_far _GenericNPCText_RocketPath_2
	text_end
