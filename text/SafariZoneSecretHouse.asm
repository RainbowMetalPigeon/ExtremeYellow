_SecretHouseText_4a350::
	text "Ah! Finally!"

	para "You're the first"
	line "person to reach"
	cont "the SECRET HOUSE!"

	para "I was getting"
	line "worried that no"
	cont "one would win our"
	cont "campaign prize."

	para "Congratulations!"
	line "You have won!"
	prompt

_ReceivedLunarRelicText::
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_LunarRelicExplanationText::
	text "This LUNAR RELIC"
	line "is a treasure of"
	cont "priceless value!"

	para "It is a unique"
	line "artifact whose"
	cont "origins are still"
	cont "unknown, but it"
	cont "is voiced to have"
	cont "some connection"
	cont "with the Moon"
	cont "itself."

	para "Some even say it's"
	line "carved out of a"
	cont "single gigantic"
	cont "MOON STONE!"

	para "Its exact place of"
	line "discovery has now"
	cont "been lost to"
	cont "time."
	para "Rumors say it"
	line "was found in"
	cont "MT. MOON."
	done

_LunarRelicNoRoomText::
	text "You don't have"
	line "room for this"
	cont "fabulous prize!"
	done
