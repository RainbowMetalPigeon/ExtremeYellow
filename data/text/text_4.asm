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
	text "names"
	prompt
_PersonalizationInfoTextTypes::
	text "types"
	prompt
_PersonalizationInfoTextSound::
	text "sound"
	prompt

; randomization ------

_RandomizationInfoTextWildMons::
	text "wild mons"
	prompt

_RandomizationInfoTextEnemyTeams::
	text "enemy teams"
	line "test 1"
	cont "test 2"
	cont "test 3"
	prompt

_RandomizationInfoTextTypeChart::
	text "type chart"
	prompt

_RandomizationInfoTextItems::
	text "items"
	prompt


; battle luck --------

_LuckInfoTextAccuracy::
	text "accuracy"
	prompt

_LuckInfoTextRoll::
	text "roll"
	prompt

_LuckInfoTextCrits::
	text "crits"
	prompt

_LuckInfoTextEffects::
	text "effects"
	prompt

_LuckInfoTextStatus::
	text "status"
	prompt


; start options ------

_OptionsInfoTextTextSpeed::
	text "text speed"
	prompt

_OptionsInfoTextAnimation::
	text "animation"
	prompt

_OptionsInfoTextBattleStyle::
	text "style"
	prompt

_OptionsInfoTextCap::
	text "cap"
	prompt

_OptionsInfoTextBadgeBoost::
	text "badge boost"
	prompt

_OptionsInfoTextLevelScale::
	text "level scale"
	prompt

_OptionsInfoTextExpGain::
	text "exp gain"
	prompt
