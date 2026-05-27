_Route22RivalBeforeBattleText1::
	text "<RIVAL>: What?"
	line "<PLAYER>?!"

	para "Are you following"
	line "me or something?!"

	para "I told you, I"
	line "don't need your"
	cont "help to complete"
	cont "the quest that"
	cont "Gramps entrusted"
	cont "to me!"

	para "So stop trying to"
	line "steal the spot-"
	cont "light from me, it"
	cont "will be me who'll"
	cont "make Gramps"
	cont "proud!"

	para "And while I will"
	line "catch all the"
	cont "#MON that"
	cont "exist, I will"
	cont "become the"
	cont "strongest trainer"
	cont "and conquer the"
	cont "#MON LEAGUE!"
	done

_Route22RivalDefeatedText1::
	text "Tsk!"
	line "Mere luck!"
	prompt

_Route22Text_511bc::
	text "See?"
	para "You aren't fit for"
	line "any of this."

	para "Give up already!"
	prompt

_Route22RivalAfterBattleText1::
	text "Don't get your"
	line "hopes high, you"
	cont "are still a"
	cont "nobody."

	para "You will not"
	line "defeat me again!"

	para "I will get the"
	line "strongest #MON"
	cont "and give them the"
	cont "hardest training!"

	para "I will crush you,"
	line "the #MON"
	cont "LEAGUE, and any-"
	cont "one who will dare"
	cont "opposing me!"
	done

; 7th match -------------------

_Route22RivalBeforeBattleText2::
	text "<RIVAL>: Of course"
	line "you would come"
	cont "here too!"

	para "I won't let you"
	line "desecrate the"
	cont "prestigious"
	cont "#MON LEAGUE"
	cont "with your filthy"
	cont "presence!"

	para "I will defeat the"
	line "ELITE FOUR and"
	cont "return to my"
	cont "Gramps with the"
	cont "title of CHAMPION"
	cont "and a complete"
	cont "#DEX!"

	para "And to achieve so,"
	line "I first need to"
	cont "destroy you once"
	cont "and for all."

	para "My soulmate, my"
	line "starter, never"
	cont "has had a more"
;	xxxx "123456789012345678"
	cont "fitting team!"

	para "You're going down!"
	done

_Route22RivalDefeatedText2::
	text "No..."
	line "Enough... I can't"
	cont "stand this"
	cont "anymore..."
	prompt

_Route22Text_511d0::
	text "Hahaha!"

	para "Yes, yes! Weep and"
	line "cry in utter des-"
	cont "peration, loser!"
	prompt

_Route22RivalAfterBattleText2::
	text "<RIVAL>: This is"
	line "unbearable..."

	para "I cannot keep on"
	line "losing against"
	cont "you!"

	para "I have... I must"
	line "find a way to"
	cont "defeat you, to"
	cont "completely crush"
	cont "you, to prove"
	cont "once and for all"
	cont "that I'm better"
	cont "than you!"

	para "And... I may just"
	line "know what is"
	cont "needed..."
	done

_Route22FrontGateText::
	text "#MON LEAGUE"
	line "Front Gate"
	done

; new, Coin-Case Meowth

_ReceivedCoinCaseText:: ; edited
	text "<PLAYER> obtained"
	line "a COIN CASE@"
	text "!@"
	text_end

_CoinCaseStillHasCoinsText::
	text "It still has a"
	line "few coins in!"
;	xxxx "123456789012345678"
	prompt

_CoinCaseExplanationText:: ; new
	text "The COIN CASE got"
	line "embedded in the"
	cont "back of the"
	cont "TRAINER CARD."
	done

; new, randomized Pokémon giver ---------------------

_Route22RandomizedPokemonGiverText_Enjoy::
	text "PHEW...!"

	para "The summoning is"
	line "complete! I hope"
	cont "you'll be happy"
	cont "with your unique"
	cont "companion."
;	xxxx "123456789012345678"
	prompt

_Route22RandomizedPokemonGiverText_NotReadyForSecond::
	text "I may be able to"
	line "summon another"
	cont "random #MON"
	cont "with random types"
	cont "and moves, but I"
	cont "need to recover"
	cont "further."

	para "Come back later."
;	xxxx "123456789012345678"
	done

_Route22RandomizedPokemonGiverText_NothingMore::
	text "There's no way I'll"
	line "be able to summon"
	cont "any more #MON."

	para "Don't ask me the"
	line "impossible."
;	xxxx "123456789012345678"
	done

_Route22RandomizedPokemonGiverText_IntroFirst::
	text "I have the power"
	line "to concoct a"
	cont "special #MON"
	cont "like no others."

	para "Its species, as"
	line "well as its types"
	cont "and its initial"
	cont "moves, will be"
	cont "totally random!"

	para "Mind that I can"
	line "summon such a"
	cont "creature only"
	cont "once. Perhaps"
	cont "twice, but I'd"
	cont "need vast lengths"
	cont "of time to rest."
;	xxxx "123456789012345678"
	prompt

_Route22RandomizedPokemonGiverText_IntroSecond::
	text "Finally I"
	line "recovered the"
	cont "energy necessary"
	cont "to summon another"
	cont "unique #MON!"

	para "I even refined my"
	line "ritual: this time"
	cont "the creature will"
	cont "be more powerful"
	cont "than ever before!" 
;	xxxx "123456789012345678"
	prompt

_Route22RandomizedPokemonGiverText_AreYouSure::
	text "Do you want to"
	line "proceed? You sure?"
;	xxxx "123456789012345678"
	done

_Route22RandomizedPokemonGiverText_ComeBackWhenReady::
	text "I understand. Come"
	line "back when ready."
	cont "If you'll ever be."
;	xxxx "123456789012345678"
	done
