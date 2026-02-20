_FileDataDestroyedText::
	text "The file data is"
	line "destroyed!"
	prompt

_WouldYouLikeToSaveText::
	text "Would you like to"
	line "SAVE the game?"
	done

_SavingText::
	text "Saving..."
	done

_GameSavedText::
	text "<PLAYER> saved"
	line "the game!"
	done

_OlderFileWillBeErasedText::
	text "The older file"
	line "will be erased to"
	cont "save. Okay?"
	done

_WhenYouChangeBoxText::
	text "When you change a"
	line "#MON BOX, data"
	cont "will be saved."

	para "Is that okay?"
	done

_ChooseABoxText::
	text "Choose a"
	line "<PKMN> BOX.@"
	text_end

_EvolvedText::
	text_ram wStringBuffer
	text " evolved"
	done

_IntoText::
	text_start
	line "into @"
	text_ram wcd6d
	text "!"
	done

_StoppedEvolvingText::
	text "Huh? @"
	text_ram wStringBuffer
	text_start
	line "stopped evolving!"
	prompt

_RepelUseAnotherText:: ; new, from Vortiene
	text "Use another?"
	done

; new, info on options ------------------------------

; personalization ----

_PersonalizationInfoTextTypes::
	text "Some selected"
	line "#MON have"
	cont "their typing"
	cont "altered."
	prompt

_PersonalizationInfoTextPhySpeSplit::
	text "If selected, the"
	line "physical/special"
	cont "split of gen4+"
	cont "is applied."
	prompt

_PersonalizationInfoTextSwapBattles::
	text "NONE: vanilla."
	line "TRADE: trade team"
	cont "with enemy after"
	cont "every fight."
	cont "ALL: SWAP mode is"
	cont "applied for all"
	cont "battles: first a"
	cont "normal battle,"
	cont "then temporarily"
	cont "swap team with"
	cont "opponent and must"
	cont "win that too."
	cont "MAJOR: SWAP mode"
	cont "is applied only"
	cont "for major fights."
;	xxxx "123456789012345678"
	prompt

_PersonalizationInfoTextTypeChart::
	text "If selected, a"
	line "custom type chart"
	cont "crafted by the"
	cont "author is used."
	cont "In can be viewed"
	cont "in the #DEX."
;	xxxx "123456789012345678"
	prompt

_PersonalizationInfoTextTCGMode::
	text "If selected, TCG"
	line "types are used"
	cont "for moves, chart,"
	cont "and pokeMON."
	cont "This overrrides"
	cont "random type chart"
	cont "& altered types."
;	xxxx "123456789012345678"
	prompt

; randomization ------

_RandomizationInfoTextWildMons::
	text "Wild encounters"
	line "are randomized."

	para "After"
	line "randomization,"
	cont "encounters in a"
	cont "given area are"
	cont "fixed."

	para "Re-randomized"
	line "every time this"
	cont "menu is opened."

	para "Not applied to"
	line "fishing."
	prompt

_RandomizationInfoTextEnemyTeams::
	text "Enemy teams are"
	line "randomized."

	para "Upon rematch,"
	line "teams change."

	para "Re-randomized"
	line "every time this"
	cont "menu is opened."
	prompt

_RandomizationInfoTextTypeChart::
	text "Type chart"
	line "(effectivenesses)"
	cont "is randomized."

	para "Re-randomized"
	line "every time this"
	cont "menu is opened."
	prompt

_RandomizationInfoTextItems::
	text "Ground items are"
	line "randomized."

	para "Upon reloading,"
	line "items change."

	para "Re-randomized"
	line "every time this"
	cont "menu is opened."

	para "Not applied to"
	line "hidden items."
	prompt

_RandomizationInfoTextEvolutions::
	text "Every #MON"
	line "evolves randomly"
	cont "in any other one"
	cont "at every level."
	prompt

; battle luck --------

_LuckInfoTextAccuracy::
	text "PLAYER MIN: all"
	line "moves with"
	cont "accuracy below"
	cont "100% always miss."

	para "ENEMY MAX: enemies"
	line "never miss."
	prompt

_LuckInfoTextRoll::
	text "PLAYER MIN: moves"
	line "deal minimum"
	cont "damage (85%)."

	para "ENEMY MAX: enemy"
	line "moves deal"
	cont "maximum damage."
	prompt

_LuckInfoTextCrits::
	text "PLAYER MIN: moves"
	line "are never"
	cont "critical hits."

	para "ENEMY MAX: enemy"
	line "moves are always"
	cont "critical hits."
	prompt

_LuckInfoTextEffects::
	text "PLAYER MIN: moves"
	line "never trigger"
	cont "additional"
	cont "effects"
;	xxxx "123456789012345678"
	cont "(e.g. flinch)."

	para "ENEMY MAX: enemy"
	line "moves always deal"
	cont "additional"
	cont "effects."
	prompt

_LuckInfoTextStatus::
	text "PLAYER MIN: max"
	line "SLEEP / DISABLE /"
	cont "CONFUSION"
	cont "duration, always"
	cont "fully PAR, always"
	cont "self-hit in"
	cont "CONFUSION."

	para "ENEMY MAX: enemies"
	line "min SLEEP /"
	cont "DISABLE /"
	cont "CONFUSION"
	cont "duration, never"
	cont "fully PAR, never"
	cont "self-hit in"
	cont "CONFUSION."
	prompt

; layout & miscellanea ------

_LayoutInfoTextSound::
	text "EARPHONE1 is"
	line "stereo, 2 focuses"
	cont "on left side, 3"
	cont "on right side."
	prompt

_LayoutInfoTextNames::
	text "Change #MON"
	line "names between"
	cont "English,"
	cont "gender-neutral,"
	cont "and Japanese."
	prompt


_LayoutInfoTextLevelStatus::
	text "With OLD layout,"
	line "the STATUS covers"
	cont "the LEVEL."
	prompt

; start options ------

_OptionsInfoTextTextSpeed::
	text "Adjust text speed."
	prompt

_OptionsInfoTextAnimation::
	text "Moves animations."
	prompt

_OptionsInfoTextBattleStyle::
	text "SHIFT: you're"
	line "prompted to"
	cont "switch #MON"
	cont "before opponent"
	cont "sends a new one."
	prompt

_OptionsInfoTextCap::
	text "Handles caps:"

	para "OBEDIENCE CAP:"
	line "#MON above the"
	cont "cap disobey."

	para "LEVEL CAP: #MON"
	line "that reach the"
	cont "cap earn no EXP."

	para "TIGHT: exactly at"
	line "the next GYM"
	cont "LEADER's ace."

	para "LOOSE: slightly"
	line "above next GYM"
	cont "LEADER's ace."
	prompt

_OptionsInfoTextBadgeBoost::
	text "CLASSIC: as in the"
	line "original games,"
	cont "including badge"
	cont "boost glitch."
	prompt

_OptionsInfoTextLevelScale::
	text "EXACT: trainers'"
	line "level is equal to"
	cont "your max."

	para "FLUCTUATING:"
	line "trainers' level"
	cont "is equal to your"
	cont "max +- 2."

	para "HARD: trainers'"
	line "level is equal to"
	cont "your max + 10%."

	para "IMPOSSIBLE:"
	line "trainers' level"
	cont "is always 100."
	prompt

_OptionsInfoTextExpGain::
	text "LIMITED: wild"
	line "#MON and"
	cont "trainer rematches"
	cont "earn no EXP."

	para "NOTHING: no battle"
	line "earn any EXP."
	prompt

_PersonalizationInfoTextTypes_WannaKnowThemAll::
	text "Want to see the"
	line "full list?"
	cont "It's pretty long."
;	xxxx "123456789012345678"
	done

_PersonalizationInfoTextTypes_Details::
	text "VENUSAUR:"
	line "GRASS/GROUND"

	para "CHARIZARD:"
	line "FIRE/DRAGON"

	para "BLASTOISE:"
	line "WATER/STEEL"

	para "BUTTERFREE:"
	line "BUG/PSYCHIC"

	para "PIDGEY:"
	line "FLYING/FLYING"

	para "PIDGEOTTO:"
	line "FLYING/FLYING"

	para "PIDGEOT:"
	line "FLYING/FLYING"

	para "RATTATA:"
	line "NORMAL/GROUND"

	para "RATICATE:"
	line "NORMAL/GROUND"

	para "SPEAROW:"
	line "FLYING/FIGHTING"

	para "FEAROW:"
	line "FLYING/FIGHTING"

	para "ARBOK:"
	line "POISON/DARK"

	para "PICHU:"
	line "ELECTRIC/GROUND"

	para "PIKACHU:"
	line "ELECTRIC/GROUND"

	para "RAICHU:"
	line "ELECTRIC/GROUND"

	para "NIDOQUEEN:"
	line "POISON/FAIRY"

	para "NIDOKING:"
	line "POISON/FIGHTING"

	para "VULPIX:"
	line "FIRE/GHOST"

	para "NINETALES:"
	line "FIRE/GHOST"

	para "ZUBAT:"
	line "DARK/FLYING"

	para "GOLBAT:"
	line "DARK/FLYING"

	para "CROBAT:"
	line "DARK/FLYING"

	para "BELLOSSOM:"
	line "GRASS/FIRE"

	para "PARAS:"
	line "BUG/GHOST"

	para "PARASECT:"
	line "BUG/GHOST"

	para "VENOMOTH:"
	line "POISON/PSYCHIC"

	para "PSYDUCK:"
	line "WATER/PSYCHIC"

	para "GOLDUCK:"
	line "WATER/PSYCHIC"

	para "PRIMEAPE:"
	line "FIGHTING/DARK"

	para "ARCANINE:"
	line "FIRE/DRAGON"

	para "GEODUDE:"
	line "ROCK/ROCK"

	para "GRAVELER:"
	line "ROCK/ROCK"

	para "GOLEM:"
	line "ROCK/ROCK"

	para "PONYTA:"
	line "FIRE/GROUND"

	para "RAPIDASH:"
	line "FIRE/GROUND"

	para "DODUO:"
	line "FLYING/GROUND"

	para "DODRIO:"
	line "FLYING/GROUND"

	para "DEWGONG:"
	line "ICE/FAIRY"

	para "GRIMER:"
	line "POISON/GROUND"

	para "MUK:"
	line "POISON/GROUND"

	para "SHELLDER:"
	line "WATER/ROCK"

	para "CLOYSTER:"
	line "ICE/ROCK"

	para "GASTLY:"
	line "GHOST/DARK"

	para "HAUNTER:"
	line "GHOST/DARK"

	para "GENGAR:"
	line "GHOST/DARK"

	para "DROWZEE:"
	line "PSYCHIC/DARK"

	para "HYPNO:"
	line "PSYCHIC/DARK"

	para "KRABBY:"
	line "WATER/BUG"

	para "KINGLER:"
	line "WATER/BUG"

	para "VOLTORB:"
	line "ELECTRIC/FIRE"

	para "ELECTRODE:"
	line "ELECTRIC/FIRE"

	para "CUBONE:"
	line "GROUND/GHOST"

	para "MAROWAK:"
	line "GROUND/GHOST"

	para "HITMONLEE:"
	line "FIGHTING/GROUND"

	para "HITMONCHAN:"
	line "FIGHTING/NORMAL"

	para "HITMONTOP:"
	line "FIGHTING/FLYING"

	para "KOFFING:"
	line "POISON/FIRE"

	para "WEEZING:"
	line "POISON/FIRE"

	para "RHYDON:"
	line "ROCK/FIGHTING"

	para "RHYPERIOR:"
	line "ROCK/FIGHTING"

	para "HAPPINY:"
	line "FAIRY/FAIRY"

	para "CHANSEY:"
	line "FAIRY/FAIRY"

	para "BLISSEY:"
	line "FAIRY/FAIRY"

	para "TANGELA:"
	line "GRASS/DARK"

	para "TANGROWTH:"
	line "GRASS/DARK"

	para "SEADRA:"
	line "WATER/POISON"

	para "KINGDRA:"
	line "DRAGON/POISON"

	para "GOLDEEN:"
	line "WATER/NORMAL"

	para "SEAKING:"
	line "WATER/NORMAL"

	para "STARYU:"
	line "WATER/FAIRY"

	para "STARMIE:"
	line "WATER/FAIRY"

	para "ELEKID:"
	line "ELECTRIC/FIGHTING"

	para "ELECTABUZZ:"
	line "ELECTRIC/FIGHTING"

	para "ELECTIVIRE:"
	line "ELECTRIC/FIGHTING"

	para "MAGBY:"
	line "FIRE/DARK"

	para "MAGMAR:"
	line "FIRE/DARK"

	para "MAGMORTAR:"
	line "FIRE/DARK"

	para "TAUROS:"
	line "NORMAL/GROUND"

	para "GYARADOS:"
	line "WATER/DRAGON"

	para "PORYGON:"
	line "ELECTRIC/GHOST"

	para "PORYGON2:"
	line "ELECTRIC/GHOST"

	para "PORYGON-Z:"
	line "ELECTRIC/GHOST"

	para "KABUTO:"
	line "ROCK/BUG"

	para "KABUTOPS:"
	line "ROCK/BUG"

	para "AERODACTYL:"
	line "ROCK/DRAGON"

	para "DRATINI:"
	line "DRAGON/FAIRY"

	para "DRAGONAIR:"
	line "DRAGON/FAIRY"

	para "DRAGONITE:"
	line "DRAGON/FAIRY"
	prompt
