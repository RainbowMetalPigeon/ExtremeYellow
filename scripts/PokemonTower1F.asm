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
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath

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
