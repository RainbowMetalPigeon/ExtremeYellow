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

_ReceivedHM04Text::
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_HM04ExplanationText::
	text "HM04 is STRENGTH!"

	para "It lets #MON"
	line "move boulders"
	cont "when you're out-"
	cont "side of battle."

	para "And, this HM isn't"
	line "disposable! You"
	cont "can use it over"
	cont "and over!"

	para "You're super lucky"
	line "for winning this"
	cont "fabulous prize!"
	done

_HM04NoRoomText::
	text "You don't have"
	line "room for this"
	cont "fabulous prize!"
	done
