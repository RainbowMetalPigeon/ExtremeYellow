SunnyDayEffect_:

	SetEvent EVENT_WEATHER_SUNNY_DAY
	ResetEvent EVENT_WEATHER_RAIN_DANCE
	ResetEvent EVENT_WEATHER_SANDSTORM
	ResetEvent EVENT_WEATHER_HAIL

	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	ld a, 5
	jr z, .playersTurn
; opponent's turn
	ld [wWeatherCounterEnemy], a
	xor a
	ld [wWeatherCounterPlayer], a
	jr .animationAndText
.playersTurn
	ld [wWeatherCounterPlayer], a
	xor a
	ld [wWeatherCounterEnemy], a

.animationAndText
	callfar PlayCurrentMoveAnimation
	ld hl, TheSunlightGotBrighText
	jp PrintText
	ret

TheSunlightGotBrighText:
	text_far _TheSunlightGotBrighText
	text_end

; --------------------------------------------------------------------------

RainDanceEffect_:

	ResetEvent EVENT_WEATHER_SUNNY_DAY
	SetEvent EVENT_WEATHER_RAIN_DANCE
	ResetEvent EVENT_WEATHER_SANDSTORM
	ResetEvent EVENT_WEATHER_HAIL

	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	ld a, 5
	jr z, .playersTurn
; opponent's turn
	ld [wWeatherCounterEnemy], a
	xor a
	ld [wWeatherCounterPlayer], a
	jr .animationAndText
.playersTurn
	ld [wWeatherCounterPlayer], a
	xor a
	ld [wWeatherCounterEnemy], a

.animationAndText
	callfar PlayCurrentMoveAnimation
	ld hl, ADownpourStartedText
	jp PrintText
	ret

ADownpourStartedText:
	text_far _ADownpourStartedText
	text_end

; --------------------------------------------------------------------------
