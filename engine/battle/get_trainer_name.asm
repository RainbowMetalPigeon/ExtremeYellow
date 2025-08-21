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

; new, for the SS Anne Captain and Copycat
	ld a, [wCurMap]
	cp SS_ANNE_CAPTAINS_ROOM
	jr nz, .continue1
	ld hl, CaptainText
	jr .foundName
.continue1
	cp COPYCATS_HOUSE_1F ; a already contains [wCurMap]
	jr nz, .continue2
	ld hl, wPlayerName ; testing
	jr .foundName ; testing
.continue2
	ld a, [wTrainerClass] ; added because I have overwritten a for the captain-and-copycat check

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
