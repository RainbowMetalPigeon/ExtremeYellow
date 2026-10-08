ViridianSchoolHouse_Script:
	RPTextChooser ViridianSchoolHouse_TextPointers, ViridianSchoolHouse_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ret

ViridianSchoolHouse_TextPointers:
	dw SchoolText1
	dw SchoolText2
	dw SchoolText3
	dw SchoolText4 ; new
	dw SchoolText5 ; new
	dw SchoolText6 ; new
	dw SchoolText7 ; new
	dw SchoolText8 ; new
	dw SchoolText9 ; new
	; new house
	dw School_PhilosophyText1 ; metalhead
	dw School_PhilosophyText2 ; metalhead
	dw School_PhilosophyText3 ; clipboard
	dw School_PhilosophyText4 ; philosopher
	dw School_PhilosophySignText1 ; notes
	dw School_PhilosophySignText2 ; TV
	dw School_PhilosophySignText3 ; notes
	dw School_PhilosophySignText4 ; PC
	dw School_PhilosophySignText5 ; blackboard
	dw School_PhilosophySignText6 ; blackboard
	dw School_PhilosophySignText7 ; trash bin


ViridianSchoolHouse_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	; new house
	dw GenericNPCText_RocketPath ; metalhead
	dw GenericNPCText_RocketPath ; metalhead
	dw School_PhilosophyText_Useless_RP ; clipboard
	dw School_PhilosophyText4_RP ; philosopher
	dw School_PhilosophyText_Useless_RP ; notes
	dw School_PhilosophyText_Useless_RP ; TV
	dw School_PhilosophyText_Useless_RP ; notes
	dw School_PhilosophyText_Useless_RP ; PC
	dw School_PhilosophyText_Useless_RP ; blackboard
	dw School_PhilosophyText_Useless_RP ; blackboard
	dw School_PhilosophyText_Useless_RP ; trash bin

SchoolText1:
	text_far _SchoolText1
	text_end

SchoolText2:
	text_asm
	farcall Func_f1c0f
	jp TextScriptEnd

SchoolText3:
	text_asm
	farcall Func_f1c03
	jp TextScriptEnd

; new ----------------------

SchoolText4:
	text_far _SchoolText4
	text_end

SchoolText5:
	text_far _SchoolText5
	text_end

SchoolText6:
	text_far _SchoolText6
	text_end

SchoolText7:
	text_far _SchoolText7
	text_end

SchoolText8:
	text_far _SchoolText8
	text_end

SchoolText9:
	text_far _SchoolText9
	text_end

; new house ============================

School_PhilosophyText1:
	text_far _School_PhilosophyText1
	text_end

School_PhilosophyText2:
	text_far _School_PhilosophyText2
	text_end

School_PhilosophyText3:
	text_far _School_PhilosophyText3
	text_end

School_PhilosophyText4:
	text_far _School_PhilosophyText4
	text_end

School_PhilosophySignText1:
	text_far _School_PhilosophySignText1
	text_end

School_PhilosophySignText2:
	text_far _School_PhilosophySignText2
	text_end

School_PhilosophySignText3:
	text_far _School_PhilosophySignText3
	text_end

School_PhilosophySignText4:
	text_far _School_PhilosophySignText4
	text_end

School_PhilosophySignText5:
	text_far _School_PhilosophySignText5
	text_end

School_PhilosophySignText6:
	text_far _School_PhilosophySignText6
	text_end

School_PhilosophySignText7:
	text_far _School_PhilosophySignText7
	text_end

; new for RP =============

School_PhilosophyText_Useless_RP:
	text_far _School_PhilosophyText_Useless_RP
	text_end

School_PhilosophyText4_RP:
	text_far _School_PhilosophyText4_RP
	text_end
