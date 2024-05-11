_BattleFacilityTextGuide_Intro::
	text "Welcome to our"
	line "BATTLE FACILITY!"

	para "How can I help"
	line "you?"
	done

_BattleFacilityTextGuide_Exit::
	text "We hope to see you"
	line "again soon!"
	done

_BattleFacilityTextGuide_Battle1::
	text "Amazing! What"
	line "challenge mode do"
	cont "you prefer?"
	done

_BattleFacilityTextGuide_Battle2::
	text "Great! Do you"
	line "prefer playing"
	cont "NORMAL or INVERSE"
	cont "battles?"
	done

_BattleFacilityTextGuide_Battle3::
	text "Fantastic! I wish"
	line "you great luck"
	cont "and fun!"
	done

_BattleFacilityTextGuide_Info::
	text "Our BATTLE"
	line "FACILITY, or B.F."
	cont "for short, offers"
	cont "two challenge"
	cont "modes: STANDARD"
	cont "and HARDCORE."

	para "In STANDARD mode,"
	line "you will be"
	cont "challenged to"
	cont "complete a"
	cont "SESSION, meaning"
	cont "7 trainers in a"
	cont "row, with"
	cont "increasingly"
	cont "stronger teams."

	para "After defeating"
	line "any of the first"
	cont "6 trainers, your"
	cont "team will be"
	cont "healed and you"
	cont "will be rewarded"
	cont "a PP UP."

	para "If you complete a"
	line "SESSION, you are"
	cont "entitled to a"
	cont "special prize!"
	cont "And were you to"
	cont "win 7 SESSIONs in"
	cont "a row, the prize"
	cont "will be"
	cont "ultra-special!"

	para "In HARDCORE mode,"
	line "instead, your"
	cont "team will NOT be"
	cont "healed after you"
	cont "defeat a trainer,"
	cont "and you'll"
	cont "continue battling"
	cont "until the very"
	cont "last HP of your"
	cont "very last"
	cont "#MON!"

	para "No prizes are"
	line "given off in this"
	cont "mode, except the"
	cont "glory of"
	cont "overcoming the"
	cont "Ultimate Battle"
	cont "Challenge!"

	para "Additionally, both"
	line "modes can be"
	cont "played as NORMAL"
	cont "or INVERSE"
	cont "battles!"

	para "You can keep track"
	line "of your records"
	cont "on the"
	cont "scoreboards on"
	cont "the wall at your"
	cont "left. They show"
	cont "how many"
	cont "consecutive"
	cont "SESSIONs you have"
	cont "won in STANDARD"
	cont "mode, and how"
	cont "many consecutive"
	cont "battles you won"
	cont "in HARDCORE mode."

	para "Keep in mind that"
	line "the levels of"
	cont "your opponents'"
	cont "#MON match the"
	cont "highest level in"
	cont "your team."

	para "Finally, be aware"
	line "that you cannot"
	cont "save the game"
	cont "while engaged in"
	cont "any of our"
	cont "challenges."

	para "This is all. I"
	line "wish you the best"
	cont "of fun at our"
	cont "BATTLE FACILITY!"
	done

_BattleFacilityTextGuide_Prizes::
	text "We are keeping for"
	line "you some prizes"
	cont "you couldn't get"
	cont "right away!"

	para "Please accept"
	line "them."
	prompt

_BattleFacilityTextGuide_Prizes_PPUPs_Given::
	text "<PLAYER> received"
	line "@"
	text_decimal wBattleFacilityBacklogPPUPs, 1, 3 ; address to read from, number of bytes to read, number of digits to display
	text " PP UPs!"
	prompt

_BattleFacilityTextGuide_Prizes_Perfecters_Given::
	text "<PLAYER> received"
	line "@"
	text_decimal wBattleFacilityBacklogPerfecters, 1, 3
	text " PERFECTERs!"
	prompt

_BattleFacilityTextGuide_Prizes_Chromogenes_Given::
	text "<PLAYER> received"
	line "@"
	text_decimal wBattleFacilityBacklogChromogenes, 1, 3
	text " CHROMOGENEs!"
	prompt

_BattleFacilityTextGuide_Prizes_PPUPs_Failed::
	text "You don't have"
	line "space for your"
	cont "PP UPs!"
	prompt

_BattleFacilityTextGuide_Prizes_Perfecters_Failed::
	text "You don't have"
	line "space for your"
	cont "PERFECTERs!"
	prompt

_BattleFacilityTextGuide_Prizes_Chromogenes_Failed::
	text "You don't have"
	line "space for your"
	cont "CHROMOGENEs!"
	prompt

_BattleFacilityTextGuide_Prizes_Ender::
	text "Here we are, that"
	line "was everything!"
	done

_BattleFacilityTextGuide_InfoShort::
	text "The rules in"
	line "short:"

	para "1) Two challenge"
	line "modes: STANDARD"
	cont "and HARDCORE."

	para "2) STANDARD:"
	line "SESSIONs of 7"
	cont "trainers."

	para "PP UP and healing"
	line "after each"
	cont "trainer."

	para "Special prize"
	line "after a SESSION."
	cont "7 SESSIONs,"
	cont "ultra-special"
	cont "prize."

	para "3) HARDCORE: no"
	line "healing, battle"
	cont "until you're KO."
	cont "No prizes given."

	para "4) Can choose"
	line "NORMAL or INVERSE"
	cont "battles."

	para "5) Records on the"
	line "scoreboards."

	para "6) Opponents'"
	line "level match your"
	cont "highest."

	para "7) Cannot save"
	line "during challenge."

; -------------------------------------

_BattleFacilityTextOpponent_Intro::
	text "Hi! Let's have a"
	line "great battle!"
	done

_BattleFacilityTextOpponent_PostBattleWin::
	text "Ah!"
	line "Well played!"
	prompt

_BattleFacilityTextOpponent_PostBattleLoss::
	text "GG!"
	line "Nice battle!"
	prompt

; -------------------------------------

_BattleFacilityTextPerson1::
	text "I'm so excited! I"
	line "wanna dive"
	cont "completely in"
	cont "INVERSE battles,"
	cont "they are my"
	cont "specialty!"

	para "I'll break all"
	line "records in no"
	cont "time!"
	done

_BattleFacilityTextPerson2::
	text "It's easy to get"
	line "hyperfixated on"
	cont "making the"
	cont "records grow and"
	cont "lose focus on"
	cont "what's important,"
	cont "which is having"
	cont "fun."
	done

_BattleFacilityTextPerson3::
	text "What is the best"
	line "team to use?"

	para "Is it the same for"
	line "STANDARD and"
	cont "HARDCORE mode?"

	para "Does it change for"
	line "NORMAL and"
	cont "INVERSE battles?"

	para "So many"
	line "possibilities!"
	done

_BattleFacilitySignIntroNormal::
	text "Scoreboard for"
	line "NORMAL battles."
	done

_BattleFacilitySignIntroInverse::
	text "Scoreboard for"
	line "INVERSE battles."
	done

; -------------------------------------

_BattleFacilityText_NextBattle::
	text "Let's continue with"
	line "battle N. @"
	text_decimal wBattleFacilityWinningStreakNext, 1, 3 ; address to read from, number of bytes to read, number of digits to display
	text "!@"
	text_end

_BattleFacilityText_FinishedBlock::
	text "Congratulations!"
	line "You completed the"
	cont "SESSION!"
	done

_BattleFacilityText_HealAndSmolPrize::
	text "We'll now heal"
	line "your team and"
	cont "gift you a PP UP!"
	done

_BattleFacilityText_ReceivedItem::
	text "<PLAYER> received "
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_BattleFacilityText_BagFull::
	text "Your bag is full."
	line "We'll hold this"
	cont "for you."
	done

_BattleFacilityText_AfterWarpVictory::
	text "Amazingly done! By"
	line "completing a full"
	cont "SESSION, you've"
	cont "earned yourself a"
	cont "special prize!"
	done

_BattleFacilityText_AfterWarpDefeat::
	text "Sometimes we win,"
	line "sometimes we"
	cont "lose."

	para "You anyhow did"
	line "great! Come back"
	cont "any time, you're"
	cont "always welcome!"
	done
