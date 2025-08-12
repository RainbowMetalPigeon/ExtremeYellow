; from Porygondolier

MACRO tutor_move
	db \1 ; Move
	db \2 ; Species
ENDM

TutorMoveData:: ; TBE
	table_width 2, TutorMove Data
	tutor_move SUNNY_DAY, MARODACTYL
	tutor_move EMBER, ARTICUNO
	tutor_move EMBER, DITTO
	tutor_move WATER_GUN, DUGTRIO
	tutor_move EMBER, EXEGGUTOR
	db $ff, $ff;end of table marker
