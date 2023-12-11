DisplayPokemonCenterDialogue_::
	ld a, [wCurMap]
	cp PEWTER_POKECENTER
	jr nz, .regularCenter
	call CheckPikachuFollowingPlayer
	jr z, .regularCenter
	ld hl, LooksContentText ; if pikachu is sleeping, don't heal
	call PrintText
	ret
.regularCenter
	call SaveScreenTilesToBuffer1 ; save screen
	ld hl, PokemonCenterWelcomeText
	call PrintText
	ld hl, wd72e
	bit 2, [hl]
	set 1, [hl]
	set 2, [hl]
	jr nz, .skipShallWeHealYourPokemon
	ld hl, ShallWeHealYourPokemonText
	call PrintText
.skipShallWeHealYourPokemon
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
	call PrintText
	ld c, 1 ; edited
	call DelayFrames
	call CheckPikachuFollowingPlayer
	jr nz, .playerPikachuNotOnScreen
	call DisablePikachuOverworldSpriteDrawing
	callfar IsStarterPikachuInOurParty
	call c, Func_6eaa
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
	callfar IsStarterPikachuInOurParty
	call c, Func_6eaa
	ld a, $5
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.doNotReturnPikachu
	lb bc, 1, 0
	call Func_6ebb
	ld hl, PokemonFightingFitText
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
	call PrintText
	call UpdateSprites
; new, testing
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ret

Func_6eaa:
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, $4
	ldh [hSpriteImageIndex], a
	call SpriteFunc_34a1
	ld c, 1 ; edited
	call DelayFrames
	ret

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

ShallWeHealYourPokemonText:
	text_pause
	text_far _ShallWeHealYourPokemonText
	text_end

NeedYourPokemonText:
	text_far _NeedYourPokemonText
	text_end

PokemonFightingFitText:
	text_far _PokemonFightingFitText
	text_end

PokemonCenterFarewellText:
	text_pause
	text_far _PokemonCenterFarewellText
	text_end

LooksContentText:
	text_far _LooksContentText
	text_end
