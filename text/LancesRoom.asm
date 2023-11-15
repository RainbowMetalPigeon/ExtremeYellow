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
	text "I salute you,"
	line "CHAMPION."

	para "It is an honor to"
	line "be standing on"
	cont "the battlefield"
	cont "against you one"
	cont "more time."

	para "Your deeds have"
	line "changed this"
	cont "region and its"
	cont "people more than"
	cont "you can imagine."

	para "I am thrilling to"
	line "measure myself"
	cont "with you again."
	cont "I, LANCE,"
	cont "challenge with"
	cont "with my ultimate"
	cont "dragons!"
	done

_LanceEndBattleTextRematch::
	text "That's it!"

	para "You beat the best"
	line "of my best!"
	prompt

_LanceAfterBattleTextRematch::
	text "Despite all my"
	line "efforts, the"
	cont "power of my"
	cont "dragons, and our"
	cont "determination..."
	cont "you won!"

	para "<PLAYER>! You are"
	line "astounding!"

	para "I would love to"
	line "crown you"
	cont "CHAMPION once"
	cont "again..."

	para "But I guess it"
	line "comes as no"
	cont "surprise that"
	cont "there is one more"
	cont "person that is"
	cont "dying to fight"
	cont "against you."

	para "Proceed now, and"
	line "face <RIVAL> in"
	cont "the highest of"
	cont "all battles!@"
	text_end ; why?
