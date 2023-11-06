OchreWonderland_Script:
	jp EnableAutoTextBoxDrawing

OchreWonderland_TextPointers:
	dw OchreWonderlandTextBlue
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw OchreWonderlandTextEevee
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw OchreWonderland_Sign1
	dw OchreWonderland_Sign2

OchreWonderland_Sign1:
	text_far _OchreWonderland_Sign1
	text_end

OchreWonderland_Sign2:
	text_far _OchreWonderland_Sign2
	text_end

; ------------------------------------------------

OchreWonderlandTextBlue:
	text_asm
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic

	ld hl, BlueBeforeBattleText
	CheckEvent EVENT_1ST_SPOKE_WITH_WONDERLAND_BLUE
	jr z, .goPrint
	ld hl, BlueBeforeBattleTextShort
.goPrint
	call PrintText
	SetEvent EVENT_1ST_SPOKE_WITH_WONDERLAND_BLUE

	callfar NormalInverseChoice
	ld a, [wCurrentMenuItem]
	ld [wInverseBattle], a

	; we select the team now so that we can modify the message accordingly
.loop
	call Random
	cp 25 ; there are 25 teams to choose from
	jr nc, .loop ; we force a to be in the range [0,24]
	ld b, 7 ; the offset for the random rematch team
	add b ; we add b to a, so now a is in the range [7,31]
	ld [wTrainerNo], a

	ld hl, BlueBeforeBattleText2Normal
	cp 29 ; a-39: if there is a carry, normal team; otherwise, tough one (last 3 teams, 29/30/31, have 5 megas)
	jr c, .continue
	ld hl, BlueBeforeBattleText2Tough
.continue
	call PrintText

	; they seem to do nothing?
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]

	ld hl, wOptions
	res 7, [hl]		; Turn on battle animations to make the battle feel more epic.

	call Delay3
	ld a, OPP_RIVAL3
	ld [wCurOpponent], a

	ld hl, BluePostBattleTextVictory
	ld de, BluePostBattleTextDefeat
	call SaveEndBattleTextPointers
	jp TextScriptEnd

BlueBeforeBattleText:
	text_far _BlueBeforeBattleText
	text_end

BlueBeforeBattleTextShort:
	text_far _BlueBeforeBattleTextShort
	text_end

BlueBeforeBattleText2Normal:
	text_far _BlueBeforeBattleText2Normal
	text_end

BlueBeforeBattleText2Tough:
	text_far _BlueBeforeBattleText2Tough
	text_end

BluePostBattleTextVictory:
	text_far _BluePostBattleTextVictory
	text_end

BluePostBattleTextDefeat:
	text_far _BluePostBattleTextDefeat
	text_end

; ------------------------------------------------

OchreWonderlandTextEevee:
	text_asm
	lb bc, EEVEE, 40
	call GivePokemon
	jr nc, .party_full
	ld a, HS_OCHRE_WONDERLAND_EEVEE
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
.party_full
	jp TextScriptEnd
