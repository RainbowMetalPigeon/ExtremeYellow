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

_DaisyUseMapText:: ; TBE
	text "Use the TOWN MAP"
	line "to find out where"
	cont "you are."
	done

_BluesHouseDaisyWalkingText::
	text "Spending time"
	line "with your #MON"
	cont "makes them more"
	cont "friendly to you."
	done

_BluesHouseTownMapText::
	text "It's a big map!"
	line "This is useful!"
	done
