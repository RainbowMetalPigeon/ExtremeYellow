; --- magna auditorium ---

; joke about the fact that the exam starts tomorrow, joke is that the guy outside is PANICKING already
; whiteboard: info on Legendary Birds
; lecturer getting ready
; student mentioning Erika

_CeladonUniversity2Text1:: ; prof
    text "I'm prof"
    done
    
_CeladonUniversity2Text2:: ; student
    text "Nervous for exam"
    line "tomorrow but have"
    cont "to attent today"
    done
    
_CeladonUniversity2Text3:: ; lovebirds
    text "Leave us alone"
    done
    
_CeladonUniversity2Text4:: ; lovebirds
    text "Some privacy plz"
    done
    
_CeladonUniversity2Text5:: ; student
    text "Erika lessons cool"
    line "but rare"
    done
    
; --- library & study room ---

_CeladonUniversity2Text6:: ; researcher
    text "Searching a book"
    line "about assembly"
    done

_CeladonUniversity2Text7:: ; student
    text "They are sleeping!"
    done

; ------------------------------
; PhD student researching on Lapras

_CeladonUniversity2Text8_Intro_NoPrompt::
	text "Intro"
	done

_CeladonUniversity2Text8_Intro_WithPrompt::
	text "Intro"
	prompt

_CeladonUniversity2Text8_WowAlreadyCaught::
	text "Wow already"
	prompt

_CeladonUniversity2Text8_FoundThisYouCanHaveIt::
	text "Found this"
	line "can have it"
	prompt

_CeladonUniversity2Text8_BagFull::
	text "Bag full"
	done

_CeladonUniversity2Text8_AlreadyRewardedOrb::
	text "Now I can"
	line "complete thesis"
	done

_CeladonUniversity2Text8_HiBackHaveYouDone::
	text "Hi back done?"
	prompt

_CeladonUniversity2Text8_NotDoneYet::
	text "Oh you're not done"
	done

_CeladonUniversity2Text8_AlreadyRewardedMoneySpaceForOrb::
	text "Have space now?"
	prompt

_CeladonUniversity2Text8_ThanksHereIsReward::
	text "Thanks a ton"
	line "here promised rewa"
	prompt

_CeladonUniversity2Text8_ReceivedIceOrb::
	text "<PLAYER> got"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

; ------------------------------

_CeladonUniversity2Text9:: ; student
    text "Studying together"
    line "can be bad"
    done

_CeladonUniversity2Text10:: ; student
    text "Studying together"
    line "is great!"
    done

_CeladonUniversity2Text11:: ; student
    text "Searching book"
    line "about LIGHT BALL"
    done

; --- computing center ---

; wanna use Alakazam and Porygon for their studies

_CeladonUniversity2Text12:: ; researcher
    text "Have to test and"
    line "install new"
    cont "components"
    done

_CeladonUniversity2Text13:: ; researcher
    text "Studying to use"
    line "ALAKA and PORY"
    done

_CeladonUniversity2Text14:: ; researcher
    text "Oh goddess too"
    line "many cables"
    cont "and no labels"
    done

; --- signs ---

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
    