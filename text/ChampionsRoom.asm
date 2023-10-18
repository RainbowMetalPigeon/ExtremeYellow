_GaryChampionIntroText_BG::
	text "<RIVAL>: Hey!"

	para "I was looking"
	line "forward to seeing"
	cont "you, <PLAYER>!"

	para "My rival should"
	line "be strong to keep"
	cont "me sharp!"

	para "While working on"
	line "#DEX, I looked"
	cont "all over for"
	cont "powerful #MON!"

	para "Not only that, I"
	line "assembled teams"
	cont "that would beat"
	cont "any #MON type!"

	para "And now!"

	para "I'm the #MON"
	line "LEAGUE champion!"

	para "<PLAYER>! Do you"
	line "know what that"
	cont "means?"

	para "I'll tell you!"

	para "I am the most"
	line "powerful trainer"
	cont "in the world!"
	done

_GaryDefeatedText_BG::
	text "NO!"
	line "That can't be!"
	cont "You beat my best!"

	para "After all that"
	line "work to become"
	cont "LEAGUE champ?"

	para "My reign is over"
	line "already?"
	cont "It's not fair!"
	prompt

_GaryVictoryText_BG::
	text "Hahaha!"
	line "I won, I won!"

	para "I'm too good for"
	line "you, <PLAYER>!"

	para "You did well to"
	line "even reach me,"
	cont "<RIVAL>, the"
	cont "#MON genius!"

	para "Nice try, loser!"
	line "Hahaha!"
	prompt

_GaryText_OWPostDefeat_BG::
	text "Why?"
	line "Why did I lose?"

	para "I never made any"
	line "mistakes raising"
	cont "my #MON..."

	para "Darn it! You're"
	line "the new #MON"
	cont "LEAGUE champion!"

	para "Although I don't"
	line "like to admit it."
	done

; --------

_GaryChampionIntroText_AG_BGR::
	text "<RIVAL>: Intro"
	line "After Game"
	cont "Before Gym Rem"
	done

_GaryDefeatedText_AG_BGR::
	text "Win"
	line "After Game"
	cont "Before Gym Rem"
	prompt

_GaryVictoryText_AG_BGR::
	text "Lose"
	line "After Game"
	cont "Before Gym Rem"
	prompt

_GaryText_OWPostDefeat_AG_BGR::
	text "Overworld"
	line "After Game"
	cont "Before Gym Rem"
	done

; --------

_GaryChampionIntroText_AG_AGR::
	text "<RIVAL>: Intro"
	line "After Game"
	cont "After Gym Rem"
	done

_GaryDefeatedText_AG_AGR::
	text "Win"
	line "After Game"
	cont "After Gym Rem"
	prompt

_GaryVictoryText_AG_AGR::
	text "Lose"
	line "After Game"
	cont "After Gym Rem"
	prompt

_GaryText_OWPostDefeat_AG_AGR::
	text "Overworld"
	line "After Game"
	cont "After Gym Rem"
	done

; ==================================

_GaryText2::
	text "OAK: <PLAYER>!"
	done

_GaryText_76120::
	text "OAK: So, you won!"
	line "Congratulations!"
	cont "You're the new"
	cont "#MON LEAGUE"
	cont "champion!"

	para "You've grown up so"
	line "much since you"
	cont "first left with"
	cont "@"
	text_ram wcd6d
	text "!"

	para "<PLAYER>, you have"
	line "come of age!"
	done

_GaryText_76125::
	text "OAK: <RIVAL>! I'm"
	line "disappointed!"

	para "I came when I"
	line "heard you beat"
	cont "the ELITE FOUR!"

	para "But, when I got"
	line "here, you had"
	cont "already lost!"

	para "<RIVAL>! Do you"
	line "understand why"
	cont "you lost?"

	para "You have forgotten"
	line "to treat your"
	cont "#MON with"
	cont "trust and love!"

	para "Without them, you"
	line "will never become"
	cont "a champ again!"
	done

_GaryText_7612a::
	text "OAK: <PLAYER>!"

	para "You understand"
	line "that your victory"
	cont "was not just your"
	cont "own doing!"

	para "The bond you share"
	line "with your #MON"
	cont "is marvelous!"

	para "<PLAYER>!"
	line "Come with me!"
	done

; ==================================

_GaryText2ndBattle_BG::
	text "AGAIN!"
	line "2ND TEAM!"
	done

_GaryDefeatedText2ndBattle_BG::
	text "TEST DEFEAT"
	prompt

_GaryVictoryText2ndBattle_BG::
	text "TEST VICTORY"
	prompt

; --------

_GaryText2ndBattle_AG::
	text "Would you like"
	line "2nd battle?"
	done ; prompt?

_GaryText2ndBattle_AG_Refused::
	text "Understandable,"
	line "it sounds unfair"
	cont "so you won!"
	done

; --------

_GaryText2ndBattle_AG_BGL::
	text "Excellent!"
	line "Get ready to meet"
	cont "some old 'friends'!"
	done

_GaryDefeatedText2ndBattle_AG_BGL::
	text "Damn!"
	line "I lost again!"
	cont "Nice battle!"
	prompt

_GaryVictoryText2ndBattle_AG_BGL::
	text "Phew!"
	line "You fought well,"
	cont "I won this time!"
	prompt

; --------

_GaryText2ndBattle_AG_AGL::
	text "Wonderful!"
	line "This other team"
	cont "is new too!"
	done

_GaryDefeatedText2ndBattle_AG_AGL::
	text "Wow!"
	line "You won again!"
	cont "You're the best!"
	prompt

_GaryVictoryText2ndBattle_AG_AGL::
	text "Ah!"
	line "Great battle!"
	cont "Finally I win!"
	prompt
