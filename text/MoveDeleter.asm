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

; new for RP ===============================

_MoveDeleterGreetingText_RP::
	text "I don't remember"
	line "having ever said"
	cont "I help criminals."

	para "Yet, at my age,"
	line "I know better"
	cont "than opposing a"
	cont "violent stronger"
	cont "than me."

	para "So: want to have"
	line "a #MON forget"
	cont "a move?"
;	xxxx "123456789012345678"
	done

_MoveDeleterSaidYesText_RP::
	text "Which #MON?"
	prompt

_MoveDeleterWhichMoveText_RP::
	text "Which move?"
	done

_MoveDeleterConfirmText_RP::
	text "Forget"
	line "@"
	text_ram wStringBuffer
	text "?"
	prompt

_MoveDeleterForgotText_RP::
	text "@"
	text_ram wStringBuffer
	text " was"
	line "forgotten."
	prompt

_MoveDeleterByeText_RP::
	text "We're done."
	line "And I ask you to"
	cont "forget about me."
;	xxxx "123456789012345678"
	done

_MoveDeleterOneMoveText_RP::
	text "Can't do."
	line "That #MON"
	cont "has one move."
	cont "Are we done, or"
	cont "wanna do another?"
;	xxxx "123456789012345678"
	done
