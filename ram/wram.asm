SECTION "Audio RAM", WRAM0

wUnusedC000:: db

wSoundID:: db

; bit 7: whether sound has been muted
; all bits: whether the effective is active
; Store 1 to activate effect (any value in the range [1, 127] works).
; All audio is muted and music is paused. Sfx continues playing until it
; ends normally.
; Store 0 to resume music.
wMuteAudioAndPauseMusic:: db

wDisableChannelOutputWhenSfxEnds:: db

wStereoPanning:: db

wSavedVolume:: db

wChannelCommandPointers:: ds NUM_CHANNELS * 2
wChannelReturnAddresses:: ds NUM_CHANNELS * 2

wChannelSoundIDs:: ds NUM_CHANNELS

wChannelFlags1:: ds NUM_CHANNELS
wChannelFlags2:: ds NUM_CHANNELS

wChannelDutyCycles:: ds NUM_CHANNELS
wChannelDutyCyclePatterns:: ds NUM_CHANNELS

; reloaded at the beginning of a note. counts down until the vibrato begins.
wChannelVibratoDelayCounters:: ds NUM_CHANNELS
wChannelVibratoExtents:: ds NUM_CHANNELS
; high nybble is rate (counter reload value) and low nybble is counter.
; time between applications of vibrato.
wChannelVibratoRates:: ds NUM_CHANNELS
wChannelFrequencyLowBytes:: ds NUM_CHANNELS
; delay of the beginning of the vibrato from the start of the note
wChannelVibratoDelayCounterReloadValues:: ds NUM_CHANNELS

wChannelPitchSlideLengthModifiers:: ds NUM_CHANNELS
wChannelPitchSlideFrequencySteps:: ds NUM_CHANNELS
wChannelPitchSlideFrequencyStepsFractionalPart:: ds NUM_CHANNELS
wChannelPitchSlideCurrentFrequencyFractionalPart:: ds NUM_CHANNELS
wChannelPitchSlideCurrentFrequencyHighBytes:: ds NUM_CHANNELS
wChannelPitchSlideCurrentFrequencyLowBytes:: ds NUM_CHANNELS
wChannelPitchSlideTargetFrequencyHighBytes:: ds NUM_CHANNELS
wChannelPitchSlideTargetFrequencyLowBytes:: ds NUM_CHANNELS

; Note delays are stored as 16-bit fixed-point numbers where the integer part
; is 8 bits and the fractional part is 8 bits.
wChannelNoteDelayCounters:: ds NUM_CHANNELS
wChannelLoopCounters:: ds NUM_CHANNELS
wChannelNoteSpeeds:: ds NUM_CHANNELS
wChannelNoteDelayCountersFractionalPart:: ds NUM_CHANNELS

wChannelOctaves:: ds NUM_CHANNELS
; also includes fade for hardware channels that support it
wChannelVolumes:: ds NUM_CHANNELS

wMusicWaveInstrument:: db
wSfxWaveInstrument:: db
wMusicTempo:: dw
wSfxTempo:: dw
wSfxHeaderPointer:: dw

wNewSoundID:: db

wAudioROMBank:: db
wAudioSavedROMBank:: db

wFrequencyModifier:: db
wTempoModifier:: db

wc0f3:: dw

	ds 11


SECTION "Sprite State Data", WRAM0

wSpriteDataStart::

; data for all sprites on the current map
; holds info for 16 sprites with $10 bytes each
wSpriteStateData1::
; struct fields:
; - 0: picture ID (fixed, loaded at map init)
; - 1: movement status (0: uninitialized, 1: ready, 2: delayed, 3: moving)
; - 2: sprite image index (changed on update, $ff if off screen, includes facing direction, progress in walking animation and a sprite-specific offset)
; - 3: Y screen position delta (-1,0 or 1; added to Y pixels on each walking animation update)
; - 4: Y screen position (in pixels, always 4 pixels above grid which makes sprites appear to be in the center of a tile)
; - 5: X screen position delta (-1,0 or 1; added to field X pixels on each walking animation update)
; - 6: X screen position (in pixels, snaps to grid if not currently walking)
; - 7: intra-animation-frame counter (counting upwards to 4 until animation frame counter is incremented)
; - 8: animation frame counter (increased every 4 updates, hold four states (totalling to 16 walking frames)
; - 9: facing direction ($0: down, $4: up, $8: left, $c: right)
; - A: adjusted Y coordinate
; - B: adjusted X coordinate
; - C: direction of collision
; - D
; - E
; - F
wSpritePlayerStateData1::  spritestatedata1 wSpritePlayerStateData1 ; player is struct 0
; wSprite02StateData1 - wSprite15StateData1
FOR n, 1, NUM_SPRITESTATEDATA_STRUCTS - 1
wSprite{02d:n}StateData1:: spritestatedata1 wSprite{02d:n}StateData1
ENDR
wSpritePikachuStateData1:: spritestatedata1 wSpritePikachuStateData1 ; pikachu is struct 15

; more data for all sprites on the current map
; holds info for 16 sprites with $10 bytes each
wSpriteStateData2::
; struct fields:
; - 0: walk animation counter (counting from $10 backwards when moving)
; - 1:
; - 2: Y displacement (initialized at 8, supposed to keep moving sprites from moving too far, but bugged)
; - 3: X displacement (initialized at 8, supposed to keep moving sprites from moving too far, but bugged)
; - 4: Y position (in 2x2 tile grid steps, topmost 2x2 tile has value 4)
; - 5: X position (in 2x2 tile grid steps, leftmost 2x2 tile has value 4)
; - 6: movement byte 1 (determines whether a sprite can move, $ff:not moving, $fe:random movements, others unknown)
; - 7: (?) (set to $80 when in grass, else $0; may be used to draw grass above the sprite)
; - 8: delay until next movement (counted downwards, movement status is set to ready if reached 0)
; - 9: original facing direction (backed up by DisplayTextIDInit, restored by CloseTextDisplay)
; - A
; - B
; - C
; - D: picture ID
; - E: sprite image base offset (in video ram, player always has value 1, used to compute sprite image index)
; - F
wSpritePlayerStateData2::  spritestatedata2 wSpritePlayerStateData2 ; player is struct 0
; wSprite02StateData2 - wSprite15StateData2
FOR n, 1, NUM_SPRITESTATEDATA_STRUCTS - 1
wSprite{02d:n}StateData2:: spritestatedata2 wSprite{02d:n}StateData2
ENDR
wSpritePikachuStateData2:: spritestatedata2 wSpritePikachuStateData2 ; pikachu is struct 15

; The high byte of a pointer to anywhere within wSpriteStateData1 can be incremented
; to reach within wSpriteStateData2, and vice-versa for decrementing.
ASSERT HIGH(wSpriteStateData1) + 1 == HIGH(wSpriteStateData2)
ASSERT LOW(wSpriteStateData1) == 0 && LOW(wSpriteStateData2) == 0

wSpriteDataEnd::


SECTION "OAM Buffer", WRAM0

; buffer for OAM data. Copied to OAM by DMA
wShadowOAM::
; wShadowOAMSprite00 - wShadowOAMSprite39
FOR n, NUM_SPRITE_OAM_STRUCTS
wShadowOAMSprite{02d:n}:: sprite_oam_struct wShadowOAMSprite{02d:n}
ENDR
wShadowOAMEnd::


SECTION "Tilemap", WRAM0

; buffer for tiles that are visible on screen (20 columns by 18 rows)
wTileMap:: ds SCREEN_WIDTH * SCREEN_HEIGHT

UNION
; buffer for temporarily saving and restoring current screen's tiles
; (e.g. if menus are drawn on top)
wTileMapBackup:: ds SCREEN_WIDTH * SCREEN_HEIGHT

NEXTU
; list of indexes to patch with SERIAL_NO_DATA_BYTE after transfer
wSerialPartyMonsPatchList:: ds 200

; list of indexes to patch with SERIAL_NO_DATA_BYTE after transfer
wSerialEnemyMonsPatchList:: ds 200

NEXTU
; this looks similar to the address structure for Gen 2 OAM animations.
wAnimatedObjectsData::

wAnimatedObjectStartTileOffsets:: ds 10 * 2

wAnimatedObjectDataStructs::
; wAnimatedObject0 - wAnimatedObject9
FOR n, 10
wAnimatedObject{d:n}:: animated_object wAnimatedObject{d:n}
ENDR

wNumLoadedAnimatedObjects:: db
wCurrentAnimatedObjectOAMBufferOffset::
	ds 3
wAnimatedObjectSpawnStateDataPointer:: dw
wAnimatedObjectFramesDataPointer:: dw
wAnimatedObjectJumptablePointer:: dw
wAnimatedObjectOAMDataPointer:: dw

wCurAnimatedObjectOAMAttributes:: db
wCurrentAnimatedObjectVTileOffset:: db
wCurrentAnimatedObjectXCoord:: db
wCurrentAnimatedObjectYCoord:: db
wCurrentAnimatedObjectXOffset:: db
wCurrentAnimatedObjectYOffset:: db
wAnimatedObjectGlobalYOffset:: db
wAnimatedObjectGlobalXOffset:: db

wAnimatedObjectsDataEnd::

; Surfing minigame
wSurfingMinigameData:: db
wSurfingMinigameRoutineNumber:: db
wc5d2:: db
wSurfingMinigameWaveFunctionNumber:: dw
wc5d5:: db
wSurfingMinigamePikachuHP:: dw ; little-endian BCD
wc5d8:: db ; unused?
; number of consecutive tricks
wSurfingMinigameRadnessMeter:: db
wSurfingMinigameRadnessScore:: dw ; little-endian BCD
wSurfingMinigameTotalScore:: dw ; little-endian BCD
wc5de:: db
wc5df:: db
wc5e0:: db
wc5e1:: db
wc5e2:: db
wSurfingMinigamePikachuSpeed:: dw ; little-endian
wc5e5:: ds 3 ; big-endian
wSurfingMinigameWaveHeightBuffer:: dw
wSurfingMinigamePikachuObjectHeight:: db
wc5eb:: db
wc5ec:: db
wc5ed:: db
wc5ee:: db
wSurfingMinigameBGMapReadBuffer:: ds 1 tiles
	ds 24
wSurfingMinigameSCX:: db
wSurfingMinigameSCX2:: db
wSurfingMinigameSCXHi:: db
wSurfingMinigameWaveHeight:: ds SCREEN_WIDTH
wSurfingMinigameXOffset:: db
wSurfingMinigameTrickFlags:: db
wc630:: db
wc631:: db
wSurfingMinigameRoutineDelay:: db
wSurfingMinigameIntroAnimationFinished:: db

; Yellow intro
wYellowIntroCurrentScene::
wc634:: db
wYellowIntroSceneTimer::
wc635:: db
wYellowIntroAnimatedObjectStructPointer:: db
wSurfingMinigameDataEnd::
ENDU

	ds 80 ; AAA!!! this is actually used for bgmap stuff!!! can't freely use it :'(


SECTION "Overworld Map", WRAM0

UNION
wOverworldMap:: ds 1300
wOverworldMapEnd::

NEXTU
wTempPic:: ds 7 * 7 tiles

NEXTU
wPrinterData::
wPrinterSendState:: db
wPrinterRowIndex:: db

; Printer data header
wPrinterDataHeader::
wc6ea:: db
wc6eb:: db
wc6ec:: db
wc6ed:: db
wPrinterChecksum:: dw

UNION
wPrinterSerialReceived:: db
; bit 7: set if error 1 (battery low)
; bit 6: set if error 4 (too hot or cold)
; bit 5: set if error 3 (paper jammed or empty)
; if this and the previous byte are both $ff: error 2 (connection error)
wPrinterStatusReceived:: db

wc6f2:: db
wc6f3:: db
	ds 12
wLYOverrides:: ds $100
wLYOverridesEnd::
wLYOverridesBuffer:: ds $100
wLYOverridesBufferEnd::

NEXTU
wPrinterSendDataSource1:: ds 20 tiles
wPrinterSendDataSource2:: ds 20 tiles
ENDU

wPrinterSendDataSource1End::

wPrinterHandshake:: db
wPrinterStatusFlags:: db
wHandshakeFrameDelay:: db
wPrinterSerialFrameDelay:: db
wPrinterSendByteOffset:: dw
wPrinterDataSize:: dw
wPrinterTileBuffer:: ds SCREEN_HEIGHT * SCREEN_WIDTH
wPrinterStatusIndicator:: dw
wcae2:: db
wPrinterSettingsTempCopy:: db
	ds 16
wPrinterQueueLength:: db
wPrinterDataEnd::

wPrinterPokedexEntryTextPointer:: dw
	ds 2
wPrinterPokedexMonIsOwned:: db
	ds 226
UNION
wcbdc:: ds 1 tiles
NEXTU
	ds 14
wcbea:: dw
ENDU
wcbec:: ds 1 tiles
ENDU


SECTION "WRAM", WRAM0

; the tiles of the row or column to be redrawn by RedrawRowOrColumn
wRedrawRowOrColumnSrcTiles:: ds SCREEN_WIDTH * 2

; coordinates of the position of the cursor for the top menu item (id 0)
wTopMenuItemY:: db
wTopMenuItemX:: db

; the id of the currently selected menu item
; the top item has id 0, the one below that has id 1, etc.
; note that the "top item" means the top item currently visible on the screen
; add this value to [wListScrollOffset] to get the item's position within the list
wCurrentMenuItem:: db

; the tile that was behind the menu cursor's current location
wTileBehindCursor:: db

; id of the bottom menu item
wMaxMenuItem:: db

; bit mask of keys that the menu will respond to
wMenuWatchedKeys:: db

; id of previously selected menu item
wLastMenuItem:: db

; It is mainly used by the party menu to remember the cursor position while the
; menu isn't active.
; It is also used to remember the cursor position of mon lists (for the
; withdraw/deposit/release actions) in Bill's PC so that it doesn't get lost
; when you choose a mon from the list and a sub-menu is shown. It's reset when
; you return to the main Bill's PC menu.
wPartyAndBillsPCSavedMenuItem:: db

; It is used by the bag list to remember the cursor position while the menu
; isn't active.
wBagSavedMenuItem:: db

; It is used by the start menu to remember the cursor position while the menu
; isn't active.
; The battle menu uses it so that the cursor position doesn't get lost when
; a sub-menu is shown. It's reset at the start of each battle.
wBattleAndStartSavedMenuItem:: db

wPlayerMoveListIndex:: db

; index in party of currently battling mon
wPlayerMonNumber:: db

; the address of the menu cursor's current location within wTileMap
wMenuCursorLocation:: dw

; if 0, normal battle; if 1, Inverse Battle
wInverseBattle:: db ; new

	ds 1 ; edited because of the inverse battle variable

; how many times should HandleMenuInput poll the joypad state before it returns?
wMenuJoypadPollCount:: db

; id of menu item selected for swapping (counts from 1) (0 means that no menu item has been selected for swapping)
wMenuItemToSwap:: db

; offset of the current top menu item from the beginning of the list
; keeps track of what section of the list is on screen
wListScrollOffset:: db

; If non-zero, then when wrapping is disabled and the player tries to go past
; the top or bottom of the menu, return from HandleMenuInput. This is useful for
; menus that have too many items to display at once on the screen because it
; allows the caller to scroll the entire menu up or down when this happens.
wMenuWatchMovingOutOfBounds:: db

wTradeCenterPointerTableIndex:: db

	ds 1

; destination pointer for text output
; this variable is written to, but is never read from
wTextDest:: dw

; if non-zero, skip waiting for a button press after displaying text in DisplayTextID
wDoNotWaitForButtonPressAfterDisplayingText:: db

UNION
; the received menu selection is stored twice
wLinkMenuSelectionReceiveBuffer:: dw
	ds 3
; the menu selection byte is stored twice before sending
wLinkMenuSelectionSendBuffer:: dw
	ds 3
wEnteringCableClub::
wLinkTimeoutCounter:: db

NEXTU
; temporary nybble used by Serial_ExchangeNybble
wSerialExchangeNybbleTempReceiveData::
; the final received nybble is stored here by Serial_SyncAndExchangeNybble
wSerialSyncAndExchangeNybbleReceiveData:: db
; the final received nybble is stored here by Serial_ExchangeNybble
wSerialExchangeNybbleReceiveData:: db
	ds 3
; this nybble is sent when using Serial_SyncAndExchangeNybble or Serial_ExchangeNybble
wSerialExchangeNybbleSendData:: db
	ds 4
wUnknownSerialCounter:: dw
ENDU

; $00 = player mons
; $01 = enemy mons
wWhichTradeMonSelectionMenu::
; 0 = player's party
; 1 = enemy party
; 2 = current box
; 3 = daycare
; 4 = in-battle mon
;
; AddPartyMon uses it slightly differently.
; If the lower nybble is 0, the mon is added to the player's party, else the enemy's.
; If the entire value is 0, then the player is allowed to name the mon.
wMonDataLocation:: db

; set to 1 if you can go from the bottom to the top or top to bottom of a menu
; set to 0 if you can't go past the top or bottom of the menu
wMenuWrappingEnabled:: db

wStoreRealhWhoseTurn:: ; new
; whether to check for 180-degree turn (0 = don't, 1 = do)
wCheckFor180DegreeTurn:: db

	ds 1

wMissableObjectIndex:: db

wPredefID:: db
wPredefHL:: dw
wPredefDE:: dw
wPredefBC:: dw

wTrainerHeaderFlagBit:: db

;	ds 1 ; edited, commented to allocate variable below
wLevelScalingBackup:: db ; new

; which NPC movement script pointer is being used
; 0 if an NPC movement script is not running
wNPCMovementScriptPointerTableNum:: db

; ROM bank of current NPC movement script
wNPCMovementScriptBank:: db

;	ds 1 ; edited, was 1, reduced for variable below
wJustCrashLanded:: db ; new, to see if we just crashlanded, used only to handle Pikachu's emotion

; This union spans 180 bytes.
UNION
wVermilionDockTileMapBuffer:: ds 5 * BG_MAP_WIDTH + SCREEN_WIDTH
wVermilionDockTileMapBufferEnd::

NEXTU
wOaksAideRewardItemName:: ds ITEM_NAME_LENGTH

NEXTU
wElevatorWarpMaps:: ds 11 * 2
wElevatorTravelDistance:: db ; new, from Vortiene

NEXTU
; List of bag items that has been filtered to a certain type of items,
; such as drinks or fossils.
wFilteredBagItems:: ds 4

NEXTU
; Saved copy of OAM for the first frame of the animation to make it easy to
; flip back from the second frame.
wMonPartySpritesSavedOAM:: ds $60

NEXTU
wTrainerCardBlkPacket:: ds $40

NEXTU
wHallOfFame:: ds HOF_TEAM

NEXTU
wNPCMovementDirections:: ds 180

NEXTU
wDexRatingNumMonsSeen:: db
wDexRatingNumMonsOwned:: db
wDexRatingText:: db

NEXTU
; If a random number greater than this value is generated, then the player is
; allowed to have three 7 symbols or bar symbols line up.
; So, this value is actually the chance of NOT entering that mode.
; If the slot is lucky, it equals 250, giving a 5/256 (~2%) chance.
; Otherwise, it equals 253, giving a 2/256 (~0.8%) chance.
wSlotMachineSevenAndBarModeChance:: db
	ds 2
; ROM back to return to when the player is done with the slot machine
wSlotMachineSavedROMBank:: db

;	ds 166 ; used for deleter/relearner
; Move Buffer stuff for Mateo's code
wMoveBuffer:: ; new
wRelearnableMoves:: ; new
	ds 164
; Try not to use this stack.
; A good amount of space is needed to store data for the move relearner.
; If it's like, 2, it'll lag like crazy and show garbage from elsewhere.

wLuckySlotHiddenObjectIndex:: db

NEXTU
; values between 0-6. Shake screen horizontally, shake screen vertically, blink Pokemon...
wAnimationType:: db
	ds 29
wAnimPalette:: db

NEXTU
	ds 60
; temporary buffer when swapping party mon data
wSwitchPartyMonTempBuffer:: ds 44 ; party_struct size

NEXTU
	ds 120
; this is the end of the joypad states
; the list starts above this address and extends downwards in memory until here
; overloaded with below labels
wSimulatedJoypadStatesEnd::

NEXTU
wBoostExpByExpAll::
wUnusedCC5B:: db

	ds 59

wNPCMovementDirections2:: ds 10
; used in Pallet Town scripted movement
wNumStepsToTake:: db

	ds 48

wRLEByteCount:: db

wParentMenuItem::
; 0 = not added
; 1 = added
wAddedToParty::
; 1 flag for each party member indicating whether it can evolve
; The purpose of these flags is to track which mons levelled up during the
; current battle at the end of the battle when evolution occurs.
; Other methods of evolution simply set it by calling TryEvolvingMon.
wCanEvolveFlags:: db

wForceEvolution:: db

; if [wAILayer2Encouragement] != 1, the second AI layer is not applied
wAILayer2Encouragement:: db

	ds 1

; current HP of player and enemy substitutes
wPlayerSubstituteHP:: db
wEnemySubstituteHP:: db

; The player's selected move during a test battle.
; InitBattleVariables sets it to the move Pound.
wTestBattlePlayerSelectedMove:: db

	ds 1

; 0=regular, 1=mimic, 2=above message box (relearn, heal pp..)
wMoveMenuType:: db

wPlayerSelectedMove:: db
wEnemySelectedMove:: db

wLinkBattleRandomNumberListIndex:: db

; number of times remaining that AI action can occur
wAICount:: db

	ds 2

wEnemyMoveListIndex:: db

; The enemy mon's HP when it was switched in or when the current player mon
; was switched in, which was more recent.
; It's used to determine the message to print when switching out the player mon.
wLastSwitchInEnemyMonHP:: dw

; total amount of money made using Pay Day during the current battle
wTotalPayDayMoney:: ds 3

wSafariEscapeFactor:: db
wSafariBaitFactor:: db

	ds 1

wTransformedEnemyMonOriginalDVs:: dw

wMonIsDisobedient:: db

wPlayerDisabledMoveNumber:: db
wEnemyDisabledMoveNumber:: db

; When running in the scope of HandlePlayerMonFainted, it equals 1.
; When running in the scope of HandleEnemyMonFainted, it equals 0.
wInHandlePlayerMonFainted:: db

wPlayerUsedMove:: db
wEnemyUsedMove:: db

wEnemyMonMinimized:: db

wMoveDidntMiss:: db

; flags that indicate which party members have fought the current enemy mon
wPartyFoughtCurrentEnemyFlags:: flag_array PARTY_LENGTH

; Whether the low health alarm has been disabled due to the player winning the
; battle.
wLowHealthAlarmDisabled:: db

wPlayerMonMinimized:: db

	ds 13

; number of hits by enemy in attacks like Double Slap, etc.
wEnemyNumHits:: ; db
; the amount of damage accumulated by the enemy while biding
wEnemyBideAccumulatedDamage:: dw

	ds 8

NEXTU
	ds 2
wTrainerCardBadgeAttributes:: ds 6 * 9 + 1

NEXTU
wPikaPicUsedGFXCount:: db

wPikaPicUsedGFX:: ds 8 * 2
wPikaPicUsedGFXEnd::

	ds 43

wPikaPicAnimObjectDataBufferSize:: db

wPikaPicAnimObjectDataBuffer::
; 4 structs each of length 8
;     0: buffer index
;     1: script index
;     2: frame index
;     3: frame timer
;     4: vtile offset
;     5: x offset
;     6: y offset
;     7: unused
	ds 4 * 8
wPikaPicAnimObjectDataBufferEnd::
ENDU

; This union spans 39 bytes.
UNION
wInGameTradeGiveMonSpecies:: db
wInGameTradeTextPointerTablePointer:: dw
wInGameTradeTextPointerTableIndex:: db
wInGameTradeGiveMonName:: ds NAME_LENGTH
wInGameTradeReceiveMonName:: ds NAME_LENGTH
wInGameTradeMonNick:: ds NAME_LENGTH
wInGameTradeReceiveMonSpecies:: db

NEXTU
wPlayerMonUnmodifiedLevel:: db
wPlayerMonUnmodifiedMaxHP:: dw
wPlayerMonUnmodifiedAttack:: dw
wPlayerMonUnmodifiedDefense:: dw
wPlayerMonUnmodifiedSpeed:: dw
wPlayerMonUnmodifiedSpecial:: dw

; stat modifiers for the player's current pokemon
; value can range from 1 - 13 ($1 to $D)
; 7 is normal
wPlayerMonStatMods::
wPlayerMonAttackMod:: db
wPlayerMonDefenseMod:: db
wPlayerMonSpeedMod:: db
wPlayerMonSpecialMod:: db
wPlayerMonAccuracyMod:: db
wPlayerMonEvasionMod:: db
	ds 2
wPlayerMonStatModsEnd::

	ds 1

wEnemyMonUnmodifiedLevel:: db
wEnemyMonUnmodifiedMaxHP:: dw
wEnemyMonUnmodifiedAttack:: dw
wEnemyMonUnmodifiedDefense:: dw
wEnemyMonUnmodifiedSpeed:: dw
wEnemyMonUnmodifiedSpecial:: dw

; stat modifiers for the enemy's current pokemon
; value can range from 1 - 13 ($1 to $D)
; 7 is normal
wEnemyMonStatMods::
wEnemyMonAttackMod:: db
wEnemyMonDefenseMod:: db
wEnemyMonSpeedMod:: db
wEnemyMonSpecialMod:: db
wEnemyMonAccuracyMod:: db
wEnemyMonEvasionMod:: db
	ds 2
wEnemyMonStatModsEnd::

NEXTU
	ds 30
wEngagedTrainerClass:: db
wEngagedTrainerSet:: db
ENDU

;	ds 1 ; edited, commented out for the one below
wSurrenderedFromTrainerBattle:: db ; new

wNPCMovementDirections2Index::
wUnusedCD37::
; number of items in wFilteredBagItems list
wFilteredBagItemsCount:: db

; the next simulated joypad state is at wSimulatedJoypadStatesEnd plus this value minus 1
; 0 if the joypad state is not being simulated
wSimulatedJoypadStatesIndex:: db

; written to but nothing ever reads it
wWastedByteCD39:: db

; written to but nothing ever reads it
wWastedByteCD3A:: db

; mask indicating which real button presses can override simulated ones
; XXX is it ever not 0?
wOverrideSimulatedJoypadStatesMask:: db

wShinyOrNotShinyPokedexPalette:: db ; new
;	ds 1

; This union spans 30 bytes.
UNION
wTradedPlayerMonSpecies:: db
wTradedEnemyMonSpecies:: db
	ds 2
wTradedPlayerMonOT:: ds NAME_LENGTH
wTradedPlayerMonOTID:: dw
wTradedEnemyMonOT:: ds NAME_LENGTH
wTradedEnemyMonOTID:: dw

NEXTU
wTradingWhichPlayerMon:: db
wTradingWhichEnemyMon:: db
wNameOfPlayerMonToBeTraded:: ds NAME_LENGTH

NEXTU
; one byte for each falling object
wFallingObjectsMovementData:: ds 20

NEXTU
; array of the number of mons in each box
wBoxMonCounts:: ds NUM_BOXES

NEXTU
wPriceTemp:: ds 3 ; BCD

NEXTU
; the current mon's field moves
wFieldMoves:: ds NUM_MOVES
wNumFieldMoves:: db
wFieldMovesLeftmostXCoord:: db
wLastFieldMoveID:: db ; unused

NEXTU
wBoxNumString:: ds 3

NEXTU
; 0 = upper half (Y < 9)
; 1 = lower half (Y >= 9)
wBattleTransitionCircleScreenQuadrantY:: db
wBattleTransitionCircleScreenQuadrantX:: db

NEXTU
; after 1 row/column has been copied, the offset to the next one to copy from
wBattleTransitionCopyTilesOffset:: dw

NEXTU
; counts down from 7 so that every time 7 more tiles of the spiral have been
; placed, the tile map buffer is copied to VRAM so that progress is visible
wInwardSpiralUpdateScreenCounter:: db
	ds 9
; 0 = outward, 1 = inward
wBattleTransitionSpiralDirection:: db

NEXTU
; multiplied by 16 to get the number of times to go right by 2 pixels
wSSAnneSmokeDriftAmount:: db
; 0 = left half (X < 10)
; 1 = right half (X >= 10)
wSSAnneSmokeX:: db

NEXTU
wHoFMonSpecies::
wHoFTeamIndex:: db
wHoFPartyMonIndex:: db
wHoFMonLevel:: db
; 0 = mon, 1 = player
wHoFMonOrPlayer:: db
wHoFTeamIndex2:: db
wHoFTeamNo:: db

NEXTU
	ds 1 ; wRivalStarterTemp:: db ; leftovers from pokered? ; edited, unused
wFlyAnimUsingCoordList_Sevii:: db ; wRivalStarterBallSpriteIndex:: db ; leftovers from pokered? ; edited, unused
wFlyLocationsList_Sevii:: ds NUM_CITY_MAPS_SEVII + 2 ; new, for Sevii

NEXTU
wFlyAnimUsingCoordList:: db
; $ff sentinel values at each end
wFlyLocationsList:: ds NUM_CITY_MAPS + 4 ; edited, to allow fly to Route 4 and Route 10

NEXTU
wWhichTownMapLocation:: db
wFlyAnimCounter:: db
wFlyAnimBirdSpriteImageIndex:: db

NEXTU
	ds 1
; difference in X between the next ball and the current one
wHUDPokeballGfxOffsetX:: db
wHUDGraphicsTiles:: ds 3

NEXTU
; the level of the mon at the time it entered day care
wDayCareStartLevel:: db
wDayCareNumLevelsGrown:: db
wDayCareTotalCost:: dw ; BCD
wDayCarePerLevelCost:: dw ; BCD (always $100)

NEXTU
; which wheel the player is trying to stop
; 0 = none, 1 = wheel 1, 2 = wheel 2, 3 or greater = wheel 3
wStoppingWhichSlotMachineWheel:: db
wSlotMachineWheel1Offset:: db
wSlotMachineWheel2Offset:: db
wSlotMachineWheel3Offset:: db
; the OAM tile number of the upper left corner of the winning symbol minus 2
wSlotMachineWinningSymbol::
wSlotMachineWheel1BottomTile:: db
wSlotMachineWheel1MiddleTile:: db
wSlotMachineWheel1TopTile:: db
wSlotMachineWheel2BottomTile:: db
wSlotMachineWheel2MiddleTile:: db
wSlotMachineWheel2TopTile:: db
wSlotMachineWheel3BottomTile:: db
wSlotMachineWheel3MiddleTile:: db
wSlotMachineWheel3TopTile:: db
wPayoutCoins:: dw
; These flags are set randomly and control when the wheels stop.
; bit 6: allow the player to win in general
; bit 7: allow the player to win with 7 or bar (plus the effect of bit 6)
wSlotMachineFlags:: db
; wheel 1 can "slip" while this is non-zero
wSlotMachineWheel1SlipCounter:: db
; wheel 2 can "slip" while this is non-zero
wSlotMachineWheel2SlipCounter:: db
; The remaining number of times wheel 3 will roll down a symbol until a match is
; found, when winning is enabled. It's initialized to 4 each bet.
wSlotMachineRerollCounter:: db
; how many coins the player bet on the slot machine (1 to 3)
wSlotMachineBet:: db

NEXTU
wCanPlaySlots:: db
	ds 8
; temporary variable used to add payout amount to the player's coins
wTempCoins1:: dw
	ds 2
; temporary variable used to subtract the bet amount from the player's coins
wTempCoins2:: dw

NEXTU
wHiddenObjectFunctionArgument:: db
wHiddenObjectFunctionRomBank:: db
wHiddenObjectIndex:: db
wHiddenObjectY:: db
wHiddenItemOrCoinsIndex::
wHiddenObjectX:: db

NEXTU
wPlayerSpinInPlaceAnimFrameDelay:: db
wPlayerSpinInPlaceAnimFrameDelayDelta:: db
wPlayerSpinInPlaceAnimFrameDelayEndValue:: db
wPlayerSpinInPlaceAnimSoundID:: db
	ds 6
	db ; temporary space used when wFacingDirectionList is rotated
; used when spinning the player's sprite
wFacingDirectionList:: ds 4
	ds 3
wSavedPlayerScreenY:: db
wSavedPlayerFacingDirection:: db

NEXTU
wPlayerSpinWhileMovingUpOrDownAnimDeltaY:: db
wPlayerSpinWhileMovingUpOrDownAnimMaxY:: db
wPlayerSpinWhileMovingUpOrDownAnimFrameDelay:: db

NEXTU
wTrainerSpriteOffset:: db
wTrainerEngageDistance:: db
wTrainerFacingDirection:: db
wTrainerScreenY:: db
wTrainerScreenX:: db

NEXTU
wTrainerInfoTextBoxWidthPlus1:: db
wTrainerInfoTextBoxWidth:: db
wTrainerInfoTextBoxNextRowOffset:: db

NEXTU
wOptionsTextSpeedCursorX:: db
wOptionsBattleAnimCursorX:: db
wOptionsBattleStyleCursorX:: db
wOptionsCancelCursorX:: db

NEXTU
; tile ID of the badge number being drawn
wBadgeNumberTile:: db
; first tile ID of the name being drawn
wBadgeNameTile:: db
; a list of the first tile IDs of each badge or face (depending on whether the
; badge is owned) to be drawn on the trainer screen
; the byte after the list gets read when shifting back one byte
wBadgeOrFaceTiles:: ds NUM_BADGES + 1
	ds 1
; temporary list created when displaying the badges on the trainer screen
; one byte for each badge; 0 = not obtained, 1 = obtained
wTempObtainedBadgesBooleans:: ds NUM_BADGES

NEXTU
wUnusedCD3D:: db
; the number of credits mons that have been displayed so far
wNumCreditsMonsDisplayed:: db

NEXTU
	ds 1
	db ; temporary space used when wJigglypuffFacingDirections is rotated
wJigglypuffFacingDirections:: ds 4

NEXTU
	ds 16
; $3d = tree tile, $52 = grass tile
wCutTile:: db
	ds 2
; 0 = cut animation, 1 = boulder dust animation
wWhichAnimationOffsets:: db

NEXTU
	ds 18
; the index of the sprite the emotion bubble is to be displayed above
wEmotionBubbleSpriteIndex:: db
wWhichEmotionBubble:: db

NEXTU
wChangeBoxSavedMapTextPointer:: dw

NEXTU
wSavedY::
wTempSCX::
; which entry from TradeMons to select
wWhichTrade::
wDexMaxSeenMon::
wDexMaxSeenAttacks:: ; new, testing
wPPRestoreItem::
wWereAnyMonsAsleep::
wNumShakes::
wWhichBadge::
wTitleMonSpecies::
wPlayerCharacterOAMTile::
; the number of small stars OAM entries to move down
wMoveDownSmallStarsOAMCount::
wChargeMoveNum::
wCoordIndex::
wSwappedMenuItem::
; 0 = no bite
; 1 = bite
; 2 = no fish on map
wRodResponse::
wOptionsCursorLocation::
	db

NEXTU
wTitleScreenScene:: db
wTitleScreenTimer:: db
ENDU

; 0 = neither
; 1 = warp pad
; 2 = hole
wStandingOnWarpPadOrHole::
wOAMBaseTile::
wGymTrashCanIndex:: db

wSymmetricSpriteOAMAttributes:: db

wMonPartySpriteSpecies:: db

; in the trade animation, the mon that leaves the left gameboy
wLeftGBMonSpecies:: db

; in the trade animation, the mon that leaves the right gameboy
wRightGBMonSpecies:: db

; bit 0: is player engaged by trainer (to avoid being engaged by multiple trainers simultaneously)
; bit 1: boulder dust animation (from using Strength) pending
; bit 3: using generic PC
; bit 5: don't play sound when A or B is pressed in menu
; bit 6: tried pushing against boulder once (you need to push twice before it will move)
wFlags_0xcd60:: db

	ds 3 ; edited, was ds 9
wShinyStarterPikachu:: ; new, shares the coordinate with the next one, they never overlay
wBattleFacilityMon1Shinyness:: db ; new
wBattleFacilityMon2Shinyness:: db ; new
wBattleFacilityMon3Shinyness:: db ; new
wBattleFacilityMon4Shinyness:: db ; new
wBattleFacilityMon5Shinyness:: db ; new
wBattleFacilityMon6Shinyness:: db ; new

; This has overlapping related uses.
; When the player tries to use an item or use certain field moves, 0 is stored
; when the attempt fails and 1 is stored when the attempt succeeds.
; In addition, some items store 2 for certain types of failures, but this
; cannot happen in battle.
; In battle, a non-zero value indicates the player has taken their turn using
; something other than a move (e.g. using an item or switching pokemon).
; So, when an item is successfully used in battle, this value becomes non-zero
; and the player is not allowed to make a move and the two uses are compatible.
wActionResultOrTookBattleTurn:: db

; Set buttons are ignored.
wJoyIgnore:: db

; size of downscaled mon pic used in pokeball entering/exiting animation
; $00 = 5×5
; $01 = 3×3
wDownscaledMonSize::
; FormatMovesString stores the number of moves minus one here
wNumMovesMinusOne:: db

UNION
wcd6d:: ds NAME_BUFFER_LENGTH ; buffer for various data

NEXTU
;wEvosMoves:: ds MAX_EVOLUTIONS * EVOLUTION_SIZE + 1
wEvosMoves:: ds EVOLUTION_SIZE ; update from suloku
wEvosMovesEnd::

NEXTU
	ds 4
; temp variable used to print a move's current PP on the status screen
wStatusScreenCurrentPP:: db
	ds 6
; list of normal max PP (without PP up) values
wNormalMaxPPList:: ds NUM_MOVES
	ds 5
ENDU

UNION
; buffer for transferring the random number list generated by the other gameboy
wSerialOtherGameboyRandomNumberListBlock:: ds $11
NEXTU
; second buffer for temporarily saving and restoring current screen's tiles (e.g. if menus are drawn on top)
wTileMapBackup2:: ds SCREEN_WIDTH * SCREEN_HEIGHT
ENDU

; This union spans 30 bytes.
UNION
; Temporary storage area
wBuffer:: ds 30

NEXTU
wEvoOldSpecies:: db
wEvoNewSpecies:: db
wEvoMonTileOffset:: db
wEvoCancelled:: db

NEXTU
wNamingScreenNameLength:: db
; non-zero when the player has chosen to submit the name
wNamingScreenSubmitName:: db
; 0 = upper case
; 1 = lower case
wAlphabetCase:: db
	ds 1
wNamingScreenLetter:: db

NEXTU
wChangeMonPicEnemyTurnSpecies:: db
wChangeMonPicPlayerTurnSpecies:: db

NEXTU
wHPBarMaxHP:: dw
wHPBarOldHP:: dw
wHPBarNewHP:: dw
wHPBarDelta:: db
wHPBarTempHP:: dw
	ds 11
wHPBarHPDifference:: dw

NEXTU
; lower nybble is x, upper nybble is y
wTownMapCoords::
; whether WriteMonMoves is being used to make a mon learn moves from day care
; non-zero if so
wLearningMovesFromDayCare::
	db

	ds 27

; the item that the AI used
wAIItem:: db
wUsedItemOnWhichPokemon:: db
ENDU

; sound ID during battle animations
wAnimSoundID:: db

; used as a storage value for the bank to return to after a BankswitchHome (bankswitch in homebank)
wBankswitchHomeSavedROMBank:: db

; used as a temp storage value for the bank to switch to
wBankswitchHomeTemp:: db

; 0 = nothing bought or sold in pokemart
; 1 = bought or sold something in pokemart
; this value is not used for anything
wBoughtOrSoldItemInMart:: db

; $00 - win
; $01 - lose
; $02 - draw
wBattleResult:: db

; bit 0: if set, DisplayTextID automatically draws a text box
wAutoTextBoxDrawingControl:: db

wcf0d:: db ; used with some overworld scripts (not exactly sure what it's used for)

; used in CheckForTilePairCollisions2 to store the tile the player is on
wTilePlayerStandingOn:: db

wNPCNumScriptedSteps:: db

; which script function within the pointer table indicated by
; wNPCMovementScriptPointerTableNum
wNPCMovementScriptFunctionNum:: db

; bit 0: set when printing a text predef so that DisplayTextID doesn't switch
;        to the current map's bank
wTextPredefFlag:: db

wPredefParentBank:: db

wSpriteIndex:: db

; movement byte 2 of current sprite
wCurSpriteMovement2:: db

	ds 2

; sprite offset of sprite being controlled by NPC movement script
wNPCMovementScriptSpriteOffset:: db

wScriptedNPCWalkCounter:: db

	ds 1

; if running on SGB, it's 1, else it's 0
wOnSGB:: db

wDefaultPaletteCommand:: db

UNION
wPlayerHPBarColor:: dw

NEXTU
; species of the mon whose palette is used for the whole screen
wWholeScreenPaletteMonSpecies:: db

wEnemyHPBarColor:: db
ENDU

; 0: green
; 1: yellow
; 2: red
wPartyMenuHPBarColors:: ds PARTY_LENGTH

wStatusScreenHPBarColor:: db

;	ds 7		; new - commented to try to save space to be able to add all new mons

wCopyingSGBTileData::
wWhichPartyMenuHPBar::
wPalPacket::
	db

; This union spans 49 bytes.
UNION
wPartyMenuBlkPacket:: ds $30

NEXTU
	ds 29
; storage buffer for various strings
wStringBuffer:: ds 20

NEXTU
	ds 29
; the total amount of exp a mon gained
wExpAmountGained:: dw
wGainBoostedExp:: db

NEXTU
	ds 9
wPartyHPBarAttributes:: ds PARTY_LENGTH
ENDU

UNION ; new, made into a union
wGymCityName:: ds 17

NEXTU ; new, 17 free juicy bytes
	wWeatherCounterPlayer:: db ; new
	wWeatherCounterEnemy:: db ; new
	wTerrainCounterPlayer:: db ; new
	wTerrainCounterEnemy:: db ; new
	wTrickRoomCounterPlayer:: db ; new
	wTrickRoomCounterEnemy:: db ; new
	wHazardsSpikesEnemySide:: db ; new
	wHazardsToxicSpikesEnemySide:: db ; new
	wHazardsStealthRockEnemySide:: db ; new
	wHazardsStickyWebEnemySide:: db ; new
	wHazardsSpikesPlayerSide:: db ; new
	wHazardsToxicSpikesPlayerSide:: db ; new
	wHazardsStealthRockPlayerSide:: db ; new
	wHazardsStickyWebPlayerSide:: db ; new
	ds 3

ENDU

wGymLeaderName:: ds NAME_LENGTH

;wItemList:: ds 16 ; moved it elsewhere so to increase market capacity

wListPointer:: dw

; used to store pointers, but never read
wUnusedCF8D:: dw

wItemPrices:: dw

wcf91:: db ; used with a lot of things (too much to list here)

; which pokemon you selected
wWhichPokemon:: db

; if non-zero, then print item prices when displaying lists
wPrintItemPrices:: db

; type of HP bar
; $00 = enemy HUD in battle
; $01 = player HUD in battle / status screen
; $02 = party menu
wHPBarType::
; ID used by DisplayListMenuID
wListMenuID:: db

; if non-zero, RemovePokemon will remove the mon from the current box,
; else it will remove the mon from the party
wRemoveMonFromBox::
; 0 = move from box to party
; 1 = move from party to box
; 2 = move from daycare to party
; 3 = move from party to daycare
wMoveMonType:: db

wItemQuantity:: db

wMaxItemQuantity:: db

; LoadMonData copies mon data here
wLoadedMon:: party_struct wLoadedMon

; bit 0: The space in VRAM that is used to store walk animation tile patterns
;        for the player and NPCs is in use for font tile patterns.
;        This means that NPC movement must be disabled.
;shinpokerednote: ADDED: use bits 1 to 6 for tracking which trainer ai pkmn have already been sent out
;bit 1: 1st pkmn (position 0)
;bit 2: 2nd pkmn (position 1)
;bit 3: 3rd pkmn (position 2)
;bit 4: 4th pkmn (position 3)
;bit 5: 5th pkmn (position 4)
;bit 6: 6th pkmn (position 5)
;bit 7: unused
wAIWhichPokemonSentOutAlready::
wFontLoaded:: db

; walk animation counter
wWalkCounter:: db

; background tile number in front of the player (either 1 or 2 steps ahead)
wTileInFrontOfPlayer:: db

; The desired fade counter reload value is stored here prior to calling
; PlaySound in order to cause the current music to fade out before the new
; music begins playing. Storing 0 causes no fade out to occur and the new music
; to begin immediately.
; This variable has another use related to fade-out, as well. PlaySound stores
; the sound ID of the music that should be played after the fade-out is finished
; in this variable. FadeOutAudio checks if it's non-zero every V-Blank and
; fades out the current audio if it is. Once it has finished fading out the
; audio, it zeroes this variable and starts playing the sound ID stored in it.
wAudioFadeOutControl:: db

wAudioFadeOutCounterReloadValue:: db

wAudioFadeOutCounter:: db

; This is used to determine whether the default music is already playing when
; attempting to play the default music (in order to avoid restarting the same
; music) and whether the music has already been stopped when attempting to
; fade out the current music (so that the new music can be begin immediately
; instead of waiting).
; It sometimes contains the sound ID of the last music played, but it may also
; contain $ff (if the music has been stopped) or 0 (because some routines zero
; it in order to prevent assumptions from being made about the current state of
; the music).
wLastMusicSoundID:: db

; $00 = causes sprites to be hidden and the value to change to $ff
; $01 = enabled
; $ff = disabled
; other values aren't used
wUpdateSpritesEnabled:: db

wEnemyMoveNum:: db
wEnemyMoveEffect:: db
wEnemyMovePower:: db
wEnemyMoveType:: db
wEnemyMoveAccuracy:: db
wEnemyMoveMaxPP:: db
wPlayerMoveNum:: db
wPlayerMoveEffect:: db
wPlayerMovePower:: db
wPlayerMoveType:: db
wPlayerMoveAccuracy:: db
wPlayerMoveMaxPP:: db

wEnemyMonSpecies2:: db
wBattleMonSpecies2:: db

wEnemyMonNick:: ds NAME_LENGTH

wEnemyMon:: battle_struct wEnemyMon

wEnemyMonBaseStats:: ds NUM_STATS
wEnemyMonActualCatchRate:: db
wEnemyMonBaseExp:: db

wBattleMonNick:: ds NAME_LENGTH
wBattleMon:: battle_struct wBattleMon


wTrainerClass:: db

	ds 1

wTrainerPicPointer:: dw

	ds 1

UNION
wTempMoveNameBuffer:: ds 14

NEXTU
; The name of the mon that is learning a move.
wLearnMoveMonName:: ds NAME_LENGTH
ENDU

	ds 2

; money received after battle = base money × level of last enemy mon
wTrainerBaseMoney:: dw ; BCD

wMissableObjectCounter:: db

	ds 1

; 13 bytes for the letters of the opposing trainer
; the name is terminated with $50 with possible
; unused trailing letters
wTrainerName:: ds 13

; lost battle, this is -1
; no battle, this is 0
; wild battle, this is 1
; trainer battle, this is 2
wIsInBattle:: db

; flags that indicate which party members should be be given exp when GainExperience is called
wPartyGainExpFlags:: flag_array PARTY_LENGTH

; in a wild battle, this is the species of pokemon
; in a trainer battle, this is the trainer class + OPP_ID_OFFSET
wCurOpponent:: db

; in normal battle, this is 0
; in old man battle, this is 1
; in safari battle, this is 2
wBattleType:: db

; bits 0-6: Effectiveness
   ;  $0 = immune
   ;  $5 = not very effective
   ;  $a = neutral
   ; $14 = super-effective
; bit 7: STAB
wDamageMultipliers:: db

; which entry in LoneAttacks to use
; it's actually the same thing as ^
wLoneAttackNo::
wGymLeaderNo:: db
; which instance of [youngster, lass, etc] is this?
wTrainerNo:: db

; $00 = normal attack
; $01 = critical hit
; $02 = successful OHKO
; $ff = failed OHKO
wCriticalHitOrOHKO:: db

wMoveMissed:: db

; always 0
wPlayerStatsToDouble:: db

; always 0
wPlayerStatsToHalve:: db

; bit 0 - bide
; bit 1 - thrash / petal dance
; bit 2 - attacking multiple times (e.g. double kick)
; bit 3 - flinch
; bit 4 - charging up for attack
; bit 5 - using multi-turn move (e.g. wrap)
; bit 6 - invulnerable to normal attack (using fly/dig)
; bit 7 - confusion
wPlayerBattleStatus1:: db

; bit 0 - X Accuracy effect
; bit 1 - protected by "mist"
; bit 2 - focus energy effect
; bit 3 - UNUSED
; bit 4 - has a substitute
; bit 5 - need to recharge
; bit 6 - curse ; edited, repurposed from rage which was removed
; bit 7 - leech seeded
wPlayerBattleStatus2:: db

; bit 0 - toxic
; bit 1 - light screen
; bit 2 - reflect
; bit 3 - transformed
wPlayerBattleStatus3:: db

; always 0
wEnemyStatsToDouble:: db

; always 0
wEnemyStatsToHalve:: db

wEnemyBattleStatus1:: db
wEnemyBattleStatus2:: db
wEnemyBattleStatus3:: db

; when the player is attacking multiple times, the number of attacks left
wPlayerNumAttacksLeft:: db

wPlayerConfusedCounter:: db

wPlayerToxicCounter:: db

; high nibble: which move is disabled (1-4)
; low nibble: disable turns left
wPlayerDisabledMove:: db

	ds 1

; when the enemy is attacking multiple times, the number of attacks left
wEnemyNumAttacksLeft:: db

wEnemyConfusedCounter:: db

wEnemyToxicCounter:: db

; high nibble: which move is disabled (1-4)
; low nibble: disable turns left
wEnemyDisabledMove:: db

	ds 1

UNION
; the amount of damage accumulated by the player while biding
wPlayerBideAccumulatedDamage:: dw

NEXTU
wUnknownSerialCounter2:: dw

NEXTU
; number of hits by player in attacks like Double Slap, etc.
wPlayerNumHits:: db
ENDU

	ds 2

; non-zero when an item or move that allows escape from battle was used
wEscapedFromBattle:: db

UNION
wAmountMoneyWon:: ds 3 ; BCD

NEXTU
wObjectToHide:: db
wObjectToShow:: db
ENDU

; the map you will start at when the debug bit is set
wDefaultMap::
wMenuItemOffset::
; ID number of the current battle animation
wAnimationID:: db

wNamingScreenType::
wPartyMenuTypeOrMessageID::
; temporary storage for the number of tiles in a tileset
wTempTilesetNumTiles:: db

; used by the pokemart code to save the existing value of wListScrollOffset
; so that it can be restored when the player is done with the pokemart NPC
wSavedListScrollOffset:: db

wAltAnimationID:: db ; new
	ds 1 ; edited, was ds 2

; base coordinates of frame block
wBaseCoordX:: db
wBaseCoordY:: db

; low health alarm counter/enable
; high bit = enable, others = timer to cycle frequencies
wLowHealthAlarm:: db

; counts how many tiles of the current frame block have been drawn
wFBTileCounter:: db

wMovingBGTilesCounter2:: db

; duration of each frame of the current subanimation in terms of screen refreshes
wSubAnimFrameDelay:: db
; counts the number of subentries left in the current subanimation
wSubAnimCounter:: db

; 1 = no save file or save file is corrupted
; 2 = save file exists and no corruption has been detected
wSaveFileStatus:: db

; number of tiles in current battle animation frame block
wNumFBTiles:: db

UNION
wSpiralBallsBaseY:: db
wSpiralBallsBaseX:: db

NEXTU
; bits 0-6: index into FallingObjects_DeltaXs array (0 - 8)
; bit 7: direction; 0 = right, 1 = left
wFallingObjectMovementByte:: db
wNumFallingObjects:: db

NEXTU
wFlashScreenLongCounter::
wNumShootingBalls::
; $01 if mon is moving from left gameboy to right gameboy; $00 if vice versa
wTradedMonMovingRight::
wOptionsInitialized::
wNewSlotMachineBallTile::
; how much to add to the X/Y coord
wCoordAdjustmentAmount::
wUnusedD08A::
	db

wSlideMonDelay::
; generic counter variable for various animations
wAnimCounter::
; controls what transformations are applied to the subanimation
; 01: flip horizontally and vertically
; 02: flip horizontally and translate downwards 40 pixels
; 03: translate base coordinates of frame blocks, but don't change their internal coordinates or flip their tiles
; 04: reverse the subanimation
wSubAnimTransform::
	db
ENDU

wEndBattleWinTextPointer:: dw
wEndBattleLoseTextPointer:: dw
	ds 2
wEndBattleTextRomBank:: db

	ds 1

; the address _of the address_ of the current subanimation entry
wSubAnimAddrPtr:: dw

UNION
; the address of the current subentry of the current subanimation
wSubAnimSubEntryAddr:: dw

NEXTU
; If non-zero, the allow matches flag is always set.
; There is a 1/256 (~0.4%) chance that this value will be set to 60, which is
; the only way it can increase. Winning certain payout amounts will decrement it
; or zero it.
wSlotMachineAllowMatchesCounter:: db
ENDU

	ds 2

wOutwardSpiralTileMapPointer:: db

wPartyMenuAnimMonEnabled::
; non-zero when enabled. causes nest locations to blink on and off.
; the town selection cursor will blink regardless of what this value is
wTownMapSpriteBlinkingEnabled::
wUnusedD09B:: db ; note: not SO unused, as it is shared with the blinking byte above

; current destination address in OAM for frame blocks (big endian)
wFBDestAddr:: dw

; controls how the frame blocks are put together to form frames
; specifically, after finishing drawing the frame block, the frame block's mode determines what happens
; 00: clean OAM buffer and delay
; 02: move onto the next frame block with no delay and no cleaning OAM buffer
; 03: delay, but don't clean OAM buffer
; 04: delay, without cleaning OAM buffer, and do not advance [wFBDestAddr], so that the next frame block will overwrite this one
wFBMode:: db

; 0 = small
; 1 = big
wLinkCableAnimBulgeToggle::
wIntroNidorinoBaseTile::
wOutwardSpiralCurrentDirection::
wDropletTile::
wNewTileBlockID::
wWhichBattleAnimTileset::
; 0 = left
; 1 = right
wSquishMonCurrentDirection::
; the tile ID of the leftmost tile in the bottom row in AnimationSlideMonUp_
wSlideMonUpBottomRowLeftTile::
	db

wDisableVBlankWYUpdate:: db ; if non-zero, don't update WY during V-blank

wSpriteCurPosX:: db
wSpriteCurPosY:: db
wSpriteWidth:: db
wSpriteHeight:: db
; current input byte
wSpriteInputCurByte:: db
; bit offset of last read input bit
wSpriteInputBitCounter:: db

; determines where in the output byte the two bits are placed. Each byte contains four columns (2bpp data)
; 3 -> XX000000   1st column
; 2 -> 00XX0000   2nd column
; 1 -> 0000XX00   3rd column
; 0 -> 000000XX   4th column
wSpriteOutputBitOffset:: db

; bit 0 determines used buffer (0 -> sSpriteBuffer1, 1 -> sSpriteBuffer2)
; bit 1 loading last sprite chunk? (there are at most 2 chunks per load operation)
wSpriteLoadFlags:: db
wSpriteUnpackMode:: db
wSpriteFlipped:: db

; pointer to next input byte
wSpriteInputPtr:: dw
; pointer to current output byte
wSpriteOutputPtr:: dw
; used to revert pointer for different bit offsets
wSpriteOutputPtrCached:: dw
; pointer to differential decoding table (assuming initial value 0)
wSpriteDecodeTable0Ptr:: dw
; pointer to differential decoding table (assuming initial value 1)
wSpriteDecodeTable1Ptr:: dw

wd0b5:: db ; used as a temp storage area for Pokemon Species, and other Pokemon/Battle related things

wNameListType:: db

wPredefBank:: db

wMonHeader::
; In the ROM base stats data structure, this is the dex number, but it is
; overwritten with the internal index number after the header is copied to WRAM.
wMonHIndex:: db
wMonHBaseStats::
wMonHBaseHP:: db
wMonHBaseAttack:: db
wMonHBaseDefense:: db
wMonHBaseSpeed:: db
wMonHBaseSpecial:: db
wMonHTypes::
wMonHType1:: db
wMonHType2:: db
wMonHCatchRate:: db
wMonHBaseEXP:: db
wMonHSpriteDim:: db
wMonHFrontSprite:: dw
wMonHBackSprite:: dw
wMonHMoves:: ds NUM_MOVES
wMonHGrowthRate:: db
wMonHLearnset:: flag_array NUM_TMS + NUM_HMS ; increased by increasing the number of TMs
wMonHPicBank:: db
wMonHeaderEnd::

; saved at the start of a battle and then written back at the end of the battle
wSavedTileAnimations:: db

	ds 1 ; edited, it was 2, reduced for increased TMs

wDamage:: dw

	ds 2

wRepelRemainingSteps:: db

; list of moves for FormatMovesString
wMoves:: ds NUM_MOVES

wMoveNum:: db

wItemList::			; suggestion from Vortiene, frees 16 bytes and allows 56 items sold in markets
wMovesString:: ds 56

wUnusedD119:: db

; wWalkBikeSurfState is sometimes copied here, but it doesn't seem to be used for anything
wWalkBikeSurfStateCopy:: db

; the type of list for InitList to init
wInitListType:: db

; 0 if no mon was captured
wCapturedMonSpecies:: db

; Non-zero when the first player mon and enemy mon haven't been sent out yet.
; It prevents the game from asking if the player wants to choose another mon
; when the enemy sends out their first mon and suppresses the "no will to fight"
; message when the game searches for the first non-fainted mon in the party,
; which will be the first mon sent out.
wFirstMonsNotOutYet:: db

wRelativePriorityForAttackdex:: ; new
wPokeBallCaptureCalcTemp::
; lower nybble: number of shakes
; upper nybble: number of animations to play
wPokeBallAnimData::
wUsingPPUp::
wMaxPP::
; 0 for player, non-zero for enemy
wCalculateWhoseStats::
wTypeEffectiveness::
wMoveType::
wNumSetBits::
; used as a Pokemon and Item storage value. Also used as an output value for CountSetBits
wd11e::
	db

; When this value is non-zero, the player isn't allowed to exit the party menu
; by pressing B and not choosing a mon.
wForcePlayerToChooseMon:: db

; number of times the player has tried to run from battle
wNumRunAttempts:: db

wEvolutionOccurred:: db

wVBlankSavedROMBank:: db

wFarCopyDataSavedROMBank:: db

wIsKeyItem:: db

wTextBoxID:: db

wCurrentMapScriptFlags:: db ; not exactly sure what this is used for, but it seems to be used as a multipurpose temp flag value

wCurEnemyLVL:: db

; pointer to list of items terminated by $FF
wItemListPointer:: dw

; number of entries in a list
wListCount:: db

wLinkState:: db

wTwoOptionMenuID:: db

; the id of the menu item the player ultimately chose
wChosenMenuItem::
; non-zero when the whole party has fainted due to out-of-battle poison damage
wOutOfBattleBlackout:: db

; the way the user exited a menu
; for list menus and the buy/sell/quit menu:
; $01 = the user pressed A to choose a menu item
; $02 = the user pressed B to cancel
; for two-option menus:
; $01 = the user pressed A with the first menu item selected
; $02 = the user pressed B or pressed A with the second menu item selected
wMenuExitMethod:: db

; the size is always 6, so they didn't need a variable in RAM for this
wDungeonWarpDataEntrySize::
; 0 = museum guy
; 1 = gym guy
wWhichPewterGuy::
; there are 3 windows, from 0 to 2
wWhichPrizeWindow::
; a horizontal or vertical gate block
wGymGateTileBlock:: db

wSavedSpriteScreenY:: db
wSavedSpriteScreenX:: db
wSavedSpriteMapY:: db
wSavedSpriteMapX:: db

	ds 3 ; edited to go beyond 200, it was ds 5
wIsTrainerBattle:: db  ; new, to go beyond 200
wWasTrainerBattle:: db ; new, to go beyond 200

wWhichPrize:: db

; counts downward each frame
; when it hits 0, bit 5 (ignore input bit) of wd730 is reset
wIgnoreInputCounter:: db

; counts down once every step
wStepCounter:: db

; after a battle, you have at least 3 steps before a random battle can occur
wNumberOfNoRandomBattleStepsLeft:: db

wPrize1:: db
wPrize2:: db
wPrize3:: db

	ds 1

UNION
wSerialRandomNumberListBlock:: ds $11

NEXTU
wPrize1Price:: dw
wPrize2Price:: dw
wPrize3Price:: dw

	ds 1

; shared list of 9 random numbers, indexed by wLinkBattleRandomNumberListIndex
wLinkBattleRandomNumberList:: ds 10
ENDU

wSerialPlayerDataBlock:: ; ds $1a8

; When a real item is being used, this is 0.
; When a move is acting as an item, this is the ID of the item it's acting as.
; For example, out-of-battle Dig is executed using a fake Escape Rope item. In
; that case, this would be ESCAPE_ROPE.
wPseudoItemID:: db

wEnemyStatEXPStore:: ; shinpokerednote: ADDED: store for EVs applied to the opponent's pokemon if the option is turned on
wUnusedD153:: db

	ds 1			; it was "ds 2", but with the edit above from Vortiene is now "ds 1"
	                ; this needs to stay free for the EVs-to-opponents to work fine, because I didn't declare wEnemyStatEXPStore as a dw?!

wEvoStoneItemID:: db

wSavedNPCMovementDirections2Index:: db

wPlayerName:: ds NAME_LENGTH


SECTION "Party Data", WRAM0

wPartyDataStart::

wPartyCount:: db
wPartySpecies:: ds PARTY_LENGTH + 1

wPartyMons::
; wPartyMon1 - wPartyMon6
FOR n, 1, PARTY_LENGTH + 1
wPartyMon{d:n}:: party_struct wPartyMon{d:n}
ENDR

wPartyMonOT::
; wPartyMon1OT - wPartyMon6OT
FOR n, 1, PARTY_LENGTH + 1
wPartyMon{d:n}OT:: ds NAME_LENGTH
ENDR

wPartyMonNicks::
; wPartyMon1Nick - wPartyMon6Nick
FOR n, 1, PARTY_LENGTH + 1
wPartyMon{d:n}Nick:: ds NAME_LENGTH
ENDR
wPartyMonNicksEnd::

wPartyDataEnd::


SECTION "Main Data", WRAM0

wMainDataStart::

wPokedexOwned:: flag_array NUM_POKEMON
wPokedexOwnedEnd::

wPokedexSeen:: flag_array NUM_POKEMON
wPokedexSeenEnd::

wAttackdexSeen:: flag_array NUM_ATTACKS ; new, 233 moves=bits / 8 bits/byte = 30 bytes needed
wAttackdexSeenEnd::

wNumBagItems:: db
; item, quantity
wBagItems:: ds BAG_ITEM_CAPACITY * 2 + 1

wPlayerMoney:: ds 3 ; BCD

wRivalName:: ds NAME_LENGTH

; bit 7 = battle animation
; 0: On
; 1: Off
; bit 6 = battle style
; 0: Shift
; 1: Set
; bits 0-3 = text speed (number of frames to delay after printing a letter)
; 1: Instant
; 3: Fast
; 5: Medium
wOptions:: db

wObtainedBadges:: flag_array NUM_BADGES

wHauntedHouse3HowManyTimeBetweenBeds:: ds 1 ; new
;	ds 1

; bit 0: If 0, limit the delay to 1 frame. Note that this has no effect if
;        the delay has been disabled entirely through bit 1 of this variable
;        or bit 6 of wd730.
; bit 1: If 0, no delay.
wLetterPrintingDelayFlags:: db

wPlayerID:: dw

wMapMusicSoundID:: db
wMapMusicROMBank:: db

; offset subtracted from FadePal4 to get the background and object palettes for the current map
; normally, it is 0. it is 6 when Flash is needed, causing FadePal2 to be used instead of FadePal4
wMapPalOffset:: db

wCurMap:: db

; pointer to the upper left corner of the current view in the tile block map
wCurrentTileBlockMapViewPointer:: dw

; player's position on the current map
wYCoord:: db
wXCoord:: db

; player's position (by block)
wYBlockCoord:: db
wXBlockCoord:: db

wLastMap:: db

wUnusedD366:: db

wCurMapTileset:: db

; blocks
wCurMapHeight:: db
wCurMapWidth:: db

wMapDataPtr:: dw
wMapTextPtr:: dw
wMapScriptPtr:: dw

wMapConnections:: db
wNorthConnectionHeader:: map_connection_struct wNorth
wSouthConnectionHeader:: map_connection_struct wSouth
wWestConnectionHeader::  map_connection_struct wWest
wEastConnectionHeader::  map_connection_struct wEast

; sprite set for the current map (11 sprite picture ID's)
wSpriteSet:: ds 11
; sprite set ID for the current map
wSpriteSetID:: db

wObjectDataPointerTemp:: dw

;	ds 2 ; commented out because went from 208 to 212 mons, i.e. one more byte needed both for seen and for owned

; the tile shown outside the boundaries of the map
wMapBackgroundTile:: db

; number of warps in current map (up to 32)
wNumberOfWarps:: db

; current map warp entries
wWarpEntries:: ds 36 * 4 ; Y, X, warp ID, map ID ; testing

; if $ff, the player's coordinates are not updated when entering the map
wDestinationWarpID:: db

wPikachuOverworldStateFlags:: db
wPikachuSpawnState:: db
wd432:: db
wd433:: db
wd434:: db
wd435:: db
wd436:: db
wPikachuFollowCommandBufferSize:: db
wPikachuFollowCommandBuffer:: ds 16

wExpressionNumber:: db
wPikaPicAnimNumber:: db

wPikachuMovementScriptBank:: db
wPikachuMovementScriptAddress:: dw
; bit 6 - spawn shadow
; bit 7 - signal end of command
wPikachuMovementFlags:: db

UNION
wCurPikaMovementData::
wCurPikaMovementParam1:: db
wCurPikaMovementFunc1:: db
wCurPikaMovementParam2:: db
wCurPikaMovementFunc2:: db
wd451:: db
wCurPikaMovementSpriteImageIdx:: db
wPikaSpriteX:: db
wPikaSpriteY:: db
wPikachuMovementXOffset:: db
wPikachuMovementYOffset:: db
wPikachuStepTimer:: db
wPikachuStepSubtimer:: db
	ds 5
wCurPikaMovementDataEnd::

NEXTU
wPikaPicAnimPointer:: dw
wPikaPicAnimPointerSetupFinished:: db
wPikaPicAnimCurGraphicID:: db
wPikaPicAnimTimer:: dw
wPikaPicAnimDelay:: db
wPikaPicPikaDrawStartX:: db
wPikaPicPikaDrawStartY:: db

wCurPikaPicAnimObject::
wCurPikaPicAnimObjectVTileOffset:: db
wCurPikaPicAnimObjectXOffset:: db
wCurPikaPicAnimObjectYOffset:: db
wCurPikaPicAnimObjectScriptIdx:: db
wCurPikaPicAnimObjectFrameIdx:: db
wCurPikaPicAnimObjectFrameTimer:: db
	ds 1
wCurPikaPicAnimObjectEnd::

	ds 18
ENDU

wPikachuHappiness:: db
wPikachuMood:: db
wd472:: db
wd473:: db
wHoFMonShiny:: db ; new, 0 if the mon is not shiny, 1 if it is
;	ds 1 ; edited, used for the above
wd475:: db
wBadgeBoostOption:: db ; new
;	ds 4 ; edited, all used
wWeAreTrading:: db ; new, used for the shiny
wOpponentMonShiny:: db ; new
wPlayerMonShiny:: db ; new, ugly-ly used only in the HoF PC?
wd47a:: db
;	ds 4 ; edited to increase bag capacity
wd492:: db
wLevelScaling:: db ; new: if 0, no level scaling; if 1, yes
;	ds 1 ; edited, commented out for var above
wSurfingMinigameHiScore:: dw ; little-endian BCD
wExpGainOption:: db ; new
;	ds 1 ; edited, commented out for var above
wPrinterSettings:: db
wUnknownSerialFlag_d499:: db
wPrinterConnectionOpen:: db
wPrinterOpcode:: db
wd49c:: db

;	ds 10 ; commented out to save space for the new HS variables

; number of signs in the current map (up to 16)
wNumSigns:: db

wSignCoords:: ds 16 * 2 ; Y, X
wSignTextIDs:: ds 16

; number of sprites on the current map (up to 16)
wNumSprites:: db

; these two variables track the X and Y offset in blocks from the last special warp used
; they don't seem to be used for anything
wYOffsetSinceLastSpecialWarp:: db
wXOffsetSinceLastSpecialWarp:: db

wMapSpriteData:: ds 16 * 2 ; movement byte 2, text ID
wMapSpriteExtraData:: ds 16 * 2 ; trainer class/item ID, trainer set ID

; map height in 2x2 meta-tiles
wCurrentMapHeight2:: db

; map width in 2x2 meta-tiles
wCurrentMapWidth2:: db

; the address of the upper left corner of the visible portion of the BG tile map in VRAM
wMapViewVRAMPointer:: dw

; In the comments for the player direction variables below, "moving" refers to
; both walking and changing facing direction without taking a step.

; if the player is moving, the current direction
; if the player is not moving, zero
; map scripts write to this in order to change the player's facing direction
wPlayerMovingDirection:: db

; the direction in which the player was moving before the player last stopped
wPlayerLastStopDirection:: db

; if the player is moving, the current direction
; if the player is not moving, the last the direction in which the player moved
wPlayerDirection:: db

wTilesetBank:: db

; maps blocks (4x4 tiles) to tiles
wTilesetBlocksPtr:: dw

wTilesetGfxPtr:: dw

; list of all walkable tiles
wTilesetCollisionPtr:: dw

wTilesetTalkingOverTiles:: ds 3

wGrassTile:: db

;	ds 4 ; commented out to save space for the extra HS variables

wNumBoxItems:: db
; item, quantity
wBoxItems:: ds PC_ITEM_CAPACITY * 2 + 1

; bits 0-6: box number
; bit 7: whether the player has changed boxes before
wCurrentBoxNum:: dw

; number of HOF teams
wNumHoFTeams:: db

wMultipurposeTemporaryStorage:: db ; edited, it was wUnusedD5A3

wPlayerCoins:: ds 2 ; BCD

; bit array of missable objects. set = removed
wMissableObjectFlags:: flag_array $100
wMissableObjectFlagsEnd::

; new for splitting HS - careful: may break a stuff because 100 bits are "a lot"
; bit array of missable objects. set = removed
wMissableObjectFlagsExtra:: flag_array $100 ; it's $100=256 (bits = 32 bytes) new HS variables
wMissableObjectFlagsExtraEnd::

;	ds 7		; new - commented to try to save space to be able to add all new mons

; temp copy of SPRITESTATEDATA1_IMAGEINDEX (used for sprite facing/anim)
wd5cd:: db

; each entry consists of 2 bytes
; * the sprite ID (depending on the current map)
; * the missable object index (global, used for wMissableObjectFlags)
; terminated with $FF
wMissableObjectList:: ds 16 * 2 + 1

wAreWeUsingTheHoFPC:: db ; new, for the shiny
;	ds 1 ; edited, used for the above

wGameProgressFlags::
wOaksLabCurScript:: db
wPalletTownCurScript:: db
;wLavenderTownCurScript:: db ; new
;	ds 1
;wBluesHouseCurScript:: db
;	ds 2

wViridianCityCurScript:: db
;wObsidianIslandCurScript:: db
;wOchreCityCurScript:: db ; new
;	ds 2
;wPewterCityCurScript:: db
;wRoute3CurScript:: db
;wRoute4CurScript:: db
	ds 5 ; new, from optimizing the scripts, UNUSED

wFanClubCurScript:: db
;wViridianGymCurScript:: db
;wPewterGymCurScript:: db
;wCeruleanGymCurScript:: db
;wVermilionGymCurScript:: db
;wCeladonGymCurScript:: db
;wRoute6CurScript:: db
;wRoute8CurScript:: db
;wRoute24CurScript:: db
;wRoute25CurScript:: db
;wRoute9CurScript:: db
;wRoute10CurScript:: db
;wMtMoon1FCurScript:: db
;wMtMoonB2FCurScript:: db
;wSSAnne1FRoomsCurScript:: db
;wSSAnne2FRoomsCurScript:: db
;wRoute22CurScript:: db
;	ds 1
;wOchreGymCurScript:: db ; new
;wRedsHouse2FCurScript:: db
	ds 18 ; new, from optimizing the scripts, UNUSED

wViridianMartCurScript:: db
wRoute22GateCurScript:: db
wCeruleanCityCurScript:: db
;wRoute26CurScript:: db ; new
;wSafariZoneNorthCurScript:: db ; new
;wObsidianWoodCurScript:: db ; new
;wObsidianWarehouseCurScript:: db ; new
;wObsidianWarehouseFinalCurScript:: db ; new
;wOnixBurrowingCurScript:: db ; new
;wSecludedCavesCurScript:: db ; new
;   db 7
;wSSAnneBowCurScript:: db
;wViridianForestCurScript:: db
	ds 9 ; new, from optimizing the scripts, UNUSED

wMuseum1FCurScript:: db
;wRoute13CurScript:: db
;wRoute14CurScript:: db
;wRoute17CurScript:: db
;wRoute19CurScript:: db
;wRoute21CurScript:: db
	ds 5 ; new, from optimizing the scripts, UNUSED

wSafariZoneGateCurScript:: db
;wRockTunnelB1FCurScript:: db
;wRockTunnel1FCurScript:: db
;wObsidianMinesCurScript:: db ; new
;	ds 1
;wRoute11CurScript:: db
;wRoute12CurScript:: db
;wRoute15CurScript:: db
;wRoute16CurScript:: db
;wRoute18CurScript:: db
;wRoute20CurScript:: db
;wSSAnneB1FRoomsCurScript:: db
;wVermilionCityCurScript:: db
;wPokemonTower2FCurScript:: db
;wPokemonTower3FCurScript:: db
;wPokemonTower4FCurScript:: db
;wPokemonTower5FCurScript:: db
;wPokemonTower6FCurScript:: db
;wPokemonTower7FCurScript:: db
;wRocketHideoutB1FCurScript:: db
;wRocketHideoutB2FCurScript:: db
;wRocketHideoutB3FCurScript:: db
;wRocketHideoutB4FCurScript:: db
;wFuchsiaCityCurScript:: db ; new
;	ds 1
;wRoute6GateCurScript:: db
;wRoute8GateCurScript:: db
;wSaffronCityCurScript:: db ; new
;	ds 1
;wCinnabarIslandCurScript:: db
;wPokemonMansion1FCurScript:: db
;wSSAnneCaptainsRoomCurScript:: db ; new
;	ds 1
;wPokemonMansion2FCurScript:: db
;wPokemonMansion3FCurScript:: db
;wPokemonMansionB1FCurScript:: db
;wVictoryRoad2FCurScript:: db
;wVictoryRoad3FCurScript:: db
;wCeladonCityCurScript:: db
;wFightingDojoCurScript:: db
;wSilphCo2FCurScript:: db
;wSilphCo3FCurScript:: db
;wSilphCo4FCurScript:: db
;wSilphCo5FCurScript:: db
;wSilphCo6FCurScript:: db
;wSilphCo7FCurScript:: db
;wSilphCo8FCurScript:: db
;wSilphCo9FCurScript:: db
;wHallOfFameCurScript:: db
	ds 12 ; new, from optimizing the scripts, UNUSED
		  ; it was 44, but -32 for the wMissableObjectFlagsSevii added below

wChampionsRoomCurScript:: db
wLoreleisRoomCurScript:: db
wBrunosRoomCurScript:: db
wAgathasRoomCurScript:: db
;wCeruleanCaveB1FCurScript:: db
;wVictoryRoad1FCurScript:: db
;wCeladonChiefHouseCurScript:: db ; new
;	ds 1
	ds 3 ; new, from optimizing the scripts, UNUSED

wLancesRoomCurScript:: db
;wCopycatsHouse2FCurScript:: db ; new
;wSafariZoneRestHouseCurScript:: db ; new
;wCinnabarVolcanoBFCurScript:: db ; new
	ds 3 ; new, from optimizing the scripts, UNUSED

wOchreRehabilitationCenterCurScript:: db ; new
;	ds 4
;wSilphCo10FCurScript:: db
;wSilphCo11FCurScript:: db
;wRoute29CurScript:: db ; new
;	ds 1
;wFuchsiaGymCurScript:: db
;wSaffronGymCurScript:: db
;wCeladonMansion2FCurScript:: db ; new
;	ds 1
;wCinnabarGymCurScript:: db
;wGameCornerCurScript:: db
;wRoute16Gate1FCurScript:: db
	ds 9 ; new, from optimizing the scripts, UNUSED

wBillsHouseCurScript:: db
;wRoute5GateCurScript:: db
;wPowerPlantCurScript:: ; overload
;wRoute7GateCurScript:: db
;wCeladonUniversity2CurScript:: db ; new
;	ds 1
;wSSAnne2FCurScript:: db
	ds 4 ; new, from optimizing the scripts, UNUSED

wSeafoamIslandsB3FCurScript:: db
;wRoute23CurScript:: db
	ds 1 ; new, from optimizing the scripts, UNUSED

wSeafoamIslandsB4FCurScript:: db
;wRoute18Gate1FCurScript:: db
;wHauntedHouse3CurScript:: db ; new
;wBattleFacilityCurScript:: db ; new
;wHauntedRedsHouseCurScript:: db ; new
;wHauntedPalletTownCurScript:: db ; new
;wHauntedIslandOfNumbersCurScript:: db ; new
;wHauntedHouse4CurScript:: db ; new
	ds 7 ; new, from optimizing the scripts, UNUSED

wHauntedPalletTownPaletteCounter:: db ; new, "out of place" but whatever, also kinda ok
;wMrPsychicsHouseCurScript:: db ; new
;wCeruleanCaveExtraMiddleCurScript:: db ; new
;wRedsHouse1FCurScript:: db ; new
;wRoute15Gate2FCurScript:: db ; new
;wRoute28CurScript:: db ; new
;wRoute27CurScript:: db ; new
	ds 10 ; UNUSED bytes in "Main Data", was 78, -28 because of the new wAttackdexSeen + 5 from optimizing the scripts - 10 for wObtainedHiddenItemsFlagsSevii
wGameProgressFlagsEnd::

; new for sevii
; bit array of missable objects. set = removed
wMissableObjectFlagsSevii:: flag_array $100 ; it's $100=256 (bits = 32 bytes) new HS variables
wMissableObjectFlagsSeviiEnd::

wPlayerGender::
	; $00 = male
	; $01 = female
	; $02 = enby
	ds 1

wTyrogueEvolutions::
	; stores directly the number/name of the chosen Hitmon
	ds 1

wBattleFacilityPokemonPool:: db ; new: 0 for AG, 1 for NFE, 2 for LC, 3 for exit
wBattleFacilityBattleMode:: db ; new: 0 is standard (blocks of 7 battles), 1 is for hardcore, 2 is for exit
wBattleFacilityInverseBattle:: db ; new: if 0, Normal battle; if 1, Inverse Battle

wBattleFacilityStandardCurrentStreakNormalAG:: db ; new
wBattleFacilityStandardCurrentStreakNormalNFE:: db ; new
wBattleFacilityStandardCurrentStreakNormalLC:: db ; new
wBattleFacilityStandardCurrentStreakInverseAG:: db ; new
wBattleFacilityStandardCurrentStreakInverseNFE:: db ; new
wBattleFacilityStandardCurrentStreakInverseLC:: db ; new
wBattleFacilityHardcoreCurrentStreak:: db ; new

wBattleFacilityStandardRecordNormalAG:: db ; new
wBattleFacilityStandardRecordNormalNFE:: db ; new
wBattleFacilityStandardRecordNormalLC:: db ; new
wBattleFacilityStandardRecordInverseAG:: db ; new
wBattleFacilityStandardRecordInverseNFE:: db ; new
wBattleFacilityStandardRecordInverseLC:: db ; new

wBattleFacilityHardcoreRecordNormalAG:: db ; new
wBattleFacilityHardcoreRecordNormalNFE:: db ; new
wBattleFacilityHardcoreRecordNormalLC:: db ; new
wBattleFacilityHardcoreRecordInverseAG:: db ; new
wBattleFacilityHardcoreRecordInverseNFE:: db ; new
wBattleFacilityHardcoreRecordInverseLC:: db ; new

wBattleFacilityBacklogPPUPs:: db ; new
wBattleFacilityBacklogPerfecters:: db ; new
wBattleFacilityBacklogChromogenes:: db ; new

; edited, originally was ds 56
	      ; reduced by 3 for gender, tyrogue, and accuracypercent
		  ; by 16 for increasing max warps from 32 to 36
		  ; by 8 for new HS variables
		  ; by 16 to increase bag capacity
		  ; by 12 for battle facility

wLevelCapOption:: db ; new: 0 obed loose, 1 obed tight, 2 level loose, 3 level tight, 4 none
wPlayerMoveAccuracyPercent:: db ; new, to host the accuracy in [0,100] rather than [0,255]

wObtainedHiddenItemsFlags:: flag_array 112

wObtainedHiddenCoinsFlags:: flag_array 16

wObtainedHiddenItemsFlagsSevii:: flag_array 112 ; 112 bits / 8 = 14 bytes

; $00 = walking
; $01 = biking
; $02 = surfing
wWalkBikeSurfState:: db

;	ds 10 ; edited, was 10

wPersonalizationPhySpeSplit:: db ; new
wPersonalizationLevelStatus:: db ; new
wDumbByteToToggleStatusScreen:: db ; new
wIsEvolvingMidBattle:: db ; new
wRandomizationWildEncounters:: db ; new
wRandomizationTrainersTeams:: db ; new
wRandomizationItems:: db ; new
wRandomizationTypeChart:: db ; new
wPersonalizationNames:: db ; new
wPersonalizationTypes:: db ; new
wLuckAccuracy:: db ; new
wLuckRoll:: db ; new
wLuckCrit:: db ; new
wLuckSecondaryEffects:: db ; new
wLuckStatusesAffliction:: db ; new

wTownVisitedFlag:: flag_array NUM_CITY_MAPS + 2

; starts at 502
wSafariSteps:: dw

; item given to cinnabar lab
wFossilItem:: db
; mon that will result from the item
wFossilMon:: db

;	ds 2
wTallGrassBillsSecretGardenSteps:: dw ; new, will start at 666

; trainer classes start at OPP_ID_OFFSET
wEnemyMonOrTrainerClass:: db

wPlayerJumpingYScreenCoordsIndex:: db

;wRivalStarter:: db ; edited, unused
wOriginallyInKantoOrSevii:: db ; new: 0=Kanto, 1=Sevii

IF DEF(_DEBUG)
; this byte gets set to NUM_POKEMON by DebugStart
wUnknownDebugByte:: db
ELSE
	ds 1
ENDC

wPlayerStarter:: db

; sprite index of the boulder the player is trying to push
wBoulderSpriteIndex:: db

wLastBlackoutMap:: db

; destination map (for certain types of special warps, not ordinary walking)
wDestinationMap:: db

wRandomizationEvolutions:: db ; it was an unused byte

; used to store the tile in front of the boulder when trying to push a boulder
; also used to store the result of the collision check ($ff for a collision and $00 for no collision)
wTileInFrontOfBoulderAndBoulderCollisionResult:: db

; destination map for dungeon warps
wDungeonWarpDestinationMap:: db

; which dungeon warp within the source map was used
wWhichDungeonWarp:: db

wBattleFacilityOpponentTrainerSprite:: db ; new
wBattleFacilityWhichMonIsRandomized:: db ; new
wBattleFacilityMonNumber1:: db ; new
wBattleFacilityMonNumber2:: db ; new
wBattleFacilityMonNumber3:: db ; new
wBattleFacilityMonNumber4:: db ; new
wBattleFacilityMonNumber5:: db ; new
wBattleFacilityWinningStreak:: db ; new
;	ds 8 ; now used for the variables above
wBattleFacilityWinningStreakNext:: db ; edited, it was wUnusedD71F

; bit 0: using Strength outside of battle
; bit 1: set by IsSurfingAllowed when surfing's allowed, but the caller resets it after checking the result
; bit 3: received Old Rod
; bit 4: received Good Rod
; bit 5: received Super Rod
; bit 6: gave one of the Saffron guards a drink
; bit 7: set by ItemUseCardKey, which is leftover code from a previous implementation of the Card Key
wd728:: db

;	ds 1
wTownVisitedFlag_Sevii:: flag_array NUM_CITY_MAPS_SEVII ; new, for Sevii
	ds 1 ; UNUSED bytes in "Main Data"; moved up from below the wBeatGymFlags

; redundant because it matches wObtainedBadges
; used to determine whether to show name on statue and in two NPC text scripts
wBeatGymFlags:: db

; bit 0: if not set, the 3 minimum steps between random battles have passed
; bit 1: prevent audio fade out
wd72c:: db

; This variable is used for temporary flags and as the destination map when
; warping to the Trade Center or Colosseum.
; bit 0: sprite facing directions have been initialised in the Trade Center
; bit 3: do scripted warp (used to warp back to Lavender Town from the top of the pokemon tower)
; bit 4: on a dungeon warp
; bit 5: don't make NPCs face the player when spoken to
; Bits 6 and 7 are set by scripts when starting major battles in the storyline,
; but they do not appear to affect anything. Bit 6 is reset after all battles
; and bit 7 is reset after trainer battles (but it's only set before trainer
; battles anyway).
wd72d:: db

; bit 0: the player has received Porygon in the Silph Co. building
; bit 1: set in various places, but doesn't appear to have an effect
; bit 2: the player has healed pokemon at a pokemon center at least once
; bit 3: the player has a received a pokemon from Prof. Oak
; bit 4: disable battles
; bit 5: set when a battle ends and when the player blacks out in the overworld due to poison
; bit 6: using the link feature
; bit 7: set if scripted NPC movement has been initialised
wd72e:: db

;	it was ds 1
wRoute32RespawnItemsSteps:: dw ; new, will start at 1000; made using the ds 1 above and the ds 1 below

; bit 0: NPC sprite being moved by script
; bit 5: ignore joypad input
; bit 6: print text with no delay between each letter
; bit 7: set if joypad states are being simulated in the overworld or an NPC's movement is being scripted
wd730:: db

;	it was ds 1 ; moved up with the other ds 1 to make the Route 32 steps counter

; bit 0: play time being counted
; bit 1: remnant of debug mode; only set by the debug build.
; if it is set:
; 1. skips most of Prof. Oak's speech, and uses NINTEN as the player's name and SONY as the rival's name
; 2. does not have the player start in floor two of the player's house (instead sending them to [wLastMap])
; 3. allows wild battles to be avoided by holding down B
; furthermore, in the debug build:
; 4. allows trainers to be avoided by holding down B
; 5. skips Safari Zone step counter by holding down B
; 6. skips the NPC who blocks Route 3 before beating Brock by holding down B
; 7. skips Cerulean City rival battle by holding down B
; 8. skips Pokémon Tower rival battle by holding down B
; bit 2: the target warp is a fly warp (bit 3 set or blacked out) or a dungeon warp (bit 4 set)
; bit 3: used warp pad, escape rope, dig, teleport, or fly, so the target warp is a "fly warp"
; bit 4: jumped into hole (Pokemon Mansion, Seafoam Islands, Victory Road) or went down waterfall (Seafoam Islands), so the target warp is a "dungeon warp"
; bit 5: currently being forced to ride bike (cycling road)
; bit 6: map destination is [wLastBlackoutMap] (usually the last used pokemon center, but could be the player's house)
wd732:: db

; bit 0: running a test battle
; bit 1: prevent music from changing when entering new map
; bit 2: skip the joypad check in CheckWarpsNoCollision (used for the forced warp down the waterfall in the Seafoam Islands)
; bit 3: trainer wants to battle
; bit 4: use variable [wCurMapScript] instead of the provided index for next frame's map script (used to start battle when talking to trainers)
; bit 7: used fly out of battle
wFlags_D733:: db

; bit 1: set when you beat Lorelei and reset in Indigo Plateau lobby
; the game uses this to tell when Elite 4 events need to be reset
wBeatLorelei:: db

	ds 1 ; UNUSED bytes in "Main Data"

; bit 0: check if the player is standing on a door and make him walk down a step if so
; bit 1: the player is currently stepping down from a door
; bit 2: standing on a warp
; bit 6: jumping down a ledge / fishing animation
; bit 7: player sprite spinning due to spin tiles (Rocket hideout / Viridian Gym)
wd736:: db

wCompletedInGameTradeFlags:: dw

wNonShinyEncounters:: dw ; new
;	ds 2 ; edited, used for above

wWarpedFromWhichWarp:: db
wWarpedFromWhichMap:: db

;	ds 2
wRandomMemoryAddressForTypeChartRandomization:: ds 2 ; new

wCardKeyDoorY:: db
wCardKeyDoorX:: db

;	ds 2
wRandomMemoryAddressForWildRandomization:: ds 2 ; new

wFirstLockTrashCanIndex:: db
wSecondLockTrashCanIndex:: db

;	ds 2
wRandomMemoryAddressForWildRandomization_Current:: ds 2 ; new

wEventFlags:: flag_array NUM_EVENTS


UNION
wGrassRate:: db
wGrassMons:: ds 10 * 2

	ds 8

wWaterRate:: db
wWaterMons:: ds 10 * 2

NEXTU
; linked game's trainer name
wLinkEnemyTrainerName:: ds NAME_LENGTH

	ds 1

wSerialEnemyDataBlock:: ; ds $1a8

	ds 9

wEnemyPartyCount:: ds 1
wEnemyPartySpecies:: ds PARTY_LENGTH + 1

wEnemyMons::
; wEnemyMon1 - wEnemyMon6
FOR n, 1, PARTY_LENGTH + 1
wEnemyMon{d:n}:: party_struct wEnemyMon{d:n}
ENDR

wEnemyMonOT::
; wEnemyMon1OT - wEnemyMon6OT
FOR n, 1, PARTY_LENGTH + 1
wEnemyMon{d:n}OT:: ds NAME_LENGTH
ENDR

wEnemyMonNicks::
; wEnemyMon1Nick - wEnemyMon6Nick
FOR n, 1, PARTY_LENGTH + 1
wEnemyMon{d:n}Nick:: ds NAME_LENGTH
ENDR

ENDU


wTrainerHeaderPtr:: dw

	ds 3 ; UNUSED bytes in "Main Data"; edited, was 6
wMultiUseBuffer:: db ; new, for various buffer purposes

; the trainer the player must face after getting a wrong answer in the Cinnabar
; gym quiz
wOpponentAfterWrongAnswer::
wUnusedDA38:: db

; index of current map script, mostly used as index for function pointer array
; mostly copied from map-specific map script pointer and written back later
wCurMapScript:: db

;	ds 7
wUniQuizAnswer:: ds NAME_LENGTH ; new, apparently it's 11 and not 7 as I thought, same length as Mons' names + terminator

wPlayTimeHours:: db
wPlayTimeMaxed:: db
wPlayTimeMinutes:: db
wPlayTimeSeconds:: db
wPlayTimeFrames:: db

wSafariZoneGameOver:: db

wNumSafariBalls:: db


; 0 if no pokemon is in the daycare
; 1 if pokemon is in the daycare
wDayCareInUse:: db

wDayCareMonName:: ds NAME_LENGTH
wDayCareMonOT::   ds NAME_LENGTH

wDayCareMon:: box_struct wDayCareMon

wMainDataEnd::


SECTION "Current Box Data", WRAM0

wBoxDataStart::

wBoxCount:: db
wBoxSpecies:: ds MONS_PER_BOX + 1

wBoxMons::
; wBoxMon1 - wBoxMon20
FOR n, 1, MONS_PER_BOX + 1
wBoxMon{d:n}:: box_struct wBoxMon{d:n}
ENDR

wBoxMonOT::
; wBoxMon1OT - wBoxMon20OT
FOR n, 1, MONS_PER_BOX + 1
wBoxMon{d:n}OT:: ds NAME_LENGTH
ENDR

wBoxMonNicks::
; wBoxMon1Nick - wBoxMon20Nick
FOR n, 1, MONS_PER_BOX + 1
wBoxMon{d:n}Nick:: ds NAME_LENGTH
ENDR
wBoxMonNicksEnd::

wBoxDataEnd::


SECTION "GBC Palette Data", WRAM0

wGBCBasePalPointers:: ds NUM_ACTIVE_PALS * 2
wGBCPal:: ds PALETTE_SIZE
wLastBGP:: db
wLastOBP0:: db
wLastOBP1:: db
wdef5:: db
wBGPPalsBuffer:: ds NUM_ACTIVE_PALS * PALETTE_SIZE


SECTION "Stack", WRAM0

; the stack grows downward
	ds $eb - 1
wStack:: db
