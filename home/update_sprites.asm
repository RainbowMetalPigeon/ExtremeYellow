UpdateSprites::
	CheckEvent EVENT_FLYING_BETWEEN_KANTO_AND_SEVII ; new for sevii
	ret nz ; new for sevii
	ld a, [wUpdateSpritesEnabled]
	dec a
	ret nz
	ldh a, [hLoadedROMBank]
	push af
	ld a, BANK(_UpdateSprites)
	call BankswitchCommon
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	call _UpdateSprites
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	pop af
	call BankswitchCommon
	ret
