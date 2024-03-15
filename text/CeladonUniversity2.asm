; --- magna auditorium ---

_CeladonUniversity2Text1:: ; prof
    text "I'm getting ready"
    line "for the lecture."
    cont "As per usual, we"
    cont "start 15 minutes"
    cont "after o'clock."

    para "Don't tell the"
    line "students, but"
    cont "this is my first"
    cont "time teaching"
    cont "about this topic,"
    cont "so I'm quite"
    cont "thrilled!"
    done

_CeladonUniversity2Text2:: ; student
    text "I'm nervous for"
    line "tomorrow's exam,"
    cont "but I have to"
    cont "attend today's"
    cont "lessons."

    para "Uff, a long night"
    line "of studying"
    cont "awaits me."
    done

_CeladonUniversity2Text3:: ; lovebirds
    text "Uh? What about"
    line "leaving as alone?"
    done

_CeladonUniversity2Text4:: ; lovebirds
    text "Some privacy,"
    line "please?"
    done

_CeladonUniversity2Text5:: ; student
    text "I really like"
    line "ERIKA's lectures,"
    cont "but unfortunately"
    cont "they don't teach"
    cont "here on a"
    cont "constant basis,"
    cont "they only hold"
    cont "colloquiums."

    para "I heard they've"
    line "been offered a"
    cont "position here,"
    cont "but they declined"
    cont "because they're"
    cont "too busy with"
    cont "their GYM duties."
    done

; --- library & study room ---

_CeladonUniversity2Text6:: ; researcher
    text "I'm searching a"
    line "specific book on"
    cont "microprocessor"
    cont "architecture, but"
    cont "I can't happen to"
    cont "find it."
    done

_CeladonUniversity2Text7:: ; student
    text "They are sleeping!"

    para "Under their head,"
    line "you can see some"
    cont "notes about"
    cont "the ruins on"
    cont "ROUTE 29."
    done

; ------------------------------
; PhD student researching on Lapras - ICE ORB -

_CeladonUniversity2Text8_Intro_NoPrompt::
    text "I'm working on my"
    line "PhD thesis about"
    cont "SURFing #MON,"
    cont "but I still need"
    cont "data on the most"
    cont "important one of"
    cont "them all, LAPRAS."

    para "My thesis can't be"
    line "considered"
    cont "complete without"
    cont "info on it, but"
    cont "it lives only in"
    cont "the deepest depth"
    cont "of the SEAFOAM"
    cont "ISLANDS."

    para "That place is"
    line "treacherous, with"
    cont "strong #MON"
    cont "and an harsh"
    cont "environment."

    para "I'm not that good"
    line "of a trainer, so"
    cont "I wasn't able to"
    cont "venture very"
    cont "deep..."

    para "You, although,"
    line "seem quite"
    cont "strong! May I ask"
    cont "you to catch a"
    cont "LAPRAS and show"
    cont "it to me?"

    para "It would help me"
    line "immensely! I'll"
    cont "pay you for this"
    cont "task, of course."
    cont "My PhD funds are"
    cont "not great, but I"
    cont "saved something."
	done

_CeladonUniversity2Text8_Intro_WithPrompt::
    text "I'm working on my"
    line "PhD thesis about"
    cont "SURFing #MON,"
    cont "but I still need"
    cont "data on the most"
    cont "important one of"
    cont "them all, LAPRAS."

    para "My thesis can't be"
    line "considered"
    cont "complete without"
    cont "info on it, but"
    cont "it lives only in"
    cont "the deepest depth"
    cont "of the SEAFOAM"
    cont "ISLANDS."

    para "That place is"
    line "treacherous, with"
    cont "strong #MON"
    cont "and an harsh"
    cont "environment."

    para "I'm not that good"
    line "of a trainer, so"
    cont "I wasn't able to"
    cont "venture very"
    cont "deep..."

    para "You, although,"
    line "seem quite"
    cont "strong! May I ask"
    cont "you to catch a"
    cont "LAPRAS and show"
    cont "it to me?"

    para "It would help me"
    line "immensely! I'll"
    cont "pay you for this"
    cont "task, of course."
    cont "My PhD funds are"
    cont "not great, but I"
    cont "saved something."
	prompt

_CeladonUniversity2Text8_WowAlreadyCaught::
    text "! Wow! You caught"
    line "a LAPRAS"
    cont "already?!"

    para "This is just so"
    line "perfect! So I was"
    cont "right, you do be"
    cont "extraordinary!"

    para "May I see it?"

    para "Yes... yes... as I"
    line "thought... oh..."
    cont "that's"
    cont "unexpected..."
    cont "cool!"

    para "Thanks a ton!"
    line "Here's your"
    cont "payment, please"
    cont "accept it!"
	prompt

_CeladonUniversity2Text8_FoundThisYouCanHaveIt::
    text "Also... I didn't"
    line "make it far when"
    cont "I ventured into"
    cont "the SEAFOAM, but"
    cont "I happened to"
    cont "find this."

    para "Maybe a trainer of"
    line "your caliber may"
    cont "find a good use"
    cont "for it!"
	prompt

_CeladonUniversity2Text8_BagFull::
    text "Oh, your bag is"
    line "full. Please come"
    cont "back."
	done

_CeladonUniversity2Text8_AlreadyRewardedOrb::
    text "Thanks to you, now"
    line "I can finally"
    cont "complete my"
    cont "thesis!"
	done

_CeladonUniversity2Text8_HiBackHaveYouDone::
    text "Welcome back! Have"
    line "you managed to"
    cont "find a LAPRAS"
    cont "already?"
	prompt

_CeladonUniversity2Text8_NotDoneYet::
    text "Oh, you don't have"
    line "a LAPRAS yet."

    para "Take your time."
    line "You know where to"
    cont "find me!"
	done

_CeladonUniversity2Text8_AlreadyRewardedMoneySpaceForOrb::
    text "Hi! Do you have"
    line "space for my gift"
    cont "now?"
	prompt

_CeladonUniversity2Text8_ThanksHereIsReward::
    text "You did! I knew,"
    line "you're amazing!"

    para "May I see it?"

    para "Yes... yes... as I"
    line "thought... oh..."
    cont "that's"
    cont "unexpected..."
    cont "cool!"

    para "Thanks a ton!"
    line "Here's your"
    cont "payment, please"
    cont "accept it!"
	prompt

_CeladonUniversity2Text8_ReceivedIceOrb::
	text "<PLAYER> got"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

; ------------------------------

_CeladonUniversity2Text9:: ; student
    text "Uff. Studying"
    line "together with a"
    cont "coursemate can be"
    cont "quite annoying at"
    cont "times. Too many"
    cont "distractions."
    done

_CeladonUniversity2Text10:: ; student
    text "Ah! Studying"
    line "together with a"
    cont "coursemate is so"
    cont "great! We can"
    cont "help each other"
    cont "and dig deep into"
    cont "the topic!"
    done

_CeladonUniversity2Text11:: ; student
    text "I'm searching a"
    line "book about the"
    cont "LIGHT BALL. It"
    cont "should be around"
    cont "here, but I can't"
    cont "find it..."
    done

; --- computing center ---

_CeladonUniversity2Text12:: ; researcher
    text "We just received a"
    line "new piece of"
    cont "equipment, and"
    cont "I'm going to test"
    cont "and install all"
    cont "the components."
    done

_CeladonUniversity2Text13:: ; researcher
    text "There are ongoing"
    line "studies on the"
    cont "feasibility of"
    cont "using ALAKAZAM"
    cont "and PORYGON to"
    cont "enhance the"
    cont "computing power"
    cont "of our machines."
    done

_CeladonUniversity2Text14:: ; researcher
    text "Oh dear goddess,"
    line "this is a"
    cont "nightmare!"
    cont "So many cables,"
    cont "and not a"
    cont "single label!"
    done

; --- signs ---

; whiteboard: info on Legendary Birds

; --- other ---

_CeladonUniversity2SignTest1::
    text "SIGN TEST 1"
    done

_CeladonUniversity2SignTest2::
    text "SIGN TEST 2"
    done

_CeladonUniversity2SignTest3::
    text "SIGN TEST 3"
    done
