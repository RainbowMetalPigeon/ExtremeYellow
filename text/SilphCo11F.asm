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

; from SilphCo10F -------------------

_SilphCoJessieJamesText1::
	text "Hold it right"
	line "there, brat!@"
	text_end

_SilphCoJessieJamesText2::
	text "Our BOSS is in a"
	line "meeting!"

	para "You better not"
	line "disturb them!"
	done

_SilphCoJessieJamesText3::
	text "Like"
	line "always..."
	prompt

_SilphCoJessieJamesText4::
	text "TEAM ROCKET, blast"
	line "off at the speed"
	cont "of light!"

	para "Again...@"
	text_end

; new for RP =====================================

_SpecialDoorSilphCo11FText::
	text "This door is"
	line "different from"
	cont "the others."

	para "The CARD KEY"
	line "can't open it."
;	xxxx "123456789012345678"
	done

_SilphCo11ScriptText1_RP::
	text "???: Stop!"
;	xxxx "123456789012345678"
	prompt

_SilphCo11ScriptText2_RP::
	text "JESSIE&JAMES: ..."
	line "Well, we know we"
	cont "had our..."
	cont "frictions, yeah."

	para "But we saw how you"
	line "grew into a"
	cont "reliable member"
	cont "of TEAM ROCKET,"
	cont "and... well, if"
	cont "the BOSS trusts"
	cont "you, why shoulnd't"
	cont "we do the same?"
;	xxxx "123456789012345678"
	done

_SilphCo11ScriptText3_RP::
	text "So... Well, we"
	line "want to apologize"
	cont "for having"
	cont "doubted you."
	
	para "You opposed us at"
	line "first, and we"
	cont "were wary..."

	para "But now it's all"
	line "good. Now you're"
	cont "part of the TEAM"
	cont "ROCKET family."

	para "Welcome."
	line "And goodbye."
;	xxxx "123456789012345678"
	done

_SilphCo11Text1_RP::
	text "PRESIDET: Please!"
	line "Save us! I can"
	cont "give you lot of"
	cont "money!"

	para "...what do you"
	line "mean, you'd earn"
	cont "much more with"
	cont "TEAM ROCKET?!"
;	xxxx "123456789012345678"
	done

_SilphCo11Text2_RP::
	text "So sad..."
	line "So young, and yet"
	cont "so corrupted."
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_GoodJobTakeThis::
	text "GIOVANNI: You did"
	line "a good job at our"
	cont "WAREHOUSEs."

	para "Well done. Here,"
	line "have this as a"
	cont "reward."
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_NoRoom::
	text "Make space for"
	line "this."
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_LoreDrop::
	text "GIOVANNI: It's"
	line "time for another"
	cont "assignment."

	para "You must know that"
	line "some time ago I"
	cont "had some people"
	cont "work on a certain"
	cont "project. It was"
	cont "meant to create"
	cont "the strongest"
	cont "#MON ever."

	para "In a way, it"
	line "succeded. But the"
	cont "result, MEWTWO,"
	cont "escaped control"
	cont "and ran away."

	para "Remember that FUJI"
	line "guy you got me?"
	cont "They were the"
	cont "main scientist"
	cont "on that project."
	cont "That's why I"
	cont "wanted them back,"
	cont "to see if we can"
	cont "create another"
	cont "MEWTWO or some-"
	cont "thing like that."

	para "No luck there yet."
	line "But here at"
	cont "SILPH they made a"
	cont "very interesting"
	cont "toy: a BADGE"
	cont "ENERGY AMPLIFIER"
	cont "machine."

	para "With it, I could"
	line "create a new"
	cont "weapon capable of"
	cont "rivaling MEWTWO!"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_BadgeQuest::
	text "GIOVANNI: To make"
	line "the BADGE machine"
	cont "work, guess what,"
	cont "I need all the"
	cont "KANTO BADGEs."

	para "So your new quest's"
	line "simple: fetch me"
	cont "all the missing"
	cont "BADGEs. I already"
	cont "have the EARTH."
	cont "Why else would I"
	cont "be a GYM LEADER?"

	para "And, last but not"
	line "least, you also"
	cont "must bring me the"
	cont "three legendary"
	cont "BIRDs: ARTICUNO,"
	cont "ZAPDOS, MOLTRES."
	cont "We got intel that"
	cont "the ruins on"
	cont "ROUTE 29 may hold"
	cont "some useful info."
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_Poaching::
	text "GIOVANNI: Also, I"
	line "gave you access"
	cont "to the SAFARI"
	cont "ZONE in FUCHSIA."

	para "Go there if you"
	line "need to get new,"
	cont "stronger weapons."

	para "You should now be"
	line "able to access it"
	cont "from OBSIDIAN too."
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_DoYouHaveNewBadgesForMe::
	text "GIOVANNI: Do you"
	line "have new BADGEs"
	cont "for me?"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_NewBadgeWellDone::
	text "Yes, you got a new"
	line "one! Excellent."

	para "Here, have this"
	line "valuable reward."
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_ComeBackWhenHaveBadges::
	text "Come back when you"
	line "have new BADGEs."
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_BroughtAllBadges::
	text "GIOVANNI: You got"
	line "all the other 7"
	cont "BADGEs! Good job."

	para "Did you also catch"
	line "the three"
	cont "legendary BIRDs?"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_NotAllBirbs::
	text "Not yet. Come back"
	line "when you've them."
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_GoBecomeChampion::
	text "GIOVANNI: Go and"
	line "become CHAMPION!"

	para "This way, we'll"
	line "be able to access"
	cont "CERULEAN CAVE and"
	cont "catch MEWTWO!"
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_DidYouBringGene::
	text "GIOVANNI: Did you"
	line "find any organic"
	cont "remnant of MEWTWO"
	cont "for the radar?"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_NoGene::
	text "Nothing yet?"
	line "Then why are you"
	cont "wasting your and"
	cont "my time? Go to"
	cont "CINNABAR, there"
	cont "has to be some-"
	cont "thing in the ex"
	cont "labs. Search the"
	cont "underground floor."
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_PlayerGivesGene::
	text "<PLAYER> gives"
	line "the BERSERK GENE"
	cont "to GIOVANNI!"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_MewtwoIsThereGoChampion::
	text "GIOVANNI: Yes!"
	line "This will do!"
	cont "I'll put it in the"
	cont "radar right away."

	para "Yes... it works!"
	line "It's synchronizing"
	cont "with MEWTWO's"
	cont "signature..."

	para "It found its"
	line "location! It's"
	cont "hiding..."

	para "?! There?"
	line "Ahahah! Fitting!"

	para "CERULEAN CAVE!"
	line "Maybe the one"
	cont "place where even"
	cont "TEAM ROCKET has"
	cont "a hard time"
	cont "sneaking in!"

	para "So we'll do things"
	line "the intended"
	cont "way: only INDIGO"
	cont "CHAMPIONs are"
	cont "allowed in?"
	cont "Then we'll get our"
	cont "own CHAMPION."

	para "Take this!"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_GotEarthBadge::
	text "<PLAYER> receives"
	line "the EARTH BADGE!@"
;	xxxx "123456789012345678"
	text_end

_SilphCo11TextGiovanni_RP_NowGoBecomeChampion::
	text "With this you can"
	line "go to the INDIGO"
	cont "PLATEAU, beat the"
	cont "shit out of the"
	cont "LEAGUE, and"
	cont "become CHAMPION"
	cont "for me!"
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_FujiToldUs::
	text "GIOVANNI: And the"
	line "good news keep"
	cont "coming!"

	para "I 'convinced' FUJI"
	line "to collaborate,"
	cont "and they built me"
	cont "a radar that will"
	cont "locate MEWTWO."
	cont "With that and the"
	cont "MASTER BALL I got"
	cont "from SILPH, I can"
	cont "finally tame it!"

	para "Problem is, it"
	line "needs some of"
	cont "MEWTWO's DNA."
	cont "Go to CINNABAR,"
	cont "and search the ex"
	cont "labs there. There"
	cont "must be some bio-"
	cont "logical remnant."
	cont "Find it and bring"
	cont "it to me."
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_PlayerGivesBirbs::
	text "<PLAYER> gives"
	line "ARTICUNO, ZAPDOS"
	cont "and MOLTRES to"
	cont "GIOVANNI!"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_GimmeTheBirbs::
	text "Now, give me the"
	line "three BIRDs!"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_GetAnotherMon::
	text "This won't do."
	line "Fetch yourself at"
	cont "least another"
	cont "#MON. You can't"
	cont "ever be without"
	cont "any weapons."
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_YesAllBirbs::
	text "Yes! You caught"
	line "them all!"
	cont "Wonderful job!"
	cont "I knew I could"
	cont "leave this to"
	cont "you."
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_ChampionGreatDoYouHaveMewtwo::
	text "GIOVANNI: Ahahah!"
	line "Welcome back,"
	cont "CHAMPION! Good"
	cont "job, as always."

	para "How did it go?"
	line "Was it tough?"

	para "...what did you"
	line "say? PROF.OAK"
	cont "opposed you and"
	cont "you had to...?"

	para "..."
	line "...SAMUEL..."

	para "..."
	line "...well, you did"
	cont "what needed to"
	cont "be done."

	para "It's not like"
	line "there were"
	cont "alternatives..."

	para "...Anyway!"
	line "Back to business."
	cont "Have you caught"
	cont "MEWTWO already?"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_NoMewtwos::
	text "No? Then go to"
	line "CERULEAN CAVE and"
	cont "submit it."

	para "Be sure to not let"
	line "it escape. You"
	cont "won't get a second"
	cont "chance with it."
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_YouDidItMyTeamIsComplete::
	text "YES! You did it!"
	line "Finally! After"
	cont "all this time!"

	para "Quick! Give it!"
	line "Give it to me!!!"

	para "<PLAYER> gives"
	line "MEWTWO to"
	cont "GIOVANNI!"
;	xxxx "123456789012345678"
	prompt

_SilphCo11TextGiovanni_RP_NowBegone::
	text "GIOVANNI: YES!!!"
	line "My ultimate team's"
	cont "finally complete!"

	para "Stronger than"
	line "ever! Nobody will"
	cont "ever be able to"
	cont "oppose me!"

	para "Nobody!!! Ever!!!"

	para "...well, actually,"
	line "there is maybe"
	cont "ONE person who"
	cont "worries me a bit."

	para "Somebody who grew"
	line "so quickly and"
	cont "become so strong."

	para "It would be a"
	line "liability to"
	cont "leave such a"
	cont "person around,"
	cont "don't you think?"

	para "Ahah! Be proud of"
	line "yourself <PLAYER>!"
	cont "You'll be the"
	cont "first victim of"
	cont "my ultimate team!"
	cont "You served me"
	cont "well, but now I"
	cont "don't need you"
	cont "anymore."

	para "Begone!"
;	xxxx "123456789012345678"
	done

_SilphCo11FGiovanniRPDefeatText::
	text "Th-th-"
	line "that's... that's"
	cont "impossible!!!"

	para "How?! How could I"
	line "possibly lose?!"
;	xxxx "123456789012345678"
	prompt

_SilphCo11ScriptText4_RP::
	text "GIOVANNI: I..."
	line "...wait, it..."

	para "I was joking, of"
	line "course! It was..."
	cont "It was a test!"
	cont "I wanted to test"
	cont "your strength!"

	para "And you passed"
	line "with flying"
	cont "colors! N-now I"
	cont "can officially"
	cont "make you my"
	cont "right arm, what"
	cont "do you thi-"
;	xxxx "123456789012345678"
	done

_SilphCo11ScriptText5_RP::
	text "AAARGH!"
	line "Wait, listen!"
;	xxxx "123456789012345678"
	done

_SilphCo11ScriptText6_RP::
	text "No, wait!"
	line "Stop!"
	cont "I'm begging you!"
;	xxxx "123456789012345678"
	done

_SilphCo11ScriptText7_RP::
	text "It... hurts..."
	line "AAAHHH!"
	cont "It hurts so much!"
;	xxxx "123456789012345678"
	done

_SilphCo11ScriptText8_RP::
	text "I... no..."
	line "No..."
	cont "I feel cold..."
	cont "All this blood..."
	cont "Is it..."
	cont "Really..."
	cont "...mine...?"
;	xxxx "123456789012345678"
	done

_SilphCo11TextGiovanni_RP_StealBallExplanation::
	text "The STEAL BALL's a"
	line "special BALL,"
	cont "developed from"
	cont "the MASTER BALL"
	cont "and improved to"
	cont "be able to catch"
	cont "any #MON."

	para "And with any,"
	line "I mean ANY."
	cont "Someone has some-"
	cont "thing you like?"
	cont "Just get it."

	para "Unfortunately it's"
	line "very harsh on the"
	cont "target, thus the"
	cont "newly acquired"
	cont "weapon'll be out"
	cont "of ammonitions."
	cont "Keep that in mind."
;	xxxx "123456789012345678"
	done
