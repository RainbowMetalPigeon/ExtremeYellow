_AIBattleWithdrawText::
	text_ram wTrainerName
	text " with-"
	line "drew @"
	text_ram wEnemyMonNick
	text "!"
	prompt

_AIBattleUseItemText::
	text_ram wTrainerName
	text_start
	line "used @"
	text_ram wcd6d
	text_start
	cont "on @"
	text_ram wEnemyMonNick
	text "!"
	prompt

_BoxFullDebugText::
	text "The BOX is full!"
	done

_BoxWillBeClearedText::
	text "The BOX will be"
	line "cleared."
	done

_TradeWentToText::
	text_ram wStringBuffer
	text " went"
	line "to @"
	text_ram wLinkEnemyTrainerName
	text "."
	done

_TradeForText::
	text "For <PLAYER>'s"
	line "@"
	text_ram wStringBuffer
	text ","
	done

_TradeSendsText::
	text_ram wLinkEnemyTrainerName
	text " sends"
	line "@"
	text_ram wcd6d
	text "."
	done

_TradeWavesFarewellText::
	text_ram wLinkEnemyTrainerName
	text " waves"
	line "farewell as"
	done

_TradeTransferredText::
	text_ram wcd6d
	text " is"
	line "transferred."
	done

_TradeTakeCareText::
	text "Take good care of"
	line "@"
	text_ram wcd6d
	text "."
	done

_TradeWillTradeText::
	text_ram wLinkEnemyTrainerName
	text " will"
	line "trade @"
	text_ram wcd6d
	text_start
	done

_TradeforText::
	text "for <PLAYER>'s"
	line "@"
	text_ram wStringBuffer
	text "."
	done

_PlaySlotMachineText::
	text "A slot machine!"
	line "Want to play?"
	done

_OutOfCoinsSlotMachineText:: ; edited
	text "Damn!"
	line "Ran out of coins!"
	done

_BetHowManySlotMachineText::
	text "Bet how many"
	line "coins?"
	done

_StartSlotMachineText::
	text "Start!"
	done

_NotEnoughCoinsSlotMachineText::
	text "Not enough"
	line "coins!"
	prompt

_OneMoreGoSlotMachineText::
	text "One more "
	line "go?"
	done

_LinedUpText::
	text " lined up!"
	line "Scored @"
	text_ram wStringBuffer
	text " coins!"
	done

_NotThisTimeText::
	text "Not this time!"
	prompt

_YeahText::
	text "Yeah!@"
	text_end

_DexSeenOwnedText::
	text "#DEX   Seen:@"
	text_decimal wDexRatingNumMonsSeen, 1, 3
	text_start
	line "         Owned:@"
	text_decimal wDexRatingNumMonsOwned, 1, 3
	text_end

_DexRatingText::
	text "#DEX Rating<COLON>"
	done

_GymStatueText1::
	text_ram wGymCityName
	text_start
	line "#MON GYM"
	cont "LEADER: @"
	text_ram wGymLeaderName
	text_start

	para "WINNING TRAINERS:"
	line "<RIVAL>"
	done

_GymStatueText2::
	text_ram wGymCityName
	text_start
	line "#MON GYM"
	cont "LEADER: @"
	text_ram wGymLeaderName
	text_start

	para "WINNING TRAINERS:"
	line "<RIVAL>"
	cont "<PLAYER>"
	done

_ViridianCityPokecenterGuyText::
	text "#MON CENTERs"
	line "heal your tired,"
	cont "hurt or fainted"
	cont "#MON!"
	done

_PewterCityPokecenterGuyText::
	text "Yawn!"

	para "When JIGGLYPUFF"
	line "sings, #MON"
	cont "get drowsy..."

	para "...Me too..."
	line "Snore..."
	done

_CeruleanPokecenterGuyText:: ; edited
	text "BILL has lots of"
	line "#MON!"

	para "They collects rare"
	line "ones too!"
	done

_LavenderPokecenterGuyText::
	text "CUBONEs wear"
	line "skulls, right?"

	para "People will pay a"
	line "lot for one!"
	done

_MtMoonPokecenterBenchGuyText::
	text "If you have too"
	line "many #MON, you"
	cont "should store them"
	cont "via PC!"
	done

_RockTunnelPokecenterGuyText::
	text "I heard that"
	line "GHOSTs haunt"
	cont "LAVENDER TOWN!"
	done

_OchrePokecenterGuyText:: ; new
	text "There's so much to"
	line "do in this city!"

	para "I'll take a small"
	line "break before I"
	cont "keep exploring!"
	done

_ObsidianPokecenterGuyText:: ; new
	text "You have no idea"
	line "how difficult was"
	cont "to get me here."

	para "I won't move just"
	line "for TEAM ROCKET!"
	done

_VermilionPokecenterGuyText::
	text "It is true that a"
	line "higher level"
	cont "#MON will be"
	cont "more powerful..."

	para "But, all #MON"
	line "will have weak"
	cont "points against"
	cont "specific types."

	para "So, there is no"
	line "universally"
	cont "strong #MON."
	done

_CeladonCityPokecenterGuyText::
	text "If I had a BIKE,"
	line "I would go to"
	cont "CYCLING ROAD!"
	done

_FuchsiaCityPokecenterGuyText::
	text "If you're studying "
	line "#MON, visit"
	cont "the SAFARI ZONE."

	para "It has all sorts"
	line "of rare #MON."
	done

_CinnabarPokecenterGuyText::
	text "#MON can still"
	line "learn techniques"
	cont "after canceling"
	cont "evolution."

	para "Evolution can wait"
	line "until new moves"
	cont "have been learned."
	done

_SaffronCityPokecenterGuyText1::
	text "It would be great"
	line "if the ELITE FOUR"
	cont "came and stomped"
	cont "TEAM ROCKET!"
	done

_SaffronCityPokecenterGuyText2::
	text "TEAM ROCKET took"
	line "off! We can go"
	cont "out safely again!"
	cont "That's great!"
	done

_CeladonCityHotelText:: ; edited
	text "I came here all"
	line "the way from"
	cont "UNOVA!"

	para "It's my first"
	line "visit to KANTO."
	cont "I am liking"
	cont "CELADON a lot,"
	cont "and I am looking"
	cont "forward to visit"
	cont "OCHRE CITY and"
	cont "CINNABAR ISLAND!"
	done

_BookcaseText::
	text "Crammed full of"
	line "#MON books!"
	done

_NewBicycleText::
	text "A shiny new"
	line "BICYCLE!"
	done

_PushStartText::
	text "Push START to"
	line "open the MENU!"
	done

_SaveOptionText::
	text "The SAVE option is"
	line "on the MENU"
	cont "screen."
	done

_StrengthsAndWeaknessesText::
	text "All #MON types"
	line "have strong and"
	cont "weak points"
	cont "against others."
	done

_TimesUpText::
	text "PA: Ding-dong!"

	para "Time's up!"
	prompt

_GameOverText::
	text "PA: Your SAFARI"
	line "GAME is over!"
	done

_CinnabarGymQuizDummyIntroText::
	text "#MON Quiz!"

	para "Get it right and"
	line "the door opens to"
	cont "the next room!"

	para "Get it wrong and"
	line "face a trainer!"

	para "If you want to"
	line "conserve your"
	cont "#MON for the"
	cont "GYM LEADER..."

	para "Then get it right!"
	line "Here we go!"
	prompt

_CinnabarGymQuizIntroText::
	text "#MON Quiz!"

	para "Get it right and"
	line "the door opens to"
	cont "the next room!"

	para "Get it wrong and"
	line "face the trainer"
	cont "blocking the way!"

	para "If you want to"
	line "conserve your"
	cont "#MON for the"
	cont "GYM LEADER..."

	para "Then get it right!"
	line "Here we go!"
	para ""
	done

_CinnabarGymQuizShortIntroText::
	text "#MON Quiz!"

	line "Test your skill!"
	para ""
	done

_CinnabarQuizQuestionsText1::
	text "Does STEEL resist"
	line "DARK?"
	done

_CinnabarQuizQuestionsText2::
	text "Are there 17 types"
	line "of #MON?"
	done

_CinnabarQuizQuestionsText3::
	text "Are BUG attacks"
	line "super effective"
	cont "against as many"
	cont "types as FIGHTING"
	cont "is weak to?"
	done

_CinnabarQuizQuestionsText4::
	text "Can SLEEP POWDER"
	line "put to sleep"
	cont "GRASS #MON?"
	done

_CinnabarQuizQuestionsText5::
	text "Can VENUSAUR"
	line "evolve?"
	done

_CinnabarQuizQuestionsText6::
	text "Will you win the"
	line "next battle?"
	done

_CinnabarGymQuizCorrectText::
	text "You're absolutely"
	line "correct!"

	para "Go on through!@"
	text_end

_CinnabarGymQuizIncorrectText::
	text "Sorry! Bad call!"
	prompt

_MagazinesText::
	text "#MON magazines!"

	para "#MON notebooks!"

	para "#MON graphs!"
	done

_BillsHouseMonitorText::
	text "TELEPORTER is"
	line "displayed on the"
	cont "PC monitor."
	done

_BillsHouseInitiatedText::
	text "<PLAYER> initiated"
	line "TELEPORTER's Cell"
	cont "Separator!@"
	text_end

_BillsHousePokemonListText1::
	text "BILL's favorite"
	line "#MON list!"
	prompt

_BillsHousePokemonListText2::
	text "Which #MON do"
	line "you want to see?"
	done

_OakLabEmailText::
	text "There's an e-mail"
	line "message here!"

	para "..."

	para "Calling all"
	line "#MON trainers!"

	para "The elite trainers"
	line "of #MON LEAGUE"
	cont "are ready to take"
	cont "on all comers!"

	para "Bring your best"
	line "#MON and see"
	cont "how you rate as a"
	cont "trainer!"

	para "#MON LEAGUE HQ"
	line "INDIGO PLATEAU"

	para "PS: PROF.OAK,"
	line "please visit us!"
	cont "..."
	done

_GameCornerCoinCaseText::
	text "A COIN CASE is"
	line "required!"
	done

_GameCornerNoCoinsText::
	text "You don't have"
	line "any coins!"
	done

_GameCornerOutOfOrderText::
	text "OUT OF ORDER"
	line "This is broken."
	done

_GameCornerOutToLunchText::
	text "OUT TO LUNCH"
	line "This is reserved."
	done

_GameCornerSomeonesKeysText::
	text "Someone's keys!"
	line "They'll be back."
	done

_JustAMomentText::
	text "Just a moment."
	done

TMNotebookText:: ; edited
	text "It's a pamphlet"
	line "on TMs."

	para "..."

	para "There are 55 TMs"
	line "in total."

	para "There are also 5"
	line "HMs that can be"
	cont "used repeatedly."

	para "SILPH CO.@"
	text_end

_TurnPageText::
	text "Turn the page?"
	done

_ViridianSchoolNotebookText6::
	text "KID: Hey! Don't"
	line "look at my notes!@"
	text_end

_ViridianSchoolNotebookText1:: ; edited
	text "Looked at the"
	line "notebook!"

	para "First page..."

	para "The goal for"
	line "#MON trainers"
	cont "is to beat the "
	cont "top 8 #MON"
	cont "GYM LEADERs."

	para "Do so to earn the"
	line "right to face..."

	para "The ELITE FOUR of"
	line "#MON LEAGUE!"
	prompt

_ViridianSchoolNotebookText2:: ; edited
	text "Second page..."

	para "The 8 GYMs can be"
	line "challenged in any"
	cont "order."

	para "The GYM LEADER and"
	line "their trainers"
	cont "will choose a"
	cont "team adequate to"
	cont "the level of the"
	cont "challenger."

	para "The more BADGEs"
	line "you've already"
	cont "earned, the"
	cont "tougher the GYMs"
	cont "will be!"
	prompt

_ViridianSchoolNotebookText3:: ; edited
	text "Third page..."

	para "High-level #MON"
	line "will disobey you"
	cont "if you don't have"
	cont "enough BADGEs!"

	para "This applies both"
	line "to #MON"
	cont "obtained via"
	cont "trade, and to the"
	cont "ones you caught"
	cont "yourself."
	prompt

_ViridianSchoolNotebookText4:: ; edited
	text "Fourth page..."

	para "CONFUSION, LEECH"
	line "SEEDs, CURSE, and"
	cont "modification to"
	cont "stats are reset"
	cont "upon switching."

	para "A temporary"
	line "retreat can have"
	cont "strategic value!"
	prompt

_ViridianSchoolNotebookText5:: ; new
	text "Fifth page..."

	para "INVERSE BATTLES"
	line "are a new style"
	cont "of #MON"
	cont "battles, recently"
	cont "arrived from a"
	cont "faraway region."

	para "During an INVERSE"
	line "BATTLE, the usual"
	cont "resistances and"
	cont "weaknesses are"
	cont "inverted!"

	para "Only elite train-"
	line "ers can engage in"
	cont "this extreme test"
	cont "of your knowledge"
	cont "and flexibility!"
	prompt

_EnemiesOnEverySideText::
	text "Enemies on every"
	line "side!"
	done

_WhatGoesAroundComesAroundText::
	text "What goes around"
	line "comes around!"
	done

_FightingDojoText::
	text "FIGHTING DOJO"
	done

_IndigoPlateauHQText::
	text "INDIGO PLATEAU"
	line "#MON LEAGUE HQ"
	done

_RedBedroomSNESText:: ; edited
	text "<PLAYER> is playing"
	line "the Switch!"

	para "A mesmerizing"
	line "open-world with"
	cont "such a variety of"
	cont "biomes, secrets,"
	cont "details, shrines,"
	cont "quests...!"

	para "It's beautiful,"
	line "but it's time to"
	cont "live our own"
	cont "great adventure!"
	done

_AerodactylFossilText::
	text "AERODACTYL Fossil"
	line "A primitive and"
	cont "rare #MON."
	done

_KabutopsFossilText::
	text "KABUTOPS Fossil"
	line "A primitive and"
	cont "rare #MON."
	done

_FanClubPicture1Text::
	text "My cute RAPIDASH."
	done

_FanClubPicture2Text::
	text "My beloved FEAROW."
	done

_LinkCableHelpText1::
	text "TRAINER TIPS"

	para "Using a Game Link"
	line "Cable"
	prompt

_LinkCableHelpText2::
	text "Which STATUS do" ; edited
	line "you want to read?"
	done

_LinkCableInfoText1::
	text "When you have"
	line "linked your GAME"
	cont "BOY with another"
	cont "GAME BOY, talk to"
	cont "the attendant on"
	cont "the right in any"
	cont "#MON CENTER."
	prompt

_LinkCableInfoText2::
	text "COLOSSEUM lets"
	line "you play against"
	cont "a friend."
	prompt

_LinkCableInfoText3::
	text "TRADE CENTER is"
	line "used for trading"
	cont "#MON."
	prompt

_ViridianSchoolBlackboardText1:: ; edited
	text "The blackboard"
	line "describes"
	cont "non-volatile"
	cont "STATUS changes"
	cont "that persist even"
	cont "after battle."
	prompt

_ViridianSchoolBlackboardText2:: ; edited
	text "Which STATUS do"
	line "you want to read?"
	done

_ViridianBlackboardSleepText::
	text "A #MON can't"
	line "attack if it's"
	cont "asleep!"

	para "SLEEP lasts 1 to" ; new
	line "7 turns. #MON"
	cont "cannot attack on"
	cont "the same turn"
	cont "they wake up."

	para "Use AWAKENING to"
	line "wake them up!"
	prompt

_ViridianBlackboardPoisonText::
	text "When poisoned, a" ; edited
	line "#MON loses 1/8"
	cont "of its max HP at"
	cont "the end of every"
	cont "of its turns."

	para "If a #MON is" ; new
	line "affected by TOXIC"
	cont "poison, it'll lose"
	cont "N/8 of its max"
	cont "HP on turn N."

	para "A poisoned #MON" ; new
	line "takes damage even"
	cont "when walking!"

	para "Use an ANTIDOTE"
	line "to cure poison!"
	prompt

_ViridianBlackboardPrlzText::
	text "Paralysis makes" ; edited
	line "#MON miss"
	cont "their moves 25%"
	cont "of the time!"

	para "It also reduces" ; new
	line "SPEED by 75%."

	para "Use PARLYZ HEAL"
	line "for treatment!"
	prompt

_ViridianBlackboardBurnText::
	text "A burn halves" ; edited
	line "physical attack."

	para "It also causes"
	line "ongoing damage"
	cont "equal to 1/8 of"
	cont "the #MON max"
	cont "HP at every turn."

	para "Use BURN HEAL to"
	line "cure a burn!"
	prompt

_ViridianBlackboardFrozenText::
	text "If frozen, a"
	line "#MON becomes"
	cont "totally immobile!"

	para "It thaws if hit by" ; new
	line "a FIRE move."

	para "Use ICE HEAL to"
	line "thaw out #MON!"
	prompt

_VermilionGymTrashText::
	text "Nope, there's"
	line "only trash here."
	done

_VermilionGymTrashSuccessText1::
	text "Hey! There's a"
	line "switch under the"
	cont "trash!"
	cont "Turn it on!"

	para "The 1st electric"
	line "lock opened!@"
	text_end

;_VermilionGymTrashSuccessText2::
;	text "Hey! There's"
;	line "another switch"
;	cont "under the trash!"
;	cont "Turn it on!"
;	prompt

_VermilionGymTrashSuccessText3::
	text "The 2nd electric"
	line "lock opened!"

	para "The motorized door"
	line "opened!@"
	text_end

_VermilionGymTrashFailText::
	text "Nope! There's"
	line "only trash here."
	cont "Hey! The electric"
	cont "locks were reset!@"
	text_end

_FoundHiddenItemText::
	text "<PLAYER> found"
	line "@"
	text_ram wcd6d
	text "!@"
	text_end

_HiddenItemBagFullText::
	text "But, <PLAYER> has"
	line "no more room for"
	cont "other items!"
	done

_FoundHiddenCoinsText::
	text "<PLAYER> found"
	line "@"
	text_bcd hCoins, 2 | LEADING_ZEROES | LEFT_ALIGN
	text " coins!@"
	text_end

_FoundHiddenCoins2Text::
	text "<PLAYER> found"
	line "@"
	text_bcd hCoins, 2 | LEADING_ZEROES | LEFT_ALIGN
	text " coins!@"
	text_end

_DroppedHiddenCoinsText::
	text_start
	para "Oops! Dropped"
	line "some coins!"
	done

_IndigoPlateauStatuesText1::
	text "INDIGO PLATEAU"
	prompt

_IndigoPlateauStatuesText2::
	text "The ultimate goal"
	line "of trainers!"
	cont "#MON LEAGUE HQ"
	done

_IndigoPlateauStatuesText3::
	text "The highest"
	line "#MON authority"
	cont "#MON LEAGUE HQ"
	done

_PokemonBooksText::
	text "Crammed full of"
	line "#MON books!"
	done

_DiglettSculptureText:: ; edited
	text "It's a buddhist"
	line "altar."
	done

_ElevatorText::
	text "This is an"
	line "elevator."
	done

_TownMapText::
	text "A TOWN MAP.@"
	text_end

_PokemonStuffText::
	text "Wow! Tons of"
	line "#MON stuff!"
	done

_OutOfSafariBallsText::
	text "PA: Ding-dong!"

	para "You are out of"
	line "SAFARI BALLs!"
	prompt

_WildRanText::
	text "Wild @"
	text_ram wEnemyMonNick
	text_start
	line "ran!"
	prompt

_EnemyRanText::
	text "Enemy @"
	text_ram wEnemyMonNick
	text_start
	line "ran!"
	prompt

_HurtByPoisonText::
	text "<USER>'s"
	line "hurt by poison!"
	prompt

_HurtByBurnText::
	text "<USER>'s"
	line "hurt by the burn!"
	prompt

_HurtByLeechSeedText::
	text "LEECH SEED saps"
	line "<USER>!"
	prompt

_HurtByCurseText:: ; new
	text "The CURSE torments"
	line "<USER>!"
	prompt

_PikachuHealItself:: ; new
	text "@"
	text_ram wBattleMonNick
	text " healed"
	line "itself from"
	cont "all conditions!"
	prompt

_EnemyMonFaintedText::
	text "Enemy @"
	text_ram wEnemyMonNick
	text_start
	line "fainted!"
	prompt

_MoneyForWinningText::
	text "<PLAYER> got ¥@"
	text_bcd wAmountMoneyWon, 3 | LEADING_ZEROES | LEFT_ALIGN
	text_start
	line "for winning!"
	prompt

_TrainerDefeatedText::
	text "<PLAYER> defeated"
	line "@"
	text_ram wTrainerName
	text "!"
	prompt

_PlayerMonFaintedText::
	text_ram wBattleMonNick
	text_start
	line "fainted!"
	prompt

_UseNextMonText::
	text "Use next #MON?"
	done

_Rival1WinText::
	text "<RIVAL>: Yeah! Am"
	line "I great or what?"
	prompt

_PlayerBlackedOutText2::
	text "<PLAYER> is out of"
	line "useable #MON!"

	para "<PLAYER> blacked"
	line "out!"
	prompt

_LinkBattleLostText::
	text "<PLAYER> lost to"
	line "@"
	text_ram wTrainerName
	text "!"
	prompt

_TrainerAboutToUseText::
	text_ram wTrainerName
	text " is"
	line "about to use"
	cont"@"
	text_ram wEnemyMonNick
	text "!"

	para "Will <PLAYER>"
	line "change #MON?"
	done

_TrainerSentOutText::
	text_ram wTrainerName
	text " sent"
	line "out @"
	text_ram wEnemyMonNick
	text "!"
	done

_NoWillText::
	text "There's no will"
	line "to fight!"
	prompt

_CantEscapeText::
	text "Can't escape!"
	prompt

;_NoRunningText::
;	text "No! There's no"
;	line "running from a"
;	cont "trainer battle!"
;	prompt

_WannaSurrenderText:: ; new
	text "Do you want to"
	line "surrender?"
	done

_AreYouSureText:: ; new
	text "Are you sure to"
	line "surrender?"
;	xxxx "123456789012345678"
	done

_LetsNotGiveUpYet:: ; new
	text "Let's not give up"
	line "just yet!"
;	xxxx "123456789012345678"
	prompt

_PlayerGaveUpText:: ; new
	text "<PLAYER> gave up!"

	para "<PLAYER> blacked"
	line "out!"
	prompt

_NoRunningFromMissingnoText:: ; new
	text "MISSINGNO.: nNnn000!!!"
	line "  y0 u cann0 00 t"
	cont "          es cape!!"

	para " H3 RE M UST D1E!!!!!"
;	xxxx "123456789012345678"
	prompt

_GotAwayText::
	text "Got away safely!"
	prompt

_RunAwayText::
	text "Hurry, get away!"
	prompt

_ItemsCantBeUsedHereText::
	text "Items can't be"
	line "used here."
	prompt

_AlreadyOutText::
	text_ram wBattleMonNick
	text " is"
	line "already out!"
	prompt

_MoveNoPPText::
	text "No PP left for"
	line "this move!"
	prompt

_MoveDisabledText::
	text "The move is"
	line "disabled!"
	prompt

_NoMovesLeftText::
	text_ram wBattleMonNick
	text " has no"
	line "moves left!"
	done

_MultiHitText::
	text "Hit the enemy"
	line "@"
	text_decimal wPlayerNumHits,1,1
	text " times!"
	prompt

_ScaredText::
	text_ram wBattleMonNick
	text " is too"
	line "scared to move!"
	prompt

_FrozenInTerrorText:: ; new
	text_ram wBattleMonNick
	text " is"
	line "frozen in terror."
	prompt

_GetOutText::
	text "GHOST: Get out..."
	line "Get out..."
	prompt

_HauntedHouseMonsText:: ; new
	text "ABOMINATION: Fool."
	line "You're dead now."
	prompt

_FastAsleepText::
	text "<USER>"
	line "is fast asleep!"
	prompt

_WokeUpText::
	text "<USER>"
	line "woke up!"
	prompt

_IsFrozenText::
	text "<USER>"
	line "is frozen solid!"
	prompt

_FullyParalyzedText::
	text "<USER>'s"
	line "fully paralyzed!"
	prompt

_FlinchedText::
	text "<USER>"
	line "flinched!"
	prompt

_MustRechargeText::
	text "<USER>"
	line "must recharge!"
	prompt

_DisabledNoMoreText::
	text "<USER>'s"
	line "disabled no more!"
	prompt

_IsConfusedText::
	text "<USER>"
	line "is confused!"
	prompt

_HurtItselfText::
	text "It hurt itself in"
	line "its confusion!"
	prompt

_ConfusedNoMoreText::
	text "<USER>'s"
	line "confused no more!"
	prompt

_SavingEnergyText::
	text "<USER>"
	line "is saving energy!"
	prompt

_UnleashedEnergyText::
	text "<USER>"
	line "unleashed energy!"
	prompt

_ThrashingAboutText::
	text "<USER>'s"
	line "thrashing about!"
	done

_AttackContinuesText::
	text "<USER>'s"
	line "attack continues!"
	done

_CantMoveText::
	text "<USER>"
	line "can't move!"
	prompt

_MoveIsDisabledText::
	text "<USER>'s"
	line "@"
	text_ram wcd6d
	text " is"
	cont "disabled!"
	prompt

_MonName1Text::
	text "<USER>@"
	text_end

_Used1Text::
	text_start
	line "used @"
	text_end

_InsteadText::
	text "instead,"
	cont "@"
	text_end

_MoveNameText::
	text_ram wStringBuffer
	text "@"

_ExclamationPoint1Text:: ; removed the other copies
	text "!"
	done

_AttackMissedText::
	text "<USER>'s"
	line "attack missed!"
	prompt

_KeptGoingAndCrashedText::
	text "<USER>"
	line "kept going and"
	cont "crashed!"
	prompt

_UnaffectedText::
	text "<TARGET>'s"
	line "unaffected!"
	prompt

_DoesntAffectMonText::
	text "It doesn't affect"
	line "<TARGET>!"
	prompt

_CriticalHitText::
	text "Critical hit!"
	prompt

_OHKOText::
	text "One-hit KO!"
	prompt

_LoafingAroundText::
	text_ram wBattleMonNick
	text " is"
	line "loafing around."
	prompt

_BeganToNapText::
	text_ram wBattleMonNick
	text " began"
	line "to nap!"
	prompt

_WontObeyText::
	text_ram wBattleMonNick
	text " won't"
	line "obey!"
	prompt

_TurnedAwayText::
	text_ram wBattleMonNick
	text " turned"
	line "away!"
	prompt

_IgnoredOrdersText::
	text_ram wBattleMonNick
	text_start
	line "ignored orders!"
	prompt

_SubstituteTookDamageText::
	text "The SUBSTITUTE"
	line "took damage for"
	cont "<TARGET>!"
	prompt

_SubstituteBrokeText::
	text "<TARGET>'s"
	line "SUBSTITUTE broke!"
	prompt

_BuildingRageText::
	text "<USER>'s"
	line "RAGE is building!"
	prompt

_MirrorMoveFailedText::
	text "The MIRROR MOVE"
	next "failed!"
	prompt

_HitXTimesText::
	text "Hit @"
	text_decimal wEnemyNumHits, 1, 1
	text " times!"
	prompt

_GainedText::
	text_ram wcd6d
	text " gained"
	line "@"
	text_end

_GainedTextMissigNo:: ; new
	text "MISSINGNO refused"
	line "to gain EXP!"
	prompt

_WithExpAllText::
	text "with EXP.ALL,"
	cont "@"
	text_end

_BoostedText::
	text "a boosted"
	cont "@"
	text_end

_ExpPointsText::
	text_decimal wExpAmountGained, 2, 4
	text " EXP. Points!"
	prompt

_GrewLevelText::
	text_ram wcd6d
	text " grew"
	line "to level @"
	text_decimal wCurEnemyLVL, 1, 3
	text "!@"
	text_end

_SuperEffectiveText::
	text "It's super"
	line "effective!"
	prompt

_NotVeryEffectiveText::
	text "It's not very"
	line "effective..."
	prompt

_ReallyNotVeryEffectiveText:: ; new
	text "It's double not"
	line "very effective..."
	prompt

_DoubleSuperEffectiveText:: ; new
	text "It's double"
	line "super effective!"
	prompt

_SafariZoneEatingText::
	text "Wild @"
	text_ram wEnemyMonNick
	text_start
	line "is eating!"
	prompt

_SafariZoneAngryText::
	text "Wild @"
	text_ram wEnemyMonNick
	text_start
	line "is angry!"
	prompt

_WildMonAppearedText::
	text "Wild @"
	text_ram wEnemyMonNick
	text_start
	line "appeared!"
	prompt

_HookedMonAttackedText:: ; edited, 2-liner
	text "Hooked @"
	text_ram wEnemyMonNick
	text_start
	line "appeared!"
	prompt

; new ----------------------------------------------------------

_PartyMenuTutorText::
	text "Teach move to"
	line "which #MON?"
	done

_BoyGirlText::
    text "Are you a boy"
    line "or a girl?"
    done

_CantUsePCHere:: ; for portablePC
	text "You cannot use"
	line "this here!"
	prompt

_TextAskRematch:: ; to reactivate trainers
	text "Rematch?"
	done

_MapMessage::
	text "Some parts of an"
	line "uncanny map..."
	done

_MapMessageComplete::
	text "The complete map!"
	line "It looks eerie..."
	done

_WeatherSunnyDayStillText::
	text "The sunlight is"
	line "strong!"
	prompt

_WeatherRainDanceStillText::
	text "Rain continues"
	line "to fall!"
	prompt

_WeatherSandstormStillText::
	text "The sandstorm"
	line "rages!"
	prompt

_WeatherHailStillText::
	text "Hail continues"
	line "to fall!"
	prompt

_WeatherBackToNormalText::
	text "The weather is"
	line "back to normal!"
	prompt

_HurtBySandstormText::
	text "<USER>'s"
	line "hurt by the sand!"
	prompt

_HurtByHailText::
	text "<USER>'s"
	line "hurt by the hail!"
	prompt

_TerrainGrassyStillText::
	text "The terrain is"
	line "still grassy!"
	prompt

_TerrainElectricStillText::
	text "The terrain is"
	line "still electric!"
	prompt

_TerrainMistyStillText::
	text "The terrain is"
	line "still misty!"
	prompt

_TerrainPsychichStillText::
	text "The terrain is"
	line "still psychic!"
	prompt

_TerrainBackToNormalText::
	text "The terrain is"
	line "back to normal!"
	prompt

_HealedByGrassyTerrainText::
	text "<USER>'s"
	line "healed by grass!"
	prompt

_NoPrioritiesDueToTerrainText::
	text "No priority moves"
	line "due to terrain!"
	prompt

_TrickRoomGotSetText::
	text "The trick room"
	line "got set!"
	prompt

_TrickRoomGotRemovedText::
	text "The trick room"
	line "got removed!"
	prompt

_TrickRoomStillActiveText::
	text "The trick room"
	line "is still active!"
	prompt

_TrickRoomExpiredText::
	text "The trick room"
	line "has expired!"
	prompt

_SeviiTicketUpTo3::
	text "Allows to travel"
	line "to the first 3 of"
	cont "SEVII ISLANDS!"
	prompt

_SeviiTicketUpTo5::
	text "Allows to travel"
	line "to the first 5 of"
	cont "SEVII ISLANDS!"
	prompt

_SeviiTicketUpTo8::
	text "Allows to travel"
	line "to all of the"
	cont "SEVII ISLANDS!"
	prompt

_SpikesScatteredOnFieldText::
	text "<TARGET>'s"
	line "field is full of"
	cont "pointy spikes!"
	prompt

_ToxicSpikesScatteredOnFieldText::
	text "<TARGET>'s"
	line "field is full of"
	cont "toxic spikes!"
	prompt

_StickyWebOnFieldText::
	text "<TARGET>'s"
	line "field got sticky!"
	prompt

_FloatingRocksOnFieldText::
	text "<TARGET>'s"
	line "field is full of"
	cont "floating rocks!"
	prompt

_CannotAddMoreOfThisText::
	text "Can't add any more"
	line "of this!"
	prompt

_AllHazardsRemovedText::
	text "<USER>"
	line "cleared its field"
	cont "from all hazards!"
	prompt

;	xxxx "123456789012345678"
