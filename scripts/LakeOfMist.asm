LakeOfMist_Script:
	call EnableAutoTextBoxDrawing
;	ld hl, LakeOfMistTrainerHeaders
;	ld de, LakeOfMist_ScriptPointers
;	ld a, [wCurMapScript] ; edited
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a ; edited
	ret
/*
LakeOfMist_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
*/
LakeOfMist_TextPointers:
	dw LakeOfMistText1

/*
	dw LakeOfMistText1
	dw LakeOfMistText2
	dw LakeOfMistText3
	dw LakeOfMistText4
	dw LakeOfMistText5
	dw LakeOfMistText6
	dw LakeOfMistText7
	dw LakeOfMistText8
	dw LakeOfMistText9
	dw LakeOfMistText10

LakeOfMistTrainerHeaders:
	def_trainers 2
LakeOfMistTrainerHeader0:
	trainer EVENT_BEAT_LAKE_OF_MIST_TRAINER_0, 2, LakeOfMistBattleText1, LakeOfMistEndBattleText1, LakeOfMistAfterBattleText1
LakeOfMistTrainerHeader1:
	trainer EVENT_BEAT_LAKE_OF_MIST_TRAINER_1, 3, LakeOfMistBattleText2, LakeOfMistEndBattleText2, LakeOfMistAfterBattleText2
LakeOfMistTrainerHeader2:
	trainer EVENT_BEAT_LAKE_OF_MIST_TRAINER_2, 2, LakeOfMistBattleText3, LakeOfMistEndBattleText3, LakeOfMistAfterBattleText3
LakeOfMistTrainerHeader3:
	trainer EVENT_BEAT_LAKE_OF_MIST_TRAINER_3, 1, LakeOfMistBattleText4, LakeOfMistEndBattleText4, LakeOfMistAfterBattleText4
LakeOfMistTrainerHeader4:
	trainer EVENT_BEAT_LAKE_OF_MIST_TRAINER_4, 4, LakeOfMistBattleText5, LakeOfMistEndBattleText5, LakeOfMistAfterBattleText5
LakeOfMistTrainerHeader5:
	trainer EVENT_BEAT_LAKE_OF_MIST_TRAINER_5, 3, LakeOfMistBattleText6, LakeOfMistEndBattleText6, LakeOfMistAfterBattleText6
LakeOfMistTrainerHeader6:
	trainer EVENT_BEAT_LAKE_OF_MIST_TRAINER_6, 3, LakeOfMistBattleText7, LakeOfMistEndBattleText7, LakeOfMistAfterBattleText7
LakeOfMistTrainerHeader7:
	trainer EVENT_BEAT_LAKE_OF_MIST_TRAINER_7, 2, LakeOfMistBattleText8, LakeOfMistEndBattleText8, LakeOfMistAfterBattleText8
	db -1 ; end

LakeOfMistText1:
	text_far _LakeOfMistText1
	text_end

LakeOfMistText2:
	text_asm
	ld hl, LakeOfMistTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

LakeOfMistBattleText1:
	text_far _LakeOfMistBattleText1
	text_end

LakeOfMistEndBattleText1:
	text_far _LakeOfMistEndBattleText1
	text_end

LakeOfMistAfterBattleText1:
	text_far _LakeOfMistAfterBattleText1
	text_end

LakeOfMistText3:
	text_asm
	ld hl, LakeOfMistTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

LakeOfMistBattleText2:
	text_far _LakeOfMistBattleText2
	text_end

LakeOfMistEndBattleText2:
	text_far _LakeOfMistEndBattleText2
	text_end

LakeOfMistAfterBattleText2:
	text_far _LakeOfMistAfterBattleText2
	text_end

LakeOfMistText4:
	text_asm
	ld hl, LakeOfMistTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

LakeOfMistBattleText3:
	text_far _LakeOfMistBattleText3
	text_end

LakeOfMistEndBattleText3:
	text_far _LakeOfMistEndBattleText3
	text_end

LakeOfMistAfterBattleText3:
	text_far _LakeOfMistAfterBattleText3
	text_end

LakeOfMistText5:
	text_asm
	ld hl, LakeOfMistTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

LakeOfMistBattleText4:
	text_far _LakeOfMistBattleText4
	text_end

LakeOfMistEndBattleText4:
	text_far _LakeOfMistEndBattleText4
	text_end

LakeOfMistAfterBattleText4:
	text_far _LakeOfMistAfterBattleText4
	text_end

LakeOfMistText6:
	text_asm
	ld hl, LakeOfMistTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

LakeOfMistBattleText5:
	text_far _LakeOfMistBattleText5
	text_end

LakeOfMistEndBattleText5:
	text_far _LakeOfMistEndBattleText5
	text_end

LakeOfMistAfterBattleText5:
	text_far _LakeOfMistAfterBattleText5
	text_end

LakeOfMistText7:
	text_asm
	ld hl, LakeOfMistTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

LakeOfMistBattleText6:
	text_far _LakeOfMistBattleText6
	text_end

LakeOfMistEndBattleText6:
	text_far _LakeOfMistEndBattleText6
	text_end

LakeOfMistAfterBattleText6:
	text_far _LakeOfMistAfterBattleText6
	text_end

LakeOfMistText8:
	text_asm
	ld hl, LakeOfMistTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

LakeOfMistBattleText7:
	text_far _LakeOfMistBattleText7
	text_end

LakeOfMistEndBattleText7:
	text_far _LakeOfMistEndBattleText7
	text_end

LakeOfMistAfterBattleText7:
	text_far _LakeOfMistAfterBattleText7
	text_end

LakeOfMistText9:
	text_asm
	ld hl, LakeOfMistTrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

LakeOfMistBattleText8:
	text_far _LakeOfMistBattleText8
	text_end

LakeOfMistEndBattleText8:
	text_far _LakeOfMistEndBattleText8
	text_end

LakeOfMistAfterBattleText8:
	text_far _LakeOfMistAfterBattleText8
	text_end

LakeOfMistText10:
	text_far _LakeOfMistText10
	text_end
*/

LakeOfMistText1:
	text_asm
	CheckEvent EVENT_LAKE_OF_MIST_GAVE_FLAME_PLUME
	ld hl, LakeOfMistText1_PostForlornCoordinates
	jr nz, .printAndEnd
; not received Forlorn coordinates yet
	ld hl, LakeOfMistText1_Intro
	call PrintText
; check if we have the plume
	ld b, FLAME_PLUME
	call IsItemInBag
	jr nz, .havePlume
; check if we have Moltres in team
	ld d, MOLTRES
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	jr nc, .done
; we have Moltres
	ld hl, LakeOfMistText1_HaveMoltres
	jr .printAndEnd
.havePlume
	call WaitForTextScrollButtonPress
	ld hl, LakeOfMistText1_HavePlume
	call PrintText
	ld a, FLAME_PLUME
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_LAKE_OF_MIST_GAVE_FLAME_PLUME
	ld c, 15
	ld b, FLAG_SET
	ld hl, wTownVisitedFlag ; mark Forlorn Valley as visited (for flying)
	predef FlagActionPredef
	ld hl, LakeOfMistText1_ReceiveForlornCoordinates
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

LakeOfMistText1_Intro:
	text_far _LakeOfMistText1_Intro
	text_end

LakeOfMistText1_HaveMoltres:
	text_far _LakeOfMistText1_HaveMoltres
	text_end

LakeOfMistText1_HavePlume:
	text_far _LakeOfMistText1_HavePlume
	text_end

LakeOfMistText1_ReceiveForlornCoordinates:
	text_far _LakeOfMistText1_ReceiveForlornCoordinates
	sound_get_key_item
	text_end

LakeOfMistText1_PostForlornCoordinates:
	text_far _LakeOfMistText1_PostForlornCoordinates
	text_end
