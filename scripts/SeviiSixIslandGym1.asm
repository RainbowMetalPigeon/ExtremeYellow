SeviiSixIslandGym1_Script:
	call ApplyMalusOnEntry1
	jp EnableAutoTextBoxDrawing

ApplyMalusOnEntry1:
	ld hl, wCurrentMapScriptFlags ; new
	bit 5, [hl]
	res 5, [hl]
	ret z
	ld a, [wXCoord]
; Intro room?
	cp 10 ; between Intro room and Stat-Debuff room
	ret c
; Stat Debuff room?
	cp 24
	jr nc, .checkPSNRoom
	ld a, 6
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkPSNRoom
; one check for all status rooms: if all mons are statused, skip the rest
	call CheckIfAllMonsAreStatused ; z flag if at least 1 mon is NOT statused
	ret nz
; now, normal checks
	ld a, [wXCoord] ; need to be reloaded because was overwritten above
	cp 38
	jr nc, .checkBRNRoom
	call FindARandomNonStatusedPokemon ; hl now points to a non-statused mon
	set PSN, [hl]
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkBRNRoom
	cp 52
	jr nc, .PARRoom
	call FindARandomNonStatusedPokemon ; hl now points to a non-statused mon
	set BRN, [hl]
	ld a, 8
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.PARRoom
	call FindARandomNonStatusedPokemon ; hl now points to a non-statused mon
	set PAR, [hl]
	ld a, 9
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

SeviiSixIslandGym1_TextPointers:
	dw SeviiSixIslandGym1Text1
	; signs
	dw SeviiSixIslandGym1SignText1
	dw SeviiSixIslandGym1SignText2
	dw SeviiSixIslandGym1SignText3
	dw SeviiSixIslandGym1SignText4
	; scripts
	dw SeviiSixIslandGym1PopUpMessageStatDebuff ; 6
	dw SeviiSixIslandGym1PopUpMessagePoison ; 7
	dw SeviiSixIslandGym1PopUpMessageBurn ; 8
	dw SeviiSixIslandGym1PopUpMessageParalysis ; 9

SeviiSixIslandGym1Text1:
	text_far _SeviiSixIslandGym1Text1
	text_end

SeviiSixIslandGym1SignText1:
	text_far _SeviiSixIslandGym1SignText1
	text_end

SeviiSixIslandGym1SignText2:
	text_far _SeviiSixIslandGym1SignText2
	text_end

SeviiSixIslandGym1SignText3:
	text_far _SeviiSixIslandGym1SignText3
	text_end

SeviiSixIslandGym1SignText4:
	text_far _SeviiSixIslandGym1SignText4
	text_end

SeviiSixIslandGym1PopUpMessageStatDebuff:
	text_far _SeviiSixIslandGym1PopUpMessageStatDebuff
	text_end
	
SeviiSixIslandGym1PopUpMessagePoison:
	text_far _SeviiSixIslandGym1PopUpMessagePoison
	text_end
	
SeviiSixIslandGym1PopUpMessageBurn:
	text_far _SeviiSixIslandGym1PopUpMessageBurn
	text_end
	
SeviiSixIslandGym1PopUpMessageParalysis:
	text_far _SeviiSixIslandGym1PopUpMessageParalysis
	text_end
	
; ------------------------------------------------------------

; returns hl as the pointer to a status-izable mon
FindARandomNonStatusedPokemon:
	ld a, [wPartyCount]
	ld d, a ; d has the number of Mons in the party
.RNGLoop
	call Random
	and 7 ; bit-wise and with %0000111
	cp d
	jr nc, .RNGLoop
; here we have a random number between 0 and b-1,
; i.e. the number of members - 1
; e.g. 0-5 if we have 6 members
	; a holds the random number
	ld hl, wPartyMon1Status
	ld bc, wPartyMon2Status - wPartyMon1Status
	call AddNTimes ; add bc to hl a times
	; now hl points to the status of the n-th mon
	ld a, [hl]
	and a
	jr nz, .RNGLoop ; back to RNG if the mon is already statused
; we can status-ize the mon
	ret

; z flag if at least 1 mon is NOT statused
CheckIfAllMonsAreStatused:
	ld a, [wPartyCount]
	ld b, a ; d has the number of Mons in the party
	ld de, wPartyMon2Status - wPartyMon1Status
	ld hl, wPartyMon1Status - (wPartyMon2Status - wPartyMon1Status)
.loop
	add hl, de
	ld a, [hl]
	and a
	ret z
	dec b
	jr nz, .loop
	ld a, 1
	and a ; to ensure nz flag is set
	ret

;DEF SLP_MASK EQU %111 ; 0-7 turns
;	const_def 3
;	const PSN ; 3
;	const BRN ; 4
;	const FRZ ; 5
;	const PAR ; 6
