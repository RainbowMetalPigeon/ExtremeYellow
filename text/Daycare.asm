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
	text "Uh? A PAMPHLET on"
	line "new #MON"
	cont "rising methods?"

	para "I wasn't updated!"
	line "With this, I can"
	cont "make #MON grow"
	cont "faster & better!"

	para "Is it for me?"
	line "Thanks a ton!"
	cont "This will help me"
	cont "so much! I'll"
	cont "probably be four"
	cont "times better!"
;	xxxx "123456789012345678"
	prompt

_DayCareMText1_GivePamphlet::
	text "<PLAYER> gifted"
	line "the PAMPHLET to"
	cont "the DAYCARE owner!"
;	xxxx "123456789012345678"
	done

_DayCareText2_CanHaveMega::
	text "?! What's that?!"
	line "That item can"
	cont "alter the genetic"
	cont "properties of"
	cont "#MON. It's like"
	cont "an evolutionary"
	cont "stone cranked to"
	cont "the max!"

	para "If you gave me it,"
	line "I could try out a"
	cont "revolutionary"
	cont "technique I've"
	cont "studied recently:"
	cont "I should be able"
	cont "to improve the"
	cont "weakest DNA"
	cont "traits of a #-"
	cont "you leave us."

	para "What do you think?"
	line "A small price now"
	cont "for a huge gain"
	cont "later! Can I have"
	cont "your MEGA STONE?"
;	xxxx "123456789012345678"
	done

_DayCareText2_NoGiveMega::
	text "No? That's a pity."
;	xxxx "123456789012345678"
	done

_DayCareText2_GottenMega::
	text "Yay! With this, I"
	line "can test that"
	cont "paper, help my"
	cont "boss, AND benefit"
	cont "you! Win-win-win!"

	para "<PLAYER> gave the"
	line "MEGA STONE!"
;	xxxx "123456789012345678"
	done

_DayCareText2_Intro::
	text "I researched a way"
	line "to improve #-"
	cont "MON raising:"

	para "If you leave me a"
	line "strong #MON,"
	cont "it can influence"
	cont "the growth of"
	cont "the ones we care"
	cont "for! A strong"
	cont "ATTACKer, for"
	cont "example, will"
	cont "steadily increase"
	cont "the ATTACK of"
	cont "the cared one."

	para "Do you want to"
	line "leave a strong"
	cont "#MON with me?"
	cont "It needs to have"
	cont "a BASE STAT of"
	cont "100 or higher."
	cont "Mind that I can't"
	cont "return it to you."
;	xxxx "123456789012345678"
	done

_DayCareText2_AlreadyGaveMe::
	text "You already gave"
	line "me a #MON for"
	cont "this STAT."
;	xxxx "123456789012345678"
	done

_DayCareText2_EverythingGiven::
	text "Thanks to the"
	line "#MON you gave"
	cont "me, our raising"
	cont "now increases"
	cont "every STAT!"
	cont "Thanks!"
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
	text "Its BASE STAT is"
	line "not high enough."
	cont "It needs to be"
	cont "100 or more."
;	xxxx "123456789012345678"
	done

_DayCareText2_OnlyOneMon::
	text "Oh, you can't give"
	line "me a #MON when"
	cont "you have only one."
;	xxxx "123456789012345678"
	done

_DayCareText2_UnlockedStatTraining::
	text "Yay! With it I can"
	line "unlock another"
	cont "STAT training!"
	cont "Thanks!"
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
