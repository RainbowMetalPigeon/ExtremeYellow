# ExtremeYellow Dialogue Review — Typos & Awkward Grammar

Full sweep of `text/*.asm` and the dialogue-bearing files in `data/text/*.asm` (item descriptions, system/menu strings, rocket-path battle intros). Entries note "may need re-wrap" where a fix changes the character count of a line, since in-game text boxes are fixed-width (~18 chars/line) and re-splitting across `line`/`cont`/`para` wasn't attempted here.

**227 typo/mistake findings, 316 awkward-grammar findings** across all 269 dialogue files.

## Typos & Mistakes

| File | Label | Original | Suggested Fix | Note |
| --- | --- | --- | --- | --- |
| data/text/item_descriptions.asm | _PearlDescription | "Fabolous pearl." | "Fabulous pearl." |  |
| data/text/item_descriptions.asm | _HM05Description | "Brigthen caves" | "Brighten caves" |  |
| data/text/item_descriptions.asm | _TM17Description | "DRAININGKISS" | "DRAINING KISS" | missing space; every other multi-word move name in the list has a space |
| data/text/item_descriptions.asm | _MaxElixerDescription | "Fully restores the" "PP of one #MON." | "Fully restores the" "PP of all moves." | PP belongs to moves, not #MON; ElixerDescription (non-Max) correctly says "of all moves" |
| data/text/text_2.asm | _DiglettSculptureText | "It's a buddhist" "altar." | "It's a Buddhist altar." | capitalization |
| data/text/text_2.asm | _ViridianBlackboardBurnText | "the #MON max" "HP at every turn." | "the #MON's max HP at every turn." | missing possessive; may need re-wrap |
| data/text/text_3.asm | _BoxFullText | "This Box is full of #MON." | "This BOX is full of #MON." | inconsistent with "BOX" used fully capitalized elsewhere |
| data/text/text_3.asm | _MonWasStoredText | "was stored in Box @" | "was stored in BOX @" | inconsistent with "BOX" used fully capitalized elsewhere |
| data/text/text_4.asm | _PersonalizationInfoTextTypeChart | "In can be viewed in the #DEX." | "It can be viewed in the #DEX." |  |
| data/text/text_4.asm | _PersonalizationInfoTextTCGMode | "for moves, chart, and pokeMON." | "for moves, chart, and #MON." | inconsistent with placeholder token used elsewhere |
| data/text/text_4.asm | _RandomizationInfoTextEvolutions | "Every #MON evolves randomly in any other one at every level." | "Every #MON evolves randomly into any other one at every level." |  |
| data/text/text_8.asm | _CannotUseWaterfallText | "You cannot use WATEFALL here!" | "You cannot use WATERFALL here!" |  |
| data/text/text_rocket_path_1.asm | _RocketNPCText_RocketPath_4 | "you'll be rewarder!" | "you'll be rewarded!" |  |
| data/text/text_rocket_path_1.asm | _GenericNPCText_RocketPath_21 | "Maybe a sense of directionless," | "Maybe a sense of directionlessness," | may need re-wrap |
| text/AgathasRoom.asm | _AgathaAfterBattleTextRematch2 | "maybe even brigther than theirs!" | "maybe even brighter than theirs!" |  |
| text/AgathasRoom.asm | _AgathaBeforeBattleText_RP_Pink | "since you ruiend our lives" | "since you ruined our lives" |  |
| text/AgathasRoom.asm | _AgathaBeforeBattleTextRematch | "SAMUEL's grankid have done" | "SAMUEL's grandkid have done" | same file later spells it "grandkid" correctly |
| text/AgathasRoom.asm | _AgathaAfterBattleText_RP | "such a disdain for what's good and worth." | "...what's good and worthy." |  |
| text/BattleFacility.asm | _BattleFacilityTextGuide_Info | "No prizes are given off in this mode" | "No prizes are given out in this mode" |  |
| text/BattleFacility.asm | _BattleFacilityTextGuide_InfoFull | "No prizes are given off in this mode" | "No prizes are given out in this mode" |  |
| text/BattleFacility.asm | _BattleFacilityTextGuide_InfoFull | "You can find all these info on the sign near the PC." | "all this info on the sign" |  |
| text/BattleFacility.asm | _BattleFacilityText_NextBattle | "Let's continue with battle N. @" | "battle No. @" | may need re-wrap |
| text/BluesHouse.asm | _DaisyPostGiveMapText | "under a mask of arrogance and fake selfconfidence..." | "...fake self-confidence..." |  |
| text/BluesHouse.asm | _DaisyInitialText | "While I was doing some researches, I stumbled upon" | "While I was doing some research, I stumbled upon" |  |
| text/BluesHouse.asm | _BluesHouseSignText1 | "for some reasons it has a sad feeling on it" | "for some reason it has a sad feeling on it" |  |
| text/BluesHouse.asm | _BluesHouseSignText2 | "There are two open broswer tabs." | "There are two open browser tabs." |  |
| text/BrunosRoom.asm | _BrunoBeforeBattleText_RP | "Let's FIGHTING!" | "Let's FIGHT!" |  |
| text/BrunosRoom.asm | _BrunoBeforeBattleTextRematch2 | "you're working to become even more strong." | "you're working to become even stronger." |  |
| text/CeladonChiefHouse.asm | _LunarShrineMonkText_RelicNotInBag | "Well, I would invite to leave, if you please." | "Well, I would invite you to leave, if you please." | "you" missing (compare sibling text "_RelicInBag_FirstTime" which has it correctly); may need re-wrap |
| text/CeladonChiefHouse.asm | _LunarShrineMonkText_RelicInBag_NotFirstTime | "It has been more than half a century it has been missing..." | "It has been missing for more than half a century now..." | duplicated verb phrase reads garbled; may need re-wrap |
| text/CeladonDiner.asm | _CeladonDinerText1_OhYouHaveGutschein | "GUTSCHEIN -I mean, a voucher" | "GUTSCHEIN - I mean, a voucher" | missing space after hyphen; may need re-wrap |
| text/CeladonGym.asm | _CeladonGymGuidePreBattleText | "they suffer ICE, BUGs, FIRE" | "they suffer ICE, BUG, FIRE" | inconsistent pluralization of type name (elsewhere "BUG" singular) |
| text/CeladonGym.asm | _ErikaRainbowBadgeInfoText | "use DIVE out of battle." | "use DIVE outside of battle." | inconsistent phrasing vs. _SabrinaMarshBadgeInfoText's "outside of battle"; may need re-wrap |
| text/CeladonGym.asm | _ErikaRematchPreBattleText | "...Oh! Salutation, CHAMPION." | "...Oh! Salutations, CHAMPION." | standard greeting is plural |
| text/CeladonHotel.asm | _CeladonHotelHallText5_FixedMatchaMachine | "I've a businnes to run here" | "I've a business to run here" |  |
| text/CeladonHotel.asm | _CeladonHotelHallSign6 / _CeladonHotelHallBattleText3 | "BOSS' OFFICE" vs "I'm the BOSS's right hand." | make possessive of BOSS consistent throughout (e.g. always "BOSS'" or always "BOSS'S") | inconsistent naming |
| text/CeladonMansion2F.asm | _CeladonMansion2TextDannye | "I have worked on a number of related project, like RBY in gen2 colors" | "a number of related projects" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextJoJo | "is an adapation of my code" | "is an adaptation of my code" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextJoJo | "focused on bugfixes and trainer ai." | "focused on bugfixes and trainer AI." |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextOrange | "I don't want to spoil anything if you haven't seen seen them yet." | remove duplicate "seen": "haven't seen them yet." |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextSign4 | "provided constant support, advices, and help" | "constant support, advice, and help" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextPorygondolier | "No; hang on, that's not right!" | "No, hang on, that's not right!" |  |
| text/CeladonMart3F.asm | _CeladonMart3Text15 | "...aftewards they" | "...afterwards they" | may need re-wrap |
| text/CeladonUniversity1.asm | _CeladonUniversity1TextPool2 | "ex student of" | "ex-student of" |  |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text3 | "Uh? What about leaving as alone?" | "Uh? What about leaving us alone?" |  |
| text/CeruleanCaveB1F.asm | _TravelerPostBattleTextDefeat | "indeed without" "pars, as I did" | "indeed without" "par, as I did" |  |
| text/CeruleanCaveExtraFinal.asm | _CeruleanCaveExtraFinalSign1 | "For all of your taboo puchases!" | "For all of your taboo purchases!" | may need re-wrap |
| text/CeruleanCaveExtraMiddle.asm | _CeruleanCaveExtraMiddleLanceBeforeBattleText | "terrifingly complex labyrinth" | "terrifyingly complex labyrinth" | may need re-wrap |
| text/CeruleanGym.asm | _CeruleanGymAfterBattleText3 | "I thought I had you like a fish out of water... Fool me!" | "...Fooled me!" |  |
| text/CeruleanGym.asm | _CeruleanGymGuidePreBattleText | "Yo! Champ in making!" | "Champ in the making!" | may need re-wrap |
| text/CeruleanGym.asm | _ReceivedCascadeBadgeText_RP | "Tch! Take these and scram!" | "Take this and scram!" (badge is singular) |  |
| text/ChampionsRoom.asm | _GaryDefeatedText2ndBattle_AG_BGL | "my birds of legends could take you down!" | "my birds of legend could take you down!" | inconsistent with "BIRDs of Legend" used elsewhere |
| text/FightingDojo.asm | _FightingDojoBrunoBeforeBattleText | "helped me trainig my wit" | "helped me train my wit" |  |
| text/FightingDojo.asm | _FightingDojoBrunoBeforeBattleText | "You visit honors this DOJO!" | "Your visit honors this DOJO!" |  |
| text/FuchsiaBillsGrandpasHouse.asm | _FuchsiaHouse1Text2 | "They're my grankid!" | "They're my grandkid!" | may need re-wrap |
| text/FuchsiaCity.asm | _FuchsiaCityTextErikHappy | "have costed us the whole day" | "have cost us the whole day" |  |
| text/FuchsiaCity.asm | _FuchsiaCityTextSaraHappy | "have costed us the whole day" | "have cost us the whole day" |  |
| text/HallOfFame.asm | _HallofFameRoomText1_RP | "I regret so deeply not to have step down before." | "...not to have stepped down before." |  |
| text/HallOfFame.asm | _HallofFameRoomTextScript1_RP | "I let you kill my grankid." | "I let you kill my grandkid." |  |
| text/IndigoPlateauLobby.asm | _IndigoPlateauLobbyText8_RP_Before | "And even if knew," | "And even if I knew," | missing "I" |
| text/LakeOfMist.asm | _LakeOfMistText1_HaveMoltres | "I cannot even phatom to control" | "I cannot even fathom controlling" | misspelling of "fathom" |
| text/LancesRoom.asm | _LanceBeforeBattleTextRematch | "challenge with" "with my ultimate" | "challenge with my ultimate" | duplicated "with"; may need re-wrap |
| text/LancesRoom.asm | _LanceBeforeBattleTextRematch2 | "You honour me by" | "You honor me by" | inconsistent spelling vs "an honor" used in VermilionGym.asm |
| text/LoreleisRoom.asm | _LoreleiBeforeBattleText_RP | "I'll make sure to see frozen for good." | "I'll make sure to see you frozen for good." | missing word; may need re-wrap |
| text/LoreleisRoom.asm | _LoreleiAfterBattleTextRematch2 | "Still, don't you think it'll be easy now. We all improved vastly!" | "Still, don't you think it'll be easy now? We all improved vastly!" | missing question mark |
| text/MrFujisHouse.asm | _LavenderHouse1Text6 | "One of them looks" "like a bit like a" "familiar mouse..." | "One of them looks a bit like a familiar mouse..." (remove duplicated "like") | may need re-wrap |
| text/OaksLab.asm | _OaksLabText9_RP_Core | "or they may die of brocken heart..." | "or they may die of a broken heart..." |  |
| text/OaksLab.asm | _GiovanniBeforeBattleText | "You saved me from a life a crime," | "You saved me from a life of crime," |  |
| text/OaksLab.asm | _GiovanniBeforeBattleText | "there is a favour I would love to ask you: would you honor me" | "there is a favour I would love to ask you: would you honour me" | pick one English spelling convention (favour vs honor) |
| text/ObsidianHouses.asm | _ObsidianHousesTextFamily3 | "TEAM ROCKET did threat to hurt them" | "TEAM ROCKET threatened to hurt them" |  |
| text/ObsidianIsland.asm | _ObsidianIslandTextClosedHouse | "The door is shut close..." | "The door is shut tight..." (or just "shut") |  |
| text/ObsidianIsland.asm | _ObsidianIslandText7_Scientist1_Intro_NoPrompt / _WithPrompt | "Alas, the environment prohibitively harsh." | "Alas, the environment is prohibitively harsh." | missing "is"; occurs in both duplicated labels |
| text/ObsidianIsland.asm | _ObsidianIslandText7_Scientist1_AlreadyRewardedOrb | "maybe if few years we'll have a clean energy source" | "maybe in a few years we'll have a clean energy source" | wrong preposition + missing article |
| text/ObsidianIsland.asm | _ObsidianIslandText7_Scientist1_ThanksHereIsReward | "please have the reward you I promised you" | "please have the reward I promised you" | duplicated word "you" |
| text/ObsidianMines.asm | _ObsidianMinesText3_ThanksHereGift | "Thank you, thank you, a thousand time thank you!" | "Thank you, thank you, a thousand times thank you!" |  |
| text/ObsidianMines.asm | _ObsidianMinesText3_RP_StealNugget | "<PLAYER> steals a BIG NUGGET!" | "<PLAYER> stole a BIG NUGGET!" | inconsistent tense; label is "Stole..." and sibling text in Museum1F.asm uses past tense "stole" |
| text/ObsidianWarehouseFinal.asm | _ObsidianWarehouseFinalAfterBattleText3 | "Grrr... you fucked cockroach. Don't get too cocky!" | "Grrr... you fucking cockroach." |  |
| text/ObsidianWarehouseFinal.asm | _ObsidianWarehouseFinalAfterBattleText5 | "I made them undergo the most excruciating trainings" | "...excruciating training" |  |
| text/ObsidianWarehouseFinal.asm | _ObsidianWarehouseFinalText10_RP | "PETREL: Oh, you thought was gonna be easy?" | "you thought it was gonna be easy?" |  |
| text/ObsidianWarehouseFinal.asm | _ObsidianWarehouseFinalText11_RP | "ARIANA: The BOSS lead us all." | "The BOSS led us all." |  |
| text/ObsidianWarehouseFinal.asm | _ObsidianWarehouseFinalText5_RP_After | "Keep on like this, kid, and you'll rank up no time." | "you'll rank up in no time." |  |
| text/OchreGym.asm | _OchreGymBattleText6 | "Nothing more wrong that that!!!" | "Nothing more wrong than that!!!" |  |
| text/OchreGym.asm | _OragePreBattleText | "Despite so, this is GYM is not... Nevermind, doesn't matter." | "Despite so, this GYM is not... Nevermind, doesn't matter." | extra "is" |
| text/OchreGym.asm | _OrageNoBadgeInfoText_RP | "No BADGE for your, nor fancy gift TM." | "No BADGE for you, nor fancy gift TM." |  |
| text/OchreGym.asm | _OchreGymStatueText | "#MON gym" / "Leader: ORAGE" | "#MON GYM" / "LEADER: ORAGE" | capitalization inconsistent with other GYM signs (e.g. VermilionCity's "#MON GYM" / "LEADER: LT.SURGE") |
| text/OchreGym.asm | _OragePreBattleText_RP | "I will certainly not face some shit like you in a honor battle." | "...in an honor battle." | article agreement |
| text/OchreHouses.asm | _OchreHousesTextBirbFan1/2/3_RP_Before | "honour of BIRDs" (x3) | Use consistent spelling ("honor") | inconsistent with "honor" spelling used in OchreGym.asm's _OragePreBattleText_RP |
| text/OchreHouses.asm | _OchreHousesTextNotebook | "Is a notebook from CELADON UNIVERSITY full of notes about MAGIKARP!" | "It's a notebook from CELADON UNIVERSITY..." | missing subject "It" (cf. other sign texts use "It's a...") |
| text/OchreRehabilitationCenter.asm | _OchreRehabilitationCenterText1 | "released back in to the wild!" | "released back into the wild!" |  |
| text/PalletTown.asm | _PalletTownTextDarkGuide_RP_After | "Keep torturing peolpe and having fun" | "Keep torturing people and having fun" |  |
| text/PalletTown.asm | _DarkGuideHints_Hint2_Solution | "the SEVII SAGEs will accept your to battle you, one per island" | "the SEVII SAGEs will accept to battle you, one per island" | word appears garbled/missing |
| text/PewterCity.asm | _PewterCityText1 | "They appeared " | "They appeared" | stray trailing space in source |
| text/PewterSpeechHouse.asm | _PewterHouse2Text4 | "250: trascend that" | "250: transcend that" | may need re-wrap |
| text/PokemonFanClub.asm | PikachuFanPrintText / _FanClubText6 | "Our CHAIRMAN's new hobby is taking #MON photos." / "Our CHAIRPERSON is very vocal about #MON." | Use one consistent title (e.g. "CHAIRPERSON") for the same character | inconsistent naming |
| text/PokemonMansion2F.asm | _Mansion2Text3 / _Mansion2Text4 | "Diary: July 5" vs "Diary: July 10." | make punctuation consistent (both with or without trailing period) |  |
| text/PokemonMansion2F.asm | _Mansion2BlaineBeforeBattleText | "I was... lost in thoughts." | "I was... lost in thought." |  |
| text/PokemonMansion2F.asm | _Mansion2BlaineBeforeBattleText | "Many memories ties me to it" | "Many memories tie me to it" |  |
| text/PokemonTower6F.asm | _PokemonTower2Text_60c24_RP | "fury and thirst" "for vengeange." | "for vengeance." |  |
| text/PokemonTower6F.asm | _PokemonTower6AgathaBeforeBattleText | "and their grankid" | "and their grandkid" | may need re-wrap |
| text/PokemonTower6F.asm | _PokemonTower6AgathaBeforeBattleText | "Are you here to" "pay respect to" "the spirits?" | "pay respects to" |  |
| text/RockTunnelB1F.asm | _RockTunnel2AfterBattleText2 | "I want to go " | "I want to go" | stray trailing space in source |
| text/RocketHideoutB4F.asm | _RocketHideoutJessieJamesText4_RP | "The higher up may have welcome you" | "The higher up may have welcomed you" |  |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_GoToSevii | "the negotations aren't proceeding" | "the negotiations aren't proceeding" |  |
| text/Route12.asm | _Route12RivalText_Lose | "and I'll you use to squash you" | "and I'll use you to squash you" | scrambled word order |
| text/Route18Gate1F.asm | _Route18And16GateText1_RP | "nor follwing rules" | "nor following rules" |  |
| text/Route20.asm | _Route20ScriptText2 | "This's the coldest" | "That's the coldest" |  |
| text/Route21.asm | _Route21DiveEndBattleText4 | "(I'm better at diving that at battling!)" | "(I'm better at diving than at battling!)" | that/than mix-up |
| text/Route21.asm | _Route21DiveAfterBattleText4 | "I heard of some gears that can help you dive for longer!" | "I heard of some gear that can help you dive for longer!" | "gear" is uncountable |
| text/Route21.asm | _Route21DiveAfterBattleText3 | "(The ROUTEs around CINNABAR've been altered by recent intense volcanic activity.)" | "(The ROUTEs around CINNABAR have been altered by recent intense volcanic activity.)" | contracting a place name reads as a typo, inconsistent with fluent translated dialogue elsewhere |
| text/Route21.asm | _Route21ScriptText1 | "It reminded me a lot another great fight I had a long, long time ago." | "It reminded me a lot of another great fight I had a long, long time ago." | missing "of" |
| text/Route23.asm | _Route23ScriptText2_RP | "I CAN'T BE!!!" | "IT CAN'T BE!!!" | parallels "It... can't be!!!" in _Route23PinkDefeatedText_RP |
| text/Route24.asm | _Route24Text_FirstQuestSummary | "CAPTAIN and rely them the message" | "CAPTAIN and relay them the message" |  |
| text/Route24.asm | _Route24Text_MessageRelyed | "and they took sail? Great job!" | "and they set sail? Great job!" |  |
| text/Route24.asm | _Route24Text_NewBoss | "Ops! I apologize BOSS." | "Oops! I apologize, BOSS." |  |
| text/Route25.asm | _Route25AfterBattleText7 | "from MT.MOON," | "from MT. MOON," | inconsistent with "MT." / "MOON" split elsewhere in file |
| text/Route25.asm | _Route25TextToHauntedHouseMessage2_RP | "Marvels beyond believe lie" | "Marvels beyond belief lie" |  |
| text/Route29.asm | _Route29TextSlowking_RP_Core | "reconsider the turns of your life that led you walk down the path of evi-" | "...that led you to walk down the path of evi-" | may need re-wrap |
| text/Route7.asm | _Route7RepairPersonText_FirstTime | "my gramparents," | "my grandparents," |  |
| text/SSAnne1FRooms.asm | _SSAnne8EndBattleText3 | "Wow! " | "Wow!" | stray trailing space in source |
| text/SSAnne2F.asm | _SSAnneRivalBeforeBattleText_RP | "...you won't back down? What a disappointement you are." | "...you won't back down? What a disappointment you are." |  |
| text/SSAnneCaptainsRoom.asm | _SSAnne7Text1_RP | "I heard the new." | "I heard the news." |  |
| text/SafariZoneCenterRestHouse.asm | _SafariZoneRestHouseTextSaraHappy | "could have costed us the whole day." | "could have cost us the whole day." |  |
| text/SafariZoneCenterRestHouse.asm | _SafariZoneRestHouseTextErikHappy | "could have costed us the whole day." | "could have cost us the whole day." |  |
| text/SaffronCity.asm | _SaffronCityText_BlockingSilph_RP_Before | "plans for the SILPH CO.." | "plans for the SILPH CO." | double period |
| text/SaffronPokecenter.asm | _SaffronPokecenterText2 | "differ from specie to specie." | "differ from species to species." | may need re-wrap |
| text/SeviiEightIsland.asm | _SeviiEightIslandCaveTextScript14 | "one must muster themselves to the utmost extreme in order to be able overcome any and adversity." | "one must muster themselves to the utmost extreme in order to be able to overcome any and all adversity." | missing "to" and "all"; may need re-wrap |
| text/SeviiEightIsland.asm | _SeviiTenIslandScriptText3 | "I definitely won't forget of this battle, trust me!" | "I definitely won't forget this battle, trust me!" | wrong preposition |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandCityScriptText3 | "You talk big, but but you're only a pathetic weakling." | "You talk big, but you're only a pathetic weakling." | duplicated "but"; may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandCityScriptText5 | "they took possess" | "they took possession" | may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandCityScriptText5 | "their traffics." | "their trafficking." | may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandCityAfterBattleText4 | "gaze on you face once more..." | "gaze on your face once more..." |  |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandHousesText1_Question | "Would you like me me to teach to your #MON the move TRICK ROOM?" | "Would you like me to teach your #MON the move TRICK ROOM?" | duplicated "me" + extra "to"; may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandHousesSignText2 | "these unheard hypothesis?" | "these unheard hypotheses?" |  |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandGymText4_Reward2 | "the SEVII TRAIL SCROLL" | "the SEVII TRIAL SCROLL" | inconsistent with "SEVII TRIAL" used elsewhere |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandWarehouse1FText1 | "gift me concret shoes" | "gift me concrete shoes" |  |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandWarehouse2FScriptText3 | "out here, uh?" | "out here, huh?" |  |
| text/SeviiFiveIsland1.asm | _SeviiRoute34Text1_BeforeAmuletCoin | "your friedships?" | "your friendships?" |  |
| text/SeviiFiveIsland1.asm | _SeviiRoute36AfterBattleText5 | "I cannot phatom" | "I cannot fathom" |  |
| text/SeviiFiveIsland1.asm | _SeviiRoute36AfterBattleText12 | "the best wat to enjoy" | "the best way to enjoy" |  |
| text/SeviiFiveIsland1.asm | _SeviiResortGorgeousText11 | "never-began games." | "never-begun games." |  |
| text/SeviiFiveIsland2.asm | _SeviiRoute35BattleText1_RP | "Uh? Helping a ROCKET by translating this?" | "Huh? Helping a ROCKET by translating this?" |  |
| text/SeviiFiveIsland2.asm | _SeviiFiveIslandCityText5_RP_Core | "TAKE ALL STRENGTH or the so." | "TAKE ALL STRENGTH or so." |  |
| text/SeviiFiveIsland2.asm | _SeviiRoute34Text1_RP | "Friends. Are the most important thing in life." | "Friends... are the most important thing in life." |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandHousesText9 | "They're are, like, ultra strong" | "They're, like, ultra strong" | may need re-wrap |
| text/SeviiFourIsland.asm | _SeviiFourIslandPokemonCenterAndMart_Text4 | "the MARKET ran by those two adorable grampies" | "the MARKET run by those two adorable grampies" |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandHousesText4_PreChrono | "It's unconceivable that little kids exert justice" | "It's inconceivable that little kids exert justice" |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandHousesText2_RP_Before | "What did we do do deserve this?!" | "What did we do to deserve this?!" |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandHousesSignText7_PC_RP | "I feel so weak and uselss." | "I feel so weak and useless." |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandHousesSignText7_PC_RP | "I'll purge the world from that plague" | "I'll purge the world of that plague" |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandHousesSignText6_Switch_RP | "wields a stupidly gigantic weapons" | "wields a stupidly gigantic weapon" | may need re-wrap |
| text/SeviiOneIsland.asm | _SeviiOneIslandGym2Text1_Intro | "pierce darkness with knownledge." | "pierce darkness with knowledge." |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandGym2Text3_Reward2 | "the SEVII TRAIL SCROLL of KNOT ISLAND!" | "the SEVII TRIAL SCROLL of KNOT ISLAND!" |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandGym2Text3_NoReward | "I cannot award you to due the presence of some exceptional #-MON" | "I cannot award you due to the presence of some exceptional #-MON" | may need re-wrap |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesText3_TryToGiftFlute | "please accept this is a humble token of my gratitude!" | "please accept this as a humble token of my gratitude!" |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesText3_RightAfterPink | "we got interrupted halfway along something!" | "we got interrupted halfway through something!" |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesText3_CelioBeforePink | "Words, money, nor gifts'll ever be enough" | "Neither words, money, nor gifts will ever be enough" | may need re-wrap |
| text/SeviiOneIsland.asm | _SeviiEmberSpaText1_After_RP | "You wouldn't have su much anger..." | "You wouldn't have so much anger..." |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesScriptText3_RP | "stay assured, you made yourself an enemy for life!" | "rest assured, you made yourself an enemy for life!" |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesText3_RightAfterPink / _SeviiOneIslandHousesText12_RP_BeforePink | "PINK's my nephew." / "beat that officer and a kid that tried to rescue my nephew." | consider a gender-neutral kinship term (e.g. "nibling"/"kid") to match the established gender-neutral "Auncle" | inconsistent with established gender-neutral naming pattern |
| text/SeviiSevenIsland.asm | _SeviiSevenIslandPokemonCenterAndMart_Text1 | "antropological" | "anthropological" |  |
| text/SeviiSevenIsland.asm | _SeviiSevenIslandPokemonCenterAndMart_Text1 | "It's easy stuf." | "It's easy stuff." |  |
| text/SeviiSevenIsland.asm | _SeviiSevenIslandGym3Text16_NoReward | "I pains me, but as" | "It pains me, but as" |  |
| text/SeviiSevenIsland.asm | _SeviiRoute42BattleText6 | "high scientifical" "interest." | "high scientific interest." |  |
| text/SeviiSevenIsland.asm | _SeviiRoute43AfterBattleText8 | "the pinnacle of" "existance?" | "the pinnacle of existence?" |  |
| text/SeviiSevenIsland.asm | _SeviiRoute42BattleText9 | "This rocky hikes" "are just the best!" | "These rocky hikes are just the best!" | wrong word/agreement |
| text/SeviiSixIsland1.asm | _SeviiSixIslandGym3Text10_Reward2 | "the SEVII TRAIL" "SCROLL of" | "the SEVII TRIAL" "SCROLL of" | "SEVII TRIAL" is used correctly everywhere else in the file |
| text/SeviiSixIsland1.asm | _SeviiSixIslandGym3Text5_Victory | "chain of choices" "lead you to beat" | "chain of choices" "led you to beat" | subject-verb agreement/tense ("chain" is singular, and this is past tense) |
| text/SeviiSixIsland1.asm | _SeviiRoute38Text2 | "Noone can map it!" | "No one can map it!" |  |
| text/SeviiSixIsland1.asm | _SeviiRoute38HousesText2_Intro | "COPYPCAT from" | "COPYCAT from" | spelled correctly ("COPYCAT") later in the same text block set |
| text/SeviiSixIsland1.asm | _SeviiPatternBushAfterBattleText2 | "under by belt," | "under my belt," |  |
| text/SeviiSixIsland1.asm | _SeviiPatternBushBattleText4 | "with a ante: let's" | "with an ante: let's" | a/an agreement |
| text/SeviiSixIsland1.asm | _SeviiRoute39Text2 | "most tranquill" | "most tranquil" |  |
| text/SeviiSixIsland1.asm | _SeviiRoute39BattleText2 | "unworhty hands on" | "unworthy hands on" |  |
| text/SeviiSixIsland1.asm | _SeviiRoute39EndBattleText2 | "Has we reached" | "Have we reached" | subject-verb agreement |
| text/SeviiSixIsland1.asm | _SeviiPatternBushBattleText1 | "Do you any hint about" | "Do you have any hint about" | missing verb |
| text/SeviiSixIsland2.asm | _SeviiDottedHoleTextScript2 | "GIOVANNI may have quitted, but we..." | "GIOVANNI may have quit, but we..." |  |
| text/SeviiSixIsland2.asm | _SeviiDottedHoleTextScript5 | "How did this brat made their #MON so strong?" | "How did this brat make their #MON so strong?" |  |
| text/SeviiSixIsland2.asm | _SeviiDottedHoleTextScript6 | "Why did we even bothered bringing you with us?" | "Why did we even bother bringing you with us?" |  |
| text/SeviiSixIsland2.asm | _SeviiDottedHoleTextScript7 | "AT LEAST weaking this brat enough" | "AT LEAST weakening this brat enough" |  |
| text/SeviiSixIsland2.asm | _SeviiDottedHoleTextScript8 | "So I'd be useless, uh?" | "So I'd be useless, huh?" |  |
| text/SeviiSixIsland2.asm | _SeviiSixIslandCityScriptText1 | "PINK: I heard the that you killed the previous BOSS" | "PINK: I heard that you killed the previous BOSS" | extra "the" |
| text/SeviiSixIsland2.asm | _SeviiSixIslandCityScriptText2 | "How can you do so much arm and go unpunished?!" | "How can you do so much harm and go unpunished?!" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandCityText3 | "the DREAM FOREST on the west're kinda creepy places." | "...on the west are kinda creepy places." |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandPokemonCenterAndMart_Text2 | "I think it's just semantic, it does not matter at all." | "I think it's just semantics, it does not matter at all." |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText2_Shelf1_Book3 | "Trasfer Coins" | "Transfer Coins" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText3_Shelf3_Book1 | "Knots, but Only in Apparence" | "Knots, but Only in Appearance" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText4_Shelf2_Book4 | "Routines With and Without Cloack" | "Routines With and Without Cloak" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText4_Shelf3_Book1 | "Just glimpsing at at the images" | "Just glimpsing at the images" | may need re-wrap |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText7_Shelf1_Book1 | "In Plain Earing With Your Partner" | "In Plain Hearing With Your Partner" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText7_Shelf1_Book2 | "In Plain Earing With Your Partner" | "In Plain Hearing With Your Partner" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText8_Shelf2_Book1 | "Just Find A Dopplegaenger" | "Just Find A Doppelganger" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText8_Shelf3_Book2 | "the main theme of figthing for Knowledge" | "the main theme of fighting for Knowledge" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText8_Shelf3_Book4 | "the book goes goes on for hundreds of pages" | "the book goes on for hundreds of pages" | may need re-wrap |
| text/SeviiThreeIsland.asm | _SeviiRoute33Text2_Core | "or our boss'll will storm here from BOON" | "or our boss'll storm here from BOON" | may need re-wrap |
| text/SeviiThreeIsland.asm | _SeviiBerryForestScriptText2 | "forward to beat' 'em to a pulp." | "forward to beat 'em to a pulp." |  |
| text/SeviiThreeIsland.asm | _SeviiRoute33DiveText0 | "in the middle of a rocky scenario!" | "in the middle of a rocky scenery!" |  |
| text/SeviiThreeIsland.asm | _SeviiRoute33BattleText4 | "I'm in vacation." | "I'm on vacation." |  |
| text/SeviiThreeIsland.asm | _SeviiBerryForestScriptText2_RP | "even beat a cop if front of 'em?" | "even beat a cop in front of 'em?" |  |
| text/SeviiThreeIsland.asm | _SeviiBerryForestScriptText6_RP | "but one piece at the time." | "but one piece at a time." |  |
| text/SeviiThreeIsland.asm | _SeviiBerryForestText1_RP | "ORM: To go CELIO and tell 'em" | "ORM: To go to CELIO and tell 'em" | may need re-wrap |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandGymText4_Reward2 | "the SEVII TRAIL SCROLL of BOON ISLAND!" | "the SEVII TRIAL SCROLL of BOON ISLAND!" |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandCityScriptText1 | "Oh, screw to all." | "Oh, screw it all." |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIsletHousesText6_Intro | "I need a PP UP, a NUGGET, a MAX REVIVE, and a MAX ELIXER." | "...a MAX ELIXIR." |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIsletHousesSignText2_Core | "Advance, complex algorithms run through silicon synapses." | "Advanced, complex algorithms run through silicon synapses." |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandCityText5_RP | "We don't business with criminals." | "We don't do business with criminals." |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIsletText2 | "Have you visited MT. EMBER?" | "Have you visited MT.EMBER?" | inconsistent with "MT.EMBER" spelling used elsewhere (no space) |
| text/SilphCo11F.asm | _SilphCo11Text1_RP | "PRESIDET: Please! Save us!" | "PRESIDENT: Please! Save us!" |  |
| text/SilphCo11F.asm | _SilphCo11ScriptText2_RP | "why shoulnd't we do the same?" | "why shouldn't we do the same?" |  |
| text/SilphCo11F.asm | _SilphCo11TextGiovanni_RP_LoreDrop | "In a way, it succeded." | "In a way, it succeeded." |  |
| text/SilphCo11F.asm | _SilphCo11TextGiovanni_RP_StealBallExplanation | "weapon'll be out of ammonitions." | "weapon'll be out of ammunition." |  |
| text/SilphCo5F.asm | _SilphCo5Text1b_NoGotPorygonYesGiovanni | "You saved my months of studies!" | "You saved months of my studies!" |  |
| text/SilphCo7F.asm | _HeresYourPorygonText | "Geez, would you listen at me," | "Geez, would you listen to me," | wrong preposition |
| text/SilphCo7F.asm | _SilphCo7Text_51ec3 | "get-ting my Gramps' attentions?" | "get-ting my Gramps' attention?" | uncountable noun |
| text/SilphCo7F.asm | _SilphCo7Text_RP_NotGottenPorygon | "I-I'm just an armless bystander" | "I-I'm just a harmless bystander" | dropped "h"; article also changes to "a"; may need re-wrap |
| text/SunkenShip.asm | _SunkenShipCaptainsLogText_Page1 | "staying in other's cabins" | "staying in others' cabins" |  |
| text/SunkenShip.asm | _SunkenShipLoreText_26 | "covered in algaes and barnacles" | "covered in algae and barnacles" |  |
| text/SunkenShip.asm | _GiveShipTreasureText_FoundTopaz | "gives in with no effor whatsoever" | "gives in with no effort whatsoever" |  |
| text/SunkenShip.asm | _GivePassword22Text | "shines in its red writings:" | "shines in its red writing:" |  |
| text/Traveler.asm | _TextTraveler_Intro_RP | "I hold a null interest in mendling with people" | "I hold a null interest in meddling with people" |  |
| text/Traveler.asm | _TextTraveler_VictoryPostBattle | "have appared somehow disappointing" | "have appeared somehow disappointing" |  |
| text/Traveler.asm | _TextTraveler_WhatWasThat_RP | "this current status sees as more befitting a 'farebad'." | "this current status seems more befitting of a 'farebad'." | may need re-wrap |
| text/VermilionCity.asm | _SSAnneFlashedTicketText / _SSAnneNoTicketText | "the S.S.TICKET!" ... "I'll take your S.S. TICKET" ... "The S.S. TICKET" ... "S.S.TICKET." | Standardize to one spacing convention (e.g. "S.S.TICKET" throughout) | inconsistent naming within/across labels |
| text/VermilionGym.asm | _VermilionGymEndBattleText2 | "I saw wanders" "poetry and song!" | "I saw wonders, poetry and song!" | likely typo for "wonders" |
| text/VermilionGym.asm | _ReceivedThunderBadgeText_RP | "I doesn't" "make any sense!" | "It doesn't make any sense!" |  |
| text/VictoryRoad3F.asm | _VictoryRoad3AfterBattleText8 | "I trained under SABRINA, and I illuded myself to have surpassed them and being ready for the #MON LEAGUE..." | "...and I deluded myself into thinking I had surpassed them and was ready for the #MON LEAGUE..." | wrong word "illuded"; may need re-wrap |
| text/WardensHouse.asm | _FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoArtifact | "You're interested in something? But don't have enough money?" | "But you don't have enough money?" | may need re-wrap |
| text/WardensHouse.asm | _FuchsiaHouse2AntiquitiesTextShopOwner_RP_ArtifactInBag | "Uh? Buying it?" | "Huh? Buying it?" |  |

## Awkward Grammar

| File | Label | Original | Suggested Fix | Note |
| --- | --- | --- | --- | --- |
| data/text/item_descriptions.asm | _SeviiTicketDescription | "Allows to travel" "to SEVII ISLANDS." | "Allows you to travel" "to SEVII ISLANDS." | missing "you"; may need re-wrap |
| data/text/item_descriptions.asm | _FlamePlumeDescription | "burning divine." | "burning divinely." | "divine" used where an adverb is needed |
| data/text/item_descriptions.asm | _SmashBallDescription | "A BALL better if" "mash A button." | "A BALL better if" "you mash the A button." | missing "you" and "the"; may need re-wrap |
| data/text/item_descriptions.asm | _FastBallDescription, _HeavyBallDescription | "A BALL optimal on" "fast #MON." / "heavy #MON." | "A BALL optimal for" "fast #MON." / "heavy #MON." | "optimal on" is nonstandard; appears in both descriptions |
| data/text/item_descriptions.asm | _HM10Description | "Summons whirlpool" | "Summons a whirlpool" | missing article |
| data/text/text_2.asm | _CeruleanPokecenterGuyText | "They collects rare" "ones too!" | "They collect rare ones too!" | subject-verb agreement |
| data/text/text_2.asm | _ObsidianPokecenterGuyText | "how difficult was" "to get me here." | "how difficult it was to get me here." | missing "it" |
| data/text/text_2.asm | _ViridianBlackboardPoisonText | "of its max HP at" "the end of every" "of its turns." | "...at the end of each of its turns." | extra "of" |
| data/text/text_2.asm | _AreYouSureText | "Are you sure to" "surrender?" | "Are you sure you want to surrender?" | may need re-wrap |
| data/text/text_2.asm | _SeviiTicketUpTo3 | "Allows to travel" "to the first 3 of" "SEVII ISLANDS!" | "Allows you to travel to the first 3 of SEVII ISLANDS!" | missing "you"; may need re-wrap |
| data/text/text_2.asm | _SeviiTicketUpTo5 | "Allows to travel" "to the first 5 of" "SEVII ISLANDS!" | "Allows you to travel to the first 5 of SEVII ISLANDS!" | missing "you"; may need re-wrap |
| data/text/text_2.asm | _SeviiTicketUpTo8 | "Allows to travel" "to all of the" "SEVII ISLANDS!" | "Allows you to travel to all of the SEVII ISLANDS!" | missing "you"; may need re-wrap |
| data/text/text_3.asm | _HurtByUnderwaterText | "<USER> suffers for being underwater!" | "<USER> suffers from being underwater!" | may need re-wrap |
| data/text/text_4.asm | _OptionsInfoTextExpGain | "NOTHING: no battle earn any EXP." | "NOTHING: no battle earns any EXP." | subject-verb agreement |
| data/text/text_4.asm | _OptionsInfoTextBattleStyle | "before opponent sends a new one." | "before the opponent sends a new one." | missing article; may need re-wrap |
| data/text/text_4.asm | _OptionsInfoTextCap | "LOOSE: slightly above next GYM LEADER's ace." | "LOOSE: slightly above the next GYM LEADER's ace." | missing article, inconsistent with the "TIGHT" entry above it which has "the"; may need re-wrap |
| data/text/text_8.asm | _CableClubNPCAreaReservedFor2FriendsLinkedByCableText_RP | "I really doubt a scum like you has any friend." | "I really doubt a scum like you has any friends." |  |
| data/text/text_rocket_path_1.asm | _GenericNPCText_RocketPath_6 | "What will your parents think of your doing?" | "What will your parents think of what you're doing?" | may need re-wrap |
| data/text/text_rocket_path_1.asm | _GenericNPCText_RocketPath_26 | "inflicting to your dear ones" | "inflicting on your dear ones" |  |
| data/text/text_rocket_path_1.asm | _GenericNPCTextUnderwater_RocketPath_2 | "Not even under-water we are safe from TEAM ROCKET!" | "Not even underwater are we safe from TEAM ROCKET!" |  |
| data/text/text_rocket_path_1.asm | _BrockPostBattleText_RP (+7 aliases incl. _OragePostBattleText_RP) | "Don't dirty my GYM any one more second." | "Don't dirty my GYM one more second." |  |
| text/AgathasRoom.asm | _AgathaBeforeBattleTextRematch | "I hope you will be able to witness the old duff's too... because is marvelous..." | "...because it is marvelous..." | missing "it" |
| text/AgathasRoom.asm | _AgathaBeforeBattleTextRematch2 | "It was also what made us better ourselves." | "It was also what helped us better ourselves." |  |
| text/BattleFacility.asm | _BattleFacilityTextGuide_Info | "B.F. for short, offers you to play with and face different pools of #MON." | "lets you play with and face different pools" | may need re-wrap |
| text/BattleFacility.asm | _BattleFacilityTextGuide_Info | "your team will be healed and you will be rewarded a PP UP." | "rewarded with a PP UP." |  |
| text/BattleFacility.asm | _BattleFacilityTextGuide_InfoFull | "your team will be healed and you will be rewarded a PP UP." | "rewarded with a PP UP." |  |
| text/BattleFacility.asm | _BattleFacilityTextGuide_Info | "We wish you best of fun at our BATTLE FACILITY!" | "We wish you the best of fun" | may need re-wrap |
| text/BattleFacility.asm | _BattleFacilityTextPerson1 | "I wanna dive completely in INVERSE battles" | "dive completely into INVERSE battles" |  |
| text/BattleFacility.asm | _BattleFacilityText_AfterWarpDefeat | "You anyhow did great!" | "Anyhow, you did great!" |  |
| text/BillsHouse.asm | _BillsHouseText3_MapAlreadyShown | "found out the map... I didn't manage to convince them" | "found the map... I didn't manage to convince them" | "found out" fits facts/info, not a physical object; may need re-wrap |
| text/BillsHouse.asm | _BillsHouseText3_MapAlreadyShown | "things were going well and smooth" | "things were going well and smoothly" | adjective/adverb mismatch; may need re-wrap |
| text/BillsHouse.asm | _BillsHouseText3_MapAlreadyShown | "in a split second was a nightmare." | "in a split second it was a nightmare." | missing subject "it"; may need re-wrap |
| text/BluesHouse.asm | _DaisyInitialText | "Since our parents disappeared, they closed quite a lot in themselves..." | "...they closed off quite a lot..." (or "closed in on themselves quite a lot") |  |
| text/BluesHouse.asm | _BluesHouseBluesMomText | "I never thought I'd ever seen my old one and my kids again..." | "I never thought I'd ever see my old one and my kids again..." | tense mismatch |
| text/BrunosRoom.asm | _BrunoBeforeBattleText_RP_Pink | "and awoke a power as anything else!" | "and awoke a power unlike anything else!" |  |
| text/CeladonChiefHouse.asm | _LunarShrineMonkText_AlreadyReturnedRelic | "I... I think I'm ready to open again the TEMPLE to the visitors." | "I... I think I'm ready to open the TEMPLE to visitors again." | unnatural word order; may need re-wrap |
| text/CeladonChiefHouse.asm | _LunarShrineTextRockets11 | "and so should be the whole of KANTO." | "and so should the whole of KANTO." | inverted auxiliary/verb order |
| text/CeladonChiefHouse.asm | _LunarShrineTextRockets6 | "Don't you think we didn't recognize you!" | "Don't think we didn't recognize you!" | extra "you" makes the intended meaning ("we did recognize you") confusing |
| text/CeladonCity.asm | _TM41ExplanationText | "because the user too takes damage!" | "because the user also takes damage!" |  |
| text/CeladonCity.asm | _CeladonCityText4 | "Despite so, it feels so isolated" | "Even so, it feels so isolated" |  |
| text/CeladonDiner.asm | _CeladonDinerText2_MachineBroken | "the machine that we use to make MATCHA TEA's out." | "the machine that we use to make MATCHA TEA is out of order." | may need re-wrap |
| text/CeladonDiner.asm | _CeladonDinerText_ImRuined | "COIN CASE with last couple of coins I had in." | "COIN CASE with the last couple of coins I had in it." | may need re-wrap |
| text/CeladonGym.asm | _ReceivedRainbowBadgeText | "I must confer you the RAINBOWBADGE." | "I must award you the RAINBOWBADGE." | "confer" needs "upon/on", not a direct object |
| text/CeladonGym.asm | _CeladonGymGuidePreBattleText | "they suffer ICE, BUGs, FIRE, but also POISON and FLYING, but on the other hand they have many tricks" | "...ICE, BUG, FIRE, and also POISON and FLYING; on the other hand they have many tricks" | double "but" creates confusing double contrast; may need re-wrap |
| text/CeladonGym.asm | _ErikaPreBattleText_RP | "But stay assured, I'll use all of my ability" | "But rest assured, I'll use all of my ability" | idiom is "rest assured" |
| text/CeladonHotel.asm | _CeladonHotelText3 | "It's the first time I go on a vacation with my partner!" | "It's the first time I've gone on a vacation with my partner!" |  |
| text/CeladonHotel.asm | _CeladonHotelRoomsText3 | "awarded for overcoming any and every challenge and rise to the rank of CHAMPION!" | "awarded for overcoming any and every challenge and rising to the rank of CHAMPION!" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextCarrot | "apparently PIGEON has more in mind my carrot side than my ZANGOOSE side" | "has my carrot side more in mind than my ZANGOOSE side" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextSign2 | "they answered a number of questions from PIGEON over the time!" | "over time!" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextSign3 | "PIGEON's project would have likely never seen the light without their invaluable help." | "would likely never have seen the light" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextSign3 | "they broke many limits of the original game, and documented all of this on valuable tutorials!" | "documented all of this in valuable tutorials!" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextSign3 | "SATOMEW is a contributor of the pret project" | "a contributor to the pret project" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextSign4 | "many, many, many more people joined and has contributed in making creating this game" | "people joined and have contributed in creating this game" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextSign4 | "a wonderful experience full of joy, satisfaction, overcome challenges, improvement" | "...overcoming challenges, improvement" |  |
| text/CeladonMansion2F.asm | _CeladonMansion2TextSign4 | "and helped PIGEON turning a childhood dream not only into a reality" | "helped PIGEON turn a childhood dream" |  |
| text/CeladonUniversity1.asm | _CeladonUniversity1Text2 | "the teacher used too frequently their QUICK CLAW." | "the teacher too frequently used their QUICK CLAW." | unnatural word order |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text1 | "we start 15 minutes after o'clock." | "we start 15 minutes past the hour." | may need re-wrap |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text6 | "but I can't happen to find it." | "but I just can't seem to find it." |  |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text8_Intro_NoPrompt | "it lives only in the deepest depth of the SEAFOAM ISLANDS." | "it lives only in the deepest depths of the SEAFOAM ISLANDS." | may need re-wrap |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text8_Intro_NoPrompt | "I've no mean to go there." | "I've no means to go there." | may need re-wrap |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text8_Intro_WithPrompt | "it lives only in the deepest depth of the SEAFOAM ISLANDS." | "it lives only in the deepest depths of the SEAFOAM ISLANDS." | may need re-wrap |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text8_Intro_WithPrompt | "strong #MON and an harsh environment." | "strong #MON and a harsh environment." |  |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text8_Intro_WithPrompt | "You, although, seem quite strong!" | "You, however, seem quite strong!" |  |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text8_WowAlreadyCaught | "So I was right, you do be extraordinary!" | "So I was right, you really are extraordinary!" | may need re-wrap |
| text/CeladonUniversity2.asm | _CeladonUniversity2Text8_ThanksHereIsReward | "You did! I knew, you're amazing!" | "You did! I knew you're amazing!" |  |
| text/CeruleanBadgeHouse.asm | _CeruleanHouse2Text_74e77 | "the more you have," "the stronger are" "the #MON that" "will follow your" "orders!" | "the stronger the #MON that will follow your orders will be!" | may need re-wrap |
| text/CeruleanCaveB1F.asm | _TravelerBeforeBattleText | "opportunity to" "communicate you" "that I succeeded" | "communicate to you" | may need re-wrap |
| text/ChampionsRoom.asm | _GaryText6_OakAmaze | "Not only you're my grandkid, and I'll always love you no matter what, but you achieved unprecedented results!" | "Not only are you my grandkid, and I'll always love you no matter what, but you achieved unprecedented results!" | missing subject-verb inversion after "Not only"; may need re-wrap |
| text/ChampionsRoom.asm | _GaryText6_OakSorrow | "remind me it, and" | "remind me of it, and" | may need re-wrap |
| text/ChampionsRoom.asm | _GaryText7_OakYouDidItAgain | "you both conquered again the title of #MON CHAMPION!" | "you both conquered the title of #MON CHAMPION again!" | adverb placement; may need re-wrap |
| text/ChampionsRoom.asm | _GaryVictoryText2ndBattle_AG_FR | "I look forward to face you again!" | "I look forward to facing you again!" | missing gerund |
| text/ChampionsRoom.asm | _GaryText3_RP | "But I reach the pinnacle, as I promised." | "But I reached the pinnacle, as I promised." | tense mismatch |
| text/ChampionsRoom.asm | _GaryText3_RP | "the strongest TRAINER in the whole planet." | "the strongest TRAINER on the whole planet." | preposition |
| text/CinnabarGym.asm | _CinnabarGymBattleText1 | "I was a thief, but I became straight as a trainer!" | "I was a thief, but I went straight and became a trainer!" | may need re-wrap |
| text/CinnabarGym.asm | _CinnabarGymGuidePreBattleText | "Yo! Champ in making!" | "Yo! Champ in the making!" | may need re-wrap |
| text/CinnabarIsland.asm | _CinnabarIslandTextNewPerson8 | "in the clearest days!" | "on the clearest days!" |  |
| text/CinnabarLab.asm | _Lab1Text2_Archeologist_PostReturnRelic_FirstTime | "the greatest testament of my life achievements" | "the greatest testament to my life achievements" | "testament to", not "of" |
| text/DiglettsCaveRoute11.asm | _DiglettsCaveEntRoute11Text1_BeforeSurge | "to take some measurements, and now all #MON are hiding..." + "as soon as the fear will pass." | "...as soon as the fear passes." | tense mismatch |
| text/DiglettsCaveRoute11.asm | _DiglettsCaveEntRoute11Text1_BeforeSurge | "went into the DIGLETT's CAVE short ago" | "went into the DIGLETT's CAVE a short while ago" | may need re-wrap |
| text/FuchsiaCity.asm | _FuchsiaCityText1_Pre | "REHABILITATION CENTER to break the ring, but is so pogger that I don't mind!" | "...but it's so pogger that I don't mind!" | missing "it" |
| text/FuchsiaCity.asm | _FuchsiaCityTextRocket_RP | "the BOSS has not allowed you yet to access our SAFARI ZONE." | "...has not yet allowed you to access..." |  |
| text/FuchsiaGym.asm | _KogaSoulBadgeInfoText | "if you desire so." | "if you so desire." |  |
| text/FuchsiaGym.asm | _FuchsiaGymBattleText1 | "Strength isn't the key for #MON!" | "Strength isn't the key to #MON battles!" | may need re-wrap |
| text/FuchsiaGym.asm | _FuchsiaGymGuidePreBattleText | "Yo! Champ in making!" | "Yo! Champ in the making!" | may need re-wrap |
| text/FuchsiaGym.asm | _FuchsiaGymAfterBattleText_Common | "you don't know who is KOGA!" | "you don't know who KOGA is!" |  |
| text/FuchsiaGym.asm | _KogaBeforeBattleText_RP | "You dare facing me, KOGA" | "You dare face me, KOGA" |  |
| text/FuchsiaMeetingRoom.asm | _FuchsiaMeetingRoomText6 | "The WARDEN tried to face off TEAM ROCKET alone" | "The WARDEN tried to face off against TEAM ROCKET alone" | missing preposition; may need re-wrap |
| text/FuchsiaMeetingRoom.asm | _FuchsiaMeetingRoomTextKoga | "Very well. I will abide to my duties." | "Very well. I will abide by my duties." | wrong preposition |
| text/HauntedHouse.asm | _HauntedRedsHouseConsoleText | "The game is so glitched to be unrecognizable." | "The game is so glitched as to be unrecognizable." | may need re-wrap |
| text/LancesRoom.asm | _LanceBeforeBattleTextRematch2 | "We were struck in awe" | "We were struck with awe" |  |
| text/LancesRoom.asm | _LanceAfterBattleTextRematch2 | "us ELITE FOUR were not the only ones" | "we ELITE FOUR were not the only ones" | pronoun case ("us" used as subject) |
| text/LoreleisRoom.asm | _LoreleiAfterBattleTextRematch | "You didn't disappoint me for the slightest." | "You didn't disappoint me in the slightest." |  |
| text/LoreleisRoom.asm | _LoreleiBeforeBattleTextRematch2 | "We couldn't slack back while you keep becoming stronger" | "We couldn't slack off while you keep becoming stronger" |  |
| text/LoreleisRoom.asm | _LoreleiBeforeBattleTextRematch2 | "today's challenge to the INDIGO PLATEAU is of another level!" | "today's challenge to the INDIGO PLATEAU is on another level!" |  |
| text/LoreleisRoom.asm | _LoreleiAfterBattleText_RP | "But stay assure, my colleagues'll destroy you." | "But stay assured, my colleagues'll destroy you." |  |
| text/MoveDeleter.asm | _MoveDeleterGreetingText_RP | "than opposing a" "violent stronger" "than me." | "than opposing someone more violent than me." | may need re-wrap |
| text/MoveRelearner.asm | _MoveRelearnerGreetingText_RP | "better than" "asking money to" "a criminal." | "asking a criminal for money" | may need re-wrap |
| text/MrPsychicsHouse.asm | _SaffronNewApartmentsText1 | "I miss a bit my spouse and our kid" | "I miss my spouse and our kid a bit" |  |
| text/MrPsychicsHouse.asm | _SaffronNewApartmentsText1 | "kid, though, but I know they're also enjoying" | "kid, but I know they're also enjoying" | redundant "though"/"but" |
| text/MtMoon1F.asm | _MtMoon1AfterBattleText2_BeforeYesNo | "ruled some paths out. Wanna me share my finds?" | "ruled some paths out. Wanna hear my finds?" | scrambled word order; may need re-wrap |
| text/Museum1F.asm | _Museum1FText_RP_NoOurAmber_Before | "You're not gonna touch that AMBER, aren't you?" | "You're not gonna touch that AMBER, are you?" | tag question doesn't match negative statement |
| text/OaksLab.asm | _OaksLabGaryText1 | "pulled another one of their craps and just forgot..." | "pulled another one of their stunts and just forgot..." |  |
| text/OaksLab.asm | _GiovanniBeforeBattleText | "SAMUEL, which welcomed me back with open arms" | "SAMUEL, who welcomed me back with open arms" |  |
| text/OaksLab.asm | _GiovanniBeforeBattleText | "I forgot how a #MON battle not finalized to crash your enemy or steal their life feels." | "I forgot how it feels for a #MON battle not to be about crushing your enemy or stealing their life." | may need re-wrap |
| text/OaksLab.asm | _GiovanniBeforeBattleText | "finally return to my researches, which I abandoned" | "finally return to my research, which I abandoned" |  |
| text/OaksLab.asm | _GiovanniBeforeBattleTextShort | "Would battle mode do you prefer?" | "Which battle mode would you prefer?" | may need re-wrap |
| text/OaksLab.asm | _OaksLabText_AidPikachuInfo1 | "This PIKACHU, although, only respects trainers that it likes." | "This PIKACHU, however, only respects trainers that it likes." |  |
| text/OaksLab.asm | _OaksLabText_AidPikachuInfo2 | "If you'll invest a lot of time in it, you may be greatly rewarded!" | "If you invest a lot of time in it, you may be greatly rewarded!" |  |
| text/OaksLab.asm | _OaksLabOakGivesText | "the little fellow we met shortly ago." | "the little fellow we met a short while ago." | may need re-wrap |
| text/ObsidianHouses.asm | _ObsidianHousesTextFishingSuperGuru_Intro | "Differently from my cousins, who focus on improving their gear, I work on improving my technique." | "Unlike my cousins, who focus on improving their gear, I work on improving my technique." |  |
| text/ObsidianHouses.asm | _ObsidianHousesTextFamily4 | "good enough of a trainer to face them off" | "...to face them down" |  |
| text/ObsidianIsland.asm | _ObsidianIslandText11_Citizen2 | "OBSIDIAN ISLAND prides itself in its respect towards the environment." | "...prides itself on its respect towards the environment." | wrong preposition |
| text/ObsidianIsland.asm | _ObsidianIslandText7_Scientist1_Intro_NoPrompt / _WithPrompt | "had to run away after few steps" | "had to run away after a few steps" | missing article; occurs in both duplicated labels |
| text/ObsidianIsland.asm | _ObsidianIslandText7_Scientist1_HiBackHaveYouDone | "Have you already found out 3 special FIRESTONEs in CINNABAR VOLCANO for me?" | "Have you already found 3 special FIRESTONEs..." | "found out" implies learning info, not locating objects |
| text/ObsidianWarehouse.asm | _ObsidianWarehouseTrainerText2_RP | "That brat had such a wrath!" | "That brat had such wrath!" | "wrath" doesn't take indefinite article |
| text/ObsidianWarehouse.asm | _ObsidianWarehouseTrainerText3_RP | "That brat had such a rage!" | "That brat was in such a rage!" | idiom is "in such a rage" |
| text/ObsidianWarehouseFinal.asm | _ObsidianWarehouseFinalBattleText3 | "letting you arrive till here," | "letting you arrive all the way here," |  |
| text/ObsidianWarehouseFinal.asm | _ObsidianWarehouseFinalAfterBattleText5 | "Nobody will any more follow me." | "Nobody will follow me anymore." |  |
| text/ObsidianWood.asm | _ObsidianWoodEndBattleText1 | "Uh?! I thought you're with TEAM ROCKET!" | "Uh?! I thought you were with TEAM ROCKET!" | tense mismatch |
| text/ObsidianWood.asm | _ObsidianWoodBattleText3 | "Help me training, so I can go and defeat them!" | "Help me train, so I can go and defeat them!" |  |
| text/ObsidianWood.asm | _ObsidianWoodOrageBeforeBattleText | "I am weirdly attracted by OBSIDIAN ISLAND." | "I am weirdly attracted to OBSIDIAN ISLAND." | wrong preposition |
| text/ObsidianWood.asm | _ObsidianWoodOrageBeforeBattleText | "Would you like break the rules and indulge in an INVERSE BATTLE?" | "Would you like to break the rules and indulge in an INVERSE BATTLE?" | missing "to"; may need re-wrap |
| text/ObsidianWood.asm | _ObsidianWoodAfterBattleText3 | "a number of #MON swims from the SAFARI ZONE till here." | "a number of #MON swim from the SAFARI ZONE till here." | subject-verb agreement |
| text/OchreCity.asm | _OchreCity_NPCText8 | "can find a safe place to stay or recover energies." | "...or recover their energy." |  |
| text/OchreGym.asm | _OchreGymAfterBattleText3 | "You may've stood strong to your ideals today" | "You may've stood firm in your ideals today" (or "stayed true to") |  |
| text/OchreGym.asm | _OchreGymAfterBattleText6 | "All-rounded, versatile, deceptively so powerful!" | "All-rounded, versatile, so deceptively powerful!" | word order |
| text/OchreGym.asm | _OragePostBattleAdviceText | "I can see a great potential in you." | "I can see great potential in you." | "potential" usually uncountable here |
| text/OchreHouses.asm | _OchreHousesTextReactivater_Intro | "I much rather prefer enjoying #MON battles!" | "I much prefer enjoying #MON battles!" | redundant "rather" |
| text/OchreHouses.asm | _OchreHousesTextReactivater_Intro | "I can cast it and make so that you can approach again every trainer" | "...and make it so that you can approach again every trainer" | missing "it" |
| text/OchreHouses.asm | _OchreHousesTextReactivater_Done | "there are a handful of elite trainers which have not been affected" | "...trainers who have not been affected" | relative pronoun for people |
| text/OchreHouses.asm | _OchreHousesTextBirbFan_AcknowledgeMissingno | "an actual BIRD-type #MON! I never saw one!" | "...I've never seen one!" | tense |
| text/OchreRehabilitationCenter.asm | _OchreRehabilitationCenterText5_Once | "It's severely forbidden to bother the recovering BIRDs!" | "It's strictly forbidden to bother the recovering BIRDs!" |  |
| text/OchreResearchCenter1.asm | _OchreResearchCenter1Text_Power_Windworks_WowAlreadyDefeated | "You indeed do be a powerful TRAINER!" | "You indeed are a powerful TRAINER!" | broken verb construction |
| text/OchreResearchCenter2.asm | _OchreResearchCenter2Text_Fossils_Unova | "get a good idea at how living beings really look like..." | "get a good idea of what living beings really look like..." |  |
| text/OchreResearchCenter2.asm | _OchreResearchCenter2Text_Fossils_Galar | "To think at all the time we could have saved" | "To think of all the time we could have saved" | missing "of" |
| text/PalletTown.asm | _DarkGuideHints_Hint2_Solution | "any your wish will be granted." | "your wish will be granted." | "any your wish" isn't standard English |
| text/PalletTown.asm | _DarkGuideHints_Hint1_Solution | "and if you will win against both of CHAMPION's teams" | "and if you win against both of CHAMPION's teams" | conditional clause shouldn't use "will" |
| text/PalletTown.asm | _PalletTownTextDarkGuide_RP_Before | "hopes of every and anyone in the whole KANTO?" | "hopes of everyone in the whole of KANTO?" | may need re-wrap |
| text/PewterCity.asm | _PewterCityTextNewRoute | "I tried it out, but is very steep and I haven't completed it yet." | "I tried it out, but it is very steep and I haven't completed it yet." | missing subject pronoun |
| text/PewterCity.asm | _PewterCityCoinCaseMeowthText_HintNext | "MEOWTH ran towards south!" | "MEOWTH ran towards the south!" | missing article; may need re-wrap |
| text/PewterGym.asm | _TM34ExplanationText | "you can buy again TMs you have already acquired!" | "you can buy TMs you have already acquired again!" | may need re-wrap |
| text/PokemonTower2F.asm | _PokemonTower2Text_6062d | "How do" "you dare showing" "your face, HERE" | "How dare you show your face, HERE" |  |
| text/RedsHouse1F.asm | _RedsHouse1FTVText_RP_Front | "Some dumb old movie nobody knows nor care for." | "...nobody knows nor cares for." | subject-verb agreement |
| text/RocketHideoutB4F.asm | _RocketHideoutJessieJamesText2 | "How did you dare humiliating us at MT.MOON!" | "How did you dare to humiliate us at MT.MOON!" | may need re-wrap |
| text/RocketHideoutB4F.asm | _RocketHideout4Text_GiovanniPostBattle | "I'll strengthen my weapons, and will exact my revenge!" | "I'll strengthen my weapons and exact my revenge!" |  |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_GoToTower | "Two are the goals: fetching rare #MON, and get that old geezer" | "There are two goals: fetching rare #MON, and getting that old geezer" | may need re-wrap |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_GoToTower | "You need to know no more about it." | "You don't need to know any more about it." | may need re-wrap |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_GoToTower | "that old stubborn doesn't intend to collaborate" | "that stubborn old man doesn't intend to collaborate" | may need re-wrap |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_GoToTowerSummary | "help us rescuing that failed project" | "help us rescue that failed project" |  |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_GoToSevii | "come reporting to me." | "come report to me." |  |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_GoToSeviiSummary | "come reporting to me." | "come report to me." |  |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_WellDoneWithCelio | "you helped convincing CELIO." | "you helped convince CELIO." |  |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_ProblemsAtWarehouses | "I already dispatched some personnel at both locations" | "I already dispatched some personnel to both locations" |  |
| text/RocketHideoutB4F.asm | _RocketHideout4Text0_RP_GoToWarehouses | "I soon have busi-ness to attend at SILPH CO.." | "I'll soon have business to attend to at SILPH CO.." | may need re-wrap |
| text/Route16FlyHouse.asm | _Route16HouseText1_RP_PreFly | "Don't you dare" "hurting it!" | "Don't you dare hurt it!" |  |
| text/Route18Gate1F.asm | _Route18And16GateText1_RP | "Only bike would be allowed on CYCLING ROAD." | "Only bikes would be allowed on CYCLING ROAD." | missing plural |
| text/Route20.asm | _Route20AfterBattleText1 | "But I find super scary!" | "But I find it super scary!" | missing "it" |
| text/Route20.asm | _Route20SpecialBirdKeeperText_AfterBattle | "dedication to birbs' unwavering as a glacier!" | "dedication to birbs is unwavering as a glacier!" | missing "is"; stray apostrophe on "birbs'" |
| text/Route20.asm | _Route20DiveAfterBattleText2 | "(What do you mean with 'Steps'?)" | "(What do you mean by 'Steps'?)" |  |
| text/Route22.asm | _Route22RivalBeforeBattleText2 | "never has had a more" "fitting team!" | "has never had a more fitting team!" |  |
| text/Route24.asm | _Route24Text_WannaJoinOffer1 | "dedicated to evil using #MON!" | "dedicated to using #MON for evil!" | may need re-wrap |
| text/Route25.asm | _Route25Text14 | "it seems it's tough to get in the city lately." | "...tough to get into the city lately." |  |
| text/Route25.asm | _Route25Text14 | "only accepts members on invitation..." | "only accepts members by invitation..." |  |
| text/Route25.asm | _Route25TextToHauntedHouseMessage1 | "Stop in your way. Do not proceed." | "Stop where you are. Do not proceed." | phrasing doesn't parse naturally; possibly intentional cryptic voice |
| text/Route26.asm | _Route26BattleText1 | "Hey! Are you wanna steal my special ONIX?!" | "Hey! You wanna steal my special ONIX?!" |  |
| text/Route29.asm | _Route29AfterBattleText5 | "one's reality can't avoid but swinging like a pendulum between them" | "can't help but swing like a pendulum" | may need re-wrap |
| text/Route29.asm | _Route29AfterBattleText5 | "them, seen how all is linked." | "them, seeing how all is linked." |  |
| text/Route29.asm | _Route29AfterBattleText7 | "trying to figure something out of these ancient words" | "figure something out from these ancient words" |  |
| text/Route29.asm | _Route29TextOrbsVanish2 | "Three immense flows of power have erupted and got channeled in three locations!" | "have erupted and been channeled" |  |
| text/Route3.asm | _Route3TextJenny | "TEAM ROCKET uses this ROUTE for its traffics." | "TEAM ROCKET uses this ROUTE for its trafficking." |  |
| text/Route9.asm | _Route9BattleText4 | "Don't you dare" "condescend me!" | "Don't you dare condescend to me!" | may need re-wrap |
| text/SSAnne2F.asm | _SSAnneRivalDefeatedText | "How? Why?! It should have not gone like this!!!" | "How? Why?! It should not have gone like this!!!" |  |
| text/SSAnneCaptainsRoom.asm | _SSAnne7TextCaptain_PreBattle | "Police is investigating to find TEAM ROCKET's accomplice" | "The police are investigating to find TEAM ROCKET's accomplice" |  |
| text/SSAnneCaptainsRoom.asm | _SSAnne7TextJenny | "As soon as you'll be of age, what about joining the police force officially?" | "Once you're of age, what about joining the police force officially?" |  |
| text/SaffronCity.asm | _SaffronCityText_BlockingSilph_RP_After_GoodTakeThis | "Congrats for earning the BOSS's approval." | "Congrats on earning the BOSS's approval." | wrong preposition |
| text/SaffronCity.asm | _SaffronClimbClubText1_OhWelcomeHaveThis | "Please, have this as welcome gift." | "Please, have this as a welcome gift." | missing article; may need re-wrap |
| text/SaffronGym.asm | _SaffronGymBattleText8 | "like SABRINA, but despite so I can foresee" | "like SABRINA, but even so I can foresee" | "despite so" is not standard phrasing |
| text/SaffronPidgeyHouse.asm | _SaffronHouse1Text1 | "At least with my partner is much easier, as we live together!" | "At least with my partner, it's much easier, as we live together!" | missing subject "it" |
| text/SeviiEightIsland.asm | _SeviiEightIslandCaveTextScript9 | "We'll do like this: show your skills." | "We'll do it like this: show your skills." | missing "it" |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandCityText2 | "repurposed as concert hall." | "repurposed as a concert hall." | missing article; may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandCityText1 | "you always come back at the entrance!" | "you always come back to the entrance!" |  |
| text/SeviiFiveIsland1.asm | _SeviiRoute34AfterBattleText3 | "keep coming back at the entrance." | "keep coming back to the entrance." | same recurring slip as above |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandCityScriptText4 | "What a timing!" | "What timing!" |  |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandCityScriptText5 | "when it comes to protect my home." | "when it comes to protecting my home." | missing gerund; may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandHousesTextMonsCommon | "and well-cared!" | "and well cared for!" | may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandWarehouse2FText1_Inner | "I won't let you in the ways of my goal." | "I won't let you stand in the way of my goal." | may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiFiveIslandWarehouse2FScriptText3 | "I felt I relied again on you to solve our mess." | "I felt like I relied on you again to solve our mess." | may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiRoute35AfterBattleText1_HP | "What it means? Beats me!" | "What does it mean? Beats me!" | may need re-wrap |
| text/SeviiFiveIsland1.asm | _SeviiRoute36BattleText5 | "they are no match to me." | "they are no match for me." |  |
| text/SeviiFiveIsland2.asm | _SeviiRoute34Text1_RP | "you won't just repeat my same mistakes" | "repeat my own mistakes" / "the same mistakes I made" |  |
| text/SeviiFiveIsland2.asm | _SeviiFiveIslandWarehouse2FText1_RP_After | "It's not good to make your BOSS wait, isn't it?" | "...wait, is it?" |  |
| text/SeviiFiveIsland2.asm | _SeviiFiveIslandWarehouse2FScriptText2_RP | "Oh, you've NO IDEA how gruesome and atrocious was my training." | "how gruesome and atrocious my training was." |  |
| text/SeviiFiveIsland2.asm | _SeviiFiveIslandWarehouse2FScriptText2_RP | "and YOU, you most than any one!" | "and YOU, you most of all!" / "more than anyone!" |  |
| text/SeviiFiveIsland2.asm | _SeviiFiveIslandWarehouse2FScriptText3_RP | "Why the fuck I had to lose again?!" | "Why the fuck did I have to lose again?!" |  |
| text/SeviiFiveIsland2.asm | _SeviiFiveIslandWarehouse1FText1_RP | "that kid which just arrived and stormed everyone?" | "that kid who just arrived" |  |
| text/SeviiFiveIsland2.asm | _SeviiLostCave2Text1_RP_BeforeWaterfall | "A ROCKET, of all people, be the first to find their way to me." | "...is the first to find their way to me." |  |
| text/SeviiFiveIsland2.asm | _SeviiLostCave2Text1_RP_BeforeWaterfall | "I will gift you this precious item...you will lead me to safety out from here!" | "lead me to safety out of here!" |  |
| text/SeviiFiveIsland2.asm | _SeviiLostCave2Text1_RP_AfterWaterfall | "it's time to hold up to your part of our agreeme-" | "time to hold up your end of our agreeme-" |  |
| text/SeviiFiveIsland2.asm | _SeviiLostCave2Text1_RP_AfterWaterfall | "Wh... what? What do you... What means 'No'?!" | "What do you mean, 'No'?!" |  |
| text/SeviiFiveIsland2.asm | _SeviiRoute36SignText1_RP_PostDesecration | "If one didn't know better, would say that it's crying." | "one would say that it's crying." |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandHousesText4_PreChrono | "Why is the police up to nothing?" | "Why are the police up to nothing?" |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandHousesScriptText5 | "I can't accept to not know if I'm now strong enough" | "I can't accept not knowing if I'm now strong enough" | may need re-wrap |
| text/SeviiFourIsland.asm | _PinksHousePinkBeatYouText | "Am I already arrived?" | "Have I already arrived?" |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandGymText4_Reward3 | "Once you'll beat every other SAGE" | "Once you beat every other SAGE" |  |
| text/SeviiFourIsland.asm | _SeviiFourIslandParkourPathText1 | "The rule is only one, & as simple as it gets" | "There's only one rule, & as simple as it gets" | may need re-wrap |
| text/SeviiFourIsland.asm | _SeviiFourIslandParkourPathText1_RP | "the strive to improvement" | "the drive to improve" | may need re-wrap |
| text/SeviiFourIsland.asm | _SeviiFourIslandHousesText6 | "I cannot help myself but buy more and more furniture" | "I cannot help but buy more and more furniture" | may need re-wrap |
| text/SeviiIslandsCommon.asm | _HideAllUndergroundGuards_RP_Text1 | "Why hurting me?" | "Why are you hurting me?" |  |
| text/SeviiIslandsCommon.asm | _SeviiUndergroundText1_ThisButtonAlreadyPressed | "stones're shining." | "stones are shining." | unusual contraction with plural noun |
| text/SeviiIslandsCommon.asm | _SeviiIslandGymText_NoRewardWannaFight | "I cannot reward you if you won." | "I cannot reward you if you win." | tense mismatch in conditional |
| text/SeviiIslandsCommon.asm | _SeviiNoRewardsIfAnomalies | "they won't be able to reward you if you won." | "they won't be able to reward you if you win." | tense mismatch in conditional |
| text/SeviiOneIsland.asm | _SeviiOneIslandCityText4 | "Why didn't teach me anything?!" | "Why didn't they teach me anything?!" |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandCityScriptText1 | "Now, if you excuse me, I have to go back to work." | "Now, if you'll excuse me, I have to go back to work." |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesText2 | "And the police is totally useless!" | "And the police are totally useless!" |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesText11 | "they can't go much outside." | "they can't go outside much." |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandPokemonCenterAndMart_Text2 | "Here we don't have good connection." | "Here we don't have a good connection." |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandGym2Text3_Reward3 | "Were you to conquer each and every one SHRINE" | "Were you to conquer each and every one of the SHRINEs" |  |
| text/SeviiOneIsland.asm | _SeviiEmberSpaText3 | "Bathing in these spa is the most relaxing thing..." | "Bathing in this spa is the most relaxing thing..." |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandCityScriptText4_RP | "I must report to the central." | "I must report to headquarters." | may need re-wrap |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesText12_RP_AfterPink | "If only I was a trainer... but I'm so powerless." | "If only I were a trainer... but I'm so powerless." |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesText4_RP_PostGiovanni | "at the best of my possibilities." | "to the best of my ability." |  |
| text/SeviiOneIsland.asm | _SeviiOneIslandHousesScriptText2_RP | "No! Wait! You never battled before!" | "No! Wait! You've never battled before!" |  |
| text/SeviiRoute37EndBattleText1 (same file) | _SeviiRoute37EndBattleText1 | "You're" "up and beyond!" | "You're" "above and beyond!" | idiom is "above and beyond" |
| text/SeviiSevenIsland.asm | _SeviiRoute42BattleText7 | "How dare you" "invading my" "secret special" "hunting ground?!" | "How dare you invade my secret special hunting ground?!" |  |
| text/SeviiSevenIsland.asm | _SeviiSevenIslandGym2DiveAfterBattleText3 | "If you'll try" "again, you'll" "know what to pick" "up and where.)" | "If you try again, you'll know what to pick up and where.)" | wrong tense after "if" |
| text/SeviiSevenIsland.asm | _SeviiSevenIslandGym3Text16_Reward3 | "If you'll go on and" "conquer every" "SHRINE, then you" | "If you go on and conquer every SHRINE, then you" | wrong tense after "if" |
| text/SeviiSevenIsland.asm | _SeviiSevenIslandGym3AfterBattleText4 | "Differently from" "any other SHRINE," | "Unlike any other SHRINE," |  |
| text/SeviiSevenIsland.asm | _SeviiRoute42AfterBattleText3 | "I can live myself" "at my fullest" | "I can live my life to the fullest" |  |
| text/SeviiSevenIsland.asm | _SeviiRoute44Text1 | "...and those weird" "folks short ago." | "...and those weird folks a while ago." |  |
| text/SeviiSevenIsland.asm | _SeviiTanobyChambersScriptText6 | "SIRD: You got in" "my ways, but my" | "SIRD: You got in my way, but my" |  |
| text/SeviiSevenIsland.asm | _SeviiTanobyChambersScriptText7 | "ORM: I and those" "two may not go" "along the best," | "ORM: Those two and I may not get along the best," | word order + wrong verb |
| text/SeviiSevenIsland.asm | _SeviiTanobyChambersScriptText7 | "smash once I'll be" "done grinding you!" | "smash once I'm done grinding you!" | wrong tense after "once" |
| text/SeviiSevenIsland.asm | _SeviiTanobyChambersScriptText5_RP | "nor TEAM ROCKET" "have any value." | "nor TEAM ROCKET has any value." | subject-verb agreement |
| text/SeviiSevenIsland.asm | _SeviiTanobyChambersScriptText4_RP | "All I want is to" "TEAM ROCKET." | "All I want is to own TEAM ROCKET." | missing verb |
| text/SeviiSixIsland1.asm | _SeviiSixIslandPokemonCenterAndMart_Text2 | "Wouldn't you like" "if days were" "longer?" | "Wouldn't you like it" "if days were" "longer?" | missing "it"; may need re-wrap |
| text/SeviiSixIsland1.asm | _SeviiSixIslandHousesText2 | "my old one is, eh, old," "and I gotta keep" "an eye on 'em." | "...keep an eye on 'im." | pronoun mismatch: "one" (singular) vs "'em" (plural) |
| text/SeviiSixIsland1.asm | _SeviiSixIslandHousesText4 | "so I" "must play indoor." | "so I" "must play indoors." | missing "s" |
| text/SeviiSixIsland1.asm | _SeviiSixIslandGym3Text1_Intro | "after taking many" "choices." | "after making many" "choices." | "taking choices" is unnatural; "making choices" is the standard idiom |
| text/SeviiSixIsland1.asm | _SeviiSixIslandGym3Text1_Intro | "Let's find it out." | "Let's find out." | extra "it" |
| text/SeviiSixIsland1.asm | _SeviiRoute37AfterBattleText10 | "One stroke at the" "time, and you can" | "One stroke at a" "time, and you can" | "at a time" not "at the time" |
| text/SeviiSixIsland1.asm | _SeviiRoute37AfterBattleText12 | "but the path to" "it impervious." | "but the path to" "it is impervious." | missing verb "is"; may need re-wrap |
| text/SeviiSixIsland1.asm | _SeviiRoute38Text2 | "Nobody understood" "what they mean." | "Nobody understands" "what they mean." | tense mismatch (ongoing truth, not past event) |
| text/SeviiSixIsland1.asm | _SeviiRoute38HousesText1_TankExplanation | "Now you can DIVE" "double as long!" | "Now you can DIVE" "twice as long!" | "double as long" is unnatural phrasing |
| text/SeviiSixIsland1.asm | _SeviiRoute38DiveCavernAfterBattleText3 | "(We come playing" "here since we're" "toddlers.)" | "(We've been coming to" "play here since we" "were toddlers.)" | tense/aspect mismatch with "since"; may need re-wrap |
| text/SeviiSixIsland1.asm | _SeviiRoute38DiveCavernAfterBattleText4 | "names. Guess how" "they called us?)" | "names. Guess what" "they called us?)" | asking for the name itself calls for "what," not "how" |
| text/SeviiSixIsland1.asm | _SeviiRoute39Text2 | "When I wish some-" "where more lively" | "When I want to be" "somewhere more lively" | "wish somewhere" is missing a verb/preposition; may need re-wrap |
| text/SeviiSixIsland1.asm | _SeviiRoute40AfterBattleText3 | "Rumors have that" "it's somehow" | "Rumor has it that" "it's somehow" | mixed idiom ("rumor has it" vs "rumors say") |
| text/SeviiSixIsland1.asm | _SeviiRoute40EndBattleText4 | "Seven sins for" "his reborn!" | "Seven sins for" "his rebirth!" | "reborn" used as a noun |
| text/SeviiSixIsland2.asm | _SeviiSecretBeachHouseText3 | "You or your team are tired? Please use the bed..." | "Are you or your team tired? Please use the bed..." | statement/question mismatch |
| text/SeviiSixIsland2.asm | _SeviiDottedHoleTextScript7 | "I hope you three garbage proved yourself not completely worthless" | "...proved yourselves not completely worthless" | plural agreement ("you three") |
| text/SeviiSixIsland2.asm | _SeviiRoute38HousesText1_RP_TakeThis | "not well enough to keep up with a filth like you" | "...to keep up with filth like you" | "filth" is uncountable |
| text/SeviiSixIsland2.asm | _SeviiDottedHoleTextScript3_RP | "Why attacking us instead of answe-" | "Why are you attacking us instead of answe-" | missing auxiliary verb (low confidence — may be intentional interrupted speech) |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesText5 | "so moving it's not a problem for me" | "so moving isn't a problem for me" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText6_Shelf3_Book3 | "three adult and one old humanoid beagles" | "three adult humanoid beagles and one old one" | may need re-wrap |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText8_Shelf3_Book2 | "the characters're awesome" | "the characters are awesome" |  |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesBookshelfText8_Shelf3_Book2 | "the plot captivating as nothing else" | "the plot is captivating as nothing else" | may need re-wrap |
| text/SeviiThreeIsland.asm | _SeviiRoute33AfterBattleText3 | "ask the one in city." | "ask the one in the city." | may need re-wrap |
| text/SeviiThreeIsland.asm | _SeviiBerryForestScriptText1 | "until our dear CELIO doesn't turn reasonable and work with us." | "until our dear CELIO turns reasonable and works with us." |  |
| text/SeviiThreeIsland.asm | _SeviiBerryForestOrmDefeatText | "How do you dare upset our BOSS?!" | "How dare you upset our BOSS?!" |  |
| text/SeviiThreeIsland.asm | _SeviiBerryForestScriptText4_RP | "we'll do like this: go" | "we'll do it like this: go" | may need re-wrap |
| text/SeviiThreeIsland.asm | _SeviiThreeIslandHousesText2_RP_Before | "Don't you dare hurting my kid!!!" | "Don't you dare hurt my kid!!!" |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandCityText3 | "it's a special charm you can't find anywher'else!" | "it has a special charm you can't find anywhere else!" |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandCityText6_LetsGamble | "Amazing! I wish best of luck!" | "Amazing! I wish you the best of luck!" | may need re-wrap |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandCityScriptText1 | "I should've not accepted to work with TEAM ROCKET." | "I shouldn't have accepted to work with TEAM ROCKET." |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandPokemonCenter_Text2_Intro | "If only there was a #MON with both these types!" | "If only there were a #MON with both these types!" |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandHousesText2_Question | "My sibling and I are both expert in meteorology." | "My sibling and I are both experts in meteorology." |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandHousesText7 | "one of the very few open-sea area in SEVII" | "one of the very few open-sea areas in SEVII" |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandHousesText9 | "My specialization is on ancient populations." | "My specialization is in ancient populations." |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandHousesText11 | "Was maybe the sea less rough centuries ago?" | "Was the sea maybe less rough centuries ago?" | may need re-wrap |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandGymText1_Intro1 | "draw out the best out of what Fate'll offer you?" | "draw the best out of what Fate'll offer you?" |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandGymText4_Reward3 | "Once you'll have defeated all my colleagues" | "Once you have defeated all my colleagues" |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIsletText1 | "I heard that in SAFFRON CITY is a CLIMB CLUB" | "I heard that there is a CLIMB CLUB in SAFFRON CITY" | may need re-wrap |
| text/SeviiTwoIsland.asm | _SeviiTwoIsletHousesText1_Intro | "your #MON ATK will go at its lowest!" | "your #MON ATK will drop to its lowest!" |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIsletHousesText2_Intro | "your #MON SPEED'll go at its lowest!" | "your #MON SPEED'll drop to its lowest!" |  |
| text/SeviiTwoIsland.asm | _SeviiTwoIsletHousesSignText1 | "There's written about a rumored SHINY CHARM" | "There's something written about a rumored SHINY CHARM" | may need re-wrap |
| text/SeviiTwoIsland.asm | _SeviiTwoIslandCityText8_AfterRiders (RP block) | "Didn't tell us what business had there, though..." | "Didn't tell us what business they had there, though..." |  |
| text/SilphCo11F.asm | _SilphCo11Text1_RP | "I can give you lot of money!" | "I can give you a lot of money!" |  |
| text/SilphCo11F.asm | _SilphCo11TextGiovanni_RP_NotAllBirbs | "Come back when you've them." | "Come back when you have them." | may need re-wrap |
| text/SilphCo11F.asm | _SilphCo11TextGiovanni_RP_NoGene | "Then why are you wasting your and my time?" | "Then why are you wasting your time and mine?" |  |
| text/SilphCo11F.asm | _SilphCo11TextGiovanni_RP_FujiToldUs | "And the good news keep coming!" | "And the good news keeps coming!" |  |
| text/SilphCo11F.asm | _SilphCo11TextGiovanni_RP_NowBegone | "Somebody who grew so quickly and become so strong." | "Somebody who grew so quickly and became so strong." |  |
| text/SilphCo7F.asm | _HeresYourPorygonText | "traveling through the cyberspace!" | "traveling through cyberspace!" | extra article |
| text/SilphCo7F.asm | _HeresYourPorygonText | "Sorry, I got lost in thoughts." | "Sorry, I got lost in thought." | idiom is "lost in thought" |
| text/SilphCo7F.asm | _HeresYourPorygonText | "Rumors said that in another department" | "Rumors say that in another department" | tense mismatch |
| text/SilphCo7F.asm | _SilphCo7Text_51ec3 | "I came here at SILPH to try to" | "I came to SILPH to try to" | "here at" is redundant/odd; may need re-wrap |
| text/SunkenShip.asm | _SunkenShipLoreText_33 | "Vacation equipment including beach kid toys." | "Vacation equipment including kids' beach toys." | may need re-wrap |
| text/SunkenShip.asm | _SunkenShipLoreText_37 | "a suffocating grip tightens the chest." | "a suffocating grip tightens around the chest." | may need re-wrap |
| text/SunkenShip.asm | _GiveCombination18Text | "Along what seem thief tools, a quickly scribbled note" | "Along what seem to be thief's tools, a quickly scribbled note" | may need re-wrap |
| text/SunkenShip.asm | _SunkenShipCaptainsLogText_Page0 | "Forecasts're good." | "The forecast is good." | may need re-wrap |
| text/SunkenShip.asm | _SunkenShipCaptainsLogText_Page4 | "I've been reported two thefts" | "Two thefts have been reported to me" | may need re-wrap |
| text/SunkenShip.asm | _SunkenShipCaptainsLogText_Page5 | "push us out of path and into the rocks" | "push us off course and into the rocks" |  |
| text/SunkenShip.asm | _SunkenShipLoreText_13 | "so much sediment that can't be opened." | "so much sediment that it can't be opened." | may need re-wrap |
| text/SunkenShip.asm | _SunkenShipLoreText_18 | "It narrates of a wonderful vacation" | "It tells of a wonderful vacation" |  |
| text/VermilionCity.asm | _ElderBattleFacilityText2 | "Come and enjoy at your fullest my BATTLE FACILITY!" | "Come and enjoy my BATTLE FACILITY to the fullest!" | awkward word order |
| text/VermilionCity.asm | _VermilionCityText7_RP_PoorSquirtle | "I'm so shameful..." | "I'm so ashamed..." | wrong word (shameful describes the act, not the feeling) |
| text/VermilionCity.asm | _VermilionCityText7_RP_OhNoSquirtle | "JENNY: What do you want from me yet?" | "JENNY: What more do you want from me?" |  |
| text/VictoryRoad1F.asm | _VictoryRoad1AfterBattleText_RP_YesUs | "Short ago, someone who looked so eerily like me stormed by" | "Not long ago, someone who looked so eerily like me stormed by" |  |
| text/VictoryRoad1F.asm | _VictoryRoad1AfterBattleText4_RP | "My alter ego looked like was devoured by sadness and anger" | "My alter ego looked like he was devoured by sadness and anger" | missing pronoun |
| text/VictoryRoad3F.asm | _VictoryRoad3AfterBattleText9 | "I'm already so happy of what my bugs and I have achieved so far!" | "I'm already so happy about what my bugs and I have achieved so far!" | wrong preposition |
| text/ViridianCity.asm | _ViridianCityText_19175 | "we have to wait until they sobers up." | "...until they sober up." | subject-verb agreement |
| text/ViridianForest.asm | _ViridianForestErikaBeforeBattleText | "I jogged" "till here all the" "way from CELADON," | "I jogged all the way here from CELADON," | redundant "till here" + "all the way"; may need re-wrap |
| text/ViridianGym.asm | _ViridianGymGiovanniPostBattleText | "...I see... you remind me the myself of so, so many, too many years ago..." | "...you remind me of myself, so, so many, too many years ago..." | garbled phrasing |
| text/ViridianGym.asm | _ViridianGymGuideText_PostLeague_Intro_Long | "And also quite a luck." | "And also quite a stroke of luck." | "luck" uncountable; may need re-wrap |
| text/ViridianGym.asm | _ViridianGymGuideText_PostLeague_AmazingLetsGo | "Thanks a ton, it's huge help for us!" | "...it's a huge help for us!" | missing article; may need re-wrap |
| text/ViridianGym.asm | _ViridianGymChallengerPreBattleText_4 | "But now, NOW I went all out my way to fetch all the secret items" | "...I went all out of my way to fetch..." | missing "of" |
| text/ViridianGym.asm | _ViridianGymChallengerPostBattleText_4 | "I just want to finished this damn adventure!" | "I just want to finish this damn adventure!" | tense error |
| text/ViridianSchoolHouse.asm | _SchoolText4 | "In the OPTION menus, it gives you extra infos!" | "In the OPTION menus, it gives you extra info!" |  |
| text/ViridianSchoolHouse.asm | _SchoolText6 | "LEECH SEED drain 1/8 of its max HP and give them to the opponent." | "LEECH SEED drains 1/8 of its max HP and gives it to the opponent." | subject-verb agreement |
| text/ViridianSchoolHouse.asm | _SchoolText7 | "But if they do that on me, I learned I just need to switch" | "But if they do that to me, I learned I just need to switch" |  |
| text/ViridianSchoolHouse.asm | _SchoolText9 | "so-called Same Type Attack Bonus or STAB in short." | "so-called Same Type Attack Bonus or STAB for short." |  |
| text/WardensHouse.asm | _FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoArtifact | "If you really wish something but you can't afford it" | "If you really wish for something" |  |
| text/WardensHouse.asm | _FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesArtifact | "Could I interest you with a trade?" | "Could I interest you in a trade?" |  |
| text/WardensHouse.asm | _FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesTrade | "You made this old antique dealer so really happy!" | "so happy!" / "really happy!" |  |
| text/WardensHouse.asm | _BeatGiovanniAmazementText | "Thank you so immensely much!!!" | "Thank you so much, immensely!!!" |  |
| text/WardensHouse.asm | _FuchsiaHouse2AntiquitiesTextShopOwner_RP_ArtifactInBag | "You wouldn't dare setting it on fi-" | "You wouldn't dare set it on fi-" |  |
| text/WardensHouse.asm | _FuchsiaHouse2AntiquitiesTextShopOwner_RP_ArtifactBreaks | "<PLAYER> gives the ARTIFACT to the seller. But ACCIDENTALLY it falls and breaks into a million pieces." | "gave...it fell and broke" (tense mismatch with other narration lines, which use past tense) |  |
