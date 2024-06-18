_DaisyInitialText::
	text "Hi <PLAYER>!"
	line "<RIVAL> is out at"
	cont "Gramps' lab."

	para "Since our parents"
	line "disappeared, they"
	cont "closed quite a"
	cont "lot in"
	cont "themselves..."

	para "On top of that,"
	line "Gramps' condition"
	cont "is worsening, and"
	cont "<RIVAL> is"
	cont "suffering so"
	cont "much."

	para "...sorry, I didn't"
	line "mean to be so"
	cont "gloomy and"
	cont "depressive."

	para "Though, the more I"
	line "try to help them,"
	cont "the more they"
	cont "push me away..."
	cont "Maybe you can"
	cont "support them"
	cont "somehow?"
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
	line "think <RIVAL>"
	cont "understands all"
	cont "that is going on,"
	cont "and they hide"
	cont "pain and"
	cont "confusion under a"
	cont "mask of arrogance"
	cont "and fake"
	cont "selfconfidence..."
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
	cont "found!"
;	xxxx "123456789012345678"
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

_BluesHouseClues_AfterMissingno::
	text "<PLAYER>!"

	para "How did you manage"
	line "to rescue my"
	cont "parents?!"

	para "You have my"
	line "eternal"
	cont "gratitude!"

	para "And not only"
	line "that..."
	cont "Look at <RIVAL>"
	cont "and Gramps! I"
	cont "haven't seen them"
	cont "so happy in"
	cont "years!"
	done

_BluesHouseBlueText::
	text "<PLAYER>!"

	para "I... you..."

	para "...thank you."
	line "Thank you so"
	cont "much."

	para "I want to thank"
	line "you more than I'm"
	cont "able, but also"
	cont "apologize until"
	cont "the end of times"
	cont "for how I treated"
	cont "you recently."

	para "I told you so many"
	line "horrible things"
	cont "that I now regret"
	cont "so deeply, and"
	cont "yet you brought"
	cont "me the best gift"
	cont "I could have"
	cont "never hoped for."

	para "You... you're"
	line "amazing."

	para "Thanks, thanks"
	line "forever."
	done

_BluesHouseBluesDadText::
	text "<PLAYER>!"

	para "I... I have no"
	line "words to express"
	cont "my gratitude."

	para "You saved us all"
	line "from an eternity"
	cont "of hell."

	para "The years in"
	line "that... glitched"
	cont "BOX... are a"
	cont "fuzzy fog of"
	cont "horror."

	para "I had no hope"
	line "whatsoever to"
	cont "ever be reunited"
	cont "with my family,"
	cont "and yet you"
	cont "rescued us all!"

	para "Thanks, thanks"
	line "so so so much."
	done

_BluesHouseBluesMomText::
	text "<PLAYER>!"

	para "I cannot believe"
	line "it! You saved me,"
	cont "my husband, your"
	cont "dad!"

	para "I... this is so"
	line "beautiful to feel"
	cont "unreal."

	para "I never thought"
	line "I'd ever seen my"
	cont "old one and my"
	cont "kids again..."

	para "I owe you my life."
	line "Literally."
	done

_BluesHouseOakText::
	text "<PLAYER>!"

	para "You never cease to"
	line "amaze me!"

	para "You did the"
	line "impossible! My"
	cont "daughter and my"
	cont "son-in-law, you"
	cont "brought them back"
	cont "to me!"

	para "I feel like I am"
	line "reborn again."

	para "All the research"
	line "achievements..."

	para "The LEAGUE"
	line "championship..."

	para "They feel like"
	line "nothing in"
	cont "comparison to the"
	cont "happiness of"
	cont "being reunited"
	cont "with my family."

	para "Thank you. From"
	line "the bottom of my"
	cont "heart, thank you."
	done
