_LavenderHouse1Text_1d8d1::
	text "That's odd, MX.FUJI"
	line "isn't here."
	cont "Where'd they go?"
	done

_LavenderHouse1Text_1d8d6::
	text "MX.FUJI had been"
	line "praying alone for"
	cont "CUBONE's mother."
	done

_LavenderHouse1Text_1d8f4::
	text "This is really"
	line "MX.FUJI's house."

	para "They're really"
	line "kind!"

	para "They look after"
	line "abandoned and"
	cont "orphaned #MON!"
	done

_LavenderHouse1Text_1d8f9::
	text "It's so warm!"
	line "#MON are so"
	cont "nice to hug!"
	done

_LavenderHouse1Text3::
	text "PSYDUCK: Gwappa!@"
	text_end

_LavenderHouse1Text4::
	text "NIDORINO: Gaoo!@"
	text_end

_LavenderHouse1Text_BeforeGivingFlute::
	text "MX.FUJI: <PLAYER>."

	para "Your #DEX quest"
	line "may fail without"
	cont "love for your"
	cont "#MON."

	para "I think this may"
	line "help your quest."
	prompt

_LavenderHouse1Text_MegaStone:: ; new
	text "MX.FUJI: <PLAYER>."

	para "You have shown"
	line "both compassion"
	cont "and strength."

	para "Those are traits"
	line "as invaluable as"
	cont "rare in trainers."

	para "I think..."
	line "...that you may"
	cont "be the right one"
	cont "to receive this."
	prompt

_ReceivedFluteText::
	text "<PLAYER> received"
	line "a @"
	text_ram wStringBuffer
	text "!@"
	text_end

_SeviiTicketExplanationText:: ; TBE
	text_start
	para "Upon hearing #"
	line "FLUTE, sleeping"
	cont "#MON will"
	cont "spring awake."

	para "It works on all"
	line "sleeping #MON."
	done

_MegaStoneXExplanationText::
	text_start
	para "It will be up to"
	line "you to discover"
	cont "how to use it at"
	cont "its absolute best."
	done

_FluteOrStoneNoRoomText::
	text "You must make"
	line "room for this!"
	done

_MrFujiAfterFluteAndStoneText::
	text "MX.FUJI: Has my"
	line "FLUTE helped you?"

	; new
	para "And have you found"
	line "a way to use that"
	cont "mysterious stone?"
	done

_LavenderHouse1Text6:: ; edited
	text "That's number 25"
	line "of the GAME FREAK"
	cont "magazine!"

	para "There's a kid"
	line "happily playing,"
	cont "and a number of"
	cont "funny creatures."

	para "One of them looks"
	line "like a bit like a"
	cont "familiar mouse..."
	done
