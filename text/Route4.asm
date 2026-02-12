_Route4Text1::
	text "Ouch! I tripped"
	line "over a rocky"
	cont "#MON, GEODUDE!"
	done

_Route4TextHiker1:: ; new
	text "A rockslide has"
	line "blocked the"
	cont "way towards"
	cont "CERULEAN CITY!"

	para "We are waiting"
	line "for a team of"
	cont "MACHAMPs to"
	cont "arrive and help."

	para "Until then, the"
	line "only path is"
	cont "through MT.MOON!"
	done

_Route4TextHiker2:: ; new
	text "Dammit! This is"
	line "such a pain."

	para "Luckily the"
	line "MACHAMPs should"
	cont "arrive any minute"
	cont "now!"
	done

_Route4BattleText1:: ; edited
	text "I want to explore"
	line "that intriguing"
	cont "cave, but the"
	cont "guard stopped me."

	para "Apparently only"
	line "CHAMPIONs can"
	cont "enter it."

	para "Well, it means I"
	line "must become one!" 
	done

_Route4EndBattleText1:: ; edited
	text "Damn!"
	line "I am not ready."
	prompt

_Route4AfterBattleText1:: ; edited
	text "I am not happy I"
	line "lost to you, but"
	cont "I am glad that I"
	cont "learn something."

	para "This brings me one"
	line "step closer to my"
	cont "goal of becoming"
	cont "CHAMPION!"
	done

_Route4Text5::
	text "MT.MOON"
	line "Tunnel Entrance"
	done

_Route4Text6::
	text "ROUTE 4"
	line "MT.MOON -"
	cont "CERULEAN CITY"
	done

; ===============================

_Route4SpecialBirdKeeperText_Pre::
	text "Hey! An important"
	line "question for you!"

	para "Do you like birbs?"

	para "No! No need for"
	line "words. Answer me"
	cont "with a battle!"
;	xxxx "123456789012345678"
	done

_Route4SpecialBirdKeeperText_AfterBattle::
	text "Ah!"
	line "I feel the fire!"
	cont "Fire for birbs!"
;	xxxx "123456789012345678"
	prompt

_Route4ScriptText1::
	text "Yes, yes... I can"
	line "sense it! A love"
	cont "for birbs, still"
	cont "not nurtured..."

	para "I know! No better"
	line "way to bond with"
	cont "the birbs than"
	cont "feeding them!"

	para "Here, have some"
	line "of my SEEDs!"
;	xxxx "123456789012345678"
	done

_Route4ScriptText2::
	text "<PLAYER> can now"
	line "feed the birbs!"
;	xxxx "123456789012345678"
	done

_Route4ScriptText3::
	text "Meet and feed all"
	line "of the birbs!"
	
	para "This way, the way"
	line "of the birds will"
	cont "undoubtedly grow"
	cont "strong in you!"

	para "I gotta go now."
	line "I must persevere"
	cont "in my quest for"
	cont "the ultimate"
	cont "birbs."

	para "I'm sure we'll meet"
	line "again! See ya!"
;	xxxx "123456789012345678"
	done
