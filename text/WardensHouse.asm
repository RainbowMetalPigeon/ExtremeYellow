; people ------

_WardenGibberishText1::
	text "WARDEN: Hif fuff"
	line "hefifoo!"

	para "Ha lof ha feef ee"
	line "hafahi ho. Heff"
	cont "hee fwee!"
	done

_WardenGibberishText2::
	text "Ah howhee ho hoo!"
	line "Eef ee hafahi ho!"
	done

_WardenGibberishText3::
	text "Ha? He ohay heh"
	line "ha hoo ee haheh!"
	done

_WardenTeethText1::
	text "<PLAYER> gave the"
	line "GOLD TEETH to the"
	cont "WARDEN!@"
	text_end

_WardenTeethText2:: ; edited
	text_start
	para "The WARDEN popped"
	line "in their teeth!"
	prompt

_WardenThankYouText::
	text "WARDEN: Thanks,"
	line "kid! No one could"
	cont "understand a word"
	cont "that I said."

	para "I lost my teeth in"
	line "OBSIDIAN ISLAND"
	cont "when I went there"
	cont "to try and kick"
	cont "out TEAM ROCKET."

	para "Nobody dared to"
	line "challenge them,"
	cont "so I went alone,"
	cont "and dear lord,"
	cont "the beating I"
	cont "received..."

	para "TEAM ROCKET uses"
	line "that island"
	cont "as a base for"
	cont "trafficking the"
	cont "#MON they"
	cont "poach in the"
	cont "SAFARI ZONE."

	para "They send them to"
	line "their CASINO in"
	cont "CELADON CITY as"
	cont "prizes, and to"
	cont "VERMILION CITY so"
	cont "that they can be"
	cont "shipped to other"
	cont "regions as well."

	para "Anyway, thanks so"
	line "much for bringing"
	cont "back my teeth!"
	cont "Let me give you"
	cont "something for"
	cont "your trouble."
	prompt

_ReceivedHM03Text::
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_HM03ExplanationText::
	text "WARDEN: HM03"
	line "teaches SURF!"

	para "#MON will be"
	line "able to ferry you"
	cont "across water!"

	para "Oh yes, did you"
	line "find SECRET HOUSE"
	cont "in SAFARI ZONE?"

	para "If you do, you"
	line "win a prize!"

	para "I heard it's a"
	line "unique treasure"
	cont "of mysterious"
	cont "origins, somehow"
	cont "connected to the"
	cont "Moon itself!"
	done

_BeatGiovanniAmazementText::
	text "What?!"

	para "You fend off TEAM"
	line "ROCKET and freed"
	cont "OBSIDIAN ISLAND,"
	cont "and now the"
	cont "SAFARI ZONE is no"
	cont "longer under the"
	cont "control of those"
	cont "criminals?!"

	para "You are really"
	line "unbelievable!"
	cont "You gave us all"
	cont "hope again! I can"
	cont "go back to work!"

	para "Thank you so"
	line "immensely much!!!"
	done

_HM03NoRoomText::
	text "Your pack is"
	line "stuffed full!"
	done

; new ---

_FuchsiaHouse2AntiquitiesTextShopOwner_PreObsidianGiovanniDefeat::
	text "We're closed!"
	line "No business!"

	para "...the elder"
	line "mumbles something"
	cont "about how TEAM"
	cont "ROCKET ruined"
	cont "their shop..."

	para "Have a nice day!"
	done

_FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoArtifact::
	text "You're interested"
	line "in something? But"
	cont "don't have enough"
;	xxxx "123456789012345678"
	cont "money? I'm sorry,"
	cont "I cannot apply"
	cont "any discount"
	cont "whatsoever."

	para "...the elder"
	line "mumbles something"
	cont "about how poor"
	cont "people should"
	cont "stop wasting"
	cont "their time..."

	para "If you really wish"
	line "something but you"
	cont "can't afford it,"
	cont "I could reduce"
	cont "its price if you"
	cont "bring me some"
	cont "valuable antique"
	cont "item."
	done

_FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesArtifact::
	text "Wait... how did"
	line "you get that"
	cont "ARTIFACT?!"

	para "I tried for years"
	line "to convince that"
	cont "stubborn"
	cont "archeologist to"
	cont "sell it to me,"
	cont "but I never got"
	cont "anything out of"
	cont "them after that"
	cont "splendid LUNAR"
	cont "RELIC!"

	para "...the elder"
	line "mumbles something"
	cont "about how they"
	cont "ended up selling"
	cont "it to the SAFARI"
	cont "ZONE for some"
	cont "cash during a"
	cont "tough time..."

	para "That ARTIFACT! I"
	line "absolutely want"
	cont "it! Although..."
	cont "I don't have"
	cont "much money with"
	cont "me right now."

	para "Could I interest"
	line "you with a trade?"
	cont "What about that"
	cont "mysterious map"
	cont "fragment there on"
	cont "the wall?"
	done

_FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoTrade::
	text "Oh... that's too"
	line "bad. Please"
	cont "reconsider it!"

	para "...the elder"
	line "mumbles something"
	cont "about how youths"
	cont "nowadays can't"
	cont "recognize a good"
	cont "deal when they"
	cont "see one..."

	para "Give it some"
	line "thought. You know"
	cont "where to find me."
	done

_FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesTrade::
	text "Fantastic!"
	line "Let's do this"
	cont "right away!"

	para "...the elder"
	line "mumbles something"
	cont "about how easy it"
	cont "was..."

	para "You made this old"
	line "antique dealer so"
	cont "really happy!"
	prompt

_FuchsiaHouse2AntiquitiesTextShopOwner_PostGivingMap::
	text "Hello there!"
	line "Are you satisfied"
	cont "with our little"
	cont "trade?"

	para "...the elder"
	line "mumbles something"
	cont "about they"
	cont "definitely are"
	cont "extremely"
	cont "satisfied..."

	para "Please come back"
	line "if you discover"
	cont "anything"
	cont "interesting or"
	cont "wish to buy"
	cont "something!"
	done

; ---

_FuchsiaHouse2AntiquitiesText4::
	text "NAUTILUS FOSSIL"

	para "Price: ¥100000000"
	done

_FuchsiaHouse2AntiquitiesText3::
	text "MOSQUITO WITH DINO"
	line "BLOOD IN AMBER"

	para "Price: ¥300000000"
	done

_FuchsiaHouse2AntiquitiesText2::
	text "OPAL FROM"
	line "DREAMTALE CAVE"

	para "Price: ¥500000000"
	done

_FuchsiaHouse2AntiquitiesText5::
	text "MYSTERIOUS HAIR"
	line "FOSSIL, GUYANA"

	para "Price: ¥999000000"
	done

_FuchsiaHouse2AntiquitiesTextMapPiece::
	text "ANCIENT MAP"
	line "FRAGMENT"

	para "Price: ¥42000000"
	done

; signs ------

_FuchsiaHouse2Text_75176::
	text "#MON photos"
	line "and fossils."
	done

_FuchsiaHouse2Text_7517b::
	text "Old #MON"
	line "merchandise."
	done

; new ---

_FuchsiaHouse2AntiquitiesSign1::
	text "MELLANJE ORE,"
	line "POKKE"

	para "Price: ¥1920000"
	done

_FuchsiaHouse2AntiquitiesSign2::
	text "BLACK DRANZER"

	para "Price: ¥6660000"
	done

_FuchsiaHouse2AntiquitiesSign3::
	text "BLEATING COW"
	line "PLUSHIE, 24 Y.A."

	para "Price: ¥INFINITE"
	done

_FuchsiaHouse2AntiquitiesSign4::
	text "SHADOWLESS MINT"
	line "B.S. CHARIZARD"

	para "Price: ¥63200000"
	done

_FuchsiaHouse2AntiquitiesSign5::
	text "MILLENNIUM PUZZLE"

	para "Price: ¥666666666"
	done

_FuchsiaHouse2AntiquitiesSign6::
	text "PHILOSOPHER STONE,"
	line "536329 SOULS"

	para "Price: YOUR BODY"
	done

_FuchsiaHouse2AntiquitiesSign7::
	text "SUUSHINCHUU"

	para "Price: ¥4000000"
	done

_FuchsiaHouse2AntiquitiesSign8::
	text "FIRST CARTRIDGE OF"
	line "#MON GREEN"

	para "Price: ¥9999999999"
	done
