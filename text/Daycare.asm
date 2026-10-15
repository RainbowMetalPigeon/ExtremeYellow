_DayCareIntroText:: ; edited
	text "I run a DAYCARE."
;	line "The more BADGEs"
;	cont "you have, the"
;	cont "more effective"
;	cont "my cares are!"
;	cont "Quadratically so!"

	para "Would you like me"
	line "to raise one of"
	cont "your #MON?"
;	xxxx "123456789012345678"
	done

_DayCareIntroText_New::
	text "We run a DAYCARE."

	para "Would you like us"
	line "to raise one of"
	cont "your #MON?"
;	xxxx "123456789012345678"
	done

_DayCareWhichMonText::
	text "Which #MON"
	line "should I raise?"
	prompt

_DayCareWillLookAfterMonText::
	text "Fine, I'll look"
	line "after @"
	text_ram wcd6d
	text_start
	cont "for a while."
	prompt

_DayCareComeSeeMeInAWhileText::
	text "Come see me in"
	line "a while."
	done

_DayCareMonHasGrownText::
	text "Your @"
	text_ram wcd6d
	text_start
	line "has grown a lot!"

	para "By level, it's"
	line "grown by @"
	text_decimal wDayCareNumLevelsGrown, 1, 3
	text "!"

	para "Aren't I great?"
	prompt

_DayCareOweMoneyText::
	text "You owe me ¥@"
	text_bcd wDayCareTotalCost, 2 | LEADING_ZEROES | LEFT_ALIGN
	text_start
	line "for the return"
	cont "of this #MON."
	done

_DayCareGotMonBackText::
	text "<PLAYER> got"
	line "@"
	text_ram wDayCareMonName
	text " back!"
	done

_DayCareMonNeedsMoreTimeText::
	text "Back already?"
	line "Your @"
	text_ram wcd6d
	text_start
	cont "needs some more"
	cont "time with me."
	prompt

_DayCareAllRightThenText::
	text "All right then,"
	line "@"
	text_end

_DayCareComeAgainText::
	text "Come again."
	done

_DayCareNoRoomForMonText::
	text "You have no room"
	line "for this #MON!"
	done

_DayCareOnlyHaveOneMonText::
	text "You only have one"
	line "#MON with you."
	done

_DayCareCantAcceptMonWithHMText::
	text "I can't accept a"
	line "#MON that"
	cont "knows an HM move."
	done

_DayCareHeresYourMonText::
	text "Thank you! Here's"
	line "your #MON!"
	prompt

_DayCareNotEnoughMoneyText::
	text "Hey, you don't"
	line "have enough ¥!"
	done

; new ----------------------------------------

_DayCareCantTakeThisMon::
	text "What... what is"
	line "this THING???"

	para "I cannot take"
	line "care of it!!!"
	done

_DayCareMText1_CoolPamphlet::
	text "pamphlet for me?"
	line "thanks!"
;	xxxx "123456789012345678"
	prompt

_DayCareMText1_GivePamphlet::
	text "<PLAYER> gifted"
	line "the PAMPHLET to"
	cont "the DAYCARE owner!"
;	xxxx "123456789012345678"
	done

_DayCareText2_CanHaveMega::
	text "hey mega stone"
	line "gimme for DV"
;	xxxx "123456789012345678"
	done

_DayCareText2_NoGiveMega::
	text "no? sadge"
;	xxxx "123456789012345678"
	done

_DayCareText2_GottenMega::
	text "yay! DVs!"
;	xxxx "123456789012345678"
	done

_DayCareText2_Intro::
	text "gimme a pokemon"
	line "to train a stat"
;	xxxx "123456789012345678"
	done

_DayCareText2_AlreadyGaveMe::
	text "you already gave"
	line "me smth for this"
;	xxxx "123456789012345678"
	done

_DayCareText2_EverythingGiven::
	text "we're all done!"
;	xxxx "123456789012345678"
	done

_DayCareText2_ChoseToGiveNoMon::
	text "No? No problem."
	line "If you change your"
	cont "mind, I'm here!"
;	xxxx "123456789012345678"
	done

_DayCareText2_WannaGiveMeThis::
	text "So you give me"
	line "this #MON?"
;	xxxx "123456789012345678"
	done

_DayCareText2_TooWeak::
	text "too weak"
;	xxxx "123456789012345678"
	done

_DayCareText2_OnlyOneMon::
	text "only 1 mon"
;	xxxx "123456789012345678"
	done

_DayCareText2_UnlockedStatTraining::
	text "unlocked this"
	line "stat training!"
;	xxxx "123456789012345678"
	done


; new for RP =================================

_DayCareMText1_RP::
	text "Ugh! There's no way"
	line "I'll ever take"
	cont "care of the #-"
	cont "MON of a ROCKET"
	cont "scum! Get lost!"
;	xxxx "123456789012345678"
	done
