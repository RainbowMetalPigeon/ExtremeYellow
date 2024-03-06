HauntedHouse1_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedHouse1HandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
	ld hl, HauntedHouse1_ScriptPointers
	ld a, [wHauntedHouse1CurScript]
	call CallFunctionInTable
	ret

HauntedHouse1HandleRandomGlitchyBehaviours:

	ret ; TBE, testing

; handle fake poison
	call Random
	srl a ; 50% chance of fake poison
	jr c, .setFakePoison
	ResetEvent EVENT_HAUNTED_HOUSE_FAKE_POISON
	jr .handleLowHealthAlarm
.setFakePoison
	SetEvent EVENT_HAUNTED_HOUSE_FAKE_POISON

.handleLowHealthAlarm
	call Random
	srl a ; 50% chance of low-health alarm
	jr c, .lowHealthAlarm
	call PlayDefaultMusic
	ld hl, wLowHealthAlarm
	res 7, [hl] ; disable low health alarm
	jr .handleSpinning
.lowHealthAlarm
	call StopAllMusic
	ld hl, wLowHealthAlarm
	set 7, [hl] ; enable low health alarm

.handleSpinning
	call Random
	cp 25 ; 10% chance of moving by spinning
	ld hl, wd736 ; bit 7: spinning; bit 6: jumping, but requires much more work
	jr c, .spinning
	res 7, [hl]
	ret
.spinning
	set 7, [hl]
	ret

HauntedHouse1_ScriptPointers:
	dw HauntedHouse1Script0

HauntedHouse1Script0:
;	call ForceRight
;	call ForceDown
;	call ForceLeft
;	call ForceUp
	ret

; ============================

HauntedHouse1_TextPointers:
;	dw HauntedHouse1Text1

	text_end

; ============================

; inputs:
; b = min x, c = max x, d = min y, e = max y
; output:
; c flag = in the rectangle, nc otherwise
CheckIfInRectangle_HauntedHouse:
	inc b
	dec d
	ld a, [wXCoord]
	cp b
	jr c, .outsideRectangle ; if X<=b-1
	cp c
	jr nc, .outsideRectangle ; if X>=c
	ld a, [wYCoord]
	cp d
	jr c, .outsideRectangle ; if Y<=d+1
	cp e
	jr c, .insideRectangle ; if Y>=e
.outsideRectangle
	xor a
	ret
.insideRectangle
	scf
	ret

;ForceRight:
;	lb bc, 18, 21
;	lb de, 50, 51
;	call CheckIfInRectangle_HauntedHouse
;	ret nc
;	ldh a, [hJoyHeld]
;	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
;	ret nz
;	ld a, D_RIGHT
;	ldh [hJoyHeld], a
;	ret
;
;ForceDown:
;	lb bc, 22, 23
;	lb de, 50, 53
;	call CheckIfInRectangle_HauntedHouse
;	ret nc
;	ldh a, [hJoyHeld]
;	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
;	ret nz
;	ld a, D_DOWN
;	ldh [hJoyHeld], a
;	ret
;
;ForceLeft:
;	lb bc, 20, 23
;	lb de, 54, 55
;	call CheckIfInRectangle_HauntedHouse
;	ret nc
;	ldh a, [hJoyHeld]
;	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
;	ret nz
;	ld a, D_LEFT
;	ldh [hJoyHeld], a
;	ret
;
;ForceUp:
;	lb bc, 18, 19
;	lb de, 52, 55
;	call CheckIfInRectangle_HauntedHouse
;	ret nc
;	ldh a, [hJoyHeld]
;	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
;	ret nz
;	ld a, D_UP
;	ldh [hJoyHeld], a
;	ret
