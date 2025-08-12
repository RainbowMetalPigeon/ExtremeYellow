; Credits to Porygondolier

;a should already contain the move ID as an input
Tutor::
;	call SaveScreenTilesToBuffer2
	ld a, [wMoveNum]
	ld [wd11e], a
	ld [wUniQuizAnswer], a ; new
	call GetMoveName
	call CopyToStringBuffer ;puts string from [de] into wStringBuffer

.chooseMon
	ld hl, wStringBuffer
	ld de, wTempMoveNameBuffer
	ld bc, 14
	call CopyData ; save the move name because DisplayPartyMenu will overwrite it
	xor a
	ld [wUpdateSpritesEnabled], a
	ld a, TUTOR_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	call DisplayPartyMenu
	push af
	ld hl, wTempMoveNameBuffer
	ld de, wStringBuffer
	ld bc, 14
	call CopyData ; copies bc bytes from hl to de
	pop af
	jr nc, .checkIfAbleToLearnMove
; if the player canceled teaching the move
	jr .done
.checkIfAbleToLearnMove
	call CanLearnTutorMove ; check if the pokemon can learn the move
	push de ; edited, was bc
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	pop de ; edited, was bc
	ld a, d ; edited, was c instead of d
	and a ; can the pokemon learn the move?
	jr nz, .checkIfAlreadyLearnedMove
; if the pokemon can't learn the move
	ld a, SFX_DENIED
	call PlaySoundWaitForCurrent
	ld hl, MonCannotLearnMachineMoveText2
	call PrintText
	jr .chooseMon
.checkIfAlreadyLearnedMove
	callfar CheckIfMoveIsKnown ; check if the pokemon already knows the move
	jr c, .chooseMon

	ld a, [wLetterPrintingDelayFlags]
	push af
	xor a
	ld [wLetterPrintingDelayFlags], a

	predef LearnMove ; teach move

	pop af
	ld [wLetterPrintingDelayFlags], a

.done
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	ret

MonCannotLearnMachineMoveText2:
	text_far _MonCannotLearnMachineMoveText
	text_end

TextXample1:
	text_far _RaisePPWhichTechniqueText
	text_end

; tests if mon [wcf91] can learn move [wMoveNum]
; returns d = nonzero if move can be taught, d = 0 if not ; edited, was c instead of d
CanLearnTutorMove:
    ld a, [wcf91]
    ld b, a
    ld a, [wMoveNum]
    ld c, a
    ld hl, TutorMoveData

.loop
	push bc
	ld bc, 2 ;bytes to copy
	ld a, BANK(TutorMoveData)
	ld de, wMultipurposeBuffer ; edited, any 2-byte buffer variable would do?
	call FarCopyData ; Copy bc bytes from a:hl to de. THis also takes care of incrementing hl twice ready for the next loop
	pop bc

	ld de, wMultipurposeBuffer ; edited, any 2-byte buffer variable would do?
    ld a, [de]
    cp $ff
    jr z, .not_found
    cp c
    jr nz, .skip
	inc de
    ld a, [de]
    cp b
    jr z, .found
    jr .loop
.skip
    jr .loop

.found
    ld d, 1 ; any nonzero value = can learn ; edited, was c
	ret

.not_found
	ld d, 0 ; edited, was c
	ret
