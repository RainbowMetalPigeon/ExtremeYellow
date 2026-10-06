# ExtremeYellow Dialogue Review — Typos & Awkward Grammar

Full sweep of `text/*.asm` and the dialogue-bearing files in `data/text/*.asm` (item descriptions, system/menu strings, rocket-path battle intros). Entries note "may need re-wrap" where a fix changes the character count of a line, since in-game text boxes are fixed-width (~18 chars/line) and re-splitting across `line`/`cont`/`para` wasn't attempted here.

**227 typo/mistake findings, 316 awkward-grammar findings** across all 269 dialogue files.

| File | Label | Original | Suggested Fix | Note |
| --- | --- | --- | --- | --- |
| text/BillsHouse.asm | _BillsHouseText3_MapAlreadyShown | "found out the map... I didn't manage to convince them" | "found the map... I didn't manage to convince them" | "found out" fits facts/info, not a physical object; may need re-wrap |
| text/BillsHouse.asm | _BillsHouseText3_MapAlreadyShown | "things were going well and smooth" | "things were going well and smoothly" | adjective/adverb mismatch; may need re-wrap |
| text/BillsHouse.asm | _BillsHouseText3_MapAlreadyShown | "in a split second was a nightmare." | "in a split second it was a nightmare." | missing subject "it"; may need re-wrap |
| text/CeladonCity.asm | _TM41ExplanationText | "because the user too takes damage!" | "because the user also takes damage!" |  |
| text/CeladonCity.asm | _CeladonCityText4 | "Despite so, it feels so isolated" | "Even so, it feels so isolated" |  |
| text/CeruleanBadgeHouse.asm | _CeruleanHouse2Text_74e77 | "the more you have," "the stronger are" "the #MON that" "will follow your" "orders!" | "the stronger the #MON that will follow your orders will be!" | may need re-wrap |
| text/CinnabarGym.asm | _CinnabarGymBattleText1 | "I was a thief, but I became straight as a trainer!" | "I was a thief, but I went straight and became a trainer!" | may need re-wrap |
| text/CinnabarGym.asm | _CinnabarGymGuidePreBattleText | "Yo! Champ in making!" | "Yo! Champ in the making!" | may need re-wrap |
| text/CinnabarIsland.asm | _CinnabarIslandTextNewPerson8 | "in the clearest days!" | "on the clearest days!" |  |
| text/CinnabarLab.asm | _Lab1Text2_Archeologist_PostReturnRelic_FirstTime | "the greatest testament of my life achievements" | "the greatest testament to my life achievements" | "testament to", not "of" |
| text/DiglettsCaveRoute11.asm | _DiglettsCaveEntRoute11Text1_BeforeSurge | "to take some measurements, and now all #MON are hiding..." + "as soon as the fear will pass." | "...as soon as the fear passes." | tense mismatch |
| text/DiglettsCaveRoute11.asm | _DiglettsCaveEntRoute11Text1_BeforeSurge | "went into the DIGLETT's CAVE short ago" | "went into the DIGLETT's CAVE a short while ago" | may need re-wrap |
| text/FuchsiaGym.asm | _KogaSoulBadgeInfoText | "if you desire so." | "if you so desire." |  |
| text/FuchsiaGym.asm | _FuchsiaGymBattleText1 | "Strength isn't the key for #MON!" | "Strength isn't the key to #MON battles!" | may need re-wrap |
| text/FuchsiaGym.asm | _FuchsiaGymGuidePreBattleText | "Yo! Champ in making!" | "Yo! Champ in the making!" | may need re-wrap |
| text/FuchsiaGym.asm | _FuchsiaGymAfterBattleText_Common | "you don't know who is KOGA!" | "you don't know who KOGA is!" |  |
| text/FuchsiaGym.asm | _KogaBeforeBattleText_RP | "You dare facing me, KOGA" | "You dare face me, KOGA" |  |
| text/FuchsiaMeetingRoom.asm | _FuchsiaMeetingRoomText6 | "The WARDEN tried to face off TEAM ROCKET alone" | "The WARDEN tried to face off against TEAM ROCKET alone" | missing preposition; may need re-wrap |
| text/FuchsiaMeetingRoom.asm | _FuchsiaMeetingRoomTextKoga | "Very well. I will abide to my duties." | "Very well. I will abide by my duties." | wrong preposition |
| text/HauntedHouse.asm | _HauntedRedsHouseConsoleText | "The game is so glitched to be unrecognizable." | "The game is so glitched as to be unrecognizable." | may need re-wrap |
| text/MoveDeleter.asm | _MoveDeleterGreetingText_RP | "than opposing a" "violent stronger" "than me." | "than opposing someone more violent than me." | may need re-wrap |
| text/MoveRelearner.asm | _MoveRelearnerGreetingText_RP | "better than" "asking money to" "a criminal." | "asking a criminal for money" | may need re-wrap |
| text/MrPsychicsHouse.asm | _SaffronNewApartmentsText1 | "I miss a bit my spouse and our kid" | "I miss my spouse and our kid a bit" |  |
| text/MrPsychicsHouse.asm | _SaffronNewApartmentsText1 | "kid, though, but I know they're also enjoying" | "kid, but I know they're also enjoying" | redundant "though"/"but" |
| text/MtMoon1F.asm | _MtMoon1AfterBattleText2_BeforeYesNo | "ruled some paths out. Wanna me share my finds?" | "ruled some paths out. Wanna hear my finds?" | scrambled word order; may need re-wrap |
| text/Museum1F.asm | _Museum1FText_RP_NoOurAmber_Before | "You're not gonna touch that AMBER, aren't you?" | "You're not gonna touch that AMBER, are you?" | tag question doesn't match negative statement |
| text/ObsidianWarehouse.asm | _ObsidianWarehouseTrainerText2_RP | "That brat had such a wrath!" | "That brat had such wrath!" | "wrath" doesn't take indefinite article |
| text/ObsidianWarehouse.asm | _ObsidianWarehouseTrainerText3_RP | "That brat had such a rage!" | "That brat was in such a rage!" | idiom is "in such a rage" |
| text/ObsidianWood.asm | _ObsidianWoodEndBattleText1 | "Uh?! I thought you're with TEAM ROCKET!" | "Uh?! I thought you were with TEAM ROCKET!" | tense mismatch |
| text/ObsidianWood.asm | _ObsidianWoodBattleText3 | "Help me training, so I can go and defeat them!" | "Help me train, so I can go and defeat them!" |  |
| text/ObsidianWood.asm | _ObsidianWoodOrageBeforeBattleText | "I am weirdly attracted by OBSIDIAN ISLAND." | "I am weirdly attracted to OBSIDIAN ISLAND." | wrong preposition |
| text/ObsidianWood.asm | _ObsidianWoodOrageBeforeBattleText | "Would you like break the rules and indulge in an INVERSE BATTLE?" | "Would you like to break the rules and indulge in an INVERSE BATTLE?" | missing "to"; may need re-wrap |
| text/ObsidianWood.asm | _ObsidianWoodAfterBattleText3 | "a number of #MON swims from the SAFARI ZONE till here." | "a number of #MON swim from the SAFARI ZONE till here." | subject-verb agreement |
| text/OchreResearchCenter1.asm | _OchreResearchCenter1Text_Power_Windworks_WowAlreadyDefeated | "You indeed do be a powerful TRAINER!" | "You indeed are a powerful TRAINER!" | broken verb construction |
| text/OchreResearchCenter2.asm | _OchreResearchCenter2Text_Fossils_Unova | "get a good idea at how living beings really look like..." | "get a good idea of what living beings really look like..." |  |
| text/OchreResearchCenter2.asm | _OchreResearchCenter2Text_Fossils_Galar | "To think at all the time we could have saved" | "To think of all the time we could have saved" | missing "of" |
| text/PewterGym.asm | _TM34ExplanationText | "you can buy again TMs you have already acquired!" | "you can buy TMs you have already acquired again!" | may need re-wrap |
| text/PokemonTower2F.asm | _PokemonTower2Text_6062d | "How do" "you dare showing" "your face, HERE" | "How dare you show your face, HERE" |  |
| text/RedsHouse1F.asm | _RedsHouse1FTVText_RP_Front | "Some dumb old movie nobody knows nor care for." | "...nobody knows nor cares for." | subject-verb agreement |
| text/Route16FlyHouse.asm | _Route16HouseText1_RP_PreFly | "Don't you dare" "hurting it!" | "Don't you dare hurt it!" |  |
| text/Route22.asm | _Route22RivalBeforeBattleText2 | "never has had a more" "fitting team!" | "has never had a more fitting team!" |  |
| text/Route26.asm | _Route26BattleText1 | "Hey! Are you wanna steal my special ONIX?!" | "Hey! You wanna steal my special ONIX?!" |  |
| text/Route3.asm | _Route3TextJenny | "TEAM ROCKET uses this ROUTE for its traffics." | "TEAM ROCKET uses this ROUTE for its trafficking." |  |
| text/Route9.asm | _Route9BattleText4 | "Don't you dare" "condescend me!" | "Don't you dare condescend to me!" | may need re-wrap |
| text/SaffronGym.asm | _SaffronGymBattleText8 | "like SABRINA, but despite so I can foresee" | "like SABRINA, but even so I can foresee" | "despite so" is not standard phrasing |
| text/SaffronPidgeyHouse.asm | _SaffronHouse1Text1 | "At least with my partner is much easier, as we live together!" | "At least with my partner, it's much easier, as we live together!" | missing subject "it" |
| text/SeviiIslandsCommon.asm | _HideAllUndergroundGuards_RP_Text1 | "Why hurting me?" | "Why are you hurting me?" |  |
| text/SeviiIslandsCommon.asm | _SeviiUndergroundText1_ThisButtonAlreadyPressed | "stones're shining." | "stones are shining." | unusual contraction with plural noun |
| text/SeviiIslandsCommon.asm | _SeviiIslandGymText_NoRewardWannaFight | "I cannot reward you if you won." | "I cannot reward you if you win." | tense mismatch in conditional |
| text/SeviiIslandsCommon.asm | _SeviiNoRewardsIfAnomalies | "they won't be able to reward you if you won." | "they won't be able to reward you if you win." | tense mismatch in conditional |
| text/SeviiRoute37EndBattleText1 (same file) | _SeviiRoute37EndBattleText1 | "You're" "up and beyond!" | "You're" "above and beyond!" | idiom is "above and beyond" |
| text/VictoryRoad1F.asm | _VictoryRoad1AfterBattleText_RP_YesUs | "Short ago, someone who looked so eerily like me stormed by" | "Not long ago, someone who looked so eerily like me stormed by" |  |
| text/VictoryRoad1F.asm | _VictoryRoad1AfterBattleText4_RP | "My alter ego looked like was devoured by sadness and anger" | "My alter ego looked like he was devoured by sadness and anger" | missing pronoun |
| text/ViridianCity.asm | _ViridianCityText_19175 | "we have to wait until they sobers up." | "...until they sober up." | subject-verb agreement |
| text/ViridianGym.asm | _ViridianGymGiovanniPostBattleText | "...I see... you remind me the myself of so, so many, too many years ago..." | "...you remind me of myself, so, so many, too many years ago..." | garbled phrasing |
| text/ViridianGym.asm | _ViridianGymGuideText_PostLeague_Intro_Long | "And also quite a luck." | "And also quite a stroke of luck." | "luck" uncountable; may need re-wrap |
| text/ViridianGym.asm | _ViridianGymGuideText_PostLeague_AmazingLetsGo | "Thanks a ton, it's huge help for us!" | "...it's a huge help for us!" | missing article; may need re-wrap |
| text/ViridianGym.asm | _ViridianGymChallengerPreBattleText_4 | "But now, NOW I went all out my way to fetch all the secret items" | "...I went all out of my way to fetch..." | missing "of" |
| text/ViridianGym.asm | _ViridianGymChallengerPostBattleText_4 | "I just want to finished this damn adventure!" | "I just want to finish this damn adventure!" | tense error |
| text/ViridianSchoolHouse.asm | _SchoolText4 | "In the OPTION menus, it gives you extra infos!" | "In the OPTION menus, it gives you extra info!" |  |
| text/ViridianSchoolHouse.asm | _SchoolText6 | "LEECH SEED drain 1/8 of its max HP and give them to the opponent." | "LEECH SEED drains 1/8 of its max HP and gives it to the opponent." | subject-verb agreement |
| text/ViridianSchoolHouse.asm | _SchoolText7 | "But if they do that on me, I learned I just need to switch" | "But if they do that to me, I learned I just need to switch" |  |
| text/ViridianSchoolHouse.asm | _SchoolText9 | "so-called Same Type Attack Bonus or STAB in short." | "so-called Same Type Attack Bonus or STAB for short." |  |
