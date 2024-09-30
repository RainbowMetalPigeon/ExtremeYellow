_MtMoon1BattleText2:: ; edited
	text "Whoa! These"
	line "unexplored"
	cont "tunnels sure are"
	cont "crowded!"
	done

_MtMoon1EndBattleText2:: ; edited
	text "Well!"
	line "At least you went"
	cont "easier on me than"
	cont "the last youth..."
	prompt

_MtMoon1AfterBattleText2_BeforeYesNo:: ; edited/new
	text "I've searched the"
	line "exit for ages!"

	para "I don't think I'm"
	line "close to the"
	cont "solution, but I've"
	cont "ruled some paths"
	cont "out. Wanna me"
	cont "share my finds?"
	prompt

_MtMoon1AfterBattleText2_NoAdvice::
	text "As you prefer!"
	line "There's fun in"
	cont "reaching a goal"
	cont "alone, but there's"
	cont "no shame in being"
	cont "helped a bit!"
	done

_MtMoon1AfterBattleText2_YesAdvice::
	text "The only thing I"
	line "can tell you for"
	cont "sure is that we"
	cont "first gotta go"
	cont "down, then up!"
;	xxxx "123456789012345678"
	done

_MtMoon1BattleText3::
	text "Did you come to"
	line "explore too?"
	done

_MtMoon1EndBattleText3::
	text "Losing"
	line "stinks!"
	prompt

_MtMoon1AfterBattleText3:: ; edited
	text "I came down here"
	line "to catch some"
	cont "rare lunar"
	cont "#MON."
	done

_MtMoon1BattleText4::
	text "Wow! It's way"
	line "bigger in here"
	cont "than I thought!"
	done

_MtMoon1EndBattleText4::
	text "Oh!"
	line "I lost it!"
	prompt

_MtMoon1AfterBattleText4::
	text "How do you get"
	line "out of here?"
	done

_MtMoon1BattleText5::
	text "What! Don't sneak"
	line "up on me!"
	done

_MtMoon1EndBattleText5::
	text "My"
	line "#MON won't do!"
	prompt

_MtMoon1AfterBattleText5::
	text "I have to find"
	line "stronger #MON."
	done

_MtMoon1BattleText6::
	text "What? I'm waiting"
	line "for my friends to"
	cont "find me here."
	done

_MtMoon1EndBattleText6::
	text "I lost?"
	prompt

_MtMoon1AfterBattleText6::
	text "I heard there are"
	line "some very rare"
	cont "fossils here."
	done

_MtMoon1BattleText7::
	text "Suspicious people"
	line "are in the cave."
	cont "What about you?"
	done

_MtMoon1EndBattleText7::
	text "You"
	line "got me!"
	prompt

_MtMoon1AfterBattleText7::
	text "I saw them! I'm"
	line "sure they're from"
	cont "TEAM ROCKET!"
	done

_MtMoon1BattleText8::
	text "Go through this"
	line "cave to get to"
	cont "CERULEAN CITY!"
	done

_MtMoon1EndBattleText8::
	text "I"
	line "lost."
	prompt

_MtMoon1AfterBattleText8::
	text "ZUBAT is tough!"
	line "But, it can be"
	cont "useful if you"
	cont "catch one."
	done

_MtMoon1Text14::
	text "Beware! ZUBAT is"
	line "a bloodsucker!"
	done

; new ------------------------------

_MtMoon1FRivalText_PreBattle_FirstBattle::
	text "<RIVAL>: What are"
	line "YOU doing HERE?!"

	para "Again spying on"
	line "me? Following me"
	cont "to steal my"
	cont "discovery?"

	para "Too bad for you,"
	line "you leech!"
	cont "There's only a"
	cont "decrepit geezer"
	cont "in an even more"
	cont "decrepit hovel."

	para "But! I will not"
	line "forgive you for"
	cont "following me like"
	cont "a shadow and try"
	cont "stealing my"
	cont "hard-gained"
	cont "discoveries!"

	para "I will demolish"
	line "you with my"
	cont "brand-new team!"
	done

_MtMoon1FRivalText_Win_FirstBattle::
	text "Not"
	line "again!!!"
	cont "This is absurd!"
	prompt

_MtMoon1FRivalText_Lose_FirstBattle::
	text "YES!"
	line "Serves you right!"
	cont "Whine and cry in"
	cont "desperation!"

	para "The only thing I'm"
	line "sorry for, is"
	cont "that there is a"
	cont "#MON CENTER"
	cont "nearby..."
	prompt

_MtMoon1FRivalText_PostBattle_FirstBattle::
	text "<RIVAL>: You..."
	line "damn... filthy..."
	cont "piece of crap..."

	para "How can you keep"
	line "defeating my"
	cont "formidable"
	cont "teams?!"
	cont "It doesn't make"
	cont "any sense!"

	para "I'm a genius!"
	line "I have the"
	cont "strongest"
	cont "#MON! I train"
	cont "the hardest!"
	cont "And yet you"
	cont "keep winning!"

	para "...tsk. Your"
	line "fucked luck will"
	cont "end one day, and"
	cont "that's when I"
	cont "will exact my"
	cont "revenge."

	para "I hope you'll get"
	line "lost in this"
	cont "absurd maze, at"
	cont "least I won't"
	cont "have to bear the"
	cont "sight of your"
	cont "face ever again."
	done

; ---

_MtMoon1FRivalText_PreBattle_BothBattles::
	text "<RIVAL>: What are"
	line "YOU doing HERE?!"

	para "Again spying on"
	line "me? Following me"
	cont "to steal my"
	cont "discovery?"

	para "Too bad for you,"
	line "you leech!"
	cont "There's only a"
	cont "decrepit geezer"
	cont "in an even more"
	cont "decrepit hovel."

	para "Well! At least I"
	line "can take it out"
	cont "on you with my"
	cont "new team! It's"
	cont "made out of the"
	cont "best of the best,"
	cont "there's no way I"
	cont "can lose this"
	cont "time!"
	done

_MtMoon1FRivalText_Win_BothBattles::
	text "WHAT?!"

	para "If not even THIS"
	line "team worked..."
	cont "How can I...?"
	prompt

_MtMoon1FRivalText_Lose_BothBattles::
	text "Ahahah!!!"

	para "I knew! I knew! I"
	line "learned from the"
	cont "best of the past,"
	cont "surpassed them,"
	cont "and humiliated"
	cont "you! Ahahah!!!"
	prompt

_MtMoon1FRivalText_PostBattle_BothBattles::
	text "<RIVAL>: Just HOW?"

	para "How did you defeat"
	line "this team, made"
	cont "out of the aces"
	cont "of the INDIGO"
	cont "strongests?!"

	para "I spent so much"
	line "time and effort"
	cont "researching,"
	cont "catching and"
	cont "training these"
	cont "#MON, and"
	cont "yet..."

	para "Tsk! My mistake"
	line "has been trying"
	cont "to emulate"
	cont "others! I'll"
	cont "start from"
	cont "scratch again,"
	cont "and make my most"
	cont "ME team ever!"

	para "I hope you'll get"
	line "lost in this"
	cont "absurd maze, at"
	cont "least I won't"
	cont "have to bear the"
	cont "sight of your"
	cont "face ever again."
	done
