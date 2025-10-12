SeviiFiveIslandHouses_Script:
	jp EnableAutoTextBoxDrawing

SeviiFiveIslandHouses_TextPointers:
	dw SeviiFiveIslandHousesText1
	; signs
	dw SeviiFiveIslandHousesSignText1
	dw SeviiFiveIslandHousesSignText2
	; scripts

SeviiFiveIslandHousesText1:
	text_far _SeviiFiveIslandHousesText1
	text_end

SeviiFiveIslandHousesSignText1:
	text_far _SeviiFiveIslandHousesSignText1
	text_end

SeviiFiveIslandHousesSignText2:
	text_far _SeviiFiveIslandHousesSignText2
	text_end
