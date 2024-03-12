//Draw


if !drawhud or !global.showhud 
{
	if global.afkroom
	{
		draw_set_align(fa_center, fa_middle)
		draw_text(480,250, "AFK")
	
		draw_text(480,280, "PRESS " + string(scr_keyname(global.key_jump)) + " TO EXIT AFK")
		with obj_player
		{
			if key_jump2
			{
				global.afkroom = false
				x = 500
				y = 500
				sprite_index = spr_lookdoor		
				image_index = 0		
				state = states.door
				targetDoor = "A"
				targetRoom = hub_room1
				instance_create(0, 0, obj_fadeout)
			}
		}
	}
	exit;
}

var sugary = false;
with obj_player if (character == "SP" or character == "SN") sugary = true;

var showhud = !instance_exists(obj_player) or (obj_player.state != states.rotate 
&& obj_player.state != states.gameover);

#region old hud

if global.hudtype == 0 {
    hud_posY = 0;
    
    //Backup Weapon
    if instance_exists(obj_player) && obj_player.backupweapon draw_sprite_ext(spr_shotgunbackup, -1, 50, 100, 1, 1, 0, c_white, alpha);
    
    if instance_exists(obj_player) && obj_player.state != states.gameover {
        var _state = obj_player.state;
        if _state == states.backbreaker {
            with obj_teleporter {
                if alarm[0] > -1 or alarm[1] > -1 _state = storedstate;
            }
            with obj_warplaser {
                if alarm[0] > -1 or alarm[1] > -1 _state = storedstate;
            }
        }
        if _state == states.hitlag _state = obj_player.tauntstoredstate;
        
        var hudface = -1;
		var hudstr = "";
        if obj_player.character == "V" 
		{
            if (healthshaketime > 0 && playerhealthup) or obj_player.sprite_index == spr_playerV_keydoor 
			or _state == states.keyget or _state == states.gottreasure 
				hudface = spr_playerV_happyHUD; 
			else if _state == states.mach1 or _state == states.mach2 or _state == states.mach3 
			or _state == states.machslide or _state == states.machroll 
				hudface = spr_playerV_machHUD; 
			else if (healthshaketime > 0 && !playerhealthup) or _state = states.hurt 
				hudface = spr_playerV_hurtHUD; 
			else if global.panic = true 
				hudface = spr_playerV_panicHUD; 
			else if obj_player.angry 
				hudface = spr_playerV_angryHUD; 
			else
				hudface = spr_playerV_normalHUD;
        }
        else if obj_player.character == "S" 
		{
            if _state = states.hurt 
				hudface = spr_snickHUDhurt; 
			else 
				hudface = spr_snickHUD;
        }
		else
		{
			switch obj_player.character
			{
				default:
					hudstr = "spr_pepinoHUD"
					break;
				case "N":
					hudstr = "spr_noiseHUD_"
					break;
				case "SN":
				case "SP":
					hudstr = "spr_pizzyHUD"
					break;
				case "PP":
					hudstr = "spr_pissinoHUD_"
					break;
			}
     
            if obj_player.sprite_index == obj_player.spr_knightpepthunder 
				hudstr += "thunder"; 
			else if obj_player.sprite_index != obj_player.spr_knightpepstart 
			&& (_state == states.knightpep or _state == states.knightpepslopes 
			or _state == states.knightpepattack) 
				hudstr += "knight"; 
			else if obj_player.sprite_index == obj_player.spr_bombpepend 
				hudstr += "bombend"; 
			else if instance_exists(obj_itspizzatime) 
			or obj_player.sprite_index == obj_player.spr_bombpepintro 
			or obj_player.sprite_index == obj_player.spr_bombpeprunabouttoexplode 
			or obj_player.sprite_index == obj_player.spr_bombpeprun 
			or obj_player.sprite_index == obj_player.spr_fireass 
				hudstr += (hudstr == "spr_pepinoHUD") ? "scream" : "panic"
			else if _state = states.Sjumpland or (_state == states.freefallland && shake_mag > 0) 
				hudstr += "stun"; 
			else if obj_player.sprite_index = obj_player.spr_victory 
			or _state = states.keyget or _state = states.smirk 
			or _state = states.gottreasure or (_state = states.bossintro 
			&& obj_player.sprite_index = obj_player.spr_levelcomplete) 
				hudstr += "happy"; 
			else if (obj_player.sprite_index == obj_player.spr_machroll 
			or obj_player.sprite_index == obj_player.spr_tumble 
			or obj_player.sprite_index == obj_player.spr_backslide) 
			&& hudstr != "spr_pizzyHUD" && hudstr != "spr_noiseHUD_"
				hudstr += "rolling"; 
			else if global.combo >= 3 
				hudstr += "menacing"; 
			else if _state == states.mach1 or _state == states.tackle 
			or _state == states.slam or _state == states.grab 
			or _state == states.punch or _state == states.backkick 
			or _state == states.uppunch or _state == states.shoulder 
				hudstr += "mach1"; 
			else if _state == states.mach2 or obj_player.sprite_index == obj_player.spr_dive 
			or _state == states.machroll or obj_player.sprite_index == obj_player.spr_machslideboost 
			or _state = states.climbwall or _state = states.handstandjump 
			or _state = states.superslam or _state == states.freefallprep 
				hudstr += "mach2"; 
			else if _state == states.mach3 && obj_player.sprite_index == obj_player.spr_crazyrun 
				hudstr += "mach4"; 
			else if _state == states.mach3 
			or obj_player.sprite_index == obj_player.spr_mach3boost 
				hudstr += "mach3"; 
			else if _state == states.hurt or obj_player.sprite_index == obj_player.spr_fireassend 
			or _state = states.timesup or _state = states.bombpep 
			or (_state = states.bossintro && obj_player.sprite_index = obj_player.spr_bossintro) 
			or (_state = states.bossintro && obj_player.sprite_index = obj_player.spr_idle) 
				hudstr += "hurt"; 
			else if obj_player.angry 
				hudstr += "3hp"; 
			else if (obj_player.sprite_index == obj_player.spr_hurtidle 
			or obj_player.sprite_index == obj_player.spr_hurtwalk)
			&& hudstr != "spr_pizzyHUD"
				hudstr += "1hp"; 
			else if global.panic or global.snickchallenge or global.miniboss 
				hudstr += "panic"; 
			else if obj_player.sprite_index == obj_player.spr_shotgunpullout 
				hudstr += "menacing"; 
			else if hudstr == "spr_pizzyHUD"
			{
				if _state == states.Sjumpprep 
					hudstr += "superjumpprep"; 
				else if _state == states.Sjump 
					hudstr += "superjump";
				else if _state == states.freefall
					hudstr += "bodyslam"
			}
			else
			{
				switch obj_player.character
				{
					case "N":
						hudstr = "spr_noiseHUD_idle"
						break;
					case "PP":
						hudstr = "spr_pissinoHUD"
						break;
				}
			}
		}
		
        /*if obj_player.character == "PUFFER" 
			hudface = spr_pufferHUD;*/
        
        if _state == states.cotton // temp
			hudface = spr_pizzyHUDcotton;
        
		if !sprite_exists(hudface)
		{
			var free_builds = asset_get_index(hudstr)
			if free_builds != -1
				hudface = free_builds
			else
				show_debug_message(hudstr)
		}
		if hudface != -1
		{
	        if _state != states.cotton 
				pal_swap_set(obj_player.spr_palette, obj_player.paletteselect, false);
            
	        draw_sprite_ext(hudface, hudframe, 125, 100, 1, 1, 0, c_white, other.alpha);
	        pal_swap_reset();
			scr_drawtexture(hudface, hudframe, 125, 100, 1, 1, 0, c_white, other.alpha, 
			,300,300,1, spr_snicktexture)
            
	        // image speed
	        var sprspd = sprite_get_speed(hudface);
	        if sprspd != 1 
				hudframe += sprspd; 
			else 
				hudframe += 0.35;
			if hudframe >= sprite_get_number(hudface)
				hudframe -= sprite_get_number(hudface);
		}
		
        // speed meter
        if !(obj_player.character == "N" && obj_player.noisetype == 0) 
		{
            var yy = 140;
            if obj_player.character == "SP" yy = 164;
            
            var speedbaractive = _state == states.mach1 or _state == states.mach2 
			or _state == states.mach3 or _state == states.climbwall 
			or _state == states.machslide or _state == states.machroll 
			or _state == states.handstandjump;
            var frame = 0;
            
            if obj_player.movespeed < 2.4 or !speedbaractive 
				frame = 0; 
			else if speedbaractive 
			{
                if obj_player.movespeed >= 2.4 && obj_player.movespeed < 4.8 
					frame = 1; 
				else if obj_player.movespeed >= 4.8 && obj_player.movespeed < 7.2 
					frame = 2; 
				else if obj_player.movespeed >= 7.2 && obj_player.movespeed < 9.6 
					frame = 3; 
				else if obj_player.movespeed >= 9.6 && obj_player.movespeed < 12 
					frame = 4; 
				else if obj_player.movespeed >= 12 
				{
                    frame = -1;
                    draw_sprite_ext(scr_sprite_charsuffix(spr_speedbarmax), -1, 125, yy, 1, 1, 0, c_white, alpha);
                }
            }
            if frame >= 0 
				draw_sprite_ext(scr_sprite_charsuffix(spr_speedbar), frame, 125, yy, 1, 1, 0, c_white, alpha);
        }
        
        // pogo noise bullshit
        with obj_player 
		{
            if character == "N" && noisetype == 0 
			{
                with other 
				{
                    if obj_player.pogospeed < 10 
						draw_sprite_ext(spr_speedbar, 0, 125, 140, 1, 1, 0, c_white, alpha); 
					else if obj_player.pogospeed >= 10 && obj_player.pogospeed < 14 
						draw_sprite_ext(spr_speedbar, 3, 125, 140, 1, 1, 0, c_white, alpha); 
					else if obj_player.pogospeed >= 14 
						draw_sprite_ext(spr_speedbarmax, -1, 125, 140, 1, 1, 0, c_white, alpha);
                }
            }
        }
        
        // fade
        if (obj_player.y < camera_get_view_y(view_camera[0]) + 200 
		&& obj_player.x < camera_get_view_x(view_camera[0]) + 200) 
		or (instance_exists(obj_gms) && ds_queue_size(global.__xmessage_queue) > 0 
		&& global.__xms_waittime > 0) 
			alpha = 0.5; 
		else 
			alpha = 1;
    } 
	else 
		shader_reset();
}

#endregion
#region new hud
else {
	if (!instance_exists(obj_player) or obj_player.state != states.gameover) && showhud 
	{
	    if ((instance_exists(obj_player) 
		&& point_in_rectangle(obj_player.x, obj_player.y, _camx, _camy, _camx + 250, _camy + 169)) 
		or manualhide) && !instance_exists(obj_fadeout)
	        hud_posY = Approach(hud_posY, -300, 15); 
		else if (check_online())
	        hud_posY = Approach(hud_posY, 20, 15);
	    else 
			hud_posY = Approach(hud_posY, 0, 15);
    
	    // heat animation
	    pizzascore_index += 0 + (0.25 * global.stylethreshold);
	    if pizzascore_index > pizzascore_number - 1 
			pizzascore_index = 0 + frac(pizzascore_index);
	    if global.stylethreshold <= 0 
		{
	        if floor(pizzascore_index) != 0 
				pizzascore_index += 0.35; 
			else 
				pizzascore_index = 0;
	    }
    
	    // setup shit
	    var b = global.style / 55;
		var hud_xx = 121 + irandom_range(-collect_shake, collect_shake);
	    var hud_yy = 90 + irandom_range(-collect_shake, collect_shake) + hud_posY;
	    var repainted = instance_exists(obj_player) && obj_player.character == "PP";
		var gcc = instance_exists(obj_player) && obj_player.character == "J"
    
	    // heat meter
	    var heatfill = spr_heatmeter_fill;
	    var _heatspr = spr_heatmeter;
	    var _heatpal = spr_heatmeter_palette;
	    if !repainted && global.heatmeter 
		{
	        if sugary 
			{
	            _heatspr = spr_heatmeter_candy;
	            _heatpal = spr_heatmeter_candy_palette;
	            heatfill = spr_heatmeter_candyfill;
	        }
        
	        var sw = sprite_get_width(heatfill);
	        var sh = sprite_get_height(heatfill);
        
	        if sprite_exists(_heatpal)
				pal_swap_set(_heatpal, global.stylethreshold, 0);
	        draw_sprite_part(heatfill, pizzascore_index, 0, 0, sw * b, sh, hud_xx - 95, hud_yy 
			+ (sugary ? -87 : 24));
	        draw_sprite_ext(_heatspr, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
	        pal_swap_reset();
	    }
    
	    // the big ass fucking pizza motherfucker
	    var _pizzascore = spr_pizzascore;
	    if sugary 
			_pizzascore = spr_candyscore;
	    if repainted 
			_pizzascore = spr_pizzascorePP;
    
	    draw_sprite_ext(_pizzascore, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
    
	    // draw the score
	    var _crankpizza = repainted ? spr_pizzascore_pepperPP : spr_pizzascore_pepper;
	    var _brankpizza = repainted ? spr_pizzascore_pepperoniPP : spr_pizzascore_pepperoni;
	    var _arankpizza = repainted ? spr_pizzascore_olivePP : spr_pizzascore_olive;
	    var _srankpizza = repainted ? spr_pizzascore_shroomPP : spr_pizzascore_shroom;
    
	    if _pizzascore == spr_pizzascoreN 
		{
	        _crankpizza = -1;
	        _brankpizza = -1;
	        _arankpizza = -1;
	        _srankpizza = -1;
	    }
	    if sugary 
		{
	        _crankpizza = spr_candyscore_crank;
	        _brankpizza = spr_candyscore_brank;
	        _arankpizza = spr_candyscore_arank;
	        _srankpizza = spr_candyscore_srank;
	    }
    
	    var _score = global.collect;
	    if global.srank > 0 
		{
	        if _score >= global.crank && sprite_exists(_crankpizza)
	                draw_sprite_ext(_crankpizza, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
	        if _score >= global.brank && sprite_exists(_brankpizza)
	                draw_sprite_ext(_brankpizza, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
	        if _score >= global.arank && sprite_exists(_arankpizza)
	                draw_sprite_ext(_arankpizza, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
	        if _score >= global.srank && sprite_exists(_srankpizza)
	                draw_sprite_ext(_srankpizza, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
	    }
    
	    // draw in front of the pizza if repainted
	    if repainted && global.heatmeter 
		{
	        heatfill = spr_heatmeter_fillPP;
	        _heatpal = spr_heatmeter_palettePP;
        
	        var sw = sprite_get_width(heatfill);
	        var sh = sprite_get_height(heatfill);
        
	        pal_swap_set(_heatpal, global.stylethreshold, 0);
	        draw_sprite_part(spr_heatmeter_fillPP, pizzascore_index, 0, 0, sw * b, sh, hud_xx - 89, hud_yy - 87);
	        draw_sprite_ext(spr_heatmeterPP, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
	        pal_swap_reset();
	    }
    
	    // rank bubble
	    var rx = hud_xx + 142;
	    var ry = hud_yy - 22;
	    var rank_ix = 0;
	    if global.srank == 0 
			rank_ix = 5; 
		else if _score >= global.srank 
			rank_ix = scr_prankvalid() ? 6 : 4; 
		else if _score >= global.arank 
			rank_ix = 3; 
		else if _score >= global.brank 
			rank_ix = 2; 
		else if _score >= global.crank 
			rank_ix = 1;
    
	    if previousrank != rank_ix 
		{
	        previousrank = rank_ix;
	        rank_scale = 3;
	    }
	    rank_scale = Approach(rank_scale, 1, 0.2);
    
		var rankhud = spr_ranks_hud
		var rankhudfill = spr_ranks_hudfill
	
		if sugary
		{
			rankhud = spr_ranks_hudSP
			rankhudfill = spr_ranks_hudfillSP
		}
		if repainted
		{
			rankhud = spr_ranks_hudPP
			rankhudfill = spr_ranks_hudfillPP
		}
		if gcc {
			rankhud = spr_rankhud_joe
			rankhudfill = spr_rankhud_hudfil_joe
		}
	    var spr_w = sprite_get_width(rankhudfill) 
	    var spr_h = sprite_get_height(rankhudfill)  
	    var spr_xo = sprite_get_xoffset(rankhudfill) 
	    var spr_yo = sprite_get_yoffset(rankhudfill)
        
	    var perc = 0;
	    switch rank_ix 
		{
	        default:
	            perc = 1;
	            break;
       
		     case 4:
			 if global.chancetogetonthatprank && !global.combodropped
	            perc = (global.lap2 + global.treasure + clamp(global.secretfound, 0, 3) 
				+ clamp(global.toppintotal - 1, 0, 3)) / 8
	            break;
			
	        case 3:
	            perc = (_score - global.arank) / (global.srank - global.arank);
	            break;
            
	        case 2:
	            perc = (_score - global.brank) / (global.arank - global.brank);
	            break;
            
	        case 1:
	            perc = (_score - global.crank) / (global.brank - global.crank);
	            break;
            
	        case 0:
	            perc = _score / global.crank;
	    }
    
	    var t = spr_h * perc;
	    var top = spr_h - t;
	
	    draw_sprite_ext(rankhud, rank_ix, rx, ry, rank_scale, rank_scale, 0, c_white, 1);
	    if rank_scale == 1 && global.srank > 0
			draw_sprite_part(rankhudfill, rank_ix, 0, top, spr_w, spr_h - top, rx - spr_xo, ry - spr_yo + top)
    
	    // text
    
	    draw_set_valign(fa_top);
	    draw_set_halign(fa_left);
    
	    if sugary 
			draw_set_font(global.candyfont); 
		else if repainted 
			draw_set_font(global.collectfontPP); 
		else 
			draw_set_font(global.collectfont);
    
	    var text_y = 0;
	    switch floor(pizzascore_index - sugary)
	    {
	        case 1:
	        case 2:
	        case 3:
	            text_y = 1;
	            break;
	        case 5:
	        case 10:
	            text_y = -1;
	            break;
	        case 6:
	        case 9:
	            text_y = -2;
	            break;
	        case 7:
	            text_y = -3;
	            break;
	        case 8:
	            text_y = -5;
	            break;
	    }
    
	    var cs = 0;
	    with obj_comboend
			cs += comboscore;
    
	    var sc = (_score - global.comboscore) - cs;
	    var str = string(sc);
	    var num = string_length(str);
	    var w = string_width(str);
	    var xx = hud_xx - w / 2;
	    if lastcollect != sc {
	        color_array = array_create(num, 0);
	        for (var i = 0; i < array_length(color_array); i++) color_array[i] = choose(irandom(3));
				lastcollect = sc;
	    }
    
	    draw_set_alpha(alpha);
	    for (i = 0; i < num; i++) {
	        var yy = ((i + 1) % 2 == 0 ? -5 : 0);
	        var c = color_array[i];
	        if !repainted 
				pal_swap_set(spr_font_palette, c, 0);
	        draw_text(xx, hud_yy - 56 + text_y + yy, string_char_at(str, i + 1));
	        xx += w / num;
	    }
    
	    draw_set_alpha(1);
	    pal_swap_reset();
    }
}

#endregion
#region global

var hud_xx = 96 + irandom_range(-collect_shake, collect_shake);
var hud_yy = 70 + irandom_range(-collect_shake, collect_shake) + hud_posY;
if global.hudtype == 0
	hud_yy += 25
else if !global.heatmeter
	hud_yy -= 25
	
if instance_exists(obj_player) && global.usebullet && !global.breakdance {
	var char = obj_player.character;
    if (char != "V" && char != "S") && !scr_checkskin(checkskin.p_anton)
	{
		var bx = hud_xx;
		var by = hud_yy + 20;
		var bspr = spr_peppinobullet_collectible;

		if char == "N" 
		{
			bx -= 6;
			by += 57;
			bspr = spr_playerN_noisebomb;
		}

		var b = min(global.bullet, 3);

		bx += 25 * b;
		for (i = 0; i < b; i++) 
		{
			bx -= 25;
			if bx <= 960 + 32 
				draw_sprite_ext(bspr, -1, bx, by, 1, 1, 0, c_white, alpha);
		}
		hud_xx += 95;
	}
}
if instance_exists(obj_player) && global.useammo 
{
    var bx = hud_xx
    var by = hud_yy + 20;
	var bspr = spr_chainsawammo;
          
    var b = min(global.ammo, 3);
          
    bx += 35 * b;
    for (i = 0; i < b; i++) 
	{
        bx -= 35;
		if bx <= 960 + 32 
			draw_sprite_ext(bspr, -1, bx, by, 1, 1, 0, c_white, alpha);
	}
}
#endregion

var sg = check_sugary();
draw_set_font(sg ? global.sugarybigfont : global.bigfont);

if instance_exists(obj_player) && obj_player.character == "V" && showhud {
    draw_set_colour(c_white);
    draw_text(200 + healthshake, 100 + healthshake + (OLD_GAMEPLAY ? 0 : 25), global.playerhealth);
}

//Key
if showhud {
    var styley = 0;
    if sugary && FINAL_GAMEPLAY styley -= 32;
    
    // key inventory type beat
    if !sugary or OLD_GAMEPLAY {
        var xx = 50;
        var yy = 30;
        if FINAL_GAMEPLAY {
            xx = 41;
            if (global.heatmeter)
                yy = 150 + hud_posY;
            else 
            yy = 120 + hud_posY;
        }
        
        if global.key_inv > 0 {
            var keyspr = sg ? spr_key_ss : spr_key;
            keyimg = (keyimg + 0.35) % sprite_get_number(keyspr);
            
            draw_sprite_ext(keyspr, keyimg, xx, yy + styley, 1, 1, 0, c_white, alpha);
        }
        draw_sprite_ext(spr_inv, -1, xx, yy + styley, 1, 1, 0, c_white, alpha);
    }
    
    // sugary spire inventory hud
    if sugary && global.gameplay == -1 {
        if global.key_inv > 0 {
            var keyspr = sg ? spr_keyinvSP_ss : spr_keyinvSP;
            keyimg = (keyimg + 0.35) % sprite_get_number(keyspr);
            
            draw_sprite_ext(keyspr, keyimg, 700, 89 + obj_tv.hud_posY + styley, 1, 1, 0, c_white, alpha);
        } else 
        draw_sprite_ext(spr_invSP, -1, 696, 89 + obj_tv.hud_posY + styley, 1, 1, 0, c_white, alpha);
    }
}
if (global.pizzadelivery || global.pvp) && global.hp > 0 {
    if (OLD_GAMEPLAY)
        draw_sprite(spr_pizzahealthbar, 8 - global.hp, 190 + healthshake, 70 + hud_posY + healthshake);
    else 
		draw_sprite(spr_pizzahealthbar, 8 - global.hp, 190 + healthshake, 155 + hud_posY + healthshake);
}
