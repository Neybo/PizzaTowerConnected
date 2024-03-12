//Draw Text
draw_set_halign(fa_center);
draw_set_color(c_white)
//draw_self() //blehhhh i dont want to deal with the offset myself
if computer
{
	draw_sprite_ext(sprite_index, image_index * (computer >= 3),
	x, y, image_xscale, image_yscale, image_angle, image_blend, 1)
	if computer == 1 // kys smaller gates
		draw_sprite_ext(bgsprite, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, bgalpha)	
}
else if check_sugary()
{
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 
	image_angle, image_blend, image_alpha)
	draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, 
	image_angle, image_blend, image_alpha)
	scr_hub_bg_draw(x, y, sprite_index, 1)
}
else
{
	draw_sprite_ext(sprite_index, 0, x, y - 16, image_xscale, 
	image_yscale, image_angle, image_blend, image_alpha)
	draw_sprite_ext(sprite_index, 1, x, y - 16, image_xscale, 
	image_yscale, image_angle, image_blend, image_alpha)
	scr_hub_bg_draw(x, y - 16, sprite_index, 1)
}

// start drawing
if place_meeting(x, y, obj_player) && !drawing
{
	drawing = true
	obj_tv.manualhide = manualhide
}

// stop drawing
if (!place_meeting(x, y, obj_player) or obj_player.state == states.victory) && drawing
{
	obj_camera.panto = [0, 0];
	
	drawing = false
	obj_tv.manualhide = false
}

// actually draw
if drawing
{
	// read savefile before drawing
	if !readsave
	{
		ini_open("saveData" + string(global.saveslot) + ".ini");
		
		tamin = ini_read_real("TAmin", string(level), -1);
		tasec = ini_read_real("TAsec", string(level), -1);
		tadec = ini_read_real("TAdec", string(level), 0);
		tachar = ini_read_string("TAchar", string(level), "?");
		
		toppin1 = ini_read_real("Toppin", string(level) + "1", 0);
		toppin2 = ini_read_real("Toppin", string(level) + "2", 0);
		toppin3 = ini_read_real("Toppin", string(level) + "3", 0);
		toppin4 = ini_read_real("Toppin", string(level) + "4", 0);
		toppin5 = ini_read_real("Toppin", string(level) + "5", 0);
		
		secret = ini_read_string("Secret", string(level), 0);
		highscore = ini_read_real("Highscore", string(level), 0);
		lap = ini_read_real("Lap", string(level), 0);
		lapC = ini_read_real("LapC", string(level), 0);

		ini_close();
		readsave = true;
	}
	
	// time attack time
	if tamin >= 0 && global.timeattack
	{
		draw_set_colour(c_yellow);
		draw_set_font(global.font_small);
		
		var middle = ":";
		if tasec < 10
			middle = ":0";
		
		var precisertext = ".";
		if tadec < 10
			precisertext = ".0";
		draw_text(x, y - 60, string(tamin) + middle + string(tasec) + precisertext + string(tadec) + " (" + tachar + ")");
	}
	
	// setup
	draw_set_font(global.bigfont)
	draw_set_colour(c_white);
	
	// secret count
	var outof = scr_secretsoutof(level);
	
	if check_sugary()
		outof = 3;
	
	// where the score number should be displayed
	var scory = -90;
	
	// TOPPINS (and secret)
	if level != "snickchallenge" && level != "snickrematch" && level != "secrets"
	&& level != "eatery" && level != "dragonlair" && level != "golf" && level != ""
	{
		scory = -160; // raise score number to fit these
		
		// draw secrets
		if OLD_GAMEPLAY
		{
			if sprite_index == spr_entrancegate && obj_player.state == states.normal
				obj_camera.panto = [0, -32];
			draw_text_auto(x, y - 200, string(secret) + " of " + string(outof) + " Secrets");
		}
		
		// sugary spire toppins
		var sugary = false;
		if level == "cotton" or level == "mines" or level == "entryway" or level == "molasses"
			sugary = true;
		
		// toppins
		var toppin1spr = spr_toppinshroom;
		var toppin2spr = spr_toppincheese;
		var toppin3spr = spr_toppintomato;
		var toppin4spr = spr_toppinsausage;
		var toppin5spr = spr_toppinpineapple;
		var sep = 75;
		
		if level == "strongcold"
		{
			if OLD_GAMEPLAY
			{
				toppin1spr = spr_xmasshroomtoppin_idle;
				toppin2spr = spr_xmascheesetoppin_idle;
				toppin3spr = spr_xmastomatotoppin_idle;
				toppin4spr = spr_xmassausagetoppin_idle;
				toppin5spr = spr_xmaspineappletoppin_idle;
			}
			else
			{
				toppin1spr = spr_xmastoppinshroom_NEW;
				toppin2spr = spr_xmastoppincheese_NEW;
				toppin3spr = spr_xmastoppintomato_NEW;
				toppin4spr = spr_xmastoppinsausage_NEW;
				toppin5spr = spr_xmastoppinpineapple_NEW;
			}
		}
		else if sugary
		{
			if OLD_GAMEPLAY
			{
				toppin1spr = spr_toppinmallow;
				toppin2spr = spr_toppinchoco;
				toppin3spr = spr_toppincrack;
				toppin4spr = spr_toppinworm;
				toppin5spr = spr_toppinworm_run;
			}
			else
			{
				sep = 100;
				toppin1spr = spr_toppinmallow_NEW;
				toppin2spr = spr_toppinchoco_NEW;
				toppin3spr = spr_toppincrack_NEW;
				toppin4spr = spr_toppinworm_NEW;
				toppin5spr = spr_toppincandy_NEW;
			}
		}
		else if FINAL_GAMEPLAY
		{
			toppin1spr = spr_toppinshroom_NEW;
			toppin2spr = spr_toppincheese_NEW;
			toppin3spr = spr_toppintomato_NEW;
			toppin4spr = spr_toppinsausage_NEW;
			toppin5spr = spr_toppinpineapple_NEW;
		}
		
		draw_sprite_ext(toppin1spr, img * .35 * toppin1, 
		x - sep, y - 120, 1, 1, 0, toppin1 ? c_white : c_black, 1);
		
		draw_sprite_ext(toppin2spr, img * .35 * toppin2,
		x - sep / 2, y - 120, 1, 1, 0, toppin2 ? c_white : c_black, 1);
		
		draw_sprite_ext(toppin3spr, img * .35 * toppin3,
		x, y - 120, 1, 1, 0, toppin3 ? c_white : c_black, 1);
		
		draw_sprite_ext(toppin4spr, img * .35 * toppin4,
		x + sep / 2, y - 120, 1, 1, 0, toppin4 ? c_white : c_black, 1);
		
		draw_sprite_ext(toppin5spr, img * .35 * toppin5, 
		x + sep, y - 120, 1, 1, 0, toppin5 ? c_white : c_black, 1);
		
		img += 1	
	}
	
	// draw the score
	if level != "eatery" && level != ""
	{
		draw_text(x, y + scory, string(highscore))
		if FINAL_GAMEPLAY
		{
			if (lap >= 99)
				draw_set_colour(c_eatery)
			if (lap > 1)
				draw_text(x, y + -190, "LAP " + string(lap + 1))
				
			draw_set_colour(c_white)
			if lapC >= 99
				draw_set_colour(c_pvp)
			if lapC > 1
				draw_text(x, y + -220, "LAP " + string(lapC + 1) + "(C)")
				
		}
		draw_set_colour(c_white)
	}
	
	ini_close();
}

