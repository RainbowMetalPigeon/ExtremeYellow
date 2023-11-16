_MoveDeleterGreetingText::
	text "In order to"
	line "progress, we need"
	cont "to be able to"
	cont "empty our minds,"
	cont "to have space to"
	cont "learn new and"
	cont "better things!"

	para "Same goes for"
	line "our #MON!"
	cont "I can make them"
	cont "forget a move."
	cont "Interested?"
	done

_MoveDeleterSaidYesText::
	text "Which #MON"
	line "should forget a"
	cont "move?"
	prompt

_MoveDeleterWhichMoveText::
	text "Which move should"
	line "it forget, then?"
	done

_MoveDeleterConfirmText::
	text "Make it forget"
	line "@"
	text_ram wStringBuffer
	text "?"
	prompt

_MoveDeleterForgotText::
	text "@"
	text_ram wStringBuffer
	text " was"
	line "forgotten!"
	prompt

_MoveDeleterByeText::
	text "Come back any"
	line "time!"

	para "And don't forget"
	line "about me, eheh."
;	xxxx "123456789012345678"
	done

_MoveDeleterOneMoveText::
	text "That #MON"
	line "has one move."
	cont "Pick another?"
	done