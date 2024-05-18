_SlidePlayerAndEnemySilhouettesOnScreen::
	call LoadPlayerBackPic
	ld a, MESSAGE_BOX ; the usual text box at the bottom of the screen
	ld [wTextBoxID], a
	call DisplayTextBoxID
	hlcoord 1, 5
	lb bc, 3, 7
	call ClearScreenArea
	call DisableLCD
	call LoadFontTilePatterns
	callfar LoadHudAndHpBarAndStatusTilePatterns ; edited into a callfar, even tho looks dumb as hell
	ld hl, vBGMap0
	ld bc, $400
.clearBackgroundLoop
	ld a, " "
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .clearBackgroundLoop
; copy the work RAM tile map to VRAM
	hlcoord 0, 0
	ld de, vBGMap0
	ld b, 18 ; number of rows
.copyRowLoop
	ld c, 20 ; number of columns
.copyColumnLoop
	ld a, [hli]
	ld [de], a
	inc e
	dec c
	jr nz, .copyColumnLoop
	ld a, 12 ; number of off screen tiles to the right of screen in VRAM
	add e ; skip the off screen tiles
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	dec b
	jr nz, .copyRowLoop
	call EnableLCD
	ld a, $90
	ldh [hWY], a
	ldh [rWY], a
	xor a
	ldh [hTileAnimations], a
	ldh [hSCY], a
	dec a
	ld [wUpdateSpritesEnabled], a
	call Delay3
	xor a
	ldh [hAutoBGTransferEnabled], a
	ld b, $70
	ld c, $90
	ld a, c
	ldh [hSCX], a
	call DelayFrame
	ld a, %11100100 ; inverted palette for silhouette effect
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	call UpdateGBCPal_BGP
	call UpdateGBCPal_OBP0
	call UpdateGBCPal_OBP1
.slideSilhouettesLoop ; slide silhouettes of the player's pic and the enemy's pic onto the screen
	ld h, b
	ld l, $40
	call SetScrollXForSlidingPlayerBodyLeft ; begin background scrolling on line $40
	inc b
	inc b
	inc b ; new, testing
	inc b ; new, testing
	inc b ; new, testing
	inc b ; new, testing
	ld h, $0
	ld l, $60
	call SetScrollXForSlidingPlayerBodyLeft ; end background scrolling on line $60
	call SlidePlayerHeadLeft
	ld a, c
	ldh [hSCX], a
	dec c
	dec c
	dec c ; new, testing
	dec c ; new, testing
	dec c ; new, testing
	dec c ; new, testing
	jr nz, .slideSilhouettesLoop
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	ld a, $31
	ldh [hStartTileID], a
	hlcoord 1, 5
	predef CopyUncompressedPicToTilemap
	xor a
	ldh [hWY], a
	ldh [rWY], a
	inc a
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ld b, SET_PAL_BATTLE
	call RunPaletteCommand
	callfar PlayShinyAnimationIfShinyEnemyMon ; new, for shiny
	call HideSprites
	jpfar PrintBeginningBattleText

; ==============================================================================

; loads either red back pic or old man back pic
; also writes OAM data and loads tile patterns for the Red or Old Man back sprite's head
; (for use when scrolling the player sprite and enemy's silhouettes on screen)
LoadPlayerBackPic::
	ld a, [wBattleType]
	ld de, OldManPicBack
	cp BATTLE_TYPE_OLD_MAN ; is it the old man tutorial?
	jr z, .next
	ld de, ProfOakPicBack
	cp BATTLE_TYPE_PIKACHU ; is it the pikachu battle at the beginning of the game?
	jr z, .next
;	ld de, RedPicBack
;.next
;	ld a, BANK(RedPicBack)
;	ASSERT BANK(RedPicBack) == BANK(OldManPicBack)
;	ASSERT BANK(RedPicBack) == BANK(ProfOakPicBack)

	ld a, [wPlayerGender]
	and a
	jr z, .RedBack
	cp a, 2			; check if enby
	jr z, .YellowBack
	ld de, GreenPicBack
	jr .next
.YellowBack
	ld de, YellowPicBack
	jr .next
.RedBack
	ld de, RedPicBack
.next
	ld a, BANK(RedPicBack)
	ASSERT BANK(RedPicBack) == BANK(OldManPicBack)
	ASSERT BANK(GreenPicBack) == BANK(OldManPicBack)
	ASSERT BANK(YellowPicBack) == BANK(OldManPicBack)
	ASSERT BANK(RedPicBack) == BANK(ProfOakPicBack)

	call UncompressSpriteFromDE
	predef ScaleSpriteByTwo
	ld hl, wShadowOAM
	xor a
	ldh [hOAMTile], a ; initial tile number
	ld b, $7 ; 7 columns
	ld e, $a0 ; X for the left-most column
.loop ; each loop iteration writes 3 OAM entries in a vertical column
	ld c, $3 ; 3 tiles per column
	ld d, $38 ; Y for the top of each column
.innerLoop ; each loop iteration writes 1 OAM entry in the column
	ld [hl], d ; OAM Y
	inc hl
	ld [hl], e ; OAM X
	ld a, $8 ; height of tile
	add d ; increase Y by height of tile
	ld d, a
	inc hl
	ldh a, [hOAMTile]
	ld [hli], a ; OAM tile number
	inc a ; increment tile number
	ldh [hOAMTile], a
	ld a, $2
	ld [hl], a
	inc hl
	dec c
	jr nz, .innerLoop
	ldh a, [hOAMTile]
	add $4 ; increase tile number by 4
	ldh [hOAMTile], a
	ld a, $8 ; width of tile
	add e ; increase X by width of tile
	ld e, a
	dec b
	jr nz, .loop
	ld de, vBackPic
	call InterlaceMergeSpriteBuffers
	ld a, $0
	call SwitchSRAMBankAndLatchClockData
	ld hl, vSprites
	ld de, sSpriteBuffer1
	ldh a, [hLoadedROMBank]
	ld b, a
	ld c, 7 * 7
	call CopyVideoData
	call PrepareRTCDataAndDisableSRAM
	ld a, $31
	ldh [hStartTileID], a
	hlcoord 1, 5
	predef_jump CopyUncompressedPicToTilemap

; ==============================================================================

SetScrollXForSlidingPlayerBodyLeft:
	ldh a, [rLY]
	cp l
	jr nz, SetScrollXForSlidingPlayerBodyLeft
	ld a, h
	ldh [rSCX], a
.loop
	ldh a, [rLY]
	cp h
	jr z, .loop
	ret

; ==============================================================================

; when a battle is starting, silhouettes of the player's pic and the enemy's pic are slid onto the screen
; the lower of the player's pic (his body) is part of the background, but his head is a sprite
; the reason for this is that it shares Y coordinates with the lower part of the enemy pic, so background scrolling wouldn't work for both pics
; instead, the enemy pic is part of the background and uses the scroll register, while the player's head is a sprite and is slid by changing its X coordinates in a loop
SlidePlayerHeadLeft:
	push bc
	ld hl, wShadowOAMSprite00XCoord
	ld c, $15 ; number of OAM entries
	ld de, $4 ; size of OAM entry
.loop
	dec [hl] ; decrement X
	dec [hl] ; decrement X
	dec [hl] ; decrement X ; new, testing
	dec [hl] ; decrement X ; new, testing
	dec [hl] ; decrement X ; new, testing
	dec [hl] ; decrement X ; new, testing
	add hl, de ; next OAM entry
	dec c
	jr nz, .loop
	pop bc
	ret
