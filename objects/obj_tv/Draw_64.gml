/// @description balls
// snick rematch vignette
if (global.snickrematch && (room == dungeon_10 or room == dungeon_9 or room == snick_challengeend) 
&& global.snickchallenge)
{
	draw_sprite_ext(spr_vignette, 0, 0, 0, 1, 1, 0, c_white, random_range(0.8, 0.9));
	instance_destroy(obj_baddie, false);
	instance_destroy(obj_baddiespawner, false);
}

if !drawhud
{	// Draw Text
	draw_set_font(check_sugary() ? global.sugarybigfont : global.bigfont)
	draw_set_halign(fa_center);
	draw_set_color(c_white)

	// Text Event
	draw_set_valign(fa_bottom);
	draw_text_auto(xi, yi, string(message))
	draw_set_valign(fa_top);

	draw_set_font(global.bigfont)
	exit;
}

// snick rematch jumpscare
if jumpscare > -1
{
	jumpscare--;
	
	if irandom(2) == 0
		jumpscareimage = irandom(sprite_get_number(spr_scares) - 1);
	
	if jumpscare <= 5
		draw_sprite(spr_scares_txt, jumpscaretext, 0, 0);
	else
		draw_sprite(spr_scares, jumpscareimage, 0, 0);
}

if !global.showhud
	exit;

// Draw Text
draw_set_font(check_sugary() ? global.sugarybigfont : global.bigfont)
draw_set_halign(fa_center);
draw_set_color(c_white)

// Text Event
draw_set_valign(fa_bottom);
draw_text_auto(xi, yi, string(message))
draw_set_valign(fa_top);

draw_set_font(global.bigfont)

#region old hud
if global.hudtype == 0
{
	//Draw TV
	var tvx = 832, tvy = 74;
	/*if !surface_exists(surf)
		surf = surface_create(960, 540);
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);*/
	
	var sprit = tvsprite;
	if global.combotime > 0 && tvsprite == spr_tvcombo
	{
		// combo tv
		draw_sprite_ext(scr_sprite_charsuffix(spr_tvcomboclear, sugary ? "ss" : -1), tvimg, tvx, tvy, 1, 1, 0, c_white, 1);
		
		sprit = scr_sprite_charsuffix(spr_tvcombo, sugary ? "ss" : -1);
		draw_sprite_part_ext(sprit, imageindexstore % 5, 0, 0, 16 + (global.combotime / 60) * 148, 
		177, tvx - sprite_get_xoffset(sprit), tvy - sprite_get_yoffset(sprit), 1, 1, c_white, 1);
		draw_text(tvx + 20, tvy + 1, string(global.combo));
	}
	else if room != Realtitlescreen
	{
		// default ss tv if the equivalent sprite doesn't exist
		sprit = scr_sprite_charsuffix(tvsprite, sugary ? "ss" : -1);
		if sugary && !string_endswith(sprite_get_name(sprit), "_ss")
			sprit = spr_tvdefault_ss;
		
		// tv
		draw_sprite_ext(sprit, tvimg, tvx, tvy, 1, 1, 0, c_white, 1);
		
		// text
		if (tvsprite == spr_tvdefault or sprit == spr_tvdefault_ss) && !global.miniboss
			draw_text(tvx - 4, tvy - 14, string(global.collect));
		if global.miniboss
			draw_text(tvx, tvy - 14, string(global.boxhp));
		if tvsprite == spr_tvdefault
			chose = false;
	}
	draw_set_alpha(1);
	
	// tv frame
	if room != Realtitlescreen && sprit != spr_tvhurt_ss
		draw_sprite_ext(sugary ? spr_tvempty_ss : spr_tvempty, tvimg, tvx, tvy, 1, 1, 0, c_white, 1);
	
	/*surface_reset_target();
	draw_surface_ext(surf, 0, 0, 1, 1, 0, c_white, alpha);*/
	
	// image speed
	tvimg += image_speed * sprite_get_speed(sprit);
	tvimg = tvimg % sprite_get_number(sprit);
}

#endregion
#region new hud
else if global.hudtype == 1
{
	var current_sprite = sprite_get_name(sprite_index);
	var tvoff = string_startswith(current_sprite, "spr_tv_off") 
	or string_startswith(current_sprite, "spr_tv_open");
	if tvoff
		sprite_prev = -1
	else if sprite_prev == -1
		sprite_prev = sprite_index
	
	var offset_x = irandom_range(-collect_shake, collect_shake);
	var offset_y = irandom_range(-collect_shake, collect_shake);
	if sugary
	{
		offset_x -= 1;
		offset_y -= 32 + sin(current_time / 500) * 2;
	}
	else
	{
		offset_x += 12;
		offset_y -= 27;
	}
	var tv_x = 833 + offset_x, tv_y = 107 + offset_y;
		
	// combo timer
	if !sugary
	{
		var _cx = (tv_x + combo_posX)
		var _cy = (((tv_y + 117) + hud_posY) + combo_posY)
		var _perc = (global.combotime / 60)
		var _minX = (_cx - 56)
		var _maxX = (_cx + 59)
		
		combofill_x = lerp(combofill_x, (_minX + ((_maxX - _minX) * _perc)), 0.5)
		combofill_y = _cy
			
		draw_sprite(spr_tv_combobubblefill, combofill_index, combofill_x, combofill_y)
		draw_sprite(spr_tv_combobubble, -1, _cx, _cy)
		draw_set_font(global.combofont2)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		
		var _tx = (_cx - 64)
		var _ty = (_cy - 12)
		var _str = string(global.combo)
		var num = string_length(_str)
		for (var i = num; i > 0; i--)
		{
		    var char = string_char_at(_str, i)
		    draw_text(_tx, _ty, char)
		    _tx -= 22
		    _ty -= 8
		}
	}

	if sugary //new sugary blah blah blah blah!!!!
	{
		var _cx = 670
		var _cy = ((tv_y) + combo_posY)
		var _perc = (global.combotime / 60)
		var _minY = ( _cy - sprite_get_yoffset(spr_SPcombometersoda) + 64 + 35) - (64 * 0)
		var _maxY = ( _cy - sprite_get_yoffset(spr_SPcombometersoda) + 64 + 35) - (64 * 1)
		//var _filly = ( _cy - sprite_get_yoffset(spr_SPcombometersoda) + 64 + 35) - (64 * _perc)
		var _filly = lerp(prevfilly, (_minY + ((_maxY - _minY) * _perc)), 0.5)
		prevfilly = _filly
		var _fillx = (_cx - 7 - sprite_get_xoffset(spr_SPcombometersoda))
		draw_sprite(spr_SPcombometer, 1, _cx, _cy)
		
		gpu_set_blendenable(false)
		gpu_set_colorwriteenable(false,false,false,true);
		draw_set_alpha(0);
		draw_rectangle(0,0, 960, 540, false);
		draw_set_alpha(1);
		draw_sprite(spr_SPcombometer,2,_cx,_cy);
		gpu_set_blendenable(true);
		gpu_set_colorwriteenable(true,true,true,true);
		gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
		gpu_set_alphatestenable(true);
		pal_swap_set(obj_player.spr_palette, obj_player.paletteselect, false, 0)
		draw_sprite_part(spr_SPcombometersoda, combofill_index, 0, 0, 88, (64 * _perc), _fillx, _filly)
		pal_swap_reset()
		gpu_set_alphatestenable(false);
		gpu_set_blendmode(bm_normal);
		
		draw_sprite(spr_SPcombometer, 0, _cx, _cy)
		draw_sprite(spr_SPcombometerhand, 0, _fillx + 27, _filly - 10)
		draw_set_font(global.combofontSP)
		draw_set_halign(fa_center)
		draw_set_valign(fa_top)
		
		var _tx = _cx
		var _ty = (_cy - 20)
		var _str = string(global.combo) + "x"
		    draw_text(_tx - 5, _ty - 53, _str)
	}
		
	// tv
	if sprite_exists(sprite_index)
	{
		var tvspr = sprite_index;
		if sprite_prev != -1 && idlespr != sprite_prev
		{
			noisebuffer = sugary ? 16 : noisemax;
			sprite_prev = idlespr;
		}
		if noisebuffer > 0
		{
			tvspr = sugary ? spr_tv_whitenoiseSP : spr_tv_whitenoise;
			if instance_exists(obj_player) && obj_player.character == "PP"
				tvspr = spr_tv_whitenoisePP;
			
			tvimg += 0.35;
			noisebuffer--;
		}
		else
			tvimg = image_index;
	
		// apply player palette
		if !tvoff && !string_startswith(current_sprite, "spr_tv_placeholder")
		{
			with obj_player
				pal_swap_set(spr_palette, paletteselect, false);
		}
		
		if !sugary
			draw_sprite_ext(spr_tv_cheapbg, 0, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
		draw_sprite_ext(tvspr, tvimg, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
		
		if !tvoff
			scr_drawtexture(tvspr, tvimg, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0,
			c_white, alpha, global.texturelist[global.playertexture], 350, 350,, obj_player.spr_texture);
		
		pal_swap_reset();
		
		if !sugary && !tvoff && !(instance_exists(obj_player) && obj_player.character == "PP")
			draw_sprite_ext(spr_tv_frame, 0, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
		
		if sugary && !tvoff
		{
			var propeller = spr_tvpropeller;
			if tvspr == spr_tv_whitenoiseSP
				propeller = spr_tvpropellerstatic;
			
			sugary_propeller += image_speed;
			sugary_propeller = sugary_propeller % sprite_get_number(propeller);
			draw_sprite_ext(propeller, sugary_propeller, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
		}
	}
	combo_shake = Approach(combo_shake, 0, 0.25);
	
		// draw combo
		combo_fade = 1;
		if 0
		{
			combo_fade = min(global.combotime / 5, 1);
			if global.combo != 0 && global.combotime > 0 && !tvoff
			{
				// sugary spire combo
				if combo_prev < global.combo
				{
					combo_shake = 5;
					combo_prev = global.combo;
				}
				tvcombo = spr_tv_comboSP;
				
				draw_sprite_ext(tvcombo, -1, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha * combo_fade)
				
				var str = string(global.combo);
				if global.combo < 10 && global.combo > -1
					str = "0" + str;
				
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
				draw_set_font(global.combofont);
				
				var num = string_length(str);
				var w = round(string_width(str) / num);
				
				for (var i = 0; i < num; i++)
				{
					var char = string_char_at(str, i + 1);
					var xx = i * w, yy = i * -3;
					draw_text_auto(xx + offset_x + 782, yy + offset_y + hud_posY + 86, char,,,combo_fade);
				}
				
				// sugary combo timer
				if !surface_exists(popsurf)
					popsurf = surface_create(112, 32);
				else
				{
					var b = global.combotime / 55;
					
					surface_set_target(popsurf);
					draw_clear_alpha(c_black, 0);
					draw_sprite_tiled(spr_barpop2_ss, 0, (-current_time / 100) + global.combotime, 0);
					draw_set_colour(#480028);
					draw_rectangle(112 * b, 0, 112, 32, false);
					draw_sprite(spr_barpop3_ss, 0, 112 * b, 0);
					draw_set_blend_mode(bm_subtract);
					draw_sprite(spr_barpop_ss, 1, 0, 0);
					draw_set_blend_mode(bm_normal);
					surface_reset_target();
			
					draw_set_alpha(combo_fade);
					draw_surface(popsurf, 833 + offset_x - 73, 107 + offset_y + hud_posY + 34);
					draw_sprite(spr_barpop_ss, 0, 833 + offset_x - 73, 107 + offset_y + hud_posY + 34);
					draw_set_alpha(1);
				}
			}
			else
				combo_prev = 0;
		}
	
	
		if bubblespr != noone
			draw_sprite_ext(bubblespr, bubbleindex, 512 - (sugary * 65), 53 + hud_posY, 1, 1, 1, c_white, alpha);
	
		if !surface_exists(promptsurface)
			promptsurface = surface_create(290, 102);
		
		surface_set_target(promptsurface)
		draw_clear_alpha(c_black, 0) 
		draw_set_font(global.font_small)
		draw_set_halign(fa_left)
		draw_set_valign(fa_middle)
		
		// draw bubble
		if bubblespr == spr_tv_bubble
		{
			promptx -= promptspd;
			if bubblespr != spr_tv_bubbleclose && promptx < 350 - string_width(prompt)
			{
				bubblespr = spr_tv_bubbleclose;
				bubbleindex = 0;
				promptx = promptxstart;
			}
			draw_text_color(promptx - 350, 50, prompt, c_white, c_white, c_white, c_white, 1);
		}
		
		draw_set_halign(fa_left);
		surface_reset_target();
		draw_surface(promptsurface, 350 - (sugary * 65), hud_posY);
	
	draw_set_font(global.bigfont)
}

#endregion

// pizzacoin in the hub
draw_set_valign(fa_top);
if check_online() && room == hub_room1 && !(instance_exists(obj_player) 
&& obj_player.state == states.victory)
{
	draw_set_halign(fa_right);
	pizzacoinframe = (pizzacoinframe + 0.35) % sprite_get_number(spr_pizzacoin);
	
	if scr_getcoin() < 0
		draw_set_colour(c_red);
	
	draw_text(960 - 64 - 32, 148 + (FINAL_GAMEPLAY ? (64 + (sugary ? 16 : 0)) : 0), string(scr_getcoin()));
	draw_sprite_ext(spr_pizzacoin, pizzacoinframe, 960 - 64 - 24, 148 + (FINAL_GAMEPLAY ? (64 + (sugary ? 16 : 0)) : 0), 1, 1, 0, c_white, alpha);
	
	draw_set_halign(fa_center);
}
draw_set_colour(c_white);

// golf hits
if instance_exists(obj_pizzaballOLD)
or instance_exists(obj_pizzaball)
{
	draw_set_halign(fa_right);
	draw_text(960 - 25, 200, string(string(global.golfhit) + " " + (global.golfhit == 1 ? "GOLF HIT" : "GOLF HITS")))
	draw_set_halign(fa_center);
}

//Draw Lap Text

if (global.lap > 1)
{
	if !sugary
		draw_set_font(global.bigfont)
	else
		draw_set_font(global.sugarybigfont)
	
	var _y_y = 250;
	// golf hits
	if instance_exists(obj_pizzaballOLD)
	or instance_exists(obj_pizzaball)
		_y_y = 270
	var _x_x = 960 - 25
	draw_set_halign(fa_right);
	if (global.lap >= 5)
		draw_set_colour(merge_colour(c_white, c_red, 0.15));
	else
		draw_set_colour(c_white);
		
	if (global.lap >= 99)
	{
		draw_set_colour(merge_colour(c_white, c_red, 0.75));
		_x_x += irandom_range(-2, 2)
		_y_y += irandom_range(-2, 2)
	}

	draw_text(_x_x, _y_y, "LAP " + string(global.lap + 1))
	draw_set_halign(fa_center);
	draw_set_colour(c_white);
}
// timer
if global.panic
{
    var _fill = global.fill
    var _currentbarpos = chunkmax - _fill
    var _perc = max(_currentbarpos, 0.005) / chunkmax
    var _max_x = 299
    var _barpos = _max_x * _perc
	
	if (global.hudtype == 1)
	{
	    if !surface_exists(bar_surface)
	        bar_surface = surface_create(298, 30)
	
	    var _barfillpos = floor(_barpos) + 13
	    if _barfillpos > 0
	    {
	        surface_resize(bar_surface, _barfillpos, 30)
	        surface_set_target(bar_surface)
	        draw_clear_alpha(c_black, 0)
	        var clip_x = timer_x + 3
	        var clip_y = timer_y + 5
	        for (i = 0; i < 3; i++)
	            draw_sprite(spr_timer_barfill, 0, barfill_x + (i * 173), 0)
	        surface_reset_target()
	        draw_surface(bar_surface, clip_x, clip_y)
	    }
	    draw_sprite(spr_timer_bar, -1, timer_x, timer_y)
	    draw_sprite(johnface_sprite, johnface_index, timer_x + 13 + _barpos, timer_y + 20)
		var timerspr = pizzaface_sprite
		var timerindex = pizzaface_index
	    if string_startswith(room_get_name(room), "tower_")
		{
	        timerspr = spr_timer_tower
			timerindex = 0	
		}
	    draw_sprite(timerspr, pizzaface_index, timer_x + 320, timer_y + 10)
	}
	var sg = check_sugary();
	draw_set_font(sg ? global.sugarybigfont : global.bigfont2)
	draw_set_halign(fa_center);
	draw_set_color(c_white)

	var _seconds = global.seconds;
	var _minutes = global.minutes;
	
	if (FINAL_GAMEPLAY)
	{ // global.fill is the shittiest piece of shit
		var formalFill = (global.fill / obj_chunktimer.fillrate) / 60;
		_seconds = floor(formalFill mod 60);
		formalFill -= _seconds;
		_minutes = floor(formalFill / 60);
	}
	
	var _color = c_white;
	if _minutes == 0 && _seconds <= 30
		_color = c_red
	var _middletext = (_seconds < 10 ? ":0" : ":");
	
	var xx = random_range(1, -1) + 480;
	if global.modifier == mods.no_toppings && FINAL_GAMEPLAY
		xx -= 75;
	draw_text_color(xx, random_range(1, -1) + (global.hudtype == 0 ? 65 : timer_y + 2), 
	string(_minutes) + _middletext + string(_seconds), _color, _color, _color, _color, image_alpha);
}

var sg = check_sugary();
draw_set_font(sg ? global.sugarybigfont : global.bigfont)
draw_set_halign(fa_center);
draw_set_color(c_white)

//Timer
if global.snickchallenge or global.miniboss or global.timedgate
{
	var _seconds = global.seconds;
	var _minutes = global.minutes;
	
	var _color = c_white;
	if _minutes == 0 && _seconds <= 30
		_color = c_red
	var _middletext = (_seconds < 10 ? ":0" : ":");
	
	var xx = random_range(1, -1) + 480;
	if global.modifier == mods.no_toppings && global.hudtype != 0
		xx -= 75;
	draw_text_color(xx, random_range(1, -1) + (global.hudtype == 0 ? 65 
	: min(obj_tv.yi - 70 - (sg * 20), 540 - 60)), string(_minutes) + _middletext 
	+ string(_seconds), _color, _color, _color, _color, image_alpha);
}

if (global.racing)
{
	var hurryup = global.racelimit - global.taminutes <= 1
	draw_sprite(spr_raceflag, ((get_timer() / 1000000) / (hurryup ? 0.1 : 0.2)) 
	% sprite_get_number(spr_raceflag), 780, 490)
	
	var timestr = string(global.taminutes) + ":"
	if (global.taseconds < 10)
		timestr += "0"
	timestr += string(global.taseconds)
	
	draw_set_halign(fa_right)
	draw_set_font(global.font_small)
	draw_set_colour(hurryup ? c_error : c_white)
	draw_text(910, 490, "RACING - " + timestr)
}