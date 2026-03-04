_CableClubNPCPleaseWaitText::
	text "Please wait.@"
	text_end

_CableClubNPCLinkClosedBecauseOfInactivityText::
	vc_patch Change_link_closed_inactivity_message
IF DEF(_YELLOW_VC)
	text "Please come again!"
	done
	text_start
	text "sed because of"
	cont "inactivity."
ELSE
	text "The link has been"
	line "closed because of"
	cont "inactivity."
ENDC
	vc_patch_end

	para "Please contact"
	line "your friend and"
	cont "come again!"
	done

_CableClubNPCPleaseComeAgainText::
	text "Please come again!"
	done

_CableClubNPCMakingPreparationsText::
	text "We're making"
	line "preparations."
	cont "Please wait."
	done

_FlashLightsAreaText::
	text "A blinding FLASH"
	line "lights the area!"
	prompt

_PokedexOrAttackdex:: ; new, testing
	text "What DEX category"
	line "to visualize?"
	done

_WarpToLastPokemonCenterText::
	text "Warp to the last"
	line "#MON CENTER."
	done

_CannotUseTeleportNowText::
	text_ram wcd6d
	text " can't"
	line "use TELEPORT now."
	prompt

_CannotFlyHereText::
	text_ram wcd6d
	text " can't"
	line "FLY here."
	prompt

_NotHealthyEnoughText::
	text "Not healthy"
	line "enough."
	prompt

_NewBadgeRequiredText::
	text "No! A new BADGE"
	line "is required."
	prompt

_CannotUseItemsHereText::
	text "You can't use items"
	line "here."
	prompt

_CannotGetOffHereText::
	text "You can't get off"
	line "here."
	prompt

_UsedStrengthText::
	text_ram wcd6d
	text " used"
	line "STRENGTH.@"
	text_end

_CanMoveBouldersText::
	text_ram wcd6d
	text " can"
	line "move boulders."
	prompt

_CanMoveBouldersText2:: ; new
	text "Your #MON can"
	line "move boulders!"
	done

_CurrentTooFastText::
	text "The current is"
	line "much too fast!"
	prompt

_CyclingIsFunText::
	text "Cycling is fun!"
	line "Forget SURFing!"
	prompt

_GotMonText::
	text "<PLAYER> got"
	line "@"
	text_ram wcd6d
	text "!@"
	text_end

_SentToBoxText::
	text "There's no more"
	line "room for #MON!"
	cont "@"
	text_ram wBoxMonNicks
	text " was"
	cont "sent to #MON"
	cont "BOX @"
	text_ram wStringBuffer
	text " on PC!"
	done

_BoxIsFullText::
	text "There's no more"
	line "room for #MON!"

	para "The #MON BOX"
	line "is full and can't"
	cont "accept any more!"

	para "Change the BOX at"
	line "a #MON CENTER!"
	done

; new ------------------------

_YouCannotDiveHereText::
	text "You cannot DIVE"
	line "here!"
;	xxxx "123456789012345678"
	prompt

_DiveMessageGoUnderText2::
	text_ram wcd6d
	text " DIVEs"
;	xxxx "123456789012345678"
	line "underwater!"
	prompt

_DiveMessageGoAboveText2::
	text_ram wcd6d
	text " DIVEs"
;	xxxx "123456789012345678"
	line "back to surface!"
	prompt

_UsedWhirlpoolText2::
	text_ram wcd6d
	text " stops"
;	xxxx "123456789012345678"
	line "the WHIRLPOOL!"
	prompt

_CannotUseWhirpoolText::
	text "You cannot use"
	line "WHIRLPOOL here!"
;	xxxx "123456789012345678"
	prompt

_UsedWaterfallText2::
	text_ram wcd6d
	text " rides"
;	xxxx "123456789012345678"
	line "the WATERFALL!"
	prompt

_CannotUseWaterfallText::
	text "You cannot use"
	line "WATEFALL here!"
;	xxxx "123456789012345678"
	prompt

_UsedRockClimbText2::
	text_ram wcd6d
	text " CLIMBs"
;	xxxx "123456789012345678"
	line "the ROCK!"
	prompt

_CannotUseRockClimbText::
	text "You cannot use"
	line "ROCK CLIMB here!"
;	xxxx "123456789012345678"
	prompt

_UsedRockSmashText2::
	text_ram wcd6d
	text " SMASHes"
;	xxxx "123456789012345678"
	line "the ROCK!"
	prompt

_CannotUseRockSmashText3::
	text "You cannot use"
	line "ROCK SMASH here!"
;	xxxx "123456789012345678"
	prompt
