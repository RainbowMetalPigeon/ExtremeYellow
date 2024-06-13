; determines if attack is a critical hit
; Azure Heights claims "the fastest pokémon (who are, not coincidentally,
; among the most popular) tend to CH about 20 to 25% of the time."
CriticalHitTest:
	xor a
	ld [wCriticalHitOrOHKO], a
	ldh a, [hWhoseTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr nz, .handleEnemy
	ld a, [wBattleMonSpecies]
.handleEnemy
	ld [wd0b5], a
	call GetMonHeader
	ld a, [wMonHBaseSpeed]
	ld b, a
;	srl b                        ; (effective (base speed/2))
	ldh a, [hWhoseTurn]
	and a
	ld hl, wPlayerMovePower
	ld de, wPlayerBattleStatus2
	jr z, .calcCriticalHitProbability
	ld hl, wEnemyMovePower
	ld de, wEnemyBattleStatus2
.calcCriticalHitProbability
	ld a, [hld]                  ; read base power from RAM
	and a
	ret z                        ; do nothing if zero
	dec hl
	ld c, [hl]                   ; read move id
	ld hl, HighCriticalMoves     ; table of high critical hit moves
.Loop
	ld a, [hli]                  ; read move from move table
	cp c                         ; does it match the move about to be used?
	jr z, .HighCritical          ; if so, the move about to be used is a high critical hit ratio move
	inc a                        ; move on to the next move, FF terminates loop
	jr nz, .Loop                 ; check the next move in HighCriticalMoves
	srl b                        ; /2 for regular move
	jr .SkipHighCritical         ; continue as a normal move
.HighCritical
	sla b                        ; *2 for high critical hit moves
	jr nc, .noCarry
	ld b, $ff                    ; cap at 255/256
.noCarry
	sla b                        ; *4 for high critical move
	jr nc, .SkipHighCritical
	ld b, $ff
.SkipHighCritical
	ld a, [de]
	bit GETTING_PUMPED, a        ; test for focus energy ; edited, fixed Focus Energy bug
	jr z, .noFocusEnergyUsed
	sla b                        ; (effective (base speed)*2)
	jr nc, .focusEnergyUsed
	ld b, $ff                    ; cap at 255/256
	jr .noFocusEnergyUsed
.focusEnergyUsed
	sla b                        ; (effective ((base speed*2)*2))
	jr nc, .noFocusEnergyUsed
	ld b, $ff                    ; cap at 255/256
.noFocusEnergyUsed
; new, to boost happy Starter Pikachu -> quadruple crit rate if happiness is 250 or more
	ldh a, [hWhoseTurn]
	and a
	jr nz, .vanilla ; we don't do this if it's not our turn
	push bc
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .notStarterPikachu
	ld a, [wPikachuHappiness]
	cp 250
	jr c, .notStarterPikachu
; happy Starter Pikachu
	pop bc
	sla b
	jr nc, .continue
	ld b, $ff
	jr .vanilla
.continue
	sla b
	jr nc, .vanilla
	ld b, $ff
	jr .vanilla
.notStarterPikachu
	pop bc
.vanilla
; back to vanilla
	call BattleRandom2           ; generates a random value, in "a" ; edited into the copy
	rlc a
	rlc a
	rlc a
	cp b                         ; check a against calculated crit rate
	ret nc                       ; no critical hit if no borrow
	ld a, $1
	ld [wCriticalHitOrOHKO], a   ; set critical hit flag
	ret

INCLUDE "data/battle/critical_hit_moves.asm"

IsMoveHighCrit:: ; to be used in the Attackdex
; input: move ID in d
; output: c flag if found
	ld a, d
	ld hl, HighCriticalMoves
	ld de, 1 ; 1-byte entry
	call IsInArray ; Search an array at hl for the value in a.
				   ; Entry size is de bytes.
				   ; Return count b and carry if found.
	ret
