GetTrainerInformation::
	call GetTrainerName
	ld a, [wLinkState]
	and a
	jr nz, .linkBattle
	ld a, BANK(TrainerPicAndMoneyPointers)
	call BankswitchHome
	ld a, [wTrainerClass]
	dec a
	ld hl, TrainerPicAndMoneyPointers
	ld bc, $5
	call AddNTimes
	ld de, wTrainerPicPointer
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld de, wTrainerBaseMoney
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	call IsFightingJessieJames
;	call IsFightingPseudoRed
	jp BankswitchBack
.linkBattle
	ld hl, wTrainerPicPointer
	ld de, RedPicFront
	ld [hl], e
	inc hl
	ld [hl], d
	ret

IsFightingJessieJames::
	ld a, [wTrainerClass]
	cp ROCKET
	ret nz
	ld a, [wTrainerNo]
	cp $2e ; edited because I added more Rockets (Obsidian Warehouse)
	ret c
	cp $33 ; added because of Rocket siblings in Lunar Shrine
	ret nc
;	ld de, LancePic ; Rocket executives' pics here, or in init_battle if gotta load another BANK... temp testing with Lance's pic
;	cp $33 ; edited, for the Rocket executives
;	jr nc, .executives
	ld de, JessieJamesPic ; possibly meant to add another pic
.executives
	ld hl, wTrainerPicPointer
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

;IsFightingPseudoRed::
;	ld a, [wTrainerClass]
;	cp COOLTRAINER_M
;	ret nz
;	ld a, [wTrainerNo]
;	cp 5
;	ret nz
;	ld de, RedPicFront
;	ld hl, wTrainerPicPointer
;	ld a, e
;	ld [hli], a
;	ld [hl], d
;	ret

GetTrainerName::
	farjp GetTrainerName_
