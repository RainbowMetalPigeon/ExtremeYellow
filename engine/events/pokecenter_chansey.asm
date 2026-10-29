PokecenterChanseyText::
	ld hl, NurseChanseyText
	call PrintText
	ld a, CHANSEY
	call PlayCry
	call WaitForSoundToFinish
	call StealPokecenterChanseyRP ; new
	ret

NurseChanseyText:
	text_far _NurseChanseyText
	text_end

; new for RP =====================================

StealPokecenterChanseyRP:
	CheckEvent EVENT_ROCKET_PATH
	ret z
; indeed RP
	CheckEvent EVENT_IN_SEVII
	ld hl, KantoMapsLevelHS
	jr z, .gotList
	ld hl, SeviiMapsLevelHS
.gotList
	ld a, [wCurMap]
	ld b, a ; b holds the current map
.loop
	ld a, [hli]
	cp $FF
	ret z ; safety check, should never be hit
	cp b
	jr z, .matchFound
; advance to next entry
	inc hl
	inc hl
	jr .loop
.matchFound
	ld a, [hli]
	ld c, a ; level, hl points to the HS index
	push hl
	ld b, CHANSEY
	SetEvent EVENT_RP_STEALING_POKEMON
	call GivePokemon
	jr nc, .failedToGiveMon
; actually give the mon
	pop hl
	ld a, [hl]
	ld [wMissableObjectIndex], a
	CheckEvent EVENT_IN_SEVII
	jr nz, .inSevii
	predef_jump HideObjectExtra2
.inSevii
	predef_jump HideObjectSevii
.failedToGiveMon
	pop hl
	ret

KantoMapsLevelHS:
	db VERMILION_POKECENTER, 16, HS_VERMILION_POKECENTER_MON_1
	db LAVENDER_POKECENTER, 22, HS_LAVENDER_POKECENTER_MON_1
	db CELADON_POKECENTER, 23, HS_CELADON_POKECENTER_MON_1
	db OCHRE_POKECENTER, 29, HS_OCHRE_POKECENTER_MON_1
	db OBSIDIAN_POKECENTER, 32, HS_OBSIDIAN_POKECENTER_MON_1
	db CINNABAR_POKECENTER, 43, HS_CINNABAR_POKECENTER_MON_1
	db INDIGO_PLATEAU_LOBBY, 53, HS_INDIGO_PLATEAU_LOBBY_MON_1
	db SAFFRON_POKECENTER, 25, HS_SAFFRON_POKECENTER_MON_1
	db ROCK_TUNNEL_POKECENTER, 19, HS_ROCK_TUNNEL_POKECENTER_MON_1
	db $FF

SeviiMapsLevelHS:
	db SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART, 26, HS_SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	db SEVII_TWO_ISLAND_POKEMON_CENTER, 27, HS_SEVII_TWO_ISLAND_POKEMON_CENTER_MON_1
	db SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART, 28, HS_SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	db SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART, 34, HS_SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	db SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART, 35, HS_SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	db SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART, 65, HS_SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	db SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART, 66, HS_SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	db $FF
