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
	callfar HauntedHouseHandleRandomGlitchyBehaviours ; testing
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
	ret

; ============================

HauntedHouse1_TextPointers:
;	dw HauntedHouse1Text1

	text_end

; ============================
