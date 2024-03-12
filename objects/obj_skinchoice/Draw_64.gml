// background
event_inherited();


draw_set_colour(c_white);
draw_set_font(global.font_small);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

if !texturemode
	draw_text(800, 30, "Current preset: " + string(global.palsel) + "/5\n\nUse page-up and page-down\nto cycle between them.\n(ONLY IN DRESSER)")
draw_text(800, 150, "Press SHIFT to switch to\n" + (texturemode ? "PALETTE mode." : "TEXTURE mode."))

// draw the skins
var _spr = selected ? spr_select : spr_idle;
if selected
	_spr = spr_select;
var _sprno = sprite_get_number(_spr);

img += sprite_get_speed(_spr) * 0.35;
if img >= _sprno or (selected && img >= 10)
{
	if selected && con != 1
	{
		t = 0;
		con = 1;
	}
	//if img >= _sprno
	//	img -= _sprno;
}

var specialsprite = false;
if sel[1] == "N"
{
	if _spr != spr_select or spr_idle == spr_select
	{
		if OLD_GAMEPLAY && noisetype == 1
			_spr = spr_playerN_mach;
		if FINAL_GAMEPLAY && noisetype == 0
			_spr = spr_playerN_pogofall;
	}
	
	if sel[0] == 14
	{
		_spr = spr_playerN_chungus;
		specialsprite = true;
		draw_set_font(global.font_small);
		if noisetype == 1 && OLD_GAMEPLAY
			draw_text_auto((960 / 2) + xoffset, ((540 / 2) + yoffset) - sprite_get_height(_spr) + 32, "Skateboard",,,talpha);
		else if noisetype == 0 && FINAL_GAMEPLAY
			draw_text_auto((960 / 2) + xoffset, ((540 / 2) + yoffset) - sprite_get_height(_spr) + 32, "Pogo",,,talpha);
	}
}
if sel[1] == "P" && sel[0] == 18
{
	_spr = spr_player_petah;
	specialsprite = true;
}
if sel[1] == "S" && sel[0] == 13
{
	_spr = spr_sbombic;
	specialsprite = true;
}

draw_player(sel[0], _spr, specialsprite)

var index = 0
if texturemode
	index = 3
// we live we love we lie
// left character
specialsprite = false
if sel[index] > 0
{
	var newpal = (texturemode) ? sel[0] : sel[0] - 1
	var specialspr = spr_idle
	var texpal = sel[3] - 1
	if sel[1] == "N"
	{
		if OLD_GAMEPLAY && noisetype == 1
			specialspr = spr_playerN_mach;
		if FINAL_GAMEPLAY && noisetype == 0
			specialspr = spr_playerN_pogofall;
	}
	if sel[1] == "N" && newpal == 14
	{
		specialsprite = true;
		specialspr = spr_playerN_chungus
	}
	if sel[1] == "P" && newpal == 18
	{
		specialsprite = true;
		specialspr = spr_player_petah
	}
	if sel[1] == "S" && newpal == 13
	{
		specialsprite = true;
		specialspr = spr_sbombic
	}
		
	draw_player(newpal, specialspr, specialsprite, -200, 0, 1, texturemode, texpal)
}

specialsprite = false

if sel[index] < selmax
{
	var newpal = (texturemode) ? sel[0] : sel[0] + 1
	var specialspr = spr_idle
	var texpal = sel[3] + 1
	
	if sel[1] == "N"
	{
		if OLD_GAMEPLAY && noisetype == 1
			specialspr = spr_playerN_mach;
		if FINAL_GAMEPLAY && noisetype == 0
			specialspr = spr_playerN_pogofall;
	}
	
	if sel[1] == "N" && newpal == 14
	{
		specialsprite = true;
		specialspr = spr_playerN_chungus
	}
	if sel[1] == "P" && newpal == 18
	{
		specialsprite = true;
		specialspr = spr_player_petah
	}
	if sel[1] == "S" && newpal == 13
	{
		specialsprite = true;
		specialspr = spr_sbombic
	}
		
	draw_player(newpal, specialspr, specialsprite, 200, 0, 1, texturemode, texpal)
}


draw_set_colour(c_white);
draw_set_font(global.bigfont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

if locked
	draw_text_auto((960 / 2) + xoffset, ((540 / 2) + yoffset) - sprite_get_height(_spr), "Locked",,,talpha);

// text
if sel[0] == -1
{
	/*
	palname = "CUSTOM PALETTE";
	paldesc = "Sky's the limit.";
	if !locked
		paldesc += "\nPress SHIFT to customize.";
	*/
	
	sel[0] = 0;
}
else
{
	try
	{
		if texturemode
		{
			var name = "skinchoice.pat.title." + string_lower(sel[3])
			var desc = "skinchoice.pat.desc." + string_lower(sel[3])
			
			if desc == "skinchoice.pat.desc.19" && sel[1] == "SP" // correct.
				desc += ".SP"

			palname = lang_str(name)
			paldesc = lang_str(desc)
		}
		else
		{
			var name = "skinchoice.name." + string_lower(sel[1]) + "." + string(sel[0])
			var desc = "skinchoice.desc." + string_lower(sel[1]) + "." + string(sel[0])
			if global.streamer
			{
				if lang_exists(name + ".streamer")
					name += ".streamer"
				
				if lang_exists(desc + ".streamer")
					desc += ".streamer"
			}
			
			palname = lang_str(name)
			paldesc = lang_str(desc)
		}
	}
	catch (e)
	{
		palname = "Palette";
		paldesc = "can we please add details";
		e = ""
	}
}