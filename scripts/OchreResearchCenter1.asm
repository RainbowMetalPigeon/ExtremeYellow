OchreResearchCenter1_Script:
	call EnableAutoTextBoxDrawing
	ret

OchreResearchCenter1_TextPointers:
	; hall
	dw OchreResearchCenter1Text_Hall_Receptionist
	; balls
	dw OchreResearchCenter1Text_Ball_Kalos
	dw OchreResearchCenter1Text_Ball_Kurtz
	dw OchreResearchCenter1Text_Ball_Silph
	dw OchreResearchCenter1Text_Ball_Heavy
	dw OchreResearchCenter1Text_Ball_Fast
	; power
	dw OchreResearchCenter1Text_Power_Galar
	dw OchreResearchCenter1Text_Power_Windworks
	dw OchreResearchCenter1Text_Power_Kanto
	; signs
	dw OchreResearchCenterSign_Hall
	dw OchreResearchCenterSign_Ball
	dw OchreResearchCenterSign_Power

OchreResearchCenter1Text_Hall_Receptionist:
	text_far _OchreResearchCenter1Text_Hall_Receptionist
	text_end

OchreResearchCenter1Text_Ball_Kalos:
	text_far _OchreResearchCenter1Text_Ball_Kalos
	text_end

OchreResearchCenter1Text_Ball_Kurtz:
	text_far _OchreResearchCenter1Text_Ball_Kurtz
	text_end

OchreResearchCenter1Text_Ball_Silph:
	text_far _OchreResearchCenter1Text_Ball_Silph
	text_end

OchreResearchCenter1Text_Ball_Heavy:
	text_far _OchreResearchCenter1Text_Ball_Heavy
	text_end

OchreResearchCenter1Text_Ball_Fast:
	text_far _OchreResearchCenter1Text_Ball_Fast
	text_end

OchreResearchCenter1Text_Power_Galar:
	text_far _OchreResearchCenter1Text_Power_Galar
	text_end
;	text_asm
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_0
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_1
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_2
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_3
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_4
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_5
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_6
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_7
;	ld hl, TESTTEXT
;	call PrintText
;	jp TextScriptEnd
;TESTTEXT:
;	text_far _TESTTEXT
;	text_end
;_TESTTEXT::
;	text "TEST!!!"
;	done
	
OchreResearchCenter1Text_Power_Kanto:
	text_far _OchreResearchCenter1Text_Power_Kanto
	text_end

OchreResearchCenterSign_Hall:
	text_far _OchreResearchCenterSign_Hall
	text_end

OchreResearchCenterSign_Ball:
	text_far _OchreResearchCenterSign_Ball
	text_end

OchreResearchCenterSign_Power:
	text_far _OchreResearchCenterSign_Power
	text_end

; ========================

OchreResearchCenter1Text_Power_Windworks:
	text_asm
	ld hl, OchreResearchCenter1Text_Power_Windworks_Intro
	CheckEvent EVENT_ALREADY_SPOKEN_WITH_OCHRE_POWER_ENGINEER
	jr z, .firstTimeSpeaking
; already spoken with them
	ld hl, OchreResearchCenter1Text_Power_Windworks_AlreadyRewardedOrb
	CheckEvent EVENT_ALREADY_REWARDED_ORB_OCHRE_POWER_ENGINEER
	jr nz, .printAndEnd
; orb not given, check for money
	CheckEvent EVENT_ALREADY_REWARDED_MONEY_OCHRE_POWER_ENGINEER
	jr z, .notYetAnyReward
	ld hl, OchreResearchCenter1Text_Power_Windworks_AlreadyRewardedMoneySpaceForOrb
	call PrintText
	jr .tryToGiveThunderOrb
.notYetAnyReward
	ld hl, OchreResearchCenter1Text_Power_Windworks_HiBackHaveYouDone
	call PrintText
	call CheckIfDefeatedAllVoltorbs
	ld hl, OchreResearchCenter1Text_Power_Windworks_NotDoneYet
	jr nc, .printAndEnd
; not first interaction, but all Voltorbs defeated
	ld hl, OchreResearchCenter1Text_Power_Windworks_ThanksHereIsReward
	call PrintText
	jr .giveMoney
.firstTimeSpeaking
	call PrintText
	SetEvent EVENT_ALREADY_SPOKEN_WITH_OCHRE_POWER_ENGINEER
	call CheckIfDefeatedAllVoltorbs
	jr nc, .justEnd
	ld hl, OchreResearchCenter1Text_Power_Windworks_WowAlreadyDefeated
	call PrintText
.giveMoney
    xor a  
    ld [hMoney + 1], a    
    ld [hMoney + 2], a    
    ld a, $05
    ld [hMoney], a
	ld hl, hMoney + 2
	ld de, wPlayerMoney + 2
	ld c, $3
	predef AddBCDPredef ; add HL to DE with length C
	SetEvent EVENT_ALREADY_REWARDED_MONEY_OCHRE_POWER_ENGINEER
	ld hl, OchreResearchCenter1Text_Power_Windworks_FoundThisYouCanHaveIt
	call PrintText
.tryToGiveThunderOrb
	lb bc, THUNDER_STONE, 1 ; TBE, THUNDER_ORB
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_ALREADY_REWARDED_ORB_OCHRE_POWER_ENGINEER
	ld hl, OchreResearchCenter1Text_Power_Windworks_ReceivedThunderOrb
	jr .printAndEnd
.bagFull
	ld hl, OchreResearchCenter1Text_Power_Windworks_BagFull
.printAndEnd
	call PrintText
.justEnd
	jp TextScriptEnd
	
; ------------------------

OchreResearchCenter1Text_Power_Windworks_Intro:
	text_far _OchreResearchCenter1Text_Power_Windworks_Intro
	text_end

OchreResearchCenter1Text_Power_Windworks_WowAlreadyDefeated:
	text_far _OchreResearchCenter1Text_Power_Windworks_WowAlreadyDefeated
	text_end

OchreResearchCenter1Text_Power_Windworks_FoundThisYouCanHaveIt:
	text_far _OchreResearchCenter1Text_Power_Windworks_FoundThisYouCanHaveIt
	text_end

OchreResearchCenter1Text_Power_Windworks_BagFull:
	text_far _OchreResearchCenter1Text_Power_Windworks_BagFull
	text_end

OchreResearchCenter1Text_Power_Windworks_AlreadyRewardedOrb:
	text_far _OchreResearchCenter1Text_Power_Windworks_AlreadyRewardedOrb
	text_end

OchreResearchCenter1Text_Power_Windworks_HiBackHaveYouDone:
	text_far _OchreResearchCenter1Text_Power_Windworks_HiBackHaveYouDone
	text_end

OchreResearchCenter1Text_Power_Windworks_NotDoneYet:
	text_far _OchreResearchCenter1Text_Power_Windworks_NotDoneYet
	text_end

OchreResearchCenter1Text_Power_Windworks_AlreadyRewardedMoneySpaceForOrb:
	text_far _OchreResearchCenter1Text_Power_Windworks_AlreadyRewardedMoneySpaceForOrb
	text_end

OchreResearchCenter1Text_Power_Windworks_ThanksHereIsReward:
	text_far _OchreResearchCenter1Text_Power_Windworks_ThanksHereIsReward
	text_end

OchreResearchCenter1Text_Power_Windworks_ReceivedThunderOrb:
	text_far _OchreResearchCenter1Text_Power_Windworks_ReceivedThunderOrb
	sound_get_key_item
	text_end

; ------------------------

; carry flag is set if all Voltorbs are defeated, otherwise not
CheckIfDefeatedAllVoltorbs:
	CheckEvent EVENT_BEAT_POWER_PLANT_VOLTORB_0
	jr z, .notDefeated
	CheckEvent EVENT_BEAT_POWER_PLANT_VOLTORB_1
	jr z, .notDefeated
	CheckEvent EVENT_BEAT_POWER_PLANT_VOLTORB_2
	jr z, .notDefeated
	CheckEvent EVENT_BEAT_POWER_PLANT_VOLTORB_3
	jr z, .notDefeated
	CheckEvent EVENT_BEAT_POWER_PLANT_VOLTORB_4
	jr z, .notDefeated
	CheckEvent EVENT_BEAT_POWER_PLANT_VOLTORB_5
	jr z, .notDefeated
	CheckEvent EVENT_BEAT_POWER_PLANT_VOLTORB_6
	jr z, .notDefeated
	CheckEvent EVENT_BEAT_POWER_PLANT_VOLTORB_7
	jr z, .notDefeated
	scf
	jr .end
.notDefeated
	xor a
.end
	ret