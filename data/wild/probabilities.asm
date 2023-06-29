WildMonEncounterSlotChances:
; There are 14 slots for wild pokemon, and this is the table that defines how common each of
; those 14 slots is. A random number is generated and then the first byte of each pair in this
; table is compared against that random number. If the random number is less than or equal
; to the first byte, then that slot is chosen.  The second byte is double the slot number.

	db  50, $00 ; 51/256 = 19.9% chance of slot 0
	db 101, $02 ; 51/256 = 19.9% chance of slot 1
	db 140, $04 ; 39/256 = 15.2% chance of slot 2
	db 165, $06 ; 25/256 =  9.8% chance of slot 3
	db 190, $08 ; 25/256 =  9.8% chance of slot 4
	db 215, $0A ; 25/256 =  9.8% chance of slot 5
	db 228, $0C ; 13/256 =  5.1% chance of slot 6
	db 238, $0E ; 10/256 =  3.9% chance of slot 7
	db 248, $10 ; 10/256 =  3.9% chance of slot 8
	db 251, $12 ;  3/256 =  1.2% chance of slot 9
	db 252, $14 ;  1/256 =  0.4% chance of slot 10
	db 253, $16 ;  1/256 =  0.4% chance of slot 11
	db 254, $18 ;  1/256 =  0.4% chance of slot 12
	db 255, $1A ;  1/256 =  0.4% chance of slot 13 - Mew

;	old:
;	db  50, $00 ; 51/256 = 19.9% chance of slot 0
;	db 101, $02 ; 51/256 = 19.9% chance of slot 1
;	db 140, $04 ; 39/256 = 15.2% chance of slot 2
;	db 165, $06 ; 25/256 =  9.8% chance of slot 3
;	db 190, $08 ; 25/256 =  9.8% chance of slot 4
;	db 215, $0A ; 25/256 =  9.8% chance of slot 5
;	db 228, $0C ; 13/256 =  5.1% chance of slot 6
;	db 241, $0E ; 13/256 =  5.1% chance of slot 7
;	db 252, $10 ; 11/256 =  4.3% chance of slot 8
;	db 255, $12 ;  3/256 =  1.2% chance of slot 9
