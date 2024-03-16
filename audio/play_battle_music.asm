PlayBattleMusic::
	xor a
	ld [wAudioFadeOutControl], a
	ld [wLowHealthAlarm], a
	call StopAllMusic
	call DelayFrame
	ld c, BANK(Music_GymLeaderBattle)

	ld a, [wCurOpponent]
	cp OPP_ID_OFFSET
	jr c, .wildBattle

	; Rival3, Oak, Pigeon, and Traveler are the most epic
	cp OPP_RIVAL3
	jr z, .finalBattle
	cp OPP_PROF_OAK
	jr z, .finalBattle
	cp OPP_TRAVELER
	jr z, .finalBattle
	cp OPP_PIGEON
	jr z, .finalBattle

	; the whole E4 now play the gym leader battle theme, even during the rematches
	cp OPP_LORELEI
	jr z, .GymLeaderOrElite4Battle
	cp OPP_BRUNO
	jr z, .GymLeaderOrElite4Battle
	cp OPP_AGATHA
	jr z, .GymLeaderOrElite4Battle
	cp OPP_LANCE
	jr z, .GymLeaderOrElite4Battle

	; also the Battle Facility trainers play the gym leader theme
	cp OPP_BF_TRAINER
	jr z, .GymLeaderOrElite4Battle

	; all gym leaders (also during their rematches) play the gym leader battle theme
	cp OPP_BROCK
	jr z, .GymLeaderOrElite4Battle
	cp OPP_MISTY
	jr z, .GymLeaderOrElite4Battle
	cp OPP_LT_SURGE
	jr z, .GymLeaderOrElite4Battle
	cp OPP_ERIKA
	jr z, .GymLeaderOrElite4Battle
	cp OPP_KOGA
	jr z, .GymLeaderOrElite4Battle
	cp OPP_SABRINA
	jr z, .GymLeaderOrElite4Battle
	cp OPP_BLAINE
	jr z, .GymLeaderOrElite4Battle
	cp OPP_GIOVANNI ; Giovanni is special
	jr nz, .normalTrainerBattle
	ld a, [wTrainerNo]
	cp 4 ; check if it's 4rd or later battle (gym leader or rematch)
	jr nc, .GymLeaderOrElite4Battle

.normalTrainerBattle
	ld a, MUSIC_TRAINER_BATTLE
	jr .playSong

.finalBattle
	ld a, MUSIC_FINAL_BATTLE
	jr .playSong

.GymLeaderOrElite4Battle
	ld a, MUSIC_GYM_LEADER_BATTLE
	jr .playSong

.wildBattle
	ld a, MUSIC_WILD_BATTLE

.playSong
	jp PlayMusic
