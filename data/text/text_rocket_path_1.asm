_EndBattleText_RocketPath_Victory::
	text "Tsk."
	line "Are you satisfied"
	cont "now, or what?"
;	xxxx "123456789012345678"
	prompt

_EndBattleText_RocketPath_Victory_VsRocket::
	text "It seems"
	line "we did well in"
	cont "recruiting you!"
;	xxxx "123456789012345678"
	prompt

_EndBattleText_RocketPath_Defeat::
	text "Ah!"
	line "Good riddance,"
	cont "you ROCKET scum!"
;	xxxx "123456789012345678"
	prompt

; ----------------------------

_AfterBattleText_RocketPath_VsRocket::
	text "You're really cut"
	line "for this job, kid!"
;	xxxx "123456789012345678"
	done

_AfterBattleText_RocketPath_VsNotRocket::
	text "You beat me, you"
	line "got my money,"
	cont "what else do you"
	cont "want from me?!"
;	xxxx "123456789012345678"
	done

; ----------------------------

_BeforeBattleText_RocketPath_VsRocket::
	text "Oh, the rookie I"
	line "heard of! Do you"
	cont "want to train?"
	cont "Fine for me!"
;	xxxx "123456789012345678"
	done

_BeforeBattleText_RocketPath_VsNotRocket::
	text "Ugh! What do you"
	line "want from me, you"
	cont "ROCKET scum?!"
;	xxxx "123456789012345678"
	done

; =============================================================

_GenericNPCText_RocketPath_1::
	text "Argh! Leave me"
	line "alone!"
;	xxxx "123456789012345678"
	done

_GenericNPCText_RocketPath_2::
	text "I want nothing to"
	line "do with TEAM"
	cont "ROCKET!"
;	xxxx "123456789012345678"
	done

; -------------

_ProxyText::
	text ""
;	xxxx "123456789012345678"
	done
