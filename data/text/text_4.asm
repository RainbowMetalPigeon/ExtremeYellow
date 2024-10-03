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

_PersonalizationInfoTextNames::
	text "Change #MON"
	line "names between"
	cont "English,"
	cont "gender-neutral,"
	cont "and Japanese."
	prompt

_PersonalizationInfoTextTypes::
	text "Some selected"
	line "#MON have"
	cont "their typing"
	cont "altered."
	prompt

_PersonalizationInfoTextSound::
	text "EARPHONE1 is"
	line "stereo, 2 focuses"
	cont "on left side, 3"
	cont "on right side."
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
