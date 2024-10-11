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
    text "I'm searching for a"
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
    cont "and a harsh"
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
    text "I'm searching for a"
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

; --- other (books) ---

_CeladonUniversity2SignBook01::
    text "#MON, ALL TOO"
    line "#MON"
    done

_CeladonUniversity2SignBook02::
    text "WHO WAS THE FIRST"
    line "#MON?"
    done

_CeladonUniversity2SignBook03::
    text "DINING WITH"
    line "#MON"
    done

_CeladonUniversity2SignBook04::
    text "MARRYING #MON?"
    line "A HISTORICAL"
    cont "OVERVIEW"
    done

_CeladonUniversity2SignBook05::
    text "ASSEMBLY FOR"
    line "BEGINNERS"
    done

_CeladonUniversity2SignBook06::
    text "THE DARKEST OF"
    line "ALL LEGENDS"

    para "The first novel of"
    line "RAINBOW METAL"
    cont "PIGEON!"
    done

_CeladonUniversity2SignBook07::
    text "GAME FREAK"
    line "NUMBER 13"

    para "A kid seems to be"
    line "trying to catch"
    cont "some bugs."
    cont "Relatable..."
    done

_CeladonUniversity2SignBook08::
    text "HOW DO #MON"
    line "REPRODUCE?"
    done

_CeladonUniversity2SignBook09::
    text "INVESTIGATION ON"
    line "USAGE OF"
    cont "#BALLS ON"
    cont "HUMANS"
    done

_CeladonUniversity2SignBook10::
    text "DO WE LIVE IN"
    line "A SIMULATION?"
    done

_CeladonUniversity2SignBook11::
    text "THEORY OF THE"
    line "MULTIDIMENSIONAL"
    cont "MODEL"
    done

_CeladonUniversity2SignBook12::
    text "WHO CAME FIRST:"
    line "THE EXEGGCUTE OR"
    cont "THE FARFETCH'D?"
    done

_CeladonUniversity2SignBook13::
    text "GEOLOGICAL HISTORY"
    line "OF KANTO"
    done

_CeladonUniversity2SignBook14::
    text "SURVEY ON CINNABAR"
    line "VOLCANIC"
    cont "ACTIVITIES AND"
    cont "RISKS FOR"
    cont "SETTLEMENTS"
    done

_CeladonUniversity2SignBook15::
    text "HOW CAN ALL"
    line "FARFETCH'D ALWAYS"
    cont "HAVE A LEEK WITH"
    cont "THEM?"
    done

_CeladonUniversity2SignBook16::
    text "SMOGON SINGLES"
    line "OR VGC?"
    done

_CeladonUniversity2SignBook17::
    text "INTRODUCTION TO"
    line "QUANTUM"
    cont "#DYNAMIC"
    done

_CeladonUniversity2SignBook18::
    text "ONE, NONE, AND"
    line "100'000 #MON"
    done

_CeladonUniversity2SignBook19::
    text "DAMAGE CALCULATION"
    line "BREAKDOWN"
    done

_CeladonUniversity2SignBook20::
    text "HOW CAN #MON BE"
    line "CONFUSED WHILE"
    cont "ASLEEP?"
    done

_CeladonUniversity2SignBook21::
    text "WHY CANNOT #MON"
    line "BE PARALYZED AND"
    cont "BURNED?"
    done

_CeladonUniversity2SignBook22::
    text "#BALL MECHANIC:"
    line "FORGOTTEN"
    cont "TRANQUILLIZER"
    done

_CeladonUniversity2SignBook23::
    text "2042"
    done

_CeladonUniversity2SignBook24::
    text "#MON FARM"
    done

_CeladonUniversity2SignBook25::
    text "SURVEY ON THE"
    line "ATTEMPTS AT"
    cont "CULTIVATING"
    cont "APRICORNS"
    cont "IN KANTO"
    done

_CeladonUniversity2SignBook26::
    text "ARE KANGASKHAN"
    line "BORN WITH AN"
    cont "INFANT IN THEIR"
    cont "POCKET?"
    done

_CeladonUniversity2SignBook27::
    text "HOW TO CATCH TWO"
    line "PIDGEY WITH ONE"
    cont "#BALL"
    done

_CeladonUniversity2SignBook28::
    text "TECHNICAL OVERVIEW"
    line "ON THE STRUCTURAL"
    cont "STABILITY OF"
    cont "CINNABAR MANSION"
    done

_CeladonUniversity2SignBook29::
    text "OVERVIEW ON THE"
    line "SIGHTINGS OF"
    cont "#MON"
    cont "DISPLAYING"
    cont "CHROMATIC"
    cont "ANOMALIES"
    done

_CeladonUniversity2SignBook30::
    text "USING ELECTRIC"
    line "#MON TO"
    cont "PRODUCE"
    cont "ELECTRICITY FOR"
    cont "HUMANS:"
    cont "FEASIBILITY AND"
    cont "MORALITY"
    done

_CeladonUniversity2SignBook31::
    text "MORAL DILEMMA ON"
    line "#MON BATTLES"
    done

_CeladonUniversity2SignBook32::
    text "INTRODUCTION ON"
    line "DIGITALIZATION OF"
    cont "BIOLOGICAL"
    cont "INFORMATION"

    para "This is from BILL!"
    done

_CeladonUniversity2SignBook33::
    text "#MON: THREAT,"
    line "FRIENDS, PETS,"
    cont "FIGHTERS,"
    cont "OR ALLIES?"
    done

_CeladonUniversity2SignBook34::
    text "#MON MASS"
    line "DENSITY AND ITS"
    cont "BIOLOGICAL"
    cont "IMPLICATIONS"

    para "There's a picture"
    line "of what looks"
    cont "like a whale"
    cont "floating in"
    cont "the air..."
    done

_CeladonUniversity2SignBook35::
    text "ARCEUS IS DEAD"
    done

_CeladonUniversity2SignBook36::
    text "HISTORY OF THE"
    line "USAGE OF WHIPS"
    cont "IN BATTLE"
    done

_CeladonUniversity2SignBook37::
    text "MEMORY LOSS IN"
    line "SENILE POPULATION"
    cont "AND ITS"
    cont "TREATMENTS"
    done

_CeladonUniversity2SignBook38::
    text "ARE MOONSTONES"
    line "METEORITES?"
    done

_CeladonUniversity2SignBook39::
    text "#MON FROM SPACE"
    line "FROM MYTHS TO THE"
    cont "SCIENTIFIC"
    cont "ANALYSIS"
    done

_CeladonUniversity2SignBook40::
    text "HISTORY OF THE"
    line "LUNAR TEMPLE"
    done

_CeladonUniversity2SignBook41::
    text "COULD #MON HOLD"
    line "ITEMS WHILE"
    cont "BATTLING?"
    done

_CeladonUniversity2SignBook42::
    text "EFFECT OF POACHING"
    line "ON WILDLIFE"
    done

_CeladonUniversity2SignBook43::
    text "CAN GASTLY AND"
    line "PORYGON BE"
    cont "CONSIDERED ALIVE?"
    done

_CeladonUniversity2SignBook44::
    text "COULD WILD #MON"
    line "EVOLVE WITHOUT"
    cont "LEVELING UP?"
    done

_CeladonUniversity2SignBook45::
    text "#BALL AND THE"
    line "VIOLATION OF"
    cont "ENERGY"
    cont "CONSERVATION"
    done

_CeladonUniversity2SignBook46::
    text "ON ROCK TYPING OF"
    line "RESURRECTED"
    cont "FOSSILS"
    done

_CeladonUniversity2SignBook47::
    text "HUMAN LANGUAGE"
    line "IN POKEMON:"
    cont "MERE IMITATION"
    cont "OR MORE?"
    done

_CeladonUniversity2SignBook48::
    text "THUS SPOKE ZERAORA"
    done

_CeladonUniversity2SignBook49::
    text "POKEMON CLONING:"
    line "HOPELESS ILLUSION"
    cont "OR A GLITCH"
    cont "IN REALITY?"
    done

_CeladonUniversity2SignBook50::
    text "ON THE DAY-NIGHT,"
    line "SEASONS, AND"
    cont "WEATHER CYCLES,"
    cont "AND LACK THEREOF"
    done

_CeladonUniversity2SignLibraryPC::
    text "With this, one"
    line "can search and"
    cont "reserve any"
    cont "book of the"
    cont "library!"
    done

_CeladonUniversity2SignWhiteboard::
    text "An electronic"
    line "whiteboard!"

    para "There are still"
    line "notes from the"
    cont "previous lesson,"
    cont "something about"
    cont "the slumbering"
    cont "Element Gods...?"
    done

_CeladonUniversity2SignMagnaPC::
    text "The PCs are set up"
    line "to stream the"
    cont "lectures to"
    cont "anyone following"
    cont "remotely!"
    done
