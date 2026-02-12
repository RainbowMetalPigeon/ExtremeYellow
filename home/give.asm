GiveItem::
; Give player quantity c of item b,
; and copy the item's name to wStringBuffer.
; Return carry on success.
	ld a, b
	ld [wd11e], a
	ld [wcf91], a
	ld a, c
	ld [wItemQuantity], a
	ld hl, wNumBagItems
	call AddItemToInventory
	ret nc
	call GetItemName
	call CopyToStringBuffer
	scf
	ret

GivePokemon::
; Give the player monster b at level c.
	ld a, b
	ld [wcf91], a
	ld a, c
	ld [wCurEnemyLVL], a
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
; new, for the shiny (starter pikachu)
	ld a, [wCurMap]
	cp OAKS_LAB
	jr nz, .notOaksLab
	ld a, [wShinyStarterPikachu]
	ld [wOpponentMonShiny], a
	jr .skipTheNormalShinyRoll
.notOaksLab
	callfar RollForShiny
.skipTheNormalShinyRoll
	callfar _GivePokemon ; main thingy
	xor a
	ld [wOpponentMonShiny], a
; back to vanilla
	ret
