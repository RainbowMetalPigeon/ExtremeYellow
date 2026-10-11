DisplayPokemonCenterDialogue_::
	CheckEvent EVENT_IN_SEVII ; new
	jr nz, .regularCenter ; new
	CheckEvent EVENT_ROCKET_PATH ; new
	jr nz, .checkRouteCenters ; new
	ld a, [wCurMap]
	cp PEWTER_POKECENTER
	jr nz, .checkRouteCenters ; edited
	call CheckPikachuFollowingPlayer
	jr z, .regularCenter
	ld hl, LooksContentText ; if pikachu is sleeping, don't heal
	call PrintText
	ret
; new, for setting Route 4 and Route 10 Pokecenters fly locations
.checkRouteCenters
	ld a, [wCurMap]
	cp MT_MOON_POKECENTER
	jr nz, .checkRockTunnelPokecenter
	ld c, 13
	ld b, FLAG_SET
	ld hl, wTownVisitedFlag   ; mark town as visited (for flying)
	predef FlagActionPredef
	jr .regularCenter
.checkRockTunnelPokecenter
	cp ROCK_TUNNEL_POKECENTER
	jr nz, .regularCenter
	ld c, 14
	ld b, FLAG_SET
	ld hl, wTownVisitedFlag   ; mark town as visited (for flying)
	predef FlagActionPredef
; back to vanilla
.regularCenter
	call SaveScreenTilesToBuffer1 ; save screen
; edited
	CheckEvent EVENT_ROCKET_PATH
	ld hl, PokemonCenterWelcomeText
	jr z, .printText1
; in RP
	call CheckIfLocalChanseyWasStolen_RP ; new
	ld hl, PokemonCenterWelcomeText_RocketPath_StolenChansey
	jp nz, .printAndEnd
	ld hl, PokemonCenterWelcomeText_RocketPath
.printText1
	call PrintText
	call YesNoChoicePokeCenter ; yes/no menu
	call UpdateSprites
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .declinedHealing ; if the player chose No
	call SetLastBlackoutMap
	callfar IsStarterPikachuInOurParty
	jr nc, .notHealingPlayerPikachu
	call CheckPikachuFollowingPlayer
	jr nz, .notHealingPlayerPikachu
	call LoadCurrentMapView
	call Delay3
	call UpdateSprites
	callfar PikachuWalksToNurseJoy ; todo
.notHealingPlayerPikachu
	ld hl, NeedYourPokemonText
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printText2
	ld hl, NeedYourPokemonText_RocketPath
.printText2
	call PrintText
	ld c, 1 ; edited
	call DelayFrames
	call CheckPikachuFollowingPlayer
	jr nz, .playerPikachuNotOnScreen
	call DisablePikachuOverworldSpriteDrawing
;	callfar IsStarterPikachuInOurParty ; edited
;	call c, Func_6eaa ; edited
.playerPikachuNotOnScreen
	lb bc, 1, 8
	call Func_6ebb
	ld c, 1 ; edited
	call DelayFrames
	farcall AnimateHealingMachine ; do the healing machine animation
	predef HealParty
	xor a
	ld [wAudioFadeOutControl], a
	ld a, [wAudioSavedROMBank]
	ld [wAudioROMBank], a
	ld a, [wMapMusicSoundID]
	ld [wLastMusicSoundID], a
	ld [wNewSoundID], a
	call PlaySound
	call CheckPikachuFollowingPlayer
	jr nz, .doNotReturnPikachu
;	callfar IsStarterPikachuInOurParty ; edited
;	call c, Func_6eaa ; edited
	ld a, $5
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.doNotReturnPikachu
	lb bc, 1, 0
	call Func_6ebb
	ld hl, PokemonFightingFitText
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printText3
	ld hl, PokemonFightingFitText_RocketPath
	call PrintText
	jp .postSleepBag
.printText3
	call PrintText
	callfar IsStarterPikachuInOurParty
	jr nc, .notInParty
	lb bc, 15, 0
	call Func_6ebb
.notInParty
	call LoadCurrentMapView
	call Delay3
	call UpdateSprites
	callfar ReloadWalkingTilePatterns
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, $1
	ldh [hSpriteImageIndex], a
	call SpriteFunc_34a1
	ld c, 20 ; edited
	call DelayFrames
	call UpdateSprites
	call LoadFontTilePatterns
	jr .done
.declinedHealing
	call LoadScreenTilesFromBuffer1 ; restore screen
.done
	ld hl, PokemonCenterFarewellText
	CheckEvent EVENT_ROCKET_PATH
	jr z, .printText4
	ld hl, PokemonCenterFarewellText_RocketPath
.printText4
	call PrintText
	call UpdateSprites
; new
IF DEF(_DEBUG)
	call DebugPressedOrHeldB
	jr nz, .postSleepBag
ENDC
	CheckEvent EVENT_GOT_SLEEP_BAG
	jr nz, .postSleepBag
	CheckEvent EVENT_ROCKET_PATH
	jr nz, .postSleepBag
	call WaitForTextScrollButtonPress ; wait for button press
	ld hl, PokemonCenterSleepBagText
	call PrintText
	lb bc, SLEEP_BAG, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_SLEEP_BAG
	ld hl, PokemonCenterGotSleepBagText
	call PrintText
	jr .postSleepBag
.bagFull
	ld hl, PokemonCenterBagFullText
.printAndEnd
	call PrintText
.postSleepBag
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ret

PokemonCenterSleepBagText: ; new
	text_far _PokemonCenterSleepBagText
	text_end

PokemonCenterGotSleepBagText: ; new
	text_far _PokemonCenterGotSleepBagText
	sound_get_key_item
	text_end

PokemonCenterBagFullText: ; new
	text_far _PokemonCenterBagFullText
	text_end

Func_6ebb:
	ld a, b
	ldh [hSpriteIndex], a
	ld a, c
	ldh [hSpriteImageIndex], a
	push bc
	call SetSpriteFacingDirection ; edited, was SetSpriteFacingDirectionAndDelay
	pop bc
	ld a, b
	ldh [hSpriteIndex], a
	ld a, c
	ldh [hSpriteImageIndex], a
	call SpriteFunc_34a1
	ret

PokemonCenterWelcomeText:
	text_far _PokemonCenterWelcomeText
	text_end

NeedYourPokemonText:
	text_far _NeedYourPokemonText
	text_end

PokemonFightingFitText:
	text_far _PokemonFightingFitText
	text_end

PokemonCenterFarewellText:
	text_far _PokemonCenterFarewellText
	text_end

LooksContentText:
	text_far _LooksContentText
	text_end

; new for RP =======================================

PokemonCenterWelcomeText_RocketPath:
	text_far _PokemonCenterWelcomeText_RocketPath
	text_end

NeedYourPokemonText_RocketPath:
	text_far _NeedYourPokemonText_RocketPath
	text_end

PokemonFightingFitText_RocketPath:
	text_far _PokemonFightingFitText_RocketPath
	text_end

PokemonCenterFarewellText_RocketPath:
	text_far _PokemonCenterFarewellText_RocketPath
	text_end

PokemonCenterWelcomeText_RocketPath_StolenChansey:
	text_far _PokemonCenterWelcomeText_RocketPath_StolenChansey
	text_end

CheckIfLocalChanseyWasStolen_RP: ; nz if we stole the local Chansey
	CheckEvent EVENT_IN_SEVII
	ld a, [wCurMap]
	jr nz, .sevii

; Kanto ---------------------------

	cp VERMILION_POKECENTER
	jr nz, .LAVENDER_POKECENTER
	CheckHideShowExtra2 HS_VERMILION_POKECENTER_MON_1 ; z flag if is SHOW, nz if is HIDE
	ret
.LAVENDER_POKECENTER

	cp LAVENDER_POKECENTER
	jr nz, .CELADON_POKECENTER
	CheckHideShowExtra2 HS_LAVENDER_POKECENTER_MON_1
	ret
.CELADON_POKECENTER

	cp CELADON_POKECENTER
	jr nz, .OCHRE_POKECENTER
	CheckHideShowExtra2 HS_CELADON_POKECENTER_MON_1
	ret
.OCHRE_POKECENTER

	cp OCHRE_POKECENTER
	jr nz, .OBSIDIAN_POKECENTER
	CheckHideShowExtra2 HS_OCHRE_POKECENTER_MON_1
	ret
.OBSIDIAN_POKECENTER

	cp OBSIDIAN_POKECENTER
	jr nz, .CINNABAR_POKECENTER
	CheckHideShowExtra2 HS_OBSIDIAN_POKECENTER_MON_1
	ret
.CINNABAR_POKECENTER

	cp CINNABAR_POKECENTER
	jr nz, .INDIGO_PLATEAU_LOBBY
	CheckHideShowExtra2 HS_CINNABAR_POKECENTER_MON_1
	ret
.INDIGO_PLATEAU_LOBBY

	cp INDIGO_PLATEAU_LOBBY
	jr nz, .SAFFRON_POKECENTER
	CheckHideShowExtra2 HS_INDIGO_PLATEAU_LOBBY_MON_1
	ret
.SAFFRON_POKECENTER

	cp SAFFRON_POKECENTER
	jr nz, .ROCK_TUNNEL_POKECENTER
	CheckHideShowExtra2 HS_SAFFRON_POKECENTER_MON_1
	ret
.ROCK_TUNNEL_POKECENTER

	cp ROCK_TUNNEL_POKECENTER
	jr nz, .noMatch
	CheckHideShowExtra2 HS_ROCK_TUNNEL_POKECENTER_MON_1
	ret

.noMatch
	xor a
	ret

.sevii ; ---------------------------

	cp SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART
	jr nz, .SEVII_TWO_ISLAND_POKEMON_CENTER
	CheckHideShowSevii HS_SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART_MON_1 ; z flag if is SHOW, nz if is HIDE
	ret
.SEVII_TWO_ISLAND_POKEMON_CENTER

	cp SEVII_TWO_ISLAND_POKEMON_CENTER
	jr nz, .SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART
	CheckHideShowSevii HS_SEVII_TWO_ISLAND_POKEMON_CENTER_MON_1
	ret
.SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART

	cp SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART
	jr nz, .SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART
	CheckHideShowSevii HS_SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	ret
.SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART

	cp SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART
	jr nz, .SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART
	CheckHideShowSevii HS_SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	ret
.SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART

	cp SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART
	jr nz, .SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART
	CheckHideShowSevii HS_SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	ret
.SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART

	cp SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART
	jr nz, .SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART
	CheckHideShowSevii HS_SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	ret
.SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART

	cp SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART
	jr nz, .noMatch
	CheckHideShowSevii HS_SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART_MON_1
	ret
