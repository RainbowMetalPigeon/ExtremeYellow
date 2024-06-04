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

_TMPokemartGreetingText:: ; new
;	text "Hi! Are you"
;	line "looking for TMs?"
	text "Hi! I sell TMs you"
	line "already found!"
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

_PokemartTellBuyPriceText::
	text_ram wStringBuffer
	text "?"
	line "That will be"
	cont "¥@"
	text_bcd hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text ". OK?"
	done

_PokemartBoughtItemText::
	text "Here you are!"
	line "Thank you!"
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

_PokemartTellSellPriceText::
	text "I can pay you"
	line "¥@"
	text_bcd hMoney, 3 | LEADING_ZEROES | LEFT_ALIGN
	text " for that."
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

_PokemartAnythingElseText::
	text "Is there anything"
	line "else I can do?"
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

_HMCantDeleteText::
	text "HM techniques"
	line "can't be deleted!"
	prompt

_PokemonCenterWelcomeText:: ; edited
	text "Welcome to our"
	line "#MON CENTER!"

;	para "We heal #MON"
;	line "back to health!"
	done

_ShallWeHealYourPokemonText:: ; edited
	text "Do you want to"
	line "heal you #MON?"
	done

_NeedYourPokemonText:: ; edited
	text "OK! Just a second!"
	done

_PokemonFightingFitText:: ; edited
;	text "Thank you!"
;	line "Your #MON are"
;	cont "fighting fit!"
	text "Your pokemon are"
	line "now fully healed!"
	prompt

_PokemonCenterFarewellText::
	text "We hope to see"
	line "you again!"
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
