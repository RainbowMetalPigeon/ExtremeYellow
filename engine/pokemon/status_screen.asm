DrawHP:
; Draws the HP bar in the stats screen
	call GetPredefRegisters
	ld a, $1
	jr DrawHP_

DrawHP2:
; Draws the HP bar in the party screen
	call GetPredefRegisters
	ld a, $2

DrawHP_:
	ld [wHPBarType], a
	push hl
	ld a, [wLoadedMonHP]
	ld b, a
	ld a, [wLoadedMonHP + 1]
	ld c, a
	or b
	jr nz, .nonzeroHP
	xor a
	ld c, a
	ld e, a
	ld a, $6
	ld d, a
	jp .drawHPBarAndPrintFraction
.nonzeroHP
	ld a, [wLoadedMonMaxHP]
	ld d, a
	ld a, [wLoadedMonMaxHP + 1]
	ld e, a
	predef HPBarLength
	ld a, $6
	ld d, a
	ld c, a
.drawHPBarAndPrintFraction
	pop hl
	push de
	push hl
	push hl
	call DrawHPBar
	pop hl
	ldh a, [hUILayoutFlags]
	bit 0, a
	jr z, .printFractionBelowBar
	ld bc, $9 ; right of bar
	jr .printFraction
.printFractionBelowBar
	ld bc, SCREEN_WIDTH + 1 ; below bar
.printFraction
	add hl, bc
	ld de, wLoadedMonHP
	lb bc, 2, 3
	call PrintNumber
	ld a, "/"
	ld [hli], a
	ld de, wLoadedMonMaxHP
	lb bc, 2, 3
	call PrintNumber
	pop hl
	pop de
	ret

; Predef 0x37
StatusScreen:
	call LoadMonData
	ld a, [wMonDataLocation]
	cp BOX_DATA
	jr c, .DontRecalculate
; mon is in a box or daycare
	ld a, [wLoadedMonBoxLevel]
	ld [wLoadedMonLevel], a
	ld [wCurEnemyLVL], a
	ld hl, wLoadedMonHPExp - 1
	ld de, wLoadedMonStats
	ld b, $1
	call CalcStats ; Recalculate stats
.DontRecalculate
	ld hl, wd72c
	set 1, [hl]
	ld a, $33
	ldh [rNR50], a ; Reduce the volume
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	call LoadHpBarAndStatusTilePatterns
	ld de, BattleHudTiles1  ; source
	ld hl, vChars2 tile $6d ; dest
	lb bc, BANK(BattleHudTiles1), 3
	call CopyVideoDataDouble ; ·│ :L and halfarrow line end
	ld de, BattleHudTiles2
	ld hl, vChars2 tile $78
	lb bc, BANK(BattleHudTiles2), 1
	call CopyVideoDataDouble ; │
	ld de, BattleHudTiles3
	ld hl, vChars2 tile $76
	lb bc, BANK(BattleHudTiles3), 2
	call CopyVideoDataDouble ; ─ ┘
	ld de, PTile
	ld hl, vChars2 tile $72
	lb bc, BANK(PTile), 1
	call CopyVideoDataDouble ; bold P (for PP)
	ldh a, [hTileAnimations]
	push af
	xor a
	ldh [hTileAnimations], a
	ld [wDumbByteToToggleStatusScreen], a ; new, to cycle through the different stat printers
	hlcoord 19, 1
	lb bc, 6, 10
	call DrawLineBox ; Draws the box around name, HP and status
	ld de, -6
	add hl, de
	ld [hl], "<DOT>"
	dec hl
	ld [hl], "№"
	hlcoord 19, 9
	lb bc, 8, 6
	call DrawLineBox ; Draws the box around types, ID No. and OT
	hlcoord 10, 9
	ld de, Type1Text
	call PlaceString ; "TYPE1/"
	hlcoord 11, 3
	predef DrawHP
	ld hl, wStatusScreenHPBarColor
	call GetHealthBarColor
	ld b, SET_PAL_STATUS_SCREEN
	call RunPaletteCommand
	hlcoord 16, 6
	ld de, wLoadedMonStatus
	call PrintStatusCondition
	jr nz, .StatusWritten
	hlcoord 16, 6
	ld de, OKText
	call PlaceString ; "OK"
.StatusWritten
	hlcoord 9, 6
	ld de, StatusText
	call PlaceString ; "STATUS/"
	hlcoord 14, 2
	call PrintLevel ; Pokémon level
	ld a, [wMonHIndex]
	ld [wd11e], a
	ld [wd0b5], a
	predef IndexToPokedex
	hlcoord 3, 7
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber ; Pokémon no.
; new, for the shiny symbol
	ld a, [wLoadedMonCatchRate]
	and a
	jr z, .notShiny
; print shiny symbol
	hlcoord 6, 7
	ld [hl], "<SHINY>"
.notShiny
; back to vanilla
; new, print label that suggests to click SELECT for more info
	hlcoord 16, 17
	ld a, "<SELINFO1>"
	ld [hli], a
	ld a, "<SELINFO2>"
	ld [hli], a
	ld a, "<SELINFO3>"
	ld [hli], a
	ld a, "<SELINFO4>"
	ld [hl], a
; back to vanilla
	hlcoord 11, 10
	predef PrintMonType
	ld hl, NamePointers2
	call .GetStringPointer
	ld d, h
	ld e, l
	hlcoord 9, 1
	call PlaceString ; Pokémon name
	ld hl, OTPointers
	call .GetStringPointer
	ld d, h
	ld e, l
	hlcoord 12, 16
	call PlaceString ; OT
	hlcoord 12, 14
	ld de, wLoadedMonOTID
	lb bc, LEADING_ZEROES | 2, 5
	call PrintNumber ; ID Number
	ld d, $0
	call PrintStatsBox
	call Delay3
	call GBPalNormal
	hlcoord 1, 0
	call LoadFlippedFrontSpriteByMonIndex ; draw Pokémon picture
	ld a, [wMonDataLocation]
	cp ENEMY_PARTY_DATA
	jr z, .playRegularCry
	cp BOX_DATA
	jr z, .checkBoxData
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .playRegularCry
	jr .playPikachuSoundClip
.checkBoxData
	callfar IsThisPartymonStarterPikachu_Box
	jr nc, .playRegularCry
.playPikachuSoundClip
	ld e, 16
	callfar PlayPikachuSoundClip
	jr .continue
.playRegularCry
	ld a, [wcf91]
	call PlayCry ; play Pokémon cry
.continue
; new, to cycle through the different stat printers
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and A_BUTTON | B_BUTTON | SELECT
	jr z, .continue
	bit BIT_SELECT, a
	jr z, .vanilla
; we call the next stat printer
.test
	ld a, [wDumbByteToToggleStatusScreen]
	and a
	jr z, .advanceTo1
	cp 1
	jr z, .advanceTo2
	cp 2
	jr z, .advanceTo3
; return to 0
	call ClearStatsValues
	hlcoord 11, 3
	predef DrawHP
	xor a
	ld [wDumbByteToToggleStatusScreen], a
	ld d, a
	call PrintStatsBox
	jr .continue
.advanceTo1
	inc a
	ld [wDumbByteToToggleStatusScreen], a
	call PrintStatsBox_Base
	jr .continue
.advanceTo2
	inc a
	ld [wDumbByteToToggleStatusScreen], a
	call PrintStatsBox_DVs
	jr .continue
.advanceTo3
	inc a
	ld [wDumbByteToToggleStatusScreen], a
	call PrintStatsBox_StatExp
	jr .continue
.vanilla
; back to vanilla
	call WaitForTextScrollButtonPress ; wait for button
	pop af
	ldh [hTileAnimations], a
	ret

.GetStringPointer
	ld a, [wMonDataLocation]
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMonDataLocation]
	cp DAYCARE_DATA
	ret z
	ld a, [wWhichPokemon]
	jp SkipFixedLengthTextEntries

OTPointers:
	dw wPartyMonOT
	dw wEnemyMonOT
	dw wBoxMonOT
	dw wDayCareMonOT

NamePointers2:
	dw wPartyMonNicks
	dw wEnemyMonNicks
	dw wBoxMonNicks
	dw wDayCareMonName

Type1Text:
	db   "TYPE1/"
	next ""
	; fallthrough
Type2Text:
	db   "TYPE2/"
	next ""
	; fallthrough
IDNoText:
	db   "<ID>№/"
	next ""
	; fallthrough
OTText:
	db   "OT/"
	next "@"

StatusText:
	db "STATUS/@"

OKText:
	db "OK@"

; Draws a line starting from hl high b and wide c
DrawLineBox:
	ld de, SCREEN_WIDTH ; New line
.PrintVerticalLine
	ld [hl], $78 ; │
	add hl, de
	dec b
	jr nz, .PrintVerticalLine
	ld [hl], $77 ; ┘
	dec hl
.PrintHorizLine
	ld [hl], $76 ; ─
	dec hl
	dec c
	jr nz, .PrintHorizLine
	ld [hl], $6f ; ← (halfarrow ending)
	ret

PTile: INCBIN "gfx/font/P.1bpp"

PrintStatsBox:
	ld a, d
	and a ; a is 0 from the status screen
	jr nz, .DifferentBox
	hlcoord 0, 8
	lb bc, 8, 8
	call TextBoxBorder ; Draws the box
; new, print label that these are the CURRENT stats
	hlcoord 1, 17
	ld a, "<CUR1>"
	ld [hli], a
	ld a, "<CUR2>"
	ld [hl], a
; back to vanilla
	hlcoord 1, 9 ; Start printing stats from here
	ld bc, $19 ; Number offset
	jr .PrintStats
.DifferentBox
	hlcoord 9, 2
	lb bc, 8, 9
	call TextBoxBorder
	hlcoord 11, 3
	ld bc, $18
.PrintStats
	push bc
	push hl
	ld de, StatsText
	call PlaceString
	pop hl
	pop bc
	add hl, bc
	lb bc, 2, 3
	ld de, wLoadedMonAttack
	call PrintStat
	ld de, wLoadedMonDefense
	call PrintStat
	ld de, wLoadedMonSpeed
	call PrintStat
	ld de, wLoadedMonSpecial
	jp PrintNumber
PrintStat:
	push hl
	call PrintNumber
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ret

PrintStatsBox_Base: ; new
	call ClearStatsValues
; print label that these are the BASE stats
	hlcoord 1, 17
	ld a, "<BASE1>"
	ld [hli], a
	ld a, "<BASE2>"
	ld [hl], a
; vanilla-like stuff
	hlcoord 1, 9 ; Start printing stats from here
	ld bc, $19 ; Number offset
.PrintStats
;	push bc
;	push hl
;	ld de, StatsText
;	call PlaceString
;	pop hl
;	pop bc
	add hl, bc
	lb bc, 1, 3
	ld de, wMonHBaseAttack
	call PrintStat
	ld de, wMonHBaseDefense
	call PrintStat
	ld de, wMonHBaseSpeed
	call PrintStat
	ld de, wMonHBaseSpecial
	call PrintNumber
; clear CurHP/MaxHP
	call ClearCurHpMaxHP
; print Base HP
	hlcoord 13, 4
	ld de, wMonHBaseHP
	lb bc, 1, 3
	jp PrintNumber

PrintStatsBox_DVs: ; new
	call ClearStatsValues
; print label that these are the IV stats
	hlcoord 1, 17
	ld a, "<IV1>"
	ld [hli], a
	ld a, "<IV2>"
	ld [hl], a
; vanilla-like stuff
	hlcoord 1, 9 ; Start printing stats from here
	ld bc, $19 ; Number offset
.PrintStats
;	push bc
;	push hl
;	ld de, StatsText
;	call PlaceString
;	pop hl
;	pop bc
	add hl, bc
	lb bc, 1, 2
; ATK DV
	ld de, wLoadedMonDVs
	ld a, [de]
	swap a
	and $f
	ld [wUniQuizAnswer], a
	ld de, wUniQuizAnswer
	call PrintStat
; DEF DV
	ld de, wLoadedMonDVs
	ld a, [de]
	and $f
	ld [wUniQuizAnswer], a
	ld de, wUniQuizAnswer
	call PrintStat
; SPEED DV
	ld de, wLoadedMonDVs
	inc de
	ld a, [de]
	swap a
	and $f
	ld [wUniQuizAnswer], a
	ld de, wUniQuizAnswer
	call PrintStat
; SPECIAL DV
	ld de, wLoadedMonDVs
	inc de
	ld a, [de]
	and $f
	ld [wUniQuizAnswer], a
	ld de, wUniQuizAnswer
	call PrintNumber
; clear CurHP/MaxHP
	call ClearCurHpMaxHP
; HP DV
	ld de, wLoadedMonDVs
	ld a, [de]  ; Atk IV
	swap a
	and $1
	sla a
	sla a
	sla a
	ld b, a
	ld a, [de] ; Def IV
	inc de
	and $1
	sla a
	sla a
	add b
	ld b, a
	ld a, [de] ; Spd IV
	swap a
	and $1
	sla a
	add b
	ld b, a
	ld a, [de] ; Spc IV
	and $1
	add b      ; HP IV: LSB of the other 4 IVs
	ld [wUniQuizAnswer], a
	ld de, wUniQuizAnswer
	hlcoord 13, 4
	lb bc, 1, 2
	jp PrintNumber

PrintStatsBox_StatExp: ; new
	call ClearStatsValues
; print label that these are the EV stats
	hlcoord 1, 17
	ld a, "<EV1>"
	ld [hli], a
	ld a, "<EV2>"
	ld [hl], a
; vanilla-like stuff
	hlcoord 1, 9 ; Start printing stats from here
	ld bc, $19 ; Number offset
.PrintStats
;	push bc
;	push hl
;	ld de, StatsText
;	call PlaceString
;	pop hl
;	pop bc
	add hl, bc
; print ATK stat exp
	push hl
	ld hl, wLoadedMonAttackExp
	ld a, [hld]
	ld a, [hli]
	call CalculateHumanReadableStatExp
	ld a, [de]
	pop hl
	lb bc, 1, 2
	call PrintStat
; print DEF stat exp
	push hl
	ld hl, wLoadedMonDefenseExp
	ld a, [hld]
	ld a, [hli]
	call CalculateHumanReadableStatExp
	ld a, [de]
	pop hl
	lb bc, 1, 2
	call PrintStat
; print SPEED stat exp
	push hl
	ld hl, wLoadedMonSpeedExp
	ld a, [hld]
	ld a, [hli]
	call CalculateHumanReadableStatExp
	ld a, [de]
	pop hl
	lb bc, 1, 2
	call PrintStat
; print SPECIAL stat exp
	push hl
	ld hl, wLoadedMonSpecialExp
	ld a, [hld]
	ld a, [hli]
	call CalculateHumanReadableStatExp
	ld a, [de]
	pop hl
	lb bc, 1, 2
	call PrintNumber
; clear CurHP/MaxHP
	call ClearCurHpMaxHP
; print HP stat exp
	ld hl, wLoadedMonHPExp
	ld a, [hld]
	ld a, [hli]
	call CalculateHumanReadableStatExp
	ld a, [de]
	hlcoord 13, 4
	lb bc, 1, 2
	jp PrintNumber

StatsText:
	db   "ATTACK"
	next "DEFENSE"
	next "SPEED"
	next "SPECIAL@"

ClearCurHpMaxHP: ; new
	ld a, " "
	hlcoord 12, 4
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

ClearStatsValues: ; new
	ld a, " "
	hlcoord 6, 10
	ld [hli], a
	ld [hli], a
	ld [hl], a
	hlcoord 6, 12
	ld [hli], a
	ld [hli], a
	ld [hl], a
	hlcoord 6, 14
	ld [hli], a
	ld [hli], a
	ld [hl], a
	hlcoord 6, 16
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

; input: wLoadedMonSTATExp in hl
; output: human-readable value of stat exp loaded in de via wUniQuizAnswer
CalculateHumanReadableStatExp: ; new
; calculates ceil(Sqrt(stat exp)) in b
	ld b, 0
	ld a, [hld]
	ld a, [hli]
.startLoop
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand+1], a
	inc b               ; increment current stat exp bonus
	ld a, b
	cp $ff
	jr z, .statExpDone
	ldh [hMultiplicand+2], a
	ldh [hMultiplier], a
	call Multiply

	ld a, [hl] ; MSB of stat exp
	ld d, a
	ldh a, [hProduct + 2] ; MSB
	cp d ; a-d = MSB of b^2 - MSB of StatExp
	jr c, .startLoop
	inc hl
	ld a, [hld] ; LSB of stat exp, and returns hl to the previous value
	ld d, a
	ldh a, [hProduct + 3] ; LSB
	cp d ; a-d = MSB of b^2 - MSB of StatExp
	jr c, .startLoop

;	ld a, [hli]
;	ld d, a
;	ldh a, [hProduct + 3] ; LSB
;	sub d
;	ld a, [hld]
;	ld d, a
;	ldh a, [hProduct + 2] ; MSB
;	sbc d               ; test if (current stat exp bonus)^2 < stat exp
;	jr c, .startLoop

.statExpDone
	ld a, b
	srl a
	srl a ; divide by 4 with the operation above
	ld [wUniQuizAnswer], a
	ld de, wUniQuizAnswer
	ret

StatusScreen2:
	ldh a, [hTileAnimations]
	push af
	xor a
	ldh [hTileAnimations], a
	ldh [hAutoBGTransferEnabled], a
	ld bc, NUM_MOVES + 1
	ld hl, wMoves
	call FillMemory
	ld hl, wLoadedMonMoves
	ld de, wMoves
	ld bc, NUM_MOVES
	call CopyData
	callfar FormatMovesString
	hlcoord 9, 2
	lb bc, 5, 10
	call ClearScreenArea ; Clear under name
	hlcoord 19, 3
	ld [hl], $78
	hlcoord 0, 8
	lb bc, 8, 18
	call TextBoxBorder ; Draw move container
	hlcoord 2, 9
	ld de, wMovesString
	call PlaceString ; Print moves
	ld a, [wNumMovesMinusOne]
	inc a
	ld c, a
	ld a, $4
	sub c
	ld b, a ; Number of moves ?
	hlcoord 11, 10
	ld de, SCREEN_WIDTH * 2
	ld a, "<BOLD_P>"
	call StatusScreen_PrintPP ; Print "PP"
	ld a, b
	and a
	jr z, .InitPP
	ld c, a
	ld a, "-"
	call StatusScreen_PrintPP ; Fill the rest with --
.InitPP
	ld hl, wLoadedMonMoves
	decoord 14, 10
	ld b, 0
.PrintPP
	ld a, [hli]
	and a
	jr z, .PPDone
	push bc
	push hl
	push de
	ld hl, wCurrentMenuItem
	ld a, [hl]
	push af
	ld a, b
	ld [hl], a
	push hl
	callfar GetMaxPP
	pop hl
	pop af
	ld [hl], a
	pop de
	pop hl
	push hl
	ld bc, wPartyMon1PP - wPartyMon1Moves - 1
	add hl, bc
	ld a, [hl]
	and $3f
	ld [wStatusScreenCurrentPP], a
	ld h, d
	ld l, e
	push hl
	ld de, wStatusScreenCurrentPP
	lb bc, 1, 2
	call PrintNumber
	ld a, "/"
	ld [hli], a
	ld de, wMaxPP
	lb bc, 1, 2
	call PrintNumber
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ld d, h
	ld e, l
	pop hl
	pop bc
	inc b
	ld a, b
	cp $4
	jr nz, .PrintPP
.PPDone
	hlcoord 9, 3
	ld de, StatusScreenExpText
	call PlaceString
	ld a, [wLoadedMonLevel]
	push af
	cp MAX_LEVEL
	jr z, .LevelMax ; edited label
	cp MAX_LEVEL_2 ; new
	jr z, .LevelMax ; new
	inc a
	ld [wLoadedMonLevel], a ; Increase temporarily if not 100
.LevelMax ; edited label
	hlcoord 14, 6
	ld [hl], "<to>"
	inc hl
	inc hl
	call PrintLevel
	pop af
	ld [wLoadedMonLevel], a
	ld de, wLoadedMonExp
	hlcoord 12, 4
	lb bc, 3, 7
	call PrintNumber ; exp
	call CalcExpToLevelUp
	ld de, wLoadedMonExp
	hlcoord 7, 6
	lb bc, 3, 7
	call PrintNumber ; exp needed to level up
	hlcoord 9, 0
	call StatusScreen_ClearName
	hlcoord 9, 1
	call StatusScreen_ClearName
	ld a, [wMonHIndex]
	ld [wd11e], a
	call GetMonName
	hlcoord 9, 1
	call PlaceString
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	call WaitForTextScrollButtonPress ; wait for button
	pop af
	ldh [hTileAnimations], a
	ld hl, wd72c
	res 1, [hl]
	ld a, $77
	ldh [rNR50], a
	call GBPalWhiteOut
	jp ClearScreen

CalcExpToLevelUp:
	ld a, [wLoadedMonLevel]
	cp MAX_LEVEL
	jr z, .atMaxLevel
	cp MAX_LEVEL_2 ; new
	jr z, .atMaxLevel ; new
	inc a
	ld d, a
	callfar CalcExperience
	ld hl, wLoadedMonExp + 2
	ldh a, [hExperience + 2]
	sub [hl]
	ld [hld], a
	ldh a, [hExperience + 1]
	sbc [hl]
	ld [hld], a
	ldh a, [hExperience]
	sbc [hl]
	ld [hld], a
	ret
.atMaxLevel
	ld hl, wLoadedMonExp
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

StatusScreenExpText:
	db   "EXP POINTS"
	next "LEVEL UP@"

StatusScreen_ClearName:
	ld bc, 10
	ld a, " "
	jp FillMemory

StatusScreen_PrintPP:
; print PP or -- c times, going down two rows each time
	ld [hli], a
	ld [hld], a
	add hl, de
	dec c
	jr nz, StatusScreen_PrintPP
	ret
