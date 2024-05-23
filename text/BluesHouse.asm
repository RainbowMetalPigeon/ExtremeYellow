_DaisyInitialText::
	text "Hi <PLAYER>!"
	line "<RIVAL> is out at"
	cont "Gramps' lab."

	para "...can you please"
	line "keep an eye on my"
	cont "sibling?"

	para "Gramps' condition"
	line "is making them"
	cont "suffer a lot, but"
	cont "the more I try to"
	cont "help them, the"
	cont "more they push me"
	cont "away..."
	done

_DaisyOfferMapText::
	text "Gramps entrusted"
	line "you with a big"
	cont "quest, isn't it?"

	para "Hehe, I know"
	line "because <RIVAL>"
	cont "told me to not"
	cont "help you..."
	cont "Here, you can"
	cont "have this!"

	para "It will be our"
	line "little secret!"
	prompt

_DaisyPostGiveMapText::
	text "And... please, try"
	line "to not mind"
	cont "<RIVAL>'s"
	cont "attitude, they're"
	cont "not really mad at"
	cont "you."

	para "The worse Gramps'"
	line "condition gets,"
	cont "the more <RIVAL>"
	cont "gets moody and"
	cont "grumpy."

	para "They... I don't"
	line "think they under-"
	cont "stand all that is"
	cont "going on, and"
	cont "they hide pain"
	cont "and confusion"
	cont "under a mask of"
	cont "arrogance and"
	cont "fake self-"
	cont "confidence..."
	done

_GotMapText::
	text "<PLAYER> got a"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_DaisyBagFullText::
	text "You have too much"
	line "stuff with you."
	done

;_DaisyUseMapText:: ; TBE
;	text "Use the TOWN MAP"
;	line "to find out where"
;	cont "you are."
;	done

;_BluesHouseDaisyWalkingText::
;	text "Spending time"
;	line "with your #MON"
;	cont "makes them more"
;	cont "friendly to you."
;	done

_BluesHouseTownMapText::
	text "It's a big map!"
	line "This is useful!"
	done

; new, for the Mega Stone's Clues ------------

_BluesHouseClues_Intro::
	text "Ehy, now that I"
	line "think about it, I"
	cont "may have another"
	cont "something that"
	cont "may be helpful in"
	cont "your quest..."

	para "...or maybe not."
	line "The point is that"
	cont "I don't really"
	cont "know what..."
	cont "they are?"

	para "As you probably"
	line "know, I have a"
	cont "passion for"
	cont "cartography."
	cont "Which is exactly"
	cont "the reason why I"
	cont "had such cool"
	cont "maps of KANTO"
	cont "around, eheh."

	para "Anyway! While I"
	line "was doing some"
	cont "researches, I"
	cont "stumbled upon"
	cont "these cryptic"
	cont "messages."

	para "Long story short,"
	line "they all seem to"
	cont "refer to some"
	cont "kind of treasure,"
	cont "or something of"
	cont "that sort..."

	para "I can't really"
	line "tell you much"
	cont "more, as the"
	cont "sources were"
	cont "obscure."
	prompt

_BluesHouseClues_IntroShort::
	text "Welcome back!"
	line "How's your"
	cont "adventure going?"

	para "Hopefully you'll"
	line "be able to"
	cont "discover all the"
	cont "treasures,"
	cont "whatever they"
	cont "are, hinted by"
	cont "the documents I"
	cont "found out!"
	prompt

_BluesHouseClues_Question::
	text "What clue would"
	line "you like to hear"
	cont "about?"
	done

_BluesHouseClues_Outro::
	text "Come back asking"
	line "me any time you"
	cont "want to hear"
	cont "the clues again!"
	done

_BluesHouseClues_Clue1::
	text "ORIGINS"
	prompt

_BluesHouseClues_Clue2::
	text "DIGGY DIGGY HOLE"
	line "L-U-U-U-U-R-"
	cont "L-U-L-L-D-L-"
	cont "L-L-U-R-L-L."
	prompt

_BluesHouseClues_Clue3::
	text "In the WONDERful"
	line "projection of the"
	cont "ORIGINal one."
	prompt

_BluesHouseClues_Clue4::
	text "REMOTE & ISOLATED"
	line "Do what you want"
	cont "cause you're free"
	cont "3 W"
	cont "11 N"
	cont "4 W"
	cont "12 N"
	cont "21 W"
	cont "2 S"
	cont "6 W"
	cont "20 S"
	cont "5 E"
	cont "6 S"
	cont "5 E"
	cont "2 N"
	prompt

_BluesHouseClues_Clue5::
	text "The forgotten"
	line "corner of"
	cont "the root of"
	cont "everything."
	prompt

_BluesHouseClues_Clue6::
	text "FLY, YOU FOOLS!"
	prompt
