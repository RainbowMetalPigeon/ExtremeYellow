InitBattleVariables:
	ldh a, [hTileAnimations]
	ld [wSavedTileAnimations], a
	xor a
	ld [wWasTrainerBattle], a             ; new, to go beyond 200
	ld [wActionResultOrTookBattleTurn], a
	ld [wBattleResult], a
	ld hl, wPartyAndBillsPCSavedMenuItem
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wListScrollOffset], a
	ld [wCriticalHitOrOHKO], a
	ld [wBattleMonSpecies], a
	ld [wPartyGainExpFlags], a
	ld [wPlayerMonNumber], a
	ld [wEscapedFromBattle], a
	ld [wMapPalOffset], a
;;;;;;;;;; PureRGBnote: ADDED: clear various new AI-related variables
;;;;;;;;;; Pigeon: currently only the wram variable related to which mons have already been sent out
;	ld [wAIMoveSpamAvoider], a
;	ld [wEnemyLastSelectedMove], a
;	ld [wPlayerLastSelectedMove], a
;	ld [wEnemyLastSelectedMoveDisable], a
;	ld [wPlayerLastSelectedMoveDisable], a
;	ld [wAITargetMonType1], a
;	ld [wAITargetMonType2], a
;	ld [wAITargetMonStatus], a
	ld a, [wAIWhichPokemonSentOutAlready]
	and $81	; clear bits 1 to 6 only by ANDing with 1000 0001
	ld [wAIWhichPokemonSentOutAlready], a
	xor a
;;;;;;;;;;
	ld hl, wPlayerHPBarColor
	ld [hli], a ; wPlayerHPBarColor
	ld [hl], a ; wEnemyHPBarColor
	ld hl, wCanEvolveFlags
	ld b, $3c
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	inc a ; POUND
	ld [wTestBattlePlayerSelectedMove], a
	ld a, [wCurMap]
	cp SAFARI_ZONE_EXTRA ; new
	jr z, .yesSafariBattle ; new
	cp SAFARI_ZONE_EAST
	jr c, .notSafariBattle
	cp SAFARI_ZONE_QUADRUPLE_REST_HOUSE ; edited because of MERGING
	jr nc, .notSafariBattle

; new special code for Safari Giovanni
	cp SAFARI_ZONE_NORTH
	jr nz, .yesSafariBattle
	; are we around Giovanni?
	ld hl, CoordsData_SafariGiovanni
	call ArePlayerCoordsInArray
	jr c, .notSafariBattle ; if yes, don't load the safari battle
.yesSafariBattle

	ld a, BATTLE_TYPE_SAFARI
	ld [wBattleType], a
.notSafariBattle
	jpfar PlayBattleMusic

CoordsData_SafariGiovanni: ; new
	dbmapcoord 25, 15
	dbmapcoord 26, 14
	dbmapcoord 26, 16
	dbmapcoord 27, 15
	db -1 ; end
