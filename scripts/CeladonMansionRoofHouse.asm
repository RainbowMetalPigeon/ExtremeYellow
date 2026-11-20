CeladonMansionRoofHouse_Script:
	RPTextChooser CeladonMansionRoofHouse_TextPointers, CeladonMansionRoofHouse_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ret

CeladonMansionRoofHouse_TextPointers:
	dw CeladonMansion5Text1
	dw CeladonMansion5Text2

CeladonMansionRoofHouse_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw CeladonMansion5Text2

CeladonMansion5Text1:
	text_far _CeladonMansion5Text1
	text_end

CeladonMansion5Text2:
	text_asm
; new for RP: the Eevee is stolen
	CheckEvent EVENT_ROCKET_PATH
	jr z, .notRP
	SetEvent EVENT_RP_STEALING_POKEMON
.notRP
; BTV
	lb bc, EEVEE, 25
	call GivePokemon
	jr nc, .party_full
	ld a, HS_CELADON_MANSION_EEVEE_GIFT
	ld [wMissableObjectIndex], a
	predef HideObject
.party_full
	jp TextScriptEnd
