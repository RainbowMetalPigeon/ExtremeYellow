_PokemonText::
	text "#MON!"
	done

_PokemartGreetingText::
	text "Hi there!"
	next "May I help you?"
	done

_TMPokemartGreetingTextFoundNone:: ; new
	text "Hi! Here we sell"
	line "TMs that you have"
	cont "already found."

	para "Come back when you"
	line "have got some!"
	done

_TMPokemartGreetingTextFoundNone_RocketPath:: ; new
	text "...I sell TMs you"
	line "already found."

	para "You found none."
;	xxxx "123456789012345678"
	done

_TMPokemartGreetingText:: ; new
	text "Hi! I sell TMs you"
	line "already found!"
;	xxxx "123456789012345678"
	done

_TMPokemartGreetingText_RocketPath:: ; new
	text "...I sell TMs you"
	line "already found."
;	xxxx "123456789012345678"
	done

_ForbiddenMerchantGreetingText:: ; new
	text "Oh oh oh!"
	line "You did amazingly"
	cont "in finding me!"

	para "Allow me to reward"
	line "you with marvels"
	cont "that cannot be"
	cont "bought anywhere"
	cont "else in KANTO!"
	prompt

_SeviiTwoIslandMerchantGreetingText:: ; new
	text "Salut, young one."
	line "Would you like to"
	cont "shop with us?"

	para "We offer a unique"
	line "specialty!"
;	xxxx "123456789012345678"
	done

_PokemartGreetingText_RocketPath:: ; new
	text "...what do you"
	line "want?"
;	xxxx "123456789012345678"
	done

_PokemonFaintedText::
	text_ram wcd6d
	text_start
	line "fainted!"
	done

_PlayerBlackedOutText::
	text "<PLAYER> is out of"
	line "useable #MON!"

	para "<PLAYER> blacked"
	line "out!"
	prompt

_RepelWoreOffText::
	text "REPEL's effect"
	line "wore off."
	prompt

_PokemartBuyingGreetingText::
	text "Take your time."
	done

_PokemartBuyingGreetingText_RocketPath:: ; new for RP
	text "(I hope they leave"
	line "soon...)"
;	xxxx "123456789012345678"
	done

_PokemartTellBuyPriceText::
	text_ram wStringBuffer
	text "?"
	line "That will be"
	cont "¥@"
	text_bcd hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text ". OK?"
	done

_PokemartTellBuyPriceText_RocketPath:: ; new
	text "It's ¥@"
	text_bcd hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text "."
	line "Or you can leave."
;	xxxx "123456789012345678"
	done

_PokemartBoughtItemText::
	text "Here you are!"
	line "Thank you!"
	prompt

_PokemartBoughtItemText_RocketPath:: ; new
	text "Here. Now leave."
	prompt

_PokemartNotEnoughMoneyText::
	text "You don't have"
	line "enough money."
	prompt

_PokemartItemBagFullText::
	text "You can't carry"
	line "any more items."
	prompt

_PokemonSellingGreetingText::
	text "What would you"
	line "like to sell?"
	done

_PokemonSellingGreetingText_RocketPath:: ; new
	text "What junk do you"
	line "wanna get rid of?"
;	xxxx "123456789012345678"
	done

_PokemartTellSellPriceText::
	text "I can pay you"
	line "¥@"
	text_bcd hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text " for that."
	done

_PokemartTellSellPriceText_RocketPath:: ; new
	text "Mh. ¥@"
	text_bcd hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text ". Take"
	line "or leave."
;	xxxx "123456789012345678"
	done

_PokemartItemBagEmptyText::
	text "You don't have"
	line "anything to sell."
	prompt

_PokemartUnsellableItemText::
	text "I can't put a"
	line "price on that."
	prompt

_PokemartThankYouText::
	text "Thank you!"
	done

_PokemartThankYouText_RocketPath::
	text "See you never"
	line "again, hopefully."
;	xxxx "123456789012345678"
	done

_PokemartAnythingElseText::
	text "Is there anything"
	line "else I can do?"
	done

_PokemartAnythingElseText_RocketPath::
	text "What else do you"
	line "still want?"
;	xxxx "123456789012345678"
	done

_LearnedMove1Text::
	text_ram wLearnMoveMonName
	text " learned"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_WhichMoveToForgetText:: ; edited
;	text "Which move should"
;	next "be forgotten?"

	text "Delete which move"
	line "for @"
	text_ram wStringBuffer
	text "?@"
	text_end

;	xxxx "123456789012345678"
	done

_AbandonLearningText::
	text "Abandon learning"
	line "@"
	text_ram wStringBuffer
	text "?"
	done

_DidNotLearnText::
	text_ram wLearnMoveMonName
	text_start
	line "did not learn"
	cont "@"
	text_ram wStringBuffer
	text "!"
	prompt

_TryingToLearnText::
	text_ram wLearnMoveMonName
	text " is"
	line "trying to learn"
	cont "@"
	text_ram wStringBuffer
	text "!"

	para "But, @"
	text_ram wLearnMoveMonName
	text_start
	line "can't learn more"
	cont "than 4 moves!"

	para "Delete an older"
	line "move to make room"
	cont "for @"
	text_ram wStringBuffer
	text "?"
	done

_OneTwoAndText::
	text "1, 2 and...@"
	text_end

_PoofText::
	text " Poof!@"
	text_end

_ForgotAndText::
	text_start
	para "@"
	text_ram wLearnMoveMonName
	text " forgot"
	line "@"
	text_ram wcd6d
	text "!"

	para "And..."
	prompt

_HMCantDeleteText:: ; edited
	text "HM techniques"
	line "can't be deleted"
	cont "just like this!"
	prompt

_PokemonCenterWelcomeText:: ; edited
	text "Welcome to our"
	line "#MON CENTER!"

	para "Do you want to"
	line "heal your #MON?"

;	para "We heal #MON"
;	line "back to health!"
	prompt

;_ShallWeHealYourPokemonText:: ; edited
;	text "Welcome to our"
;	line "#MON CENTER!"
;
;	para "Do you want to"
;	line "heal your #MON?"
;	done

_PokemonCenterWelcomeText_RocketPath:: ; new
	text "...I have to heal"
	line "your #MON, if"
	cont "you really ask."
;	xxxx "123456789012345678"
	prompt

_NeedYourPokemonText:: ; edited
	text "OK! Just a second!"
	done

_NeedYourPokemonText_RocketPath:: ; new
	text "Sure."
;	xxxx "123456789012345678"
	done

_PokemonFightingFitText:: ; edited
;	text "Thank you!"
;	line "Your #MON are"
;	cont "fighting fit!"
	text "Your #MON are"
	line "now fully healed!"
	prompt

_PokemonFightingFitText_RocketPath:: ; new
	text "Done."

	para "I hope to never"
	line "see you again."
	done

_PokemonCenterFarewellText::
	text "We hope to see"
	line "you again!"
	done

_PokemonCenterSleepBagText::
	text "It's your first"
	line "time here, right?"

	para "Please, have this."
	line "It won't be able"
	cont "to heal your team"
	cont "like we can do,"
	cont "but with a good"
	cont "sleep you can"
	cont "rest until night"
	cont "or the next day!"
;	xxxx "123456789012345678"
	prompt

_PokemonCenterGotSleepBagText::
	text "<PLAYER> received"
	line "a SLEEP BAG!"
;	xxxx "123456789012345678"
	done

_PokemonCenterBagFullText::
	text "Oh, you don't have"
	line "space for this."
;	xxxx "123456789012345678"
	done

_LooksContentText::
	text "It looks very"
	line "content asleep."
	done

_CableClubNPCAreaReservedFor2FriendsLinkedByCableText::
	text "This area is"
	line "reserved for 2"
	cont "friends who are"
	cont "linked by cable."
	done

_CableClubNPCWelcomeText::
	text "Welcome to the"
	line "Cable Club!"
	done

_CableClubNPCPleaseApplyHereHaveToSaveText::
	text "Please apply here."

	para "Before opening"
	line "the link, we have"
	cont "to save the game."
	done

_SwapAndAgainText:: ; new
	text "Let's swap teams"
	line "and fight again!"
;	xxxx "123456789012345678"
	done
