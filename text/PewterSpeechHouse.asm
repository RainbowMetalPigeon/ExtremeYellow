_PewterHouse2Text1::
	text "#MON learn new"
	line "techniques as"
	cont "they grow!"

	para "But, some moves"
	line "must be taught by"
	cont "the trainer by"
	cont "using dedicated"
	cont "tools, the TMs!"
	done

_PewterHouse2Text2::
	text "#MON become"
	line "easier to catch"
	cont "when they are"
	cont "hurt or asleep!"

	para "But, it's not a"
	line "sure thing!"
	done

; new

_PewterHouse2Text3::
	text "I..."
	line "See..."
	cont "Numbers..."

	para "UuHhUuhH..."
	line "@"
	text_decimal wPikachuHappiness, 1, 3 ; address to read from, number of bytes to read, number of digits to display
	text "!!!"

	para "OohHoOHh..."
	line "@"
	text_decimal wPikachuMood, 1, 3
	text "!!!"
	done

_SmashBallDebugText:: ; for debugging only
	text "Smashed A"
	line "@"
	text_decimal wSmashBallNumberOfInputs, 1, 3 ; address to read from, number of bytes to read, number of digits to display
	text " times!"
	prompt

_PewterHouse2Text4::
	text "It's full of"
	line "scribbles that"
	cont "look like they're"
	cont "straight out of a"
	cont "fever dream..."

	para "50: until such,"
	line "3 in 10 partner"
	cont "won't be such."

	para "100: before this,"
	line "2 in 10 companion"
	cont "won't follow."

	para "130: below it,"
	line "1 in 10 bestie"
	cont "won't have ears."

	para "160: above limit,"
	line "limit of rolling"
	cont "will be reached."

	para "200: beyond here,"
	line "1 in 4 to shrug"
	cont "off all evils."

	para "250: trascend that"
	line "four critical"
	cont "ascension."

	para "...the hell is"
	line "this gibberish?!"
	done
