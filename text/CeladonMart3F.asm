_CeladonMart3Text2::
	text "Captured #MON"
	line "are registered"
	cont "with an ID No."
	cont "and OT, the name"
	cont "of the Original"
	cont "Trainer that"
	cont "caught it!"
	done

_CeladonMart3Text3::
	text "All right!"

	para "My buddy's going"
	line "to trade me their"
	cont "KANGASKHAN for my"
	cont "GRAVELER!"
	done

_CeladonMart3Text4::
	text "Come on GRAVELER!"

	para "I love GRAVELER!"
	line "I collect them!"

	para "Huh?"

	para "GRAVELER turned"
	line "into a different"
	cont "#MON!"
	done

_CeladonMart3Text5::
	text "You can identify"
	line "#MON you got"
	cont "in trades by"
	cont "their ID Numbers!"
	done

_CeladonMart3Text6:: ; edited
	text "It's a Switch!"
	done

_CeladonMart3Text7::
	text "An RPG! There's"
	line "no time for that!"
	done

_CeladonMart3Text9:: ; edited
	text "A sports game!"
	line "DAD would have"
	cont "liked that..."
	done

_CeladonMart3Text11::
	text "A puzzle game!"
	line "Looks addictive!"
	done

_CeladonMart3Text13::
	text "A fighting game!"
	line "Looks tough!"
	done

_CeladonMart3Text14::
	text "3F: TV GAME SHOP"
	done

_CeladonMart3Text15:: ; edited
	text "RED, BLUE, YELLOW!"

	para "GOLD, SILVER"
	line "CRYSTAL!"

	para "RUBY, SAPPHIRE,"
	line "EMERALD!"

	para "DIAMOND, PEARL,"
	line "PLATINUM!"

	para "BLACK, WHITE,"
	line "BLACK2, WHITE2!"

	para "...aftewards they"
	line "become a bit"
	cont "lame."
	done

_TM18PreReceiveText::
	text "Oh, hi! I finally"
	line "finished #MON!"

	para "Not done yet?"
	line "This might be"
	cont "useful!"
	prompt

_ReceivedTM18Text::
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_TM18ExplanationText::
	text "TM18 contains"
	line "FLASH CANNON!"
	cont "It's a recently"
	cont "discovered move,"
	cont "and may help you"
	cont "greatly!"
	done

_TM18NoRoomText::
	text "Your pack is full"
	line "of items!"
	done
