_BattleFacilityTextGuide_Intro::
	text "Welcome!"

	para "WIP!"
	done

_BattleFacilityTextGuide_Exit::
	text "Bye!"
	done

_BattleFacilityTextGuide_Battle1::
	text "Great"
	line "What mode?"
	done

_BattleFacilityTextGuide_Battle2::
	text "Great!"
	line "NORMAL or INVERSE?"
	done

_BattleFacilityTextGuide_Battle3::
	text "Great!"
	line "Let's go!"
	done

_BattleFacilityTextGuide_Info::
	text "Infos"
	done

_BattleFacilityTextGuide_Prizes::
	text "Prizes"
	done

_BattleFacilityTextGuide_Prizes_PPUPs_Given::
	text "PPUP GIVEN"
	prompt

_BattleFacilityTextGuide_Prizes_Perfecters_Given::
	text "PERFECTERS GIVEN"
	prompt

_BattleFacilityTextGuide_Prizes_Chromogenes_Given::
	text "CHROMOGENES GIVEN"
	prompt

_BattleFacilityTextGuide_Prizes_PPUPs_Failed::
	text "PPUP FAILED"
	done

_BattleFacilityTextGuide_Prizes_Perfecters_Failed::
	text "PERFECTERS FAILED"
	done

_BattleFacilityTextGuide_Prizes_Chromogenes_Failed::
	text "CHROMOGENES FAILED"
	done

_BattleFacilityTextGuide_Prizes_Ender::
	text "End of prizes"
	done

; -------------------------------------

_BattleFacilityTextOpponent_Intro::
	text "Hi! Battle!"
	done

_BattleFacilityTextOpponent_PostBattleWin::
	text "Ah!"
	prompt

_BattleFacilityTextOpponent_PostBattleLoss::
	text "GG!"
	prompt

; -------------------------------------

_BattleFacilityTextPerson1::
	text "I'm excited!"
	line "Will do INVERSE"
	cont "my specialty"
	done

_BattleFacilityTextPerson2::
	text "I wanna see"
	line "my numbers big"
	done

_BattleFacilityTextPerson3::
	text "What can be"
	line "best team?!"
	done

_BattleFacilitySignIntroNormal::
	text "Points"
	line "NORMAL"
	done

_BattleFacilitySignIntroInverse::
	text "Points"
	line "INVERSE"
	done

; -------------------------------------

_BattleFacilityText_NextBattle::
	text "Let's continue with"
	line "battle N. @"
	text_decimal wBattleFacilityWinningStreakNext, 1, 3 ; address to read from, number of bytes to read, number of digits to display
	text "!@"
	text_end

_BattleFacilityText_FinishedBlock::
	text "Finished session!"
	done

_BattleFacilityText_HealAndSmolPrize::
	text "Heal and PPUP"
	done

_BattleFacilityText_ReceivedItem::
	text "<PLAYER> received "
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_BattleFacilityText_BagFull::
	text "Bag full"
	done

_BattleFacilityText_AfterWarpVictory::
	text "Congrats!!!"
	done

_BattleFacilityText_AfterWarpDefeat::
	text "Well, not bad!"
	line "Come back soon!"
	done
