_LanceBeforeBattleText:: ; edited
	text "Ah! I heard about"
	line "you, <PLAYER>!"

	para "I lead the ELITE"
	line "FOUR! You can"
	cont "call me LANCE the"
	cont "dragon trainer!"

;	para "You know that"
;	line "dragons are"
;	cont "mythical #MON!"
;
;	para "They're hard to"
;	line "catch and raise,"
;	cont "but their powers"
;	cont "are superior!"

;	para "They're virtually"
;	line "indestructible!"

	para "My legendary"
	line "DRAGONs are"
	cont "powerful engines"
	cont "of destruction!"
	cont "Virtually"
	cont "invincible, very"
	cont "few have faced"
	cont "these awesome"
	cont "creatures and"
	cont "lived to tell"
	cont "the tale!"
;	xxxx "123456789012345678"

	para "Well, are you"
	line "ready to lose?"

	para "Your LEAGUE"
	line "challenge ends"
	cont "with me, <PLAYER>!"
	done

_LanceEndBattleText::
	text "That's it!"

	para "I hate to admit"
	line "it, but you are a"
	cont "#MON master!"
	prompt

_LanceAfterBattleText::
	text "I still can't"
	line "believe my"
	cont "dragons lost to"
	cont "you, <PLAYER>!"

	para "You are now the"
	line "#MON LEAGUE"
	cont "champion!"

	para "...Or, you would"
	line "have been, but"
	cont "you have one more"
	cont "challenge ahead."

	para "You have to face"
	line "another trainer!"
	cont "Their name is..."

	para "<RIVAL>!"
	line "They beat the"
	cont "ELITE FOUR"
	cont "before you!"

	para "They are the real"
	line "#MON LEAGUE"
	cont "champion!"

	para "And... let me tell"
	line "you this."

	para "They are"
	line "absolutely"
	cont "frightening."

	para "I never saw a"
	line "trainer battling"
	cont "with such"
	cont "overwhelming"
	cont "fury.@"
	text_end

; new -------------------------------

_LanceBeforeBattleTextRematch::
	text "I salute you,"
	line "CHAMPION."

	para "It is an honor to"
	line "be standing on"
	cont "the battlefield"
	cont "against you one"
	cont "more time."

	para "Your deeds have"
	line "changed this"
	cont "region and its"
	cont "people more than"
	cont "you can imagine."

	para "I am thrilled to"
	line "measure myself"
	cont "with you again."
	cont "I, LANCE,"
	cont "challenge with"
	cont "with my ultimate"
	cont "dragons!"
	done

_LanceEndBattleTextRematch::
	text "That's it!"

	para "You beat the best"
	line "of my best!"
	prompt

_LanceAfterBattleTextRematch::
	text "Despite all my"
	line "efforts, the"
	cont "power of my"
	cont "dragons, and our"
	cont "determination..."
	cont "you won!"

	para "<PLAYER>! You are"
	line "astounding!"

	para "I would love to"
	line "crown you"
	cont "CHAMPION once"
	cont "again..."

	para "But I guess it"
	line "comes as no"
	cont "surprise that"
	cont "there is one more"
	cont "person that is"
	cont "dying to fight"
	cont "against you."

	para "Proceed now, and"
	line "face <RIVAL> in"
	cont "the highest of"
	cont "all battles!@"
	text_end ; why?

_LanceBeforeBattleTextRematch2::
	text "CHAMPION <PLAYER>!"
	line "You honour me by"
	cont "facing me again"
	cont "on this sacred"
	cont "battlefield!"

	para "We were struck in"
	line "awe when we heard"
	cont "of your"
	cont "achievements in"
	cont "the SEVII TRIAL."

	para "And that fueled"
	line "our fighting"
	cont "spirit even more!"

	para "Are you ready to"
	line "measure yourself"
	cont "against my flock"
	cont "of dragons, now"
	cont "more invincible"
	cont "than ever?"
;	xxxx "123456789012345678"
	done

_LanceEndBattleTextRematch2::
	text "And yet,"
	line "you emerged once"
	cont "again victorious!"
;	xxxx "123456789012345678"
	prompt

_LanceAfterBattleTextRematch2::
	text "Unfathomable."
	line "Your skills and"
	cont "power seem limit-"
	cont "less. Wonderful."

	para "I have no more to"
	line "say. Except..."

	para "As you probably"
	line "have suspected,"
	cont "us ELITE FOUR"
	cont "were not the only"
	cont "ones who heard of"
	cont "your deeds and"
	cont "improved."

	para "Go ahead. One last"
	line "fight awaits in"
	cont "the INDIGO ORDEAL."
;	xxxx "123456789012345678"
	done

; new for RP ===============================

_LanceBeforeBattleText_RP::
	text "I am LANCE of"
	line "the ELITE FOUR."

	para "If you managed to"
	line "reach me it means"
	cont "you're up to what"
	cont "I heard of you."

	para "But your path ends"
	line "here and now,"
	cont "because I, the"
	cont "DRAGON master,"
	cont "will stop you in"
	cont "your way, once"
	cont "and for all!"
;	xxxx "123456789012345678"
	done

_LanceEndBattleText_RP::
	text "No! It"
	line "cannot be!"
;	xxxx "123456789012345678"
	prompt

_LanceAfterBattleText_RP_Before::
	text "I can't believe my"
	line "DRAGONs lost!"
	cont "That I lost!"

	para "...umph. Normally"
	line "it'd pain me to"
	cont "admit it, but"
	cont "in this moment I'm"
	cont "glad that there's"
	cont "someone even"
	cont "stronger than me."

	para "They WILL stop"
	line "you, I'm sure of"
	cont "that. Go on,"
	cont "and face them."
;	xxxx "123456789012345678"
	done

_LanceAfterBattleText_RP_After::
	text "I heard screaming!"
	line "What happened in"
	cont "there...?"

	para "What did you do?!"
;	xxxx "123456789012345678"
	done

_LanceBeforeBattleText_RP_Pink::
	text "You."

	para "You dare to show"
	line "your face here"
	cont "one more time."

	para "I'll prevent our"
	line "new leader from"
	cont "being forced to"
	cont "look at your"
	cont "face once again."

	para "You're going down"
	line "by my ultimate"
	cont "power."
;	xxxx "123456789012345678"
	done

_LanceEndBattleText_RP_Pink::
	text "This doesn't"
	line "make any sense!"
;	xxxx "123456789012345678"
	prompt

_LanceAfterBattleText_RP_Pink_Core::
	text "How could I lose"
	line "again to a filthy"
	cont "criminal?!"

	para "After all that"
	line "we've trained!"
	cont "I thought I"
	cont "achieved"
	cont "perfection!"

	para "What are yo-? No!"
	line "AAAAHHH!!!"
;	xxxx "123456789012345678"
	done
