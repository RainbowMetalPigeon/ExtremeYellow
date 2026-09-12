_ObsidianMinesBattleText1::
    text "AAAHHH!!!"
    done

_ObsidianMinesEndBattleText1::
    text "Uh?!"
    prompt

_ObsidianMinesAfterBattleText1::
    text "Sorry, I've been"
    line "lost in these"
    cont "MINES for so long"
    cont "and when I saw"
    cont "someone appearing"
    cont "right when I was"
    cont "so close to the"
    cont "exit..."
    done

; ----------------------------------

_ObsidianMinesText2_1::
    text "I love this place."
    line "It's so quiet"
    cont "when nobody is"
    cont "mining,"
    cont "absolutely"
    cont "perfect for"
    cont "relaxing in"
    cont "solitude."
    done

; ----------------------------------

_ObsidianMinesText3_Intro::
    text "Oh goddess, yes,"
    line "someone!!!"

    para "I've been lost for"
    line "days! I need an"
    cont "ESCAPE ROPE! Do"
    cont "you have one?!"
    prompt

_ObsidianMinesText3_CouldGiveRope::
    text "Yes?! Please, can"
    line "you give me one?!"
    cont "Not for free, I"
    cont "will repay you!"
    done

_ObsidianMinesText3_ThanksHereGift::
    text "Oh, my saviour!!!"
    line "Thank you, thank"
    cont "you, a thousand"
    cont "time thank you!"

    para "Here, please"
    line "accept this gift!"
    prompt

_ObsidianMinesText3_ThanksATon::
    text "Have this BIG"
    line "NUGGET I found"
    cont "while I was"
    cont "exploring around!"

    para "I'm fed up with"
    line "caves! I'll have"
    cont "a fishing"
    cont "vacation"
    cont "somewhere"
    cont "tranquil."

    para "See you, and"
    line "thanks again!"
    done

_ObsidianMinesText3_NoRope::
    text "Oh nooo, you don't"
    line "have it either!!!"
    done

_ObsidianMinesText3_Asshole::
    text "What the solid"
    line "actual fuck?!"

    para "Would you leave me"
    line "dying here?!"
    done

_ObsidianMinesText3_BagFull::
    text "Oh, your bag"
    line "is full!"

    para "I can't not"
    line "reward you!"
    done

; new for RP =================================

_ObsidianMinesText3_RP_StealNugget::
    text "Oh goddess, yes,"
    line "someone!!!"

    para "I've been lost for"
    line "days! I ne-"

    para "You're a ROCKET?"
    line "Well... you won't"
    cont "leave me dying"
    cont "here, right?"
    cont "I can even pay"
    cont "you to get me"
    cont "out of thi-"

    para "AAARGH!"
    line "No! Wait! Stop!"
    cont "What're you doing?"
;	xxxx "123456789012345678"
	prompt

_ObsidianMinesText3_RP_StoleNugget::
	text "<PLAYER> steals a"
    line "BIG NUGGET!"
;	xxxx "123456789012345678"
	done

_ObsidianMinesText3_RP_StealMap::
	text "...No... please..."
    line "Have mercy..."

    para "Agh! What else do"
    line "you still want"
    cont "from me? No!!!"
;	xxxx "123456789012345678"
	prompt

_ObsidianMinesText3_RP_StoleMap::
	text "<PLAYER> steals a"
	line "piece of the"
	cont "MYSTERY MAP!"
;	xxxx "123456789012345678"
	done

_ObsidianMinesText3_RP_PostMap::
	text "You are the worst"
    line "piece of shit of"
    cont "the whole world..."
;	xxxx "123456789012345678"
	done
