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

; apartments -----------------------

_SaffronNewApartmentsText1::
	text "n1"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsText2::
	text "n2"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsText3::
	text "n3"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsText4_FromAbove::
	text "Hey! Move out!"
	line "You're in the way!"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsText4_NotFromAbove::
	text "TV is good."
	line "More than people."

	para "So? Did you get"
	line "the hint?"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsText5:: ; games
	text "n5"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsText6::
	text "n6"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsSignText1_FromBelow::
	text "ducktales!"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsSignText1_NotFromBelow::
	text "wrong side"
;	xxxx "123456789012345678"
	done
