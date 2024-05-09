TextBoxFunctionTable:
	; text box ID, function address
	dbw MONEY_BOX,           DisplayMoneyBox
	dbw BUY_SELL_QUIT_MENU,  DoBuySellQuitMenu
	dbw FIELD_MOVE_MON_MENU, DisplayFieldMoveMonMenu
	db -1 ; end

TextBoxCoordTable:
	; text box ID, upper-left X, upper-left Y, lower-right X, lower-right Y
	db MESSAGE_BOX,       0, 12, 19, 17
	db MENU_TEMPLATE_03,  0,  0, 19, 14
	db MENU_TEMPLATE_07,  0,  0, 11,  6
	db LIST_MENU_BOX,     4,  2, 19, 12
;	db MENU_TEMPLATE_10,  7,  0, 19, 17 ; edited, removed as it was not used
	db MON_SPRITE_POPUP,  6,  4, 14, 13
	db -1 ; end

MACRO text_box_text
	db \1 ; text box ID
	db \2, \3, \4, \5 ; text box coordinates
	dw \6 ; text pointer
	db \7, \8 ; text coordinates
ENDM

TextBoxTextAndCoordTable:
	; text box ID, upper-left X, upper-left Y, lower-right X, lower-right Y, text pointer, text X, text Y
	text_box_text JP_MOCHIMONO_MENU_TEMPLATE,         0,  0, 14, 17, JapaneseMochimonoText,    3,  0
	text_box_text USE_TOSS_MENU_TEMPLATE,            13, 10, 19, 14, UseTossText,             15, 11
	text_box_text JP_SAVE_MESSAGE_MENU_TEMPLATE,      0,  0,  7,  5, JapaneseSaveMessageText,  2,  2
	text_box_text JP_SPEED_OPTIONS_MENU_TEMPLATE,     0,  6,  5, 10, JapaneseSpeedOptionsText, 2,  7
	text_box_text BATTLE_MENU_TEMPLATE,               8, 12, 19, 17, BattleMenuText,          10, 14
	text_box_text SAFARI_BATTLE_MENU_TEMPLATE,        0, 12, 19, 17, SafariZoneBattleMenuText, 2, 14
	text_box_text SWITCH_STATS_CANCEL_MENU_TEMPLATE, 11, 11, 19, 17, SwitchStatsCancelText,   13, 12
	text_box_text BUY_SELL_QUIT_MENU_TEMPLATE,        0,  0, 10,  6, BuySellQuitText,          2,  1
	text_box_text MONEY_BOX_TEMPLATE,                11,  0, 19,  2, MoneyText,               13,  0
	text_box_text BOY_GIRL_NO,                       13,  6, 19, 12, BoyGirlNoText,           15,  7 ; new
	text_box_text TYROGUE_EVOLUTIONS,				  9,  6, 19, 12, TyrogueEvolutions,		  11,  7 ; new
	text_box_text JP_POKEDEX_MENU_TEMPLATE,          11,  8, 19, 17, JapanesePokedexMenu,     12, 10
	text_box_text BF_MENU_INFO_BATTLE_EXIT,          11,  6, 19, 12, BFInfoBattleExit,        13,  7 ; new
	text_box_text BF_MENU_INFO_BATTLE_PRIZES_EXIT,   11,  4, 19, 12, BFInfoBattlePrizesExit,  13,  5 ; new, TBV
	text_box_text BF_MENU_STANDARD_HARDCORE_EXIT,    11,  6, 19, 12, BFStandardHardcoreExit,  13,  7 ; new


BuySellQuitText:
	db   "BUY"
	next "SELL"
	next "QUIT@"

	db "@" ; unused

UseTossText:
	db   "USE"
	next "TOSS@"

JapaneseSaveMessageText:
	db   "きろく"
	next "メッセージ@"

JapaneseSpeedOptionsText:
	db   "はやい"
	next "おそい@"

MoneyText:
	db "MONEY@"

JapaneseMochimonoText:
	db "もちもの@"

JapaneseMainMenuText:
	db   "つづきから"
	next "さいしょから@"

BattleMenuText:
	db   "FIGHT <PK><MN>"
	next "ITEM  RUN@"

SafariZoneBattleMenuText:
	db   "BALL×       BAIT"
	next "THROW ROCK  RUN@"

SwitchStatsCancelText:
	db   "SWITCH"
	next "STATS"
	next "CANCEL@"

BoyGirlNoText: ; new
	db   "BOY"
	next "GIRL"
	next "NO@"

TyrogueEvolutions: ; new
	db   "GLOVES"
	next "ANNIE"
	next "BEYBLADE@"

BFInfoBattleExit: ; new
	db   "INFO"
	next "BATTLE"
	next "EXIT@"

BFInfoBattlePrizesExit: ; new
	db   "INFO"
	next "BATTLE"
	next "PRIZES"
	next "EXIT@"

BFStandardHardcoreExit: ; new
	db   "STAND." ; testing
	next "HARDC." ; testing
	next "EXIT@"

JapanesePokedexMenu:
	db   "データをみる"
	next "なきごえ"
	next "ぶんぷをみる"
	next "キャンセル@"
