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
;	xxxx "123456789012345678"
	done
