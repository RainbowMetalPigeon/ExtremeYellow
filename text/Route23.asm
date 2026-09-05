_VictoryRoadGuardText_YouNeedIt::
	text "You can pass here"
	line "only if you have"
	cont "the @"
	text_ram wcd6d
	text "!"

	para "You don't have the"
	line "@"
	text_ram wcd6d
	text " yet!"

	para "You have to have"
	line "it to get to"
	cont "#MON LEAGUE!@"
	text_end

_VictoryRoadGuardText_OhYouHaveIt::
	text "You can pass here"
	line "only if you have"
	cont "the @"
	text_ram wcd6d
	text "!"

	para "Oh! That is the"
	line "@"
	text_ram wcd6d
	text "!@"
	text_end

_VictoryRoadGuardText_CanPass::
	text_start

	para "OK then! Please,"
	line "go right ahead!"
	done

_Route23Text8::
	text "VICTORY ROAD GATE"
	line "- #MON LEAGUE"
	done

; new --------------------------

_Route23Text9::
	text "To interact with"
	line "people and signs,"
	cont "press the"
	cont "A Button!"
	done

_Route23TextPink::
	text "???: Wait <PLAYER>!"
;	xxxx "123456789012345678"
	done

_Route23ScriptText1::
	text "PINK: I knew I'd"
	line "meet you here!"

	para "I told you we"
	line "were going to"
	cont "face off again."

	para "<PLAYER>. I have"
	line "much respect and"
	cont "admiration for"
	cont "you. You saved my"
	cont "land twice. You"
	cont "inspired me to"
	cont "become stronger."

	para "But it's exactly"
	line "this drive that"
	cont "forces me to"
	cont "surpass you."
	
	para "That's why I must"
	line "defeat you, once"
	cont "and for all, to"
	cont "prove how much"
	cont "I grew!"
;	xxxx "123456789012345678"
	done

_Route23PinkDefeatedText::
	text "...not yet."
;	xxxx "123456789012345678"
	prompt

_Route23PinkBeatYouText::
	text "I did it!"
	line "I won! I achieved"
	cont "all I wanted."
	
	para "...so this is how"
	line "the peak feels?"
	cont "It's..."

	para "...underwhelming."
;	xxxx "123456789012345678"
	prompt

_Route23ScriptText2::
	text "PINK: ...you are"
	line "still stronger"
	cont "than me."

	para "I should feel"
	line "frustrated for"
	cont "losing, and I do,"
	cont "to some extent,"
	cont "but..."

	para "There's also still"
	line "a flame burning."
	cont "A fire to better"
	cont "myself further."

	para "<PLAYER>! I look"
	line "forward to facing"
	cont "you again. You"
	cont "won't believe how"
	cont "much I'll grow!"
;	xxxx "123456789012345678"
	done

; new for RP ========================

_VictoryRoadGuardText_YouNeedIt_RP::
	text "You can pass only"
	line "if you have the"
;	xxxx "123456789012345678"
	cont "@"
	text_ram wcd6d
	text "."

	para "You don't have it."

	para "Leave.@"
	text_end

_VictoryRoadGuardText_OhYouHaveIt_RP::
	text "You can pass only"
	line "if you have the"
	cont "@"
	text_ram wcd6d
	text "."

	para "Ah. You have it.@"
	text_end

_VictoryRoadGuardText_CanPass_RP::
	text_start

	para "Pass, then, if you"
	line "really must."
;	xxxx "123456789012345678"
	done

_Route23TextPink_RP::
	text "???: YOU!!!"
;	xxxx "123456789012345678"
	done

_Route23ScriptText1_RP::
	text "PINK: You!"
	line "You monster!"
	cont "You kidnapped my"
	cont "cousin! You"
	cont "ravaged my land!"

	para "Oh, but now you'll"
	line "see. I trained to"
	cont "the brink of"
	cont "death, only to be"
	cont "able to KILL YOU!"
;	xxxx "123456789012345678"
	done

_Route23PinkDefeatedText_RP::
	text "...no."
	line "It... can't be!!!"
;	xxxx "123456789012345678"
	prompt

_Route23PinkBeatYouText_RP::
	text "Yes!!!"
	line "I had my victory,"
	cont "and now I'll have"
	cont "your shitty life!"
;	xxxx "123456789012345678"
	prompt

_Route23ScriptText2_RP::
	text "PINK: ...you..."
	line "I... can't..."

	para "I CAN'T BE!!!"

	para "Why?! Why do you"
	line "keep winning, why"
	cont "do you keep"
	cont "FUCKING MY LIFE?!"

	para "You... I swear on"
	line "my life, I'll"
	cont "massacre you,"
	cont "you fucking"
	cont "shitty bastard."
;	xxxx "123456789012345678"
	done
