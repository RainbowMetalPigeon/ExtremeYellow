; edited

RemoveGuardDrink::
	xor a
	ldh [hItemToRemoveID], a
	ld b, MATCHA_TEA
	call IsItemInBag ; z if not
	ret z
	ld a, MATCHA_TEA
	ldh [hItemToRemoveID], a
	farjp RemoveItemByID

GuardWrongDrinksList:
	db FRESH_WATER
	db SODA_POP
	db LEMONADE
	db BEER
	db COFFEE
	db 0 ; end

DoWeHaveTheWrongDrinks:: ; nz if we have one of the non-Matcha-Tea
	ld hl, GuardWrongDrinksList
.drinkLoop
	ld a, [hli]
	and a
	ret z
	push hl
	ld b, a
	call IsItemInBag ; z if not
	pop hl
	ret nz
	jr .drinkLoop
