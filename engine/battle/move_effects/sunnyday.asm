SunnyDayEffect_:

	SetEvent EVENT_WEATHER_SUNNY_DAY
;	ResetEvent EVENT_WEATHER_RAINDANCE
;	ResetEvent EVENT_WEATHER_SANDSTORM
;	ResetEvent EVENT_WEATHER_HAIL

	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	ld a, 5
	jr z, .playersTurn
; opponent's turn
	ld [wWeatherCounterEnemy], a
	SetEvent EVENT_WEATHER_SET_BY_ENEMY
	ResetEvent EVENT_WEATHER_SET_BY_PLAYER
	jr .continue
.playersTurn
	ld [wWeatherCounterPlayer], a
	SetEvent EVENT_WEATHER_SET_BY_PLAYER
	ResetEvent EVENT_WEATHER_SET_BY_ENEMY

.continue

	callfar PlayCurrentMoveAnimation

	ld hl, TheSunlightGotBrighText
	jp PrintText
	ret

TheSunlightGotBrighText:
	text_far _TheSunlightGotBrighText
	text_end
