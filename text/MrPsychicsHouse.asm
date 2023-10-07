_TM29PreReceiveText::
	text "...Wait! Don't"
	line "say a word!"

	para "You wanted this!"
	prompt

_ReceivedTM29Text::
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_TM29ExplanationText::
	text "TM29 is PSYCHIC!"

	para "It can lower the"
	line "target's SPECIAL"
	cont "abilities."
	done

_TM29NoRoomText::
	text "Where do you plan"
	line "to put this?"
	done

; new ------------------------------------------------

_SaffronHouse2SabrinaBeforeBattleText::
;	xxxx "123456789012345678"
	text "Let us have a nice"
	line "INVERSE BATTLE!"
	done

_SaffronHouse2SabrinaPostBattleText::
;	xxxx "123456789012345678"
	text "Thank you" ; need to consider a "SABRINA: " extra space
	line "for the battle!"
	prompt
