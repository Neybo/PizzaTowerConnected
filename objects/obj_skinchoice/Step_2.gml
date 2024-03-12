if selected
{
	xoffset = lerp(xoffset, 0, 0.25);
	yoffset = lerp(yoffset, 0, 0.25);
	exit;
}
event_inherited();
if con == 1
	exit;

if sel[1] == "N" && key_taunt2
{
	scr_soundeffect(sfx_step);
	noisetype = !noisetype;
}

// change character
var lastchar = "SN";//"PUFFER";

if key_down2 && sel[1] != lastchar && !texturemode
{
	scr_soundeffect(sfx_step);
	comingfromtex = false

	yoffset = 100;
	switch sel[1]
	{
		case "P":
			sel[1] = "N";
			break;
		case "N":
			sel[1] = "V";
			break;
		case "V":
			sel[1] = "S";
			break;
		case "S":
			sel[1] = "PP"; // to pissino
			break;
		case "PP":
			sel[1] = "SP"; // to pizzelle
			break;
		case "SP":
			sel[1] = "SN"; // to PIZZANO!
			break;
	}
	event_user(0);
}
else if key_up2 && sel[1] != "P"  && !texturemode
{
	comingfromtex = false
	scr_soundeffect(sfx_step);
	
	yoffset = -100;
	switch sel[1]
	{
		case "N":
			sel[1] = "P";
			break;
		case "V":
			sel[1] = "N";
			break;
		case "S":
			sel[1] = "V";
			break;
		case "PP":
			sel[1] = "S";
			break;
		case "SP":
			sel[1] = "PP";
			break;
		case "SN": // from PIZZANO!
			sel[1] = "SP"; // to pizzelle
			break;
		case "J":  // from joe
			sel[1] = "SN"; // to PIZZANO!
			break;
	}
	event_user(0);
}
if !texturemode
	{
	if (keyboard_check_pressed(vk_pagedown) && global.palsel > 1)
	{
		global.palsel--;
		//scr_peploadpal(.id, global.palsel)
		scr_soundeffect(sfx_step);
		yoffset = -100;
		ini_open("pepPal")
	
		sel[1] = ini_read_string("pal" + string(global.palsel), "char", "P")
		event_user(0);
	
		sel[0] = ini_read_real("pal" + string(global.palsel), "pal", check_shaders())
		noisetype = ini_read_real("pal" + string(global.palsel), "woag", 1)
		sel[3] = ini_read_real("pal" + string(global.palsel), "tex", 0)
		ini_close()

	}
	if (keyboard_check_pressed(vk_pageup) && global.palsel < 5)
	{
		global.palsel++;
		//scr_peploadpal(.id, global.palsel)
		scr_soundeffect(sfx_step);
		yoffset = 100;
		ini_open("pepPal")
	
		sel[1] = ini_read_string("pal" + string(global.palsel), "char", "P")
		event_user(0);
	
		sel[0] = ini_read_real("pal" + string(global.palsel), "pal", check_shaders())
		noisetype = ini_read_real("pal" + string(global.palsel), "woag", 1)
		sel[3] = ini_read_real("pal" + string(global.palsel), "tex", 0)
		ini_close()

	}
}

if (keyboard_check_pressed(vk_shift))
{
	texturemode = !texturemode
	if texturemode
		event_user(2);
	else
		event_user(0);
	selaccess = (texturemode) ? 3 : 0
	comingfromtex = true
}