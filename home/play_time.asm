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
;; if wram variable for play time maxed is set: return and do nothing
;; this is redundant with the first variable above
;	ld a, [wPlayTimeMaxed]
;	and a
;	ret nz
; handle frames
	ld a, [wPlayTimeFrames]
	inc a
	ld [wPlayTimeFrames], a
	cp 60
	ret nz
; handle seconds
	xor a
	ld [wPlayTimeFrames], a
	ld a, [wPlayTimeSeconds]
	inc a
	ld [wPlayTimeSeconds], a
	cp 60
	ret nz
; handle minutes
	xor a
	ld [wPlayTimeSeconds], a
	ld a, [wPlayTimeMinutes]
	inc a
	ld [wPlayTimeMinutes], a
	cp 60
	ret nz
; handle hours (edited to be 2-byte)
.hours
	xor a
	ld [wPlayTimeMinutes], a
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
	jpfar _TrackPlayTime_Tanoby
