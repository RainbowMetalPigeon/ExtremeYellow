; wild mon or link battle enemy ran from battle
_EnemyRan:
	call LoadScreenTilesFromBuffer1
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ld hl, WildRanText
	jr nz, .printText
; link battle
	xor a
	ld [wBattleResult], a
	ld hl, EnemyRanText
.printText
	call PrintText
	ld a, SFX_RUN
	call PlaySoundWaitForCurrent
	xor a
	ldh [hWhoseTurn], a
	jpfar AnimationSlideEnemyMonOff

WildRanText:
	text_far _WildRanText
	text_end

EnemyRanText:
	text_far _EnemyRanText
	text_end

; ----------------------------------------------------------

CheckWeathersAndTerrainsForBallAndPulse:
	ldh a, [hWhoseTurn]
	and a
	ld hl, wPlayerMoveNum
	jp z, .player
	ld hl, wEnemyMoveNum
.player
; hl points to the move number
	ld a, [hl]
	cp WEATHER_BALL
	jr nz, .checkTerrainPulse
; it's Weather Ball; check if there's an active weather
	inc hl
	inc hl ; now hl points to the move power
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	ld a, FIRE
	jr nz, .weather
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	ld a, WATER
	jr nz, .weather
	CheckEvent EVENT_WEATHER_SANDSTORM
	ld a, ROCK
	jr nz, .weather
	CheckEvent EVENT_WEATHER_HAIL
	ld a, ICE
	ret z ; no active weather
.weather
	ld [hl], 100
	inc hl ; now hl points to the move type
	ld [hl], a
	ret

.checkTerrainPulse
	cp TERRAIN_PULSE
	ret nz
; it's Terrain Pulse; check if there's an active terrain
	inc hl
	inc hl ; now hl points to the move power
	CheckEvent EVENT_TERRAIN_GRASSY
	ld a, GRASS
	jr nz, .terrain
	CheckEvent EVENT_TERRAIN_ELECTRIC
	ld a, ELECTRIC
	jr nz, .terrain
	CheckEvent EVENT_TERRAIN_MISTY
	ld a, FAIRY
	jr nz, .terrain
	CheckEvent EVENT_TERRAIN_PSYCHIC
	ld a, PSYCHIC_TYPE
	ret z ; no active terrain
.terrain
	ld [hl], 100
	inc hl ; now hl points to the move type
	ld [hl], a
	ret

; ----------------------------------------------------------
