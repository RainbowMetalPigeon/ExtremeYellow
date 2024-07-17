_SSAnne7RubText::
	text "CAPTAIN: Ooargh..."
	line "I feel hideous..."
	cont "Urrp! Seasick..."

	para "<PLAYER> rubbed"
	line "the CAPTAIN's"
	cont "back!"

	para "Rub-rub..."
	line "Rub-rub...@"
	text_end

_ReceivingHM01Text::
	text "CAPTAIN: Whew!"
	line "Thank you! I"
	cont "feel much better!"

	para "You want to see"
	line "my CUT technique?"

	para "I could show you"
	line "if I wasn't ill..."

	para "I know! You can"
	line "have this!"

	para "Teach it to your"
	line "#MON and you"
	cont "can see it CUT"
	cont "anytime!"
	prompt

_ReceivedHM01Text::
	text "<PLAYER> got"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_SSAnne7Text_61932:: ; edited
	text "CAPTAIN: Whew!"

	para "Now that I feel a"
	line "bit better, I"
	cont "guess it's time"
	cont "to depart!"
	done

_HM01NoRoomText::
	text "Oh no! You have"
	line "no room for this!"
	done

_SSAnne7Text2::
	text "Yuck! Shouldn't"
	line "have looked!"
	done

_SSAnne7Text3::
	text "How to Conquer"
	line "Seasickness..."
	cont "The CAPTAIN's"
	cont "reading this!"
	done

; new ----------------------

_SSAnne7TextCaptain_PreBattle::
	text "CAPTAIN: Oh? Look"
	line "who's there! How"
	cont "long! How are you"
	cont "doing?"

	para "...wait, what do"
	line "you mean? Police"
	cont "is investigating"
	cont "to find TEAM"
	cont "ROCKET's"
	cont "accomplice in"
	cont "their poaching in"
	cont "the SAFARI ZONE?"

	para "And how would you"
	line "know that...?"

	para "WHAT? YOU are the"
	line "one that crumbled"
	cont "our traffics?!"

	para "May you be"
	line "damned!!! I lost"
	cont "so much money"
	cont "because of you!"

	para "Oh, you'll regret"
	line "so much coming"
	cont "here alone!"
	cont "I'll slice you"
	cont "down and feed you"
	cont "to the fish!"
	done

_SSAnne7TextCaptain_Defeat::
	text "No...! It"
	line "can't be...!"

	para "Now I see how"
	line "you defeated"
	cont "GIOVANNI..."
	prompt

_SSAnne7TextJenny::
	text "JENNY: One more"
	line "time, thank you"
	cont "so very much!"

	para "Your help has once"
	line "again been"
	cont "invaluable in"
	cont "cleansing KANTO"
	cont "from this scum."

	para "As soon as you'll"
	line "be of age, what"
	cont "about joining the"
	cont "police force"
	cont "officially?"
	done

_SSAnne7Text5::
	text "CAPTAIN: May you"
	line "be damned!!!"
	done
