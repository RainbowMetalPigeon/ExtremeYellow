SeviiRoute38Houses_Script:
	jp EnableAutoTextBoxDrawing

SeviiRoute38Houses_TextPointers:
	dw SeviiRoute38HousesText1
	dw SeviiRoute38HousesText2
	dw SeviiRoute38HousesText3
	; signs
	dw SeviiRoute38HousesSignText1
	dw SeviiRoute38HousesSignText2
	dw SeviiRoute38HousesSignText3

SeviiRoute38HousesText1: ; Dive Expert
	text_asm
	ld a, [wCurMap] ; for debugging
	ld [wCurMap], a ; for debugging
	CheckEvent EVENT_DIVE_GOT_OXYGEN_TANK
	ld hl, SeviiRoute38HousesText1_PostTank
	jr nz, .printAndEnd
; before obtaining the tank
	ld hl, SeviiRoute38HousesText1_ILikeDivingAndPearls
	call PrintText
	ld b, PEARL
	predef GetQuantityOfItemInBag ; input: b=item; output: b=how many
	ld a, b
	cp 7
	jr c, .notEnoughPearls
; have enough pearls
	ld b, 7
.loopGivePearls
	push bc
	call RemoveOnePearl
	pop bc
	dec b
	jr nz, .loopGivePearls
	SetEvent EVENT_DIVE_GOT_OXYGEN_TANK
	ld hl, SeviiRoute38HousesText1_HavePearlsLetsTrade
	call PrintText
	ld hl, SeviiRoute38HousesText1_GetsTank
	call PrintText
	ld hl, SeviiRoute38HousesText1_TankExplanation
	jr .printAndEnd
.notEnoughPearls
	ld hl, SeviiRoute38HousesText1_ComeIfHavePearls
.printAndEnd
	call PrintText
	jp TextScriptEnd

RemoveOnePearl:
	ld a, PEARL
	ldh [hItemToRemoveID], a
	jpfar RemoveItemByID

SeviiRoute38HousesText1_HavePearlsLetsTrade:
	text_far _SeviiRoute38HousesText1_HavePearlsLetsTrade
	text_end

SeviiRoute38HousesText1_GetsTank:
	text_far _SeviiRoute38HousesText1_GetsTank
	sound_get_item_2
	text_end

SeviiRoute38HousesText1_TankExplanation:
	text_far _SeviiRoute38HousesText1_TankExplanation
	text_end

SeviiRoute38HousesText1_ComeIfHavePearls:
	text_far _SeviiRoute38HousesText1_ComeIfHavePearls
	text_end

SeviiRoute38HousesText1_ILikeDivingAndPearls:
	text_far _SeviiRoute38HousesText1_ILikeDivingAndPearls
	text_end

SeviiRoute38HousesText1_PostTank:
	text_far _SeviiRoute38HousesText1_PostTank
	text_end

SeviiRoute38HousesText2: ; Imposter "tutor"
	text_asm
	CheckEvent EVENT_SEVII_GAVE_TM_MIMIC_TO_IMPOSTER_TUTOR
	jr z, .notUnlockedImposterYet
; we unlocked the Imposter service, ask if we want to de/activate it
	CheckEvent EVENT_ENABLED_IMPOSTER
	jr z, .offerToEnableImposter
; imposter already enabled, offer to disable it
	ld hl, SeviiRoute38HousesText2_WannaDisableImposter
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, SeviiRoute38HousesText2_NoDisableImposter
	jr nz, .printAndEnd
; yes enable Imposter
	ResetEvent EVENT_ENABLED_IMPOSTER
	ld hl, SeviiRoute38HousesText2_TooBadLetsGo
	jr .printAndEnd
.notUnlockedImposterYet
	ld hl, SeviiRoute38HousesText2_Intro
	call PrintText
; check if have Ditto
	ld d, DITTO
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	jr nc, .done
; we have ditto
	call WaitForTextScrollButtonPress
	ld hl, SeviiRoute38HousesText2_HaveDitto
	call PrintText
; check if have TM for Mimic
	ld b, TM_MIMIC
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .done
; we have it in bag
	call WaitForTextScrollButtonPress
	ld hl, SeviiRoute38HousesText2_WannaGiveTM
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, SeviiRoute38HousesText2_NoGiveTM
	jr nz, .printAndEnd
; we give the TM
	ld a, TM_MIMIC
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SEVII_GAVE_TM_MIMIC_TO_IMPOSTER_TUTOR
	ld hl, SeviiRoute38HousesText2_ThanksATon
	call PrintText
.offerToEnableImposter
	ld hl, SeviiRoute38HousesText2_WannaEnableImposter
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, SeviiRoute38HousesText2_NoEnableImposter
	jr nz, .printAndEnd
; yes enable Imposter
	SetEvent EVENT_ENABLED_IMPOSTER
	ld hl, SeviiRoute38HousesText2_PerfectLetsGo
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiRoute38HousesText2_Intro:
	text_far _SeviiRoute38HousesText2_Intro
	text_end

SeviiRoute38HousesText2_HaveDitto:
	text_far _SeviiRoute38HousesText2_HaveDitto
	text_end

SeviiRoute38HousesText2_WannaGiveTM:
	text_far _SeviiRoute38HousesText2_WannaGiveTM
	text_end

SeviiRoute38HousesText2_NoGiveTM:
	text_far _SeviiRoute38HousesText2_NoGiveTM
	text_end

SeviiRoute38HousesText2_ThanksATon:
	text_far _SeviiRoute38HousesText2_ThanksATon
	text_end

SeviiRoute38HousesText2_WannaEnableImposter:
	text_far _SeviiRoute38HousesText2_WannaEnableImposter
	text_end

SeviiRoute38HousesText2_NoEnableImposter:
	text_far _SeviiRoute38HousesText2_NoEnableImposter
	text_end

SeviiRoute38HousesText2_PerfectLetsGo:
	text_far _SeviiRoute38HousesText2_PerfectLetsGo
	sound_get_item_2
	text_end

SeviiRoute38HousesText2_WannaDisableImposter:
	text_far _SeviiRoute38HousesText2_WannaDisableImposter
	text_end

SeviiRoute38HousesText2_NoDisableImposter:
	text_far _SeviiRoute38HousesText2_NoDisableImposter
	text_end

SeviiRoute38HousesText2_TooBadLetsGo:
	text_far _SeviiRoute38HousesText2_TooBadLetsGo
	text_end

SeviiRoute38HousesText3: ; Imposter "tutor" sibling
	text_far _SeviiRoute38HousesText3
	text_end

; signs ----------

SeviiRoute38HousesSignText1:
	text_far _SeviiRoute38HousesSignText1
	text_end

SeviiRoute38HousesSignText2:
	text_far _SeviiRoute38HousesSignText2
	text_end

SeviiRoute38HousesSignText3:
	text_far _SeviiRoute38HousesSignText3
	text_end
