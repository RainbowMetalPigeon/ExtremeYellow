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
	text "I came here from"
	line "BOON ISLET. It's"
	cont "a long trip to"
	cont "meet my partner"
	cont "and my meta, but"
	cont "it's worth it."

	para "I miss a bit my"
	line "spouse and our"
	cont "kid, though, but"
	cont "I know they're"
	cont "also enjoying"
	cont "their 'them time'."
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsText2::
	text "I can't afford a"
	line "SEVII TICKET, so"
	cont "it's my partner"
	cont "visiting us."
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsText3::
	text "With TEAM ROCKET"
	line "running around,"
	cont "SAFFRON was"
	cont "unliveable!"

	para "I'm so glad that"
	line "scum is gone."
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
	text "I don't care about"
	line "TV. I wanna be my"
	cont "own protagonist."
	cont "Videogames are so"
	cont "much better!"

	para "Right now I'm play-"
	line "ing this Monster"
	cont "Collector where"
	cont "you record the"
	cont "creatures instead"
	cont "of catching 'em."
	cont "It's amazing! The"
	cont "plot, characters,"
	cont "world, music, and"
	cont "mechanics, they're"
	cont "all so great!"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsText6::
	text "I like plants."

	para "I REALLY like"
	line "plants."

	para "...maybe I like"
	line "plants a bit too"
	cont "much. I think I"
	cont "don't have a bed"
	cont "anymore..."
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsSignText1_FromBelow::
	text "Ducks! Living"
	line "adventures!"

	para "They're so cute but"
	line "also amazing and"
	cont "cool and fun!"

	para "But now it's time"
	line "to go and live"
	cont "our own adventure!"
;	xxxx "123456789012345678"
	done

_SaffronNewApartmentsSignText1_NotFromBelow::
	text "Maybe this is not"
	line "the best side to"
	cont "watch TV."
;	xxxx "123456789012345678"
	done
