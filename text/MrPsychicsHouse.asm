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
	text "SABRINA: I could"
	line "tell you I'm"
	cont "surprised to see"
	cont "you here, but"
	cont "we'd both know it"
	cont "wouldn't be true,"
	cont "right?"

	para "I like hanging out"
	line "with MX.PSYCHIC."
	cont "Our conversations"
	cont "are..."
	cont "ESP-ecially"
	cont "interesting,"
	cont "eheh."

	para "Today I feel..."
	line "bizarre. I have a"
	cont "roaring desire"
	cont "for fighting! I"
	cont "challenge you to"
	cont "an INVERSE"
	cont "BATTLE!"
	done

_SaffronHouse2SabrinaPostBattleText::
	text "Yes! That"
	line "was a blast!"
	cont "Thank you!"
	prompt
