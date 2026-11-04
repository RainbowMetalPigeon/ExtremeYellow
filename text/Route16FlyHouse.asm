_Route16HouseText3::
	text "Oh, you found my"
	line "secret retreat!"

	para "It seems you like"
	line "exploring."
	cont "I really like"
	cont "traveling. I even"
	cont "made a HM just"
	cont "for that!"

	para "I'll be happy to"
	line "share it with you"
	cont "if you bring me a"
	cont "travel proof."
	cont "A sweet from a"
	cont "faraway place"
	cont "will do!"
	done

_Route16HouseText_YesCookie::
	text "Oh! You have an"
	line "exotic goodie"
	cont "for me!"

	para "Thanks! You can"
	line "have this!"
;	xxxx "123456789012345678"
	prompt

_Route16HouseText_NoCookie::
	text "Proxy"
;	xxxx "123456789012345678"
	prompt

_ReceivedHM02Text::
	text "<PLAYER> received"
	line "HM02 FLY!@"
	text_end

_HM02ExplanationText::
	text "HM02 is FLY."
	line "It will take you"
	cont "back to any town."

	para "Put it to good"
	line "use!"
	done

_Route16HouseText_1e652::
	text "FEAROW: Kyueen!"
	done

; new for RP ---------------------

_Route16HouseText2_RP_PostHM::
	text "FEAROW: Kyyy..."

	para "...pathetic."

	para "Still, may as well"
	line "take it, instead"
	cont "of letting a"
	cont "weapon rot."
;	xxxx "123456789012345678"
	prompt

_Route16HouseText2_RP_PostDefeat::
	text "FEAROW: Kyyy..."

	para "...pathetic."
;	xxxx "123456789012345678"
	done

_Route16HouseText1_RP_PostFly::
	text "You have nothing"
	line "more to earn"
	cont "from me! Now"
	cont "leave us alone!"
;	xxxx "123456789012345678"
	done

_Route16HouseText1_RP_PreFly::
	text "Hey! How did you"
	line "find this place?"

	para "Tsk. It doesn't"
	line "matter. There's"
	cont "nothing here for"
	cont "you. Just leave."
;	xxxx "123456789012345678"
	done

_Route16HouseText1_RP_PostFearow::
	text "You revolting"
	line "bastard...!"
	cont "How could you?!"
;	xxxx "123456789012345678"
	done

_Route16HouseText1_RP_TakeFly::
	text "Here! Take it!"
	line "Just leave me and"
	cont "FEAROW alone now!"
;	xxxx "123456789012345678"
	prompt

_Route16HouseScriptText1_RP::
	text "No! Stop! Stop!!!"
	line "Don't hurt my"
	cont "FEAROW!"

	para "I get it! You won!"
	line "I'll surrender"
	cont "my HM to you!"
;	xxxx "123456789012345678"
	done
