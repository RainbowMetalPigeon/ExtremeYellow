TradeMons:
; entries correspond to TRADE_FOR_* constants
	table_width 3 + NAME_LENGTH, TradeMons
	; give mon, get mon, dialog id, nickname
	; The two instances of TRADE_DIALOGSET_EVOLUTION are a leftover
	; from the Japanese Blue trades, which used species that evolve.
	; Japanese Red and Green used TRADE_DIALOGSET_CASUAL, and had
	; the same species as English Red and Blue.
	db DUGTRIO,    LICKITUNG,TRADE_DIALOGSET_CASUAL,    "TOUNGY@@@@@" ; edited
	db CLEFAIRY,   MR_MIME,  TRADE_DIALOGSET_CASUAL,    "MILES@@@@@@"
	db KINGLER,    GRAVELER, TRADE_DIALOGSET_CASUAL,    "PEBBLE@@@@@" ; edited
	db SEAKING,    HAUNTER,  TRADE_DIALOGSET_CASUAL,    "PHANTA@@@@@" ; edited
	db GOLDUCK,    KADABRA,  TRADE_DIALOGSET_EVOLUTION, "SPOONY@@@@@" ; edited
	db DEWGONG,    MACHOKE,  TRADE_DIALOGSET_HAPPY,     "MUSKY@@@@@@" ; edited
	db JIGGLYPUFF, SHELLDER, TRADE_DIALOGSET_HAPPY,     "SHELLO@@@@@" ; edited
	assert_table_length NUM_NPC_TRADES
