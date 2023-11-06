_MewtwoBattleText::
	text "How do you dare,"
	line "human?!@"
	text_end

; new --------------------------

_TravelerBeforeBattleText::
	text "Salutations"
	line "Got Mewtwo"
	cont "Great training area"
	cont "Rematch!"
	cont "INVERSE or NORMAL?"
	prompt

_TravelerBeforeBattleText2::
	text "Excellent!"
	line "Fight!"
	done

_TravelerPostBattleTextVictory::
	text "Ah!"
	line "You won!"
	prompt

_TravelerPostBattleTextDefeat::
	text "Ah!"
	line "I won!"
	prompt
