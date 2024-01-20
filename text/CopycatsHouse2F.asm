_CopycatsHouse2FText_5ccd4::
	text "<PLAYER>: Hi! Do"
	line "you like #MON?"

	para "<PLAYER>: Uh no, I"
	line "just asked you."

	para "<PLAYER>: Huh?"
	line "You're strange!"

	para "COPYCAT: Hmm?"
	line "Quit mimicking?"

	para "But, that's my"
	line "favorite hobby!"
	prompt

_TM31PreReceiveText:: ; edited
	text "Oh wow!"
	line "A # DOLL!"

	para "For me?"
	line "Thank you!"

	para "Unfortunately, I"
	line "already have this"
	cont "doll... but I"
	cont "appreciate the"
	cont "thought!"

	para "But you know what"
	line "else I like? A"
	cont "good #MON"
	cont "battle!"
	prompt

_PostBattleAndGiveTMText::
	text "Thanks for the"
	line "lovely battle!"

	para "Here, you can"
	line "have this!"
	prompt

_ReceivedTM31Text::
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_TM31ExplanationText1::
	text_start

	para "TM31 contains my"
	line "favorite, MIMIC!"

	para "Use it on a good"
	line "#MON!@"
	text_end

_TM31ExplanationText2::
	text "<PLAYER>: Hi!"
	line "Thanks for TM31!"

	para "<PLAYER>: Pardon?"

	para "<PLAYER>: Is it"
	line "that fun to mimic"
	cont "my every move?"

	para "COPYCAT: You bet!"
	line "It's a blast!" ; edited

	para "Hey! I know it!"
	line "What would you"
	cont "think of another"
	cont "battle? I can"
	cont "show off my"
	cont "ultimate mimicry"
	cont "skills!"
	done

_TM31NoRoomText:: ; edited
	text "Oh, you don't have"
	line "enough space.@"
	text_end

_CopycatsHouse2FText2::
	text "DODUO: Giiih!"

	para "MIRROR MIRROR ON"
	line "THE WALL, WHO IS"
	cont "THE FAIREST ONE"
	cont "OF ALL?"
	done

_CopycatsHouse2FText3::
	text "This is a rare"
	line "#MON! Huh?"
	cont "It's only a doll!"
	done

_CopycatsHouse2FText6::
	text "A game with MARIO"
	line "wearing a talking"
	cont "hat with eyes!"
;	xxxx "123456789012345678"
	done

_CopycatsHouse2FText_5cd17::
	text "..."

	para "My Secrets!"

	para "Skill: Mimicry!"
	line "Hobby: Collecting"
	cont "dolls!"
	cont "Favorite #MON:"
	cont "CLEFAIRY!"
	done

_CopycatsHouse2FText_5cd1c::
	text "Huh? Can't see!"
	done

_CopycatText_PostBattleText::
	text "<PLAYER>: Yes!"
	line "I won!"
	prompt

_CopycatText_PostBattleText2::
	text "<PLAYER>: Yes!"
	line "I won again!"
	prompt

_CopycatsHouse2FText_BattleRefused::
	text "Oh, that's a"
	line "bummer..."

	para "Well, you know"
	line "where to find me"
	cont "if you change"
	cont "your mind, my"
	cont "bedroom is always"
	cont "open for you!"
	done

_CopycatsHouse2FText_BattleAccepted::
	text "Eheh, get ready"
	line "for a battle like"
	cont "you've never had"
	cont "before!"
	done
