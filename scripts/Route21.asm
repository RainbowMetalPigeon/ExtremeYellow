Route21_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route21TrainerHeaders
	ld de, Route21_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

; scripts =======================================

Route21_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw Route21Script_PostOakBattle ; 3

Route21Script_PostOakBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route21ResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won: gift last expansion of Sevii Ticket
	ld a, 11 ; Route21ScriptText1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_8
	ld a, SFX_GET_KEY_ITEM
	call PlaySound
	ld a, 12 ; Route21ScriptText2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 13 ; Route21ScriptText3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route21ResetScripts
	ret

Route21ResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts =========================================

Route21_TextPointers:
	dw Route21TextOak
	dw Route21Text1
	dw Route21Text2
	dw Route21Text3
	dw Route21Text4
	dw Route21Text5
	dw Route21Text6
	dw Route21Text7
	dw Route21Text8
	dw Route21Text9
	; scripts
	dw Route21ScriptText1 ; 11
	dw Route21ScriptText2 ; 12
	dw Route21ScriptText3 ; 13

Route21TrainerHeaders:
	def_trainers 2 ; edited because of Oak
Route21TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_21_TRAINER_0, 0, Route21BattleText1, Route21EndBattleText1, Route21AfterBattleText1
Route21TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_21_TRAINER_1, 0, Route21BattleText2, Route21EndBattleText2, Route21AfterBattleText2
Route21TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_21_TRAINER_2, 4, Route21BattleText3, Route21EndBattleText3, Route21AfterBattleText3
Route21TrainerHeader3:
	trainer EVENT_BEAT_ROUTE_21_TRAINER_3, 4, Route21BattleText4, Route21EndBattleText4, Route21AfterBattleText4
Route21TrainerHeader4:
	trainer EVENT_BEAT_ROUTE_21_TRAINER_4, 4, Route21BattleText5, Route21EndBattleText5, Route21AfterBattleText5
Route21TrainerHeader5:
	trainer EVENT_BEAT_ROUTE_21_TRAINER_5, 4, Route21BattleText6, Route21EndBattleText6, Route21AfterBattleText6
Route21TrainerHeader6:
	trainer EVENT_BEAT_ROUTE_21_TRAINER_6, 3, Route21BattleText7, Route21EndBattleText7, Route21AfterBattleText7
Route21TrainerHeader7:
	trainer EVENT_BEAT_ROUTE_21_TRAINER_7, 0, Route21BattleText8, Route21EndBattleText8, Route21AfterBattleText8
Route21TrainerHeader8:
	trainer EVENT_BEAT_ROUTE_21_TRAINER_8, 0, Route21BattleText9, Route21EndBattleText9, Route21AfterBattleText9
	db -1 ; end

Route21Text1:
	text_asm
	ld hl, Route21TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route21Text2:
	text_asm
	ld hl, Route21TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route21Text3:
	text_asm
	ld hl, Route21TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route21Text4:
	text_asm
	ld hl, Route21TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route21Text5:
	text_asm
	ld hl, Route21TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route21Text6:
	text_asm
	ld hl, Route21TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route21Text7:
	text_asm
	ld hl, Route21TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route21Text8:
	text_asm
	ld hl, Route21TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

Route21Text9:
	text_asm
	ld hl, Route21TrainerHeader8
	call TalkToTrainer
	jp TextScriptEnd

Route21BattleText1:
	text_far _Route21BattleText1
	text_end

Route21EndBattleText1:
	text_far _Route21EndBattleText1
	text_end

Route21AfterBattleText1:
	text_far _Route21AfterBattleText1
	text_end

Route21BattleText2:
	text_far _Route21BattleText2
	text_end

Route21EndBattleText2:
	text_far _Route21EndBattleText2
	text_end

Route21AfterBattleText2:
	text_far _Route21AfterBattleText2
	text_end

Route21BattleText3:
	text_far _Route21BattleText3
	text_end

Route21EndBattleText3:
	text_far _Route21EndBattleText3
	text_end

Route21AfterBattleText3:
	text_far _Route21AfterBattleText3
	text_end

Route21BattleText4:
	text_far _Route21BattleText4
	text_end

Route21EndBattleText4:
	text_far _Route21EndBattleText4
	text_end

Route21AfterBattleText4:
	text_far _Route21AfterBattleText4
	text_end

Route21BattleText5:
	text_far _Route21BattleText5
	text_end

Route21EndBattleText5:
	text_far _Route21EndBattleText5
	text_end

Route21AfterBattleText5:
	text_far _Route21AfterBattleText5
	text_end

Route21BattleText6:
	text_far _Route21BattleText6
	text_end

Route21EndBattleText6:
	text_far _Route21EndBattleText6
	text_end

Route21AfterBattleText6:
	text_far _Route21AfterBattleText6
	text_end

Route21BattleText7:
	text_far _Route21BattleText7
	text_end

Route21EndBattleText7:
	text_far _Route21EndBattleText7
	text_end

Route21AfterBattleText7:
	text_far _Route21AfterBattleText7
	text_end

Route21BattleText8:
	text_far _Route21BattleText8
	text_end

Route21EndBattleText8:
	text_far _Route21EndBattleText8
	text_end

Route21AfterBattleText8:
	text_far _Route21AfterBattleText8
	text_end

Route21BattleText9:
	text_far _Route21BattleText9
	text_end

Route21EndBattleText9:
	text_far _Route21EndBattleText9
	text_end

Route21AfterBattleText9:
	text_far _Route21AfterBattleText9
	text_end

; ------------------------------------------------

Route21TextOak:
	text_asm
	ld c, BANK(Music_MeetProfOak)
	ld a, MUSIC_MEET_PROF_OAK
	call PlayMusic

	ld hl, OakBeforeBattleText
	CheckEvent EVENT_1ST_SPOKE_WITH_ROUTE21_OAK
	jr z, .goPrint
	ld hl, OakBeforeBattleTextShort
.goPrint
	call PrintText
	SetEvent EVENT_1ST_SPOKE_WITH_ROUTE21_OAK

	call NormalInverseChoice
	ld a, [wCurrentMenuItem]
	ld [wInverseBattle], a

	ld hl, OakBeforeBattleText2
	call PrintText

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]

	ld hl, wOptions
	res 7, [hl]	; Turn on battle animations to make the battle feel more epic
	set 6, [hl] ; battle style set

	call Delay3
	ld a, OPP_PROF_OAK
	ld [wCurOpponent], a

	ld a, 1
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	CheckEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_8
	jr nz, .dontSetScript
	ld a, 3
	ld [wCurMapScript], a
.dontSetScript

	ld hl, OakPostBattleTextVictory
	ld de, OakPostBattleTextDefeat
	call SaveEndBattleTextPointers
	jp TextScriptEnd

OakBeforeBattleText:
	text_far _OakBeforeBattleText
	text_end

OakBeforeBattleTextShort:
	text_far _OakBeforeBattleTextShort
	text_end

OakBeforeBattleText2:
	text_far _OakBeforeBattleText2
	text_end

OakPostBattleTextVictory:
	text_far _OakPostBattleTextVictory
	text_end

OakPostBattleTextDefeat:
	text_far _OakPostBattleTextDefeat
	text_end

NormalInverseChoice:: ; how did it even work with just one column?!
	call SaveScreenTilesToBuffer1
	ld a, NORMAL_INVERSE_MENU
	ld [wTwoOptionMenuID], a
	coord hl, 10, 7
	ld bc, $80b ; weird coordinates for the cursor
	ld a, $14
	ld [wTextBoxID], a
	call DisplayTextBoxID
	jp LoadScreenTilesFromBuffer1

Route21ScriptText1:
	text_far _Route21ScriptText1
	text_end

Route21ScriptText2:
	text_far _Route21ScriptText2
	text_end

Route21ScriptText3:
	text_far _Route21ScriptText3
	text_end
