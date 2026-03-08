SeviiDottedHole_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiDottedHole_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

; scripts ====================================

SeviiDottedHole_ScriptPointers:
	dw SeviiDottedHoleScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiDottedHoleScript0:
	ret

SeviiDottedHoleTrainerHeaders:
	def_trainers
SeviiDottedHoleMeltanTrainerHeader:
	trainer EVENT_BEAT_MELTAN, 0, SeviiDottedHoleMeltanBattleText, SeviiDottedHoleMeltanBattleText, SeviiDottedHoleMeltanBattleText
	db -1 ; end

SeviiDottedHoleInitStaticEncounterBattle:
	call TalkToTrainer
	jp TextScriptEnd

SeviiDottedHoleMeltanText:
	text_asm
	ld hl, SeviiDottedHoleMeltanTrainerHeader
	jr SeviiDottedHoleInitStaticEncounterBattle

SeviiDottedHoleMeltanBattleText:
	text_far _SeviiDottedHoleMeltanBattleText
	text_asm
	ld a, MELTAN
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

; texts ====================================

SeviiDottedHole_TextPointers:
	dw SeviiDottedHoleMeltanText ; Meltan
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy ; 9
	; scripts

SeviiDottedHoleTextProxy:
	text_far _SeviiDottedHoleText1
	text_end
