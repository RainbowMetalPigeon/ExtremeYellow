SeviiTwoIslet_Script:
	RPTextChooser SeviiTwoIslet_TextPointers, SeviiTwoIslet_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

SeviiTwoIslet_TextPointers:
	dw RockSmashText
	dw RockSmashText
	dw RockSmashText
	dw RockSmashText
	dw RockSmashText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw SeviiTwoIsletText1
	dw SeviiTwoIsletText2

SeviiTwoIslet_TextPointers_Rocket:
	dw RockSmashText
	dw RockSmashText
	dw RockSmashText
	dw RockSmashText
	dw RockSmashText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath

SeviiTwoIsletText1:
	text_far _SeviiTwoIsletText1
	text_end

SeviiTwoIsletText2:
	text_far _SeviiTwoIsletText2
	text_end
