TrackPlayTime::
	call CountDownIgnoreInputBitReset
; check wram variable: if set, go to max time
	ld hl, wd47a
	bit 0, [hl]
	ret nz ; edited, was jr nz, .maxIGT
; check another wram variable: do nothing (don't count time) if set
	ld a, [wd732]
	bit 0, a
	ret z
; handle frames
; new for Chaos Mode
	ld a, [wRandomizationChaosMode]
	cp 4 ; frames
	call z, RandomizeMainDataByte
; BTV
	ld a, [wPlayTimeFrames]
	inc a
	ld [wPlayTimeFrames], a
	cp 60
	ret nz
; handle seconds
	xor a
	ld [wPlayTimeFrames], a
; new for Chaos Mode
	ld a, [wRandomizationChaosMode]
	cp 3 ; seconds
	call z, RandomizeMainDataByte
; BTV
	ld a, [wPlayTimeSeconds]
	inc a
	ld [wPlayTimeSeconds], a
	cp 60
	ret nz
; handle minutes
	xor a
	ld [wPlayTimeSeconds], a
; new for Chaos Mode
	ld a, [wRandomizationChaosMode]
	cp 2 ; minutes
	call z, RandomizeMainDataByte
; BTV
; new, for day-night cycle
	ld a, [wDayNightCycle]
	add 1 << 1 ; 2 : 1 shifted one bit to the left
	cp 60 << 1 ; 120 : 60 shifted one bit to the left
	jr c, .subDayNightMinutes
	inc a
	and %1
.subDayNightMinutes
	ld [wDayNightCycle], a
; BTV
	ld a, [wPlayTimeMinutes]
	inc a
	ld [wPlayTimeMinutes], a
	cp 60
	ret nz
; handle hours (edited to be 2-byte)
.hours
	xor a
	ld [wPlayTimeMinutes], a
; new for Chaos Mode
	ld a, [wRandomizationChaosMode]
	cp 1 ; hours
	call z, RandomizeMainDataByte
; BTV
	ld a, [wPlayTimeHours+1]
	inc a
	ld [wPlayTimeHours+1], a
	cp 0
	ret nz
; MSB of hours
	xor a
	ld [wPlayTimeHours+1], a
	ld a, [wPlayTimeHours]
	inc a
	ld [wPlayTimeHours], a
	cp $ff
	ret nz
; handle max time
	ld hl, wd47a
	set 0, [hl]
.maxIGT
	ld a, 59
	ld [wPlayTimeSeconds], a
	ld [wPlayTimeMinutes], a
	ld a, $ff
	ld [wPlayTimeHours], a
	ld [wPlayTimeHours+1], a
;	ld [wPlayTimeMaxed], a ; redundant
	ret

CountDownIgnoreInputBitReset:
	ld a, [wIgnoreInputCounter]
	and a
	jr nz, .decrement
	ld a, $ff
	jr .continue
.decrement
	dec a
.continue
	ld [wIgnoreInputCounter], a
	and a
	ret nz
	ld a, [wd730]
	res 1, a
	res 2, a
	bit 5, a
	res 5, a
	ld [wd730], a
	ret z
	xor a
	ldh [hJoyPressed], a
	ldh [hJoyHeld], a
	ret

TrackPlayTime_Tanoby:: ; new
	CheckEvent EVENT_SEVII_TANOBY_TRACK_TIME
	ret z
; the event was triggered
	ld a, [wPlayTimeFrames]
	and a
	ret nz
; if frames=0, then 60 are passed, ergo 1 second
; increase the Tanoby second counter: wUniQuizAnswer abused for this instead of the vanilla wPlayTimeSeconds
	ld a, [wUniQuizAnswer]
	inc a
	ld [wUniQuizAnswer], a
	cp 120
	ret nz
; if we are here: 120 Tanoby seconds passed
	SetEvent EVENT_SEVII_TANOBY_TIME_PASSED
	ret

TrackPlayTime_ShinyRitual:: ; new
	CheckEvent EVENT_SHINY_RITUAL_ACTIVE
	ret z
; the event was triggered
	ld a, [wPlayTimeFrames]
	and a
	ret nz
; if frames=0, then 60 are passed, ergo 1 second
; increase the dedicated second counter
	ld a, [wShinyRitualSeconds]
	inc a
	ld [wShinyRitualSeconds], a
	cp 240
	ret nz
; if we are here: 240 seconds passed
	ResetEvent EVENT_SHINY_RITUAL_ACTIVE
	ret

TrackPlayTime_ParkourPath:: ; new
	CheckEvent EVENT_PARKOUR_TRACKING_TIME
	ret z
; the event was triggered
	ld a, [wPlayTimeFrames]
	and a
	ret nz
; if frames=0, then 60 are passed, ergo 1 second
; increase the dedicated second counter
	ld a, [wParkourPathSeconds]
	inc a
	ld [wParkourPathSeconds], a
	cp 240
	ret nz
; if we are here: 240 seconds passed
	ResetEvent EVENT_PARKOUR_TRACKING_TIME
	SetEvent EVENT_PARKOUR_OVERTIME
	ret

RandomizeMainDataByte: ; new
	CheckEvent EVENT_DO_NOT_WARN_ABOUT_CHAOS_MODE
	ret nz ; do NOT deploy Chaos Mode while the player if looking at it
.loop
    call Random
; We only need 14 bits because a bank is maximum 16 kB
; bc = random value from $0000-$4000 = 0-16384 = %0-00111111'11111111
    ldh a, [hRandomAdd]
    and %00111111
    ld b, a ; high byte
    ldh a, [hRandomSub]
    ld c, a ; low byte
; reject values >= Main Data size
; check high byte
    ld a, b
    cp HIGH(wMainDataEnd - wMainDataStart)
    jr c, .gotOffset
    jr nz, .loop
; check low byte
    ld a, c
    cp LOW(wMainDataEnd - wMainDataStart)
    jr nc, .loop
.gotOffset
    ld hl, wMainDataStart
    add hl, bc
    call Random
    ld [hl], a
    ret
