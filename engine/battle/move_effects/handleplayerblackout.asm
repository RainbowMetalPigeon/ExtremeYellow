; called when player is out of usable mons.
; prints appropriate lose message, sets carry flag if player blacked out (special case for initial rival fight)
; trying updates from Vortiene
_HandlePlayerBlackOut:
	xor a                    ; new, to go beyond 200
	ld [wIsTrainerBattle], a ; new, to go beyond 200
	ld [wInverseBattle], a   ; new, to reset battle style to normal after losing
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .noLossText
; edited, to handle surrender from a trainer
	ld a, [wSurrenderedFromTrainerBattle]
	and a
	lb bc, 12, SCREEN_WIDTH
	jr nz, .surrendered
; back to vanilla
	ld a, [wCurOpponent]
	cp OPP_RIVAL1
	jr z, .lossText
	cp OPP_RIVAL2 ; edited: loss text for Rival2 trainer class restored
	jr z, .lossText
	cp OPP_RIVAL3 ; edited: loss text for Rival3 trainer class restored
	jr z, .lossText
	cp OPP_PROF_OAK ; edited: loss text for Oak trainer class restored
	jr z, .lossText
	cp OPP_TRAVELER ; new
	jr z, .lossText
	cp OPP_PIGEON ; new
	jr z, .lossText
	cp OPP_BF_TRAINER ; new
	jr z, .lossText
	jr .noLossText
.lossText ; battle that has loss text
	lb bc, 8, 21
.surrendered
	hlcoord 0, 0 
	call ClearScreenArea
	callfar ScrollTrainerPicAfterBattle ; this should do?
	ld c, 40
	call DelayFrames
	call PrintEndBattleText ; in this case the end battle text is the "loss" text
	ld a, [wCurMap]
	cp OAKS_LAB
	ret z            		; starter battle in oak's lab: don't black out
	cp BATTLE_FACILITY      ; new: don't black out in Battle Facility
	jr nz, .noLossText      ; new and edited
; handling battle facility loss, including surrendering
	ld a, [wSurrenderedFromTrainerBattle]
	and a
	jr z, .notSurrenderInBF
; we did surrender in BF
	ld b, SET_PAL_BATTLE_BLACK
	call RunPaletteCommand
	ld hl, PlayerGaveUpText
	call PrintText
	call ClearScreen
	scf
.notSurrenderInBF
	ret
.noLossText
	ld b, SET_PAL_BATTLE_BLACK
	call RunPaletteCommand
; edited, to handle surrender from a trainer
	ld a, [wSurrenderedFromTrainerBattle]
	and a
	ld hl, PlayerGaveUpText
	jr nz, .noLinkBattle
; back to vanilla
	ld hl, PlayerBlackedOutText2
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .noLinkBattle
	ld hl, LinkBattleLostText
.noLinkBattle
	call PrintText
	ld a, [wd732]
	res 5, a
	ld [wd732], a
	call ClearScreen
	scf
	ret

Rival1WinText:
	text_far _Rival1WinText
	text_end

PlayerBlackedOutText2:
	text_far _PlayerBlackedOutText2
	text_end

PlayerGaveUpText:: ; new
	text_far _PlayerGaveUpText
	text_end

LinkBattleLostText:
	text_far _LinkBattleLostText
	text_end
