_TM35PreReceiveText::
	text "Like, have you,"
	line "like, seen all"
	cont "the water that is"
	cont "around here?"

	para "I mean, we're on"
	line "an island, so it"
	cont "is, like, obvious,"
	cont "but it gave me an"
	cont "idea for, like,"
	cont "a powerful TM."
	prompt

_ReceivedTM35Text::
	text "<PLAYER> received "
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_TM35ExplanationText::
	text "HYDRO PUMP!"
	line "It teaches, like,"
	cont "the most powerful"
	cont "WATER move, like."

	para "Someone, like,"
	line "speculates that,"
	cont "like, there is an"
	cont "even stronger move"
	cont "around, but I,"
	cont "like, don't really"
	cont "believe it..."
	done

_TM35NoRoomText::
	text "Your pack is"
	line "crammed full!"
	done

_Lab3Text2::
	text "EEVEE can evolve"
	line "into 1 of 8 kinds"
	cont "of #MON."
	done

_Lab3Text3::
	text "There's an e-mail"
	line "message!"

	para "..."

	para "The 3 legendary"
	line "bird #MON are"
	cont "ARTICUNO, ZAPDOS"
	cont "and MOLTRES."

	para "Their whereabouts"
	line "are unknown."

	para "We plan to explore"
	line "the cavern close"
	cont "to CERULEAN."

	para "From: #MON"
	line "RESEARCH TEAM"

	para "..."
	done

_Lab3Text5::
	text "An amber pipe!"
	done
