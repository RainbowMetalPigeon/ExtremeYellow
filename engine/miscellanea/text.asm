RandomizeGenericNPCText_RocketPath:: ; TBE: (many?) more texts (2^n?), selections to be adapted
	call EnableAutoTextBoxDrawing
; above or under water?
	ld a, [wCurMapTileset]
	cp UNDERWATER
	jr nz, .notUnderwater
; underwater
	call Random
	and %00000001
	add a
	ld e, a
	ld d, 0
	ld hl, GenericNPCTextUnderwater_RocketPath_Pointers
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a ; hl = address of the text
	jr .printAndEnd
.notUnderwater
	call Random
	and %00000111
	add a
	ld e, a
	ld d, 0
	ld hl, GenericNPCText_RocketPath_Pointers
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a ; hl = address of the text
.printAndEnd
	jp PrintText

GenericNPCText_RocketPath_Pointers:
	dw GenericNPCText_RocketPath_1
	dw GenericNPCText_RocketPath_2
	dw GenericNPCText_RocketPath_3
	dw GenericNPCText_RocketPath_4
	dw GenericNPCText_RocketPath_5
	dw GenericNPCText_RocketPath_6
	dw GenericNPCText_RocketPath_7
	dw GenericNPCText_RocketPath_8

GenericNPCText_RocketPath_1:
	text_far _GenericNPCText_RocketPath_1
	text_end

GenericNPCText_RocketPath_2:
	text_far _GenericNPCText_RocketPath_2
	text_end

GenericNPCText_RocketPath_3:
	text_far _GenericNPCText_RocketPath_3
	text_end

GenericNPCText_RocketPath_4:
	text_far _GenericNPCText_RocketPath_4
	text_end

GenericNPCText_RocketPath_5:
	text_far _GenericNPCText_RocketPath_5
	text_end

GenericNPCText_RocketPath_6:
	text_far _GenericNPCText_RocketPath_6
	text_end

GenericNPCText_RocketPath_7:
	text_far _GenericNPCText_RocketPath_7
	text_end

GenericNPCText_RocketPath_8:
	text_far _GenericNPCText_RocketPath_8
	text_end

GenericNPCTextUnderwater_RocketPath_Pointers:
	dw GenericNPCTextUnderwater_RocketPath_1
	dw GenericNPCTextUnderwater_RocketPath_2

GenericNPCTextUnderwater_RocketPath_1:
	text_far _GenericNPCTextUnderwater_RocketPath_1
	text_end

GenericNPCTextUnderwater_RocketPath_2:
	text_far _GenericNPCTextUnderwater_RocketPath_2
	text_end
	
; ===============================================

RandomizeRocketNPCText_RocketPath:: ; TBE: (many?) more texts (2^n?), selections to be adapted
	call EnableAutoTextBoxDrawing
	CheckEvent EVENT_RP_KILLED_GIOVANNI
	jr z, .preKillGiovanni
; we are the new BOSS
	ld hl, RocketNPCText_RocketPath_Boss
	jr .printAndEnd
.preKillGiovanni
	call Random
	and %00000001
	add a
	ld e, a
	ld d, 0
	ld hl, RocketNPCText_RocketPath_Pointers
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a ; hl = address of the text
.printAndEnd
	call PrintText
	ret

RocketNPCText_RocketPath_Pointers:
	dw RocketNPCText_RocketPath_1
	dw RocketNPCText_RocketPath_2

RocketNPCText_RocketPath_1:
	text_far _RocketNPCText_RocketPath_1
	text_end

RocketNPCText_RocketPath_2:
	text_far _RocketNPCText_RocketPath_2
	text_end

RocketNPCText_RocketPath_Boss:
	text_far _RocketNPCText_RocketPath_Boss
	text_end
