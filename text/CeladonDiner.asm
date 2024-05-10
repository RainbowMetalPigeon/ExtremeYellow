_CeladonDinerText1_OnigiriObtained:: ; new
	text "Our super ONIGIRI"
	line "are adored by"
	cont "humans and"
	cont "#MON alike!"

	para "If you folks eat"
	line "them together,"
	cont "you'll all get at"
	cont "peak shape."

	para "Better than a"
	line "night at the"
	cont "#MON CENTER!"
	done

_CeladonDinerText1_OhYouHaveGutschein:: ; new
	text "Oh! You have a"
	line "GUTSCHEIN from"
	cont "the HOTEL."

	para "Here is your"
	line "packed meal!"
	prompt

_CeladonDinerText1_ReceivedOnigiri:: ; new
	text "<PLAYER> received"
	line "an ONIGIRI BOX!"
	done

_CeladonDinerText1_WeAreOnBreak:: ; new
	text "Hi!"

	para "We're taking a"
	line "break now."
	done

_CeladonDinerText2:: ; edited
	text "Donuts?"
	line "Sandwiches?"

	para "Sorry, we don't"
	line "have anything"
	cont "like that here."

	para "We serve only"
	line "ONIGIRI, our"
	cont "specialty!"
	done

_CeladonDinerText3::
	text "Psst! There's a"
	line "basement under"
	cont "the GAME CORNER."
	done

_CeladonDinerText4:: ; edited
	text "Munch..."

	para "The person at that"
	line "table lost it all"
	cont "at the slots."
	done

_CeladonDinerText_491a7::
	text "Go ahead! Laugh!"

	para "I'm flat out"
	line "busted!"

	para "No more slots for"
	line "me! I'm going"
	cont "straight!"

	para "Here! I won't be"
	line "needing this any-"
	cont "more!"
	prompt

_ReceivedCoinCaseText::
	text "<PLAYER> received"
	line "a @"
	text_ram wStringBuffer
	text "!@"
	text_end

_CoinCaseNoRoomText::
	text "Make room for"
	line "this!"
	done

_CeladonDinerText_491b7::
	text "I always thought"
	line "I was going to"
	cont "win it back..."
	done
