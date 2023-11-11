; ----- Trainer 1, STEEL -----

_OchreGymBattleText1::
	text "Welcome to"
	line "OCHRE GYM!"

	para "Here we don't"
	line "specialize in one"
	cont "single type, but"
	cont "we pay respect to"
	cont "all the ones that"
	cont "have been ignored"
	cont "by the"
	cont "#MON LEAGUE."

	para "Me, I am a"
	line "master of STEEL!"
	cont "Get ready to face"
	cont "my metal!"
	done

_OchreGymEndBattleText1::
	text "Dang!"
	line "How could you"
	cont "overcome the many"
	cont "resistances of"
	cont "STEEL #MON?!"
	prompt

_OchreGymAfterBattleText1::
	text "You did well, but"
	line "there's no way"
	cont "you can defeat"
	cont "ORAGE!"
	done

; ----- Trainer 2, FLYING -----

_OchreGymBattleText2::
	text "FLYING #MON"
	line "are fast and"
	cont "beautiful!"
	cont "Let's fight!"
	done

_OchreGymEndBattleText2::
	text "Argh!"
	line "The speed and"
	cont "elegance and"
	cont "intelligence of"
	cont "FLYING #MON!"
	cont "It wasn't enough!"
	prompt

_OchreGymAfterBattleText2::
	text "Congrats. But be"
	line "kind to birds!"
	done

; ----- Trainer 3, DARK -----

_OchreGymBattleText3::
	text "That voice within"
	line "our minds... That"
	cont "whispers of evil"
	cont "deeds and cruel"
	cont "acts..."

	para "Embracing its lure"
	line "can bring"
	cont "power... DARK"
	cont "types are"
	cont "extraordinarily"
	cont "rare and"
	cont "powerful!"
	done

_OchreGymEndBattleText3::
	text "Wha?!"
	line "How did you resist"
	cont "the temptation of"
	cont "DARKness?!"
	prompt

_OchreGymAfterBattleText3::
	text "Umph."
	line "You may have stood"
	cont "strong to your"
	cont "ideals today, but"
	cont "you'll eventually"
	cont "give in."
	done

; ----- Trainer 4, BUG -----

_OchreGymBattleText4::
	text "Hi! I like BUGs!"
	line "They are"
	cont "fascinating,"
	cont "evolve quickly,"
	cont "and can be"
	cont "deceptively"
	cont "strong!"

	para "Allow me to"
	line "demonstrate!"
	done

_OchreGymEndBattleText4::
	text "Oh."

	para "Too bad. It was"
	line "a nice fight!"
	cont "I hope you liked"
	cont "my BUG #MON!"
	prompt

_OchreGymAfterBattleText4::
	text "Keep up the good"
	line "work, you're"
	cont "almost arrived at"
	cont "our LEADER!"
	done

; ----- Trainer 5, FAIRY -----

_OchreGymBattleText5::
	text "Can you feel the"
	line "voices of the"
	cont "forest, and the"
	cont "deeper truths"
	cont "hidden within"
	cont "fairy tales?"

	para "No? I suspected"
	line "so. You should"
	cont "armonize more"
	cont "with FAIRY types."
	done

_OchreGymEndBattleText5::
	text "Well,"

	para "maybe you are"
	line "synchronized with"
	cont "the world even"
	cont "without the power"
	cont "of FAIRY..."
	prompt

_OchreGymAfterBattleText5::
	text "FAIRY #MON have"
	line "been discovered"
	cont "recently."

	para "They use their"
	line "magical power to"
	cont "subdue whom who"
	cont "rely on brutal"
	cont "strength."
	done

; ----- Trainer 6, NORMAL -----

_OchreGymBattleText6::
	text "OCHRE GYM"
	line "Battle text"
	cont "NORMAL!"
	done

_OchreGymEndBattleText6::
	text "OCHRE GYM"
	line "End text"
	cont "NORMAL!"
	prompt

_OchreGymAfterBattleText6::
	text "OCHRE GYM"
	line "After text"
	cont "NORMAL!"
	done

; ----- Trainer 7, COOLTRAINER -----

_OchreGymBattleText7::
	text "OCHRE GYM"
	line "Battle text"
	cont "COOLTRAINER!"
	done

_OchreGymEndBattleText7::
	text "OCHRE GYM"
	line "End text"
	cont "COOLTRAINER!"
	prompt

_OchreGymAfterBattleText7::
	text "OCHRE GYM"
	line "After text"
	cont "COOLTRAINER!"
	done

; ----- ORAGE -----

_OragePreBattleText::
	text "Pre-battle"
	line "text, test"
	done

_ReceivedNoBadgeText::
	text "Welp, I'm"
	line "sorry, but we are"
	cont "not an official"
	cont "GYM, so I have"
	cont "no BADGE for you."

	para "Regardless, I did"
	line "prepare myself a"
	cont "valuable prize."
	prompt

_OragePostBattleAdviceText::
	text "Mph."
	line "You did well."
	cont "I can see a great"
	cont "potential in you."

	para "If you succeed and"
	line "become CHAMPION,"
	cont "you could try to"
	cont "advocate for"
	cont "OCHRE GYM to be"
	cont "acknowledged as"
	cont "an official GYM."
	done

_OrageNoBadgeInfoText::
	text "Here, you can"
	line "have this!"
	done

_ReceivedGiftText::
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_GiftExplanationText::
	text_start

	para "MAX REVIVE fully"
	line "heals a fainted"
	cont "pokeMON, so that"
	cont "it can continue"
	cont "to defy any and"
	cont "all opponents!"
	done

_GiftNoRoomText::
	text "Your pack is full"
	line "of other items!"
	done

; ----- "signs" -----

_OchreGymStatueText::
	text "Statue text"
	done

_OchreGymTrashBinText_Try1::
	text "Trash text 1"
	done

_OchreGymTrashBinText_Try2::
	text "Trash text 2"
	done

_OchreGymTrashBinText_Try3::
	text "Trash text 3"
	done

; for rematch ---------------------

_OrageRematchPreBattleText::
	text "Rematch"
	line "ORAGE"
	cont "Pre"
	done

_OrageRematchDefeatedText::
	text "Nice!"
	line "Thanks!"
	prompt
