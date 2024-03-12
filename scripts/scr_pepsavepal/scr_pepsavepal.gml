function scr_pepsavepal(player, num = 1){
	ini_open("pepPal")
	with (player)
	{
		ini_write_real("pal" + string(num), "pal", paletteselect)
		ini_write_real("pal" + string(num), "woag", noisetype)
		ini_write_string("pal" + string(num), "char", character)
		ini_write_real("pal" + string(num), "tex", global.playertexture)
	}
	ini_close()
	ini_open("saveData.ini");
	ini_write_real("pal", "palsel", num)
	ini_close()
}

function scr_peploadpal(player, num = 1){
	ini_open("pepPal")
	
	with (player)
	{
		paletteselect = ini_read_real("pal" + string(num), "pal", check_shaders())
		noisetype = ini_read_real("pal" + string(num), "woag", 1)
		character = ini_read_string("pal" + string(num), "char", "P")
		if (character == "J")
			character = "SN"
		global.playertexture = ini_read_real("pal" + string(num), "tex", 0)
		scr_characterspr()
		scr_changetoppings()
	}
	
	ini_close()
	ini_open("saveData.ini");
	ini_write_real("pal", "palsel", num)
	ini_close()
}