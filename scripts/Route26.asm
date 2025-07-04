Route26_Script:
	call EnableAutoTextBoxDrawing
	ld hl, wd72e	; ugly fix for the non-encounter thingy of the Onix Burrowing
	res 4, [hl]		; ugly fix for the non-encounter thingy of the Onix Burrowing
	ld hl, Route26TrainerHeaders
	ld de, Route26_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Route26_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route26_TextPointers:
	dw Route26TextHiker1
	dw Route26TextHiker2
	dw Route26TextHiker3
	dw Route26TextHiker4
	dw Route26Text1
	dw BoulderText
	dw Route26Text2 ; sign welcome
	dw Route26Text3 ; sign burrowing

Route26TrainerHeaders:
	def_trainers 5
Route26TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_26_TRAINER_0, 1, Route26BattleText1, Route26EndBattleText1, Route26AfterBattleText1
	db -1 ; end

; --- non-trainers ---

Route26TextHiker1:
	text_far _Route26TextHiker1
	text_end

Route26TextHiker2:
	text_far _Route26TextHiker2
	text_end

Route26TextHiker3:
	text_far _Route26TextHiker3
	text_end

Route26TextHiker4:
	text_far _Route26TextHiker4
	text_end

; --- trainers ---

Route26Text1:
	text_asm
	ld hl, Route26TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route26BattleText1:
	text_far _Route26BattleText1
	text_end

Route26EndBattleText1:
	text_far _Route26EndBattleText1
	text_end

Route26AfterBattleText1:
	text_far _Route26AfterBattleText1
	text_end

; --- signs ---

Route26Text2:
	text_far _Route26Text2
	text_end

Route26Text3:
	text_far _Route26Text3
	text_end
