_LanceBeforeBattleText::
	text "Ah! I heard about"
	line "you, <PLAYER>!"

	para "I lead the ELITE"
	line "FOUR! You can"
	cont "call me LANCE the"
	cont "dragon trainer!"

	para "You know that"
	line "dragons are"
	cont "mythical #MON!"

	para "They're hard to"
	line "catch and raise,"
	cont "but their powers"
	cont "are superior!"

	para "They're virtually"
	line "indestructible!"

	para "Well, are you"
	line "ready to lose?"

	para "Your LEAGUE"
	line "challenge ends"
	cont "with me, <PLAYER>!"
	done

_LanceEndBattleText::
	text "That's it!"

	para "I hate to admit"
	line "it, but you are a"
	cont "#MON master!"
	prompt

_LanceAfterBattleText::
	text "I still can't"
	line "believe my"
	cont "dragons lost to"
	cont "you, <PLAYER>!"

	para "You are now the"
	line "#MON LEAGUE"
	cont "champion!"

	para "...Or, you would"
	line "have been, but"
	cont "you have one more"
	cont "challenge ahead."

	para "You have to face"
	line "another trainer!"
	cont "Their name is..."

	para "<RIVAL>!"
	line "They beat the"
	cont "ELITE FOUR"
	cont "before you!"

	para "They are the real"
	line "#MON LEAGUE"
	cont "champion!@"
	text_end

; new -------------------------------

_LanceBeforeBattleTextRematch::
	text "Rematch Lance"
	line "Pre"
	done

_LanceEndBattleTextRematch::
	text "Rematch Lance"
	line "Post"
	prompt

_LanceAfterBattleTextRematch::
	text "Rematch Lance"
	line "After"
	done
