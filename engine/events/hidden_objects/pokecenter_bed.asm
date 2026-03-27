UsePokemonCenterBed::
	call EnableAutoTextBoxDrawing
	tx_pre_jump SleepTillNextPhaseText

SleepTillNextPhaseText::
	text_asm
	ld hl, SleepTillNextPhaseText_Core
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .takeANap
	ld hl, ImNotSleepyText
	jr .printAndEnd
.takeANap
	ld hl, SleepBagText2
	call PrintText
	call WaitForTextScrollButtonPress ; wait for button press
	callfar ChangeDayNightPhase
	ld hl, ItWasAGoodRestText
.printAndEnd
	call PrintText
	jp TextScriptEnd

SleepTillNextPhaseText_Core:
	text_far _SleepTillNextPhaseText
	text_end

SleepBagText2:
	text_far _SleepBagText
	text_end

ImNotSleepyText:
	text_far _ImNotSleepyText
	text_end

ItWasAGoodRestText:
	text_far _ItWasAGoodRestText
	text_end
