; TBE

; top floor --------------

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

; mid floor --------------

_SunkenShipLockedDoorMidFloorText::
    text "It's locked. It"
    line "needs a password."
;   xxxx "123456789012345678"
    done

_SunkenShipWrongPasswordText::
    text "Wrong password."
;   xxxx "123456789012345678"
    done

; bottom floor --------------

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

; shared -------------------------

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
