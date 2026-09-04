PokemonTower1F_Script:
	RPTextChooser PokemonTower1F_TextPointers, PokemonTower1F_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ret

PokemonTower1F_TextPointers:
	dw PokemonTower1Text1
	dw PokemonTower1Text2
	dw PokemonTower1Text3
	dw PokemonTower1Text4
	dw PokemonTower1Text5

PokemonTower1F_TextPointers_Rocket:
	dw PokemonTower1Text1_RP
	dw PokemonTower1Text2_RP
	dw PokemonTower1Text3_RP
	dw PokemonTower1Text4_RP
	dw PokemonTower1Text5_RP

PokemonTower1Text1:
	text_far _PokemonTower1Text1
	text_end

PokemonTower1Text2:
	text_far _PokemonTower1Text2
	text_end

PokemonTower1Text3:
	text_far _PokemonTower1Text3
	text_end

PokemonTower1Text4:
	text_far _PokemonTower1Text4
	text_end

PokemonTower1Text5:
	text_far _PokemonTower1Text5
	text_end

; new for RP =======================

PokemonTower1Text1_RP:
	text_far _PokemonTower1Text1_RP
	text_end

PokemonTower1Text2_RP:
	text_far _PokemonTower1Text2_RP
	text_end

PokemonTower1Text3_RP:
	text_far _PokemonTower1Text3_RP
	text_end

PokemonTower1Text4_RP:
	text_far _PokemonTower1Text4_RP
	text_end

PokemonTower1Text5_RP:
	text_far _PokemonTower1Text5_RP
	text_end
