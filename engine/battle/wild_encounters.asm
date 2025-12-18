; try to initiate a wild pokemon encounter
; returns success in Z
TryDoWildEncounter:
	ld a, [wNPCMovementScriptPointerTableNum]
	and a
	ret nz
	ld a, [wd736]
	and a
	ret nz
	callfar IsPlayerStandingOnDoorTileOrWarpTile
	jr nc, .notStandingOnDoorOrWarpTile
.CantEncounter
	ld a, $1
	and a
	ret
; new for sliding ice
.notStandingOnDoorOrWarpTile
	callfar AreWeOnSlidingIce
	jr z, .CantEncounter
	CheckEvent EVENT_DOING_WATERFALL
	jr nz, .CantEncounter
	CheckEvent EVENT_DOING_ROCK_CLIMB
	jr nz, .CantEncounter
; BTV
	callfar IsPlayerJustOutsideMap
	jr z, .CantEncounter
	ld a, [wRepelRemainingSteps]
	and a
	jr z, .next
	dec a
	jp z, .lastRepelStep
	ld [wRepelRemainingSteps], a
.next
; determine if wild pokemon can appear in the half-block we're standing in
; is the bottom left tile (8,9) of the half-block we're standing in a grass/water tile?
; note that by using the bottom left tile, this prevents the "left-shore" tiles from generating grass encounters
	hlcoord 8, 9
	ld c, [hl]
	ld a, [wGrassTile]
	cp c
	ld a, [wGrassRate]
	jr z, .CanEncounter
	ld a, $14 ; in all tilesets with a water tile, this is its id
	cp c
	ld a, [wWaterRate]
	jr z, .CanEncounter
; even if not in grass/water, standing anywhere we can encounter pokemon
; so long as the map is "indoor" and has wild pokemon defined.
; ...as long as it's not Viridian Forest or Safari Zone.
; edited: added condition for Forlorn Valley
; new, edited for sevii
	CheckEvent EVENT_IN_SEVII
	ld a, [wCurMap]
	jr nz, .sevii
; Kanto
	cp FIRST_INDOOR_MAP ; is this an indoor map?
	jr c, .CantEncounter2
	jr .continue
.sevii
	cp FIRST_INDOOR_MAP_SEVII
	jr c, .CantEncounter2
.continue
	cp FORLORN_VALLEY
	jr z, .CantEncounter2
; back to vanilla
	ld a, [wCurMapTileset]
	cp FOREST ; Viridian Forest/Safari Zone and forest(s) of Sevii
	jr z, .CantEncounter2
; new
	cp ISLAND ; Secluded Island
	jr z, .CantEncounter2
	cp OVERWORLD_SEVII ; for Seven Island Gym
	jr z, .CantEncounter2
	cp UNDERWATER
	jr z, .CantEncounter2
; BTV
	ld a, [wGrassRate]
.CanEncounter
; compare encounter chance with a random number to determine if there will be an encounter
	ld b, a
	ldh a, [hRandomAdd]
	cp b
	jr nc, .CantEncounter2
	ldh a, [hRandomSub]
	ld b, a
	ld hl, WildMonEncounterSlotChances
.determineEncounterSlot
	ld a, [hli]
	cp b
	jr nc, .gotEncounterSlot
	inc hl
	jr .determineEncounterSlot
.gotEncounterSlot
; determine which wild pokemon (grass or water) can appear in the half-block we're standing in
; edit: "can", because the repel check is applied later
	ld c, [hl]
	ld hl, wGrassMons
	lda_coord 8, 9
	cp $14 ; is the bottom left tile (8,9) of the half-block we're standing in a water tile?
	jr nz, .gotWildEncounterType ; else, it's treated as a grass tile by default
	ld hl, wWaterMons
.gotWildEncounterType
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld [wCurEnemyLVL], a
	ld a, [hl]
	ld [wcf91], a
	ld [wEnemyMonSpecies2], a
	ld a, [wRepelRemainingSteps]
	and a
	jr z, .willEncounter
	ld a, [wPartyMon1Level]
	ld b, a
	ld a, [wCurEnemyLVL]
	cp b
	jr c, .CantEncounter2 ; repel prevents encounters if the leading party mon's level is higher than the wild mon
	jr .willEncounter
.lastRepelStep
	ld [wRepelRemainingSteps], a
	ld a, TEXT_REPEL_WORE_OFF
	ldh [hSpriteIndexOrTextID], a
	call EnableAutoTextBoxDrawing
	call DisplayTextID
.CantEncounter2
	ld a, $1
	and a
	ret
.willEncounter
;	callfar RollForShiny ; deprecated
	xor a
	ld [wIsTrainerBattle], a		; new, to go beyond 200
	ret

INCLUDE "data/wild/probabilities.asm"
