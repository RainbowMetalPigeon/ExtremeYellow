_SilphCoPresidentText::
	text "PRESIDENT: Thank"
	line "you for saving"
	cont "SILPH!"

	para "I will never"
	line "forget you saved"
	cont "us in our moment"
	cont "of peril!"

	para "I have to thank"
	line "you in some way!"

	para "Because I am rich,"
	line "I can give you"
	cont "anything!"

	para "Here, maybe this"
	line "will do!"
	prompt

_ReceivedSilphCoMasterBallText::
	text "<PLAYER> got a"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_SilphCo10Text_6231c:: ; edited
	text "PRESIDENT: You"
	line "can't buy that"
	cont "anywhere!"

	para "It's our secret"
	line "prototype, the"
	cont "MASTER BALL!"

	para "It will catch any"
	line "#MON without"
	cont "fail!"

	para "TEAM ROCKET was"
	line "after this, as"
	cont "well as our other"
	cont "prototype."
	done

_SilphCoMasterBallNoRoomText::
	text "You have no"
	line "room for this."
	done

_SilphCo11Text2:: ; edited
	text "SECRETARY: Thank"
	line "you for rescuing"
	cont "all of us!"

	para "We admire your"
	line "courage."

	para "TEAM ROCKET was"
	line "trying to get"
	cont "their hands on"
	cont "our latest tech:"
	cont "the MASTER BALL"
	cont "and the #MON"
	cont "BADGE ENERGY"
	cont "AMPLIFIER machine."

;	para "One can only fear"
;	line "what they'd have"
;	cont "done with them if"
;	cont "you hadn't stopped"
;	cont "them! Thank you!"
;	xxxx "123456789012345678"
	done

_SilphCo11Text3::
	text "You again!!!"

	para "Why do you"
	line "keep sticking"
	cont "your nose in"
	cont "TEAM ROCKET's"
	cont "business?!"

	para "Who are you? Who"
	line "sent you, the"
	cont "police? Are you"
	cont "a plainclothes"
	cont "agent?!"

	para "It doesn't matter!"
	line "My weapons are"
	cont "stronger than"
	cont "ever, I'll crush"
	cont "you for good this"
	cont "time!"
	done

_SilphCo10Text_62330::
	text "Arrgh!!"
	line "I lost again!?"
	prompt

_SilphCo10Text_62335::
	text "You little piece"
	line "of shit...!"

	para "No! You will not"
	line "catch me! My life"
	cont "cannot end here!"

	para "Remember, TEAM"
	line "ROCKET doesn't"
	cont "forget nor"
	cont "forgive!"
	cont "We will get you"
	cont "and your beloved"
	cont "ones when you"
	cont "least expect it!"
	done

_SilphCo11BattleText2:: ; edited
	text "Halt! Do you have"
	line "an appointment"
	cont "with our BOSS?"
	done

_SilphCo11EndBattleText2::
	text "Gaah!"
	line "Demolished!"
	prompt

_SilphCo11AfterBattleText2:: ; edited
	text "Watch your steps,"
	line "the BOSS has"
	cont "super-tough"
	cont "#MON!"
	done

; new -------------------------------------

_SilphCo11SignText1::
	text "It's an expensive-"
	line "looking portrait"
	cont "of the PRESIDENT."

	para "...they look much"
	line "younger, slimmer,"
	cont "friendlier,"
	cont "happier,"
	cont "and healthier"
	cont "than in person."
;	xxxx "123456789012345678"
	done
	
_SilphCo11SignText2_1::
	text "It contains info"
	line "on the latest"
	cont "SILPH inventions!"

	para "MASTER BALL:"
	line "100% catch..."
	cont "Extortiate..."
	cont "Experimental..."

	para "BADGE ENERGY"
	line "AMPLIFIER"
	cont "machine:"
	cont "Unstable..."
	cont "Dangerous..."
	cont "Fuse...?"

	para "And then what's"
	line "this? A #MON?"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextBadgeMachine_WantThuFiZer::
	text "The machine reacts"
	line "to the presence"
	cont "of your #MON!"

	para "Do you want to"
	line "fuse ARTICUNO,"
	cont "ZAPDOS, and"
	cont "MOLTRES into"
	cont "THU-FI-ZER?"
	done

_SilphCo11TextBadgeMachine_WantVenustoise::
	text "The machine reacts"
	line "to the presence"
	cont "of your #MON!"

	para "Do you want to"
	line "fuse VENUSAUR and"
	cont "BLASTOISE into"
	cont "VENUSTOISE?"
	done

_SilphCo11TextBadgeMachine_NotNow::
	text "Not just now."
;	xxxx "123456789012345678"
	done

_SilphCo11TextBadgeMachine_NotEnoughBadges::
	text "A weird machine."
	line "It has 8 slots,"
	cont "shaped like the"
	cont "KANTO BADGEs."
	done

_SilphCo11TextBadgeMachine_EnoughBadges::
	text "You temporarily"
	line "place your BADGEs"
	cont "into the machine."

	para "It turns on!"
	prompt

_SilphCo11TextBadgeMachine_Nope::
	text "It seems something"
	line "is still missing."
	done
