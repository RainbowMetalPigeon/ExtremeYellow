SilphCo1F_Script: ; edited
	RPTextChooser SilphCo1F_TextPointers, SilphCo1F_TextPointers_Rocket ; useless?
	jp EnableAutoTextBoxDrawing

SilphCo1F_TextPointers:
	dw SilphCo1Text1

SilphCo1F_TextPointers_Rocket:
	dw GenericNPCText_RocketPath

SilphCo1Text1:
	text_far _SilphCo1Text1
	text_end
