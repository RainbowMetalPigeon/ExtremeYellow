DisplayStartMenu:: ; edited to save space in home
	ld a, BANK(DisplayStartMenu_)
	call BankswitchCommon
	jp DisplayStartMenu_
