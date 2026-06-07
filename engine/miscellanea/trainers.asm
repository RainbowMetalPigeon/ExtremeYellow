; moved from home

PlayTrainerMusic::
	ld a, [wEngagedTrainerClass]
	cp OPP_RIVAL1
	ret z
	cp OPP_RIVAL2
	ret z
	cp OPP_RIVAL3
	ret z
	ld a, [wGymLeaderNo]
	and a
	ret nz
	xor a
	ld [wAudioFadeOutControl], a
	call StopAllMusic
	ld a, BANK(Music_MeetEvilTrainer)
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	ld a, [wEngagedTrainerClass]
	ld b, a
	ld hl, EvilTrainerList
.evilTrainerListLoop
	ld a, [hli]
	cp $ff
	jr z, .noEvilTrainer
	cp b
	jr nz, .evilTrainerListLoop
	ld a, MUSIC_MEET_EVIL_TRAINER
	jr .PlaySound
.noEvilTrainer
	ld hl, FemaleTrainerList
.femaleTrainerListLoop
	ld a, [hli]
	cp $ff
	jr z, .maleTrainer
	cp b
	jr nz, .femaleTrainerListLoop
	ld a, MUSIC_MEET_FEMALE_TRAINER
	jr .PlaySound
.maleTrainer
	ld a, MUSIC_MEET_MALE_TRAINER
.PlaySound
	ld [wNewSoundID], a
	jp PlaySound

INCLUDE "data/trainers/encounter_types.asm"

PrintAfterBattleText_RocketPath::
	callfar EngageMapTrainer_Internal_FindTrainerClass
	ld a, [wEngagedTrainerClass]
	ld hl, AfterBattleText_RocketPath_VsRocket
	cp OPP_ROCKET
	jp z, PrintText
	ld hl, AfterBattleText_RocketPath_VsNotRocket
	jp PrintText

AfterBattleText_RocketPath_VsRocket: ; new
	text_far _AfterBattleText_RocketPath_VsRocket
	text_end

AfterBattleText_RocketPath_VsNotRocket: ; new
	text_far _AfterBattleText_RocketPath_VsNotRocket
	text_end
