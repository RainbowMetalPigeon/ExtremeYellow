SecludedCaves_Script:
	call EnableAutoTextBoxDrawing
	ld de, SecludedCaves_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

SecludedCaves_ScriptPointers:
	dw SecludedCavesScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SecludedCavesScript0: ; testing
	ld a, [wYCoord]
	cp 22
	ret nc
	call StopAllMusic ; glitchy, it breaks the "bump" sounds too
; à la Vortiene
;	ld a, 1
;	ld [wMuteAudioAndPauseMusic], a
	ret

SecludedCaves_TextPointers:
	dw MZygardeText
	dw UNecrozmaText
	dw MRayquazaText
	dw EEternatusText
	dw ArceusText

SecludedCavesTrainerHeaders:
	def_trainers
MZygardeTrainerHeader:
	trainer EVENT_BEAT_MZYGARDE, 0, MZygardeBattleText, MZygardeBattleText, MZygardeBattleText
UNecrozmaTrainerHeader:
	trainer EVENT_BEAT_UNECROZMA, 0, UNecrozmaBattleText, UNecrozmaBattleText, UNecrozmaBattleText
MRayquazaTrainerHeader:
	trainer EVENT_BEAT_MRAYQUAZA, 0, MRayquazaBattleText, MRayquazaBattleText, MRayquazaBattleText
EEternatusTrainerHeader:
	trainer EVENT_BEAT_EETERNATUS, 0, EEternatusBattleText, EEternatusBattleText, EEternatusBattleText
ArceusTrainerHeader:
	trainer EVENT_BEAT_ARCEUS, 0, ArceusBattleText, ArceusBattleText, ArceusBattleText
	db -1 ; end

InitStaticEncounterBattle:
	call TalkToTrainer
;	ld a, [wCurMapScript]
;	ld [wSecludedCavesCurScript], a
	jp TextScriptEnd

MZygardeText:
	text_asm
	ld hl, MZygardeTrainerHeader
	jr InitStaticEncounterBattle

MZygardeBattleText:
	text_far _MZygardeBattleText
	text_asm
	ld a, MZYGARDE
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

UNecrozmaText:
	text_asm
	ld hl, UNecrozmaTrainerHeader
	jr InitStaticEncounterBattle

UNecrozmaBattleText:
	text_far _UNecrozmaBattleText
	text_asm
	ld a, UNECROZMA
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

MRayquazaText:
	text_asm
	ld hl, MRayquazaTrainerHeader
	jr InitStaticEncounterBattle

MRayquazaBattleText:
	text_far _MRayquazaBattleText
	text_asm
	ld a, MRAYQUAZA
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

EEternatusText:
	text_asm
	ld hl, EEternatusTrainerHeader
	jr InitStaticEncounterBattle

EEternatusBattleText:
	text_far _EEternatusBattleText
	text_asm
	ld a, EETERNATUS
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

ArceusText:
	text_asm
	ld hl, ArceusTrainerHeader
	jr InitStaticEncounterBattle

ArceusBattleText:
	text_far _ArceusBattleText
	text_asm
	ld a, ARCEUS
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
