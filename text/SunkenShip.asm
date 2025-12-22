; TBE

; top floor ---------------------------------

_GiveCombination12Text::
    text "LEFT LEFT RIGHT"
    line "LEFT RIGHT PULL"
;   xxxx "123456789012345678"
    done

_SunkenShipTheKeyWorksText::
    text "<PLAYER> inserts"
    line "the card key."
;   xxxx "123456789012345678"
    prompt

_SunkenShipLockedDoorTopFloorText::
    text "It's locked. It"
    line "needs a card key."
;   xxxx "123456789012345678"
    done

_GiveRoomKey34Text_FoundItem::
    text "Found KEY 34"
;   xxxx "123456789012345678"
    prompt

_GiveRoomKey37Text_FoundItem::
    text "Found KEY 37"
;   xxxx "123456789012345678"
    prompt

_GiveRoomKey3XText_BagFull::
    text "Bag full"
;   xxxx "123456789012345678"
    done

_GiveRoomKey3XText_GotItem::
	text "<PLAYER> obtained"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end
;   xxxx "123456789012345678"
    done

_GiveRoomKey3XText_PostItem::
    text "Empty"
;   xxxx "123456789012345678"
    done

; mid floor ---------------------------------

_GiveCombination18Text::
    text "R R L"
;   xxxx "123456789012345678"
    done

_SunkenShipLockedDoorMidFloorText::
    text "It's locked. It"
    line "needs a password."
;   xxxx "123456789012345678"
    done

_SunkenShipWrongPasswordText::
    text "Wrong password."
;   xxxx "123456789012345678"
    done

; bottom floor ---------------------------------

_GivePassword25Text::
    text "HEL"
;   xxxx "123456789012345678"
    done

_GivePassword22Text::
    text "ALL"
;   xxxx "123456789012345678"
    done

_SunkenShipLockedDoorBottomFloorText::
    text "It's locked. Needs"
    line "a combination."
;   xxxx "123456789012345678"
    prompt

_SunkenShipWrongCombinationText::
    text "Wrong combination."
;   xxxx "123456789012345678"
    done

_SunkenShipWhatToDoText::
    text "What to do?"
    done

; shared ---------------------------------

_ObstructedStairsText::
    text "They're obstructed."
    line "Cannot pass."
;   xxxx "123456789012345678"
    done

_DoorCantBeOpenedText::
    text "The door's stuck."
    line "It can't be opened."
;   xxxx "123456789012345678"
    done

_DoorIsAlreadyUnlockedText::
    text "The door is open."
;   xxxx "123456789012345678"
    done

_SunkenShipTheLockOpenedText::
    text "The lock opened!"
;   xxxx "123456789012345678"
    done
