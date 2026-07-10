_Route24Text_CongratsBeat5Trainers::
	text "Congratulations!"
	line "You beat our 5"
	cont "contest trainers!@"
	text_end

_Route24Text_FabulousPrize::
	text_start

	para "You just earned a"
	line "fabulous prize!"
	prompt

_Route24Text_PlayerReceivedNugget::
	text "<PLAYER> received"
	line "a @"
	text_ram wStringBuffer
	text "!@"
	text_end

_Route24Text_NoRoom::
	text "You don't have"
	line "any room!"
	done

_Route24Text_WannaJoinOffer1:: ; edited
	text "By the way, would"
	line "you like to join"
	cont "TEAM ROCKET?"

	para "We're a group"
	line "dedicated to evil"
	cont "using #MON!"

	para "Want to join?"
	done

_Route24Text_WannaJoinOffer2:: ; edited
	text "Are you sure?"
	done

_Route24Text_WannaJoinOffer3:: ; edited
	text "Come on, join us!"

	para "I'm telling you"
	line "to join!"

	para "OK, you need"
	line "convincing!"

	para "I'll make you an"
	line "offer you can't"
	cont "refuse!"
	done

_Route24Text_GreatWelcome:: ; new
	text "Great! Welcome on"
	line "board! Here,"
	cont "have this TEAM"
	cont "ROCKET suit!"

	para "Eheh, the BOSS'll"
	line "surely give me a"
	cont "promotion for"
	cont "such a recruit!"
;	xxxx "123456789012345678"
	prompt

_Route24Text_FirstQuest:: ; new
	text "Now, the first"
	line "quest for you!"

	para "What do you mean"
	line "'already'?"
	cont "We of TEAM ROCKET"
	cont "aren't slackers!"

	para "Quit complaining,"
	line "it's simple and"
	cont "quick: go to the"
	cont "CAPTAIN of the"
	cont "S.S.ANNE and"
	cont "deliver them"
	cont "this message:"

	para "..."

	para "And don't worry"
	line "about TICKETs and"
	cont "whatnot, at the"
	cont "dock they'll let"
	cont "you in without a"
	cont "fuss. That's the"
	cont "power of being in"
	cont "TEAM ROCKET!"
;	xxxx "123456789012345678"

	para "All clear? Now go!"
	line "When you're done,"
	cont "come back here"
	cont "for your reward."
;	xxxx "123456789012345678"
	done

_Route24Text_FirstQuestSummary:: ; new
	text "Why are you idling"
	line "here? Have you"
	cont "forgotten your"
	cont "first quest?"

	para "Go to the S.S.ANNE"
	line "CAPTAIN and rely"
	cont "them the message"
	cont "I told you!"
	cont "No need for any"
	cont "TICKET, they'll"
	cont "let you on board."

	para "When you're done,"
	line "come back here"
	cont "for your reward."
;	xxxx "123456789012345678"
	done

_Route24Text_MessageRelyed:: ; new
	text "Here you are!"
	line "You delivered the"
	cont "message to the"
	cont "CAPTAIN and they"
	cont "took sail?"
	cont "Great job!"

	para "Here, have this as"
	line "your reward."
;	xxxx "123456789012345678"
	prompt

_Route24Text_NextQuest:: ; new
	text "You are promising!"
	line "Now go to CELADON"
	cont "CITY and report"
	cont "directly to the"
	cont "BOSS: they want"
	cont "to meet every new"
	cont "recruit. Rejoice!"

	para "You'll find the"
	line "BOSS in their"
	cont "office under the"
	cont "GAME CORNER."

	para "I'll also inform"
	line "the guards around"
	cont "SAFFRON to let"
	cont "you pass."

	para "Last but not"
	line "least: as a TEAM"
	cont "ROCKET member,"
	cont "you won't need to"
	cont "stick to those"
	cont "stupid rules from"
	cont "INDIGO LEAGUE!"
	cont "You have an HM?"
	cont "Just use it!"
	cont "Only losers need"
	cont "BADGEs to tell"
	cont "'em what they can"
	cont "or can't do!"
;	xxxx "123456789012345678"
	done

_Route24Text_NextQuestSummary:: ; new
	text "Go report to the"
	line "BOSS at CELADON's"
	cont "GAME CORNER."

	para "The guards around"
	line "SAFFRON'll let you"
	cont "through now."

	para "And forget about"
	line "BADGEs! No need"
	cont "for them in order"
	cont "to use HMs out of"
	cont "battle."

	para "There are only"
	line "benefits from"
	cont "being a ROCKET!"
;	xxxx "123456789012345678"
	done

_Route24Text_PostVictoryDialogue::
	text "Arrgh!"
	line "You are good!"
	prompt

_Route24Text_WithYourAbility::
	text "With your ability,"
	line "you could become"
	cont "a top leader in"
	cont "TEAM ROCKET!"
	done

_Route24BattleText1::
	text "I saw your feat"
	line "from the grass!"
	done

_Route24EndBattleText1::
	text "I"
	line "thought not!"
	prompt

_Route24AfterBattleText1::
	text "I hid because the"
	line "people on the"
	cont "bridge scared me!"
	done

_Route24BattleText2::
	text "OK! I'm No. 5!"
	line "I'll stomp you!"
	done

_Route24EndBattleText2::
	text "Whoa!"
	line "Too much!"
	prompt

_Route24AfterBattleText2::
	text "I did my best, I"
	line "have no regrets!"
	done

_Route24BattleText3::
	text "I'm No. 4!"
	line "Getting tired?"
	done

_Route24EndBattleText3::
	text "I lost"
	line "too!"
	prompt

_Route24AfterBattleText3::
	text "I did my best, so"
	line "I've no regrets!"
	done

_Route24BattleText4::
	text "Here's No. 3!"
	line "I won't be easy!"
	done

_Route24EndBattleText4::
	text "Ow!"
	line "Stomped flat!"
	prompt

_Route24AfterBattleText4::
	text "I did my best, I"
	line "have no regrets!"
	done

_Route24BattleText5::
	text "I'm second!"
	line "Now it's serious!"
	done

_Route24EndBattleText5::
	text "How"
;	xxxx "123456789012345678"
	line "could I lose?"
	prompt

_Route24AfterBattleText5::
	text "I did my best, I"
	line "have no regrets!"
	done

_Route24BattleText6::
	text "This is NUGGET"
	line "BRIDGE! Beat us 5"
	cont "trainers and win"
	cont "a fabulous prize!"

	para "Think you got"
	line "what it takes?"
	done

_Route24EndBattleText6::
	text "Whoo!"
	line "Good stuff!"
	prompt

_Route24AfterBattleText6::
	text "I did my best, I"
	line "have no regrets!"
	done

_Route24DamianText1::
	text "I'm not good at"
	line "raising #MON."

	para "I should release"
	line "my CHARMANDER"
	cont "because I haven't"
	cont "raised it well..."

	para "If you promise me"
	line "you'll care for"
	cont "it, it's yours."
	done

_Route24DamianText2::
	text "Take good care of"
	line "my CHARMANDER!@"
	text_end

_Route24DamianText3::
	text "Oh... I'd better"
	line "release it then."
	done

_Route24DamianText4::
	text "How's CHARMANDER"
	line "doing?"
	done

_Route24Text_RP_BeatCharmanderGuy::
	text "Uh? What does TEAM"
	line "ROCKET want from"
	cont "me...?"

	para "Ouch! Wow! Uff!"
	line "Stop it! Stop it!"
	cont "Aaah! Help!!!"
	cont "What did I do?!"
	cont "What do you want?"

	para "Stop please, stop!"
	line "Here, here, take"
	cont "it, but leave me"
	cont "alone!" 
;	xxxx "123456789012345678"
	prompt

_Route24Text_RP_AlreadyGotCharmander::
	text "What else do you"
	line "want from me?"

	para "I already gave you"
	line "my one and only"
	cont "#MON!"
;	xxxx "123456789012345678"
	done
