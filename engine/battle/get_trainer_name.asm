GetTrainerName_::
	ld hl, wGrassRate
	ld a, [wLinkState]
	and a
	jr nz, .foundName

	ld hl, wRivalName
	ld a, [wTrainerClass]
	cp RIVAL1
	jr z, .foundName
	cp RIVAL2
	jr z, .foundName
	cp RIVAL3
	jr z, .foundName

; new, for the SS Anne Captain
;	cp GENTLEMAN
;	jr nz, .continue
	ld a, [wCurMap]
	cp SS_ANNE_CAPTAINS_ROOM
	jr nz, .continue
	ld hl, CaptainText ; testing
	jr .foundName ; testing
.continue
	ld a, [wTrainerClass] ; added because I have overwritten a for the captain check

	ld [wd0b5], a
	ld a, TRAINER_NAME
	ld [wNameListType], a
	ld a, BANK(TrainerNames)
	ld [wPredefBank], a
	call GetName
	ld hl, wcd6d
.foundName
	ld de, wTrainerName
	ld bc, $d
	jp CopyData ; copies bc bytes from hl to de

CaptainText: db "CAPTAIN@" ; new
